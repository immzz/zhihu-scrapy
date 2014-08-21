function [x flag hist dt] = pagerank(A,optionsu)
% PAGERANK Compute the PageRank for a directed graph.
%
% [p flag hist dt] = pagerank(A)
%
%   Compute the pagerank vector p for the directed graph A, with
%   teleportation probability (1-c).  
%
%   flag is 1 if the method converged; hist returns the convergence history
%   and dt is the total time spent solving the system
%
%   The matrix A should have the outlinks represented in the rows.
%
%   This driver can compute PageRank using 4 different algorithms, 
%   the default algorithm is the Arnoldi iteration for PageRank due to
%   Grief and Golub.  Other algorithms include gauss-seidel iterations,
%   power iterations, a linear system formulation, or an approximate
%   PageRank formulation.
%
%   The output p satisfies p = c A'*D^{+} p + c d'*p v + (1-c) v and
%   norm(p,1) = 1.
%
%   The power method solves the eigensystem x = P''^T x.
%   The linear system solves the system (I-cP^T)x = (1-c)v.
%   The dense method uses "\" on I-cP^T which the LU factorization.
%   
%   To specify a different solver for the linear system, use an anonymous
%   function wrapper around one of Matlab's solver calls.  To use GMRES,
%   call pagerank(..., struct('linsolver', ... 
%             @(f,v,tol,its) gmres(f,v,[],tol, its)))
%
%   Note 1: the 'approx' algorithm is the PageRank approximate personalized
%   PageRank algorithm due to Gleich and Polito.  It creates a set of
%   active pages and runs until either norm(p(boundary),1) < options.bp or
%   norm(p(boundary),inf) < options.bp, where the boundary is defined as
%   the set of pages that have a non-zero personalized PageRank but are not
%   in the set of active pages.  As options.bp -> 0, both of these
%   approximations compute the actual personalized PageRank vector.
%
%   Note 2: the 'eval' algorithm evaluates five algorithms to compute the
%   PageRank vector and summarizes the results in a report.  The return
%   from the algorithm are a set of cell arrays where 
%   p = cell(5,1), flag = cell(5,1), hist = cell(5,1), dt = cell(5,1)
%   and each cell contains the result from one algorithm.  
%   p{1} is the vector computed from the 'power' algorithm
%   p{2} is the vector computed from the 'gs' algorithm
%   p{3} is the vector computed from the 'arnoldi' algorithm
%   p{4} is the vector computed from the 'linsys' algorithm with bicgstab
%   p{5} is the vector comptued from the 'linsys' algorithm with gmres
%   the other outputs all match these indices.
%
%   pagerank(A,options) specifies optional parameters
%   options.c: the teleportation coefficient [double | {0.85}]
%   options.tol: the stopping tolerance [double | {1e-7}]
%   options.v: the personalization vector [vector | {uniform: 1/n}]
%   options.maxiter maximum number of iterations [integer | {500}]
%   options.verbose: extra output information [{0} | 1]
%   options.x0: the initial vector [vector | {options.v}]
%   options.alg: force the algorithm type 
%     ['gs' | 'power' | 'linsys' | 'dense' | {'arnoldi'} | ...
%      'approx' | 'eval']
%
%   options.linsys_solver: a function handle for the linear solver used
%     with the linsys option [fh | {@(f,v,tol,its) bicgstab(f,v,tol,its)}]
%   options.arnoldi_k: use a k dimensional arnoldi basis [intger | {8}]
%   options.approx_bp: boundary probability to expand [float | 1e-3]
%   options.approx_boundary: when to expand on the boundary [1 | {inf}]
%   options.approx_subiter: number of subiterations of power iterations
%     [integer | {5}]
%
% Example:
%   load cs-stanford;
%   p = pagerank(A);
%   p = pagerank(A,struct('alg','linsys',... 
%                  'linsys_solver',@(f,v,tol,its) gmres(f,v,[],tol, its)));
%   pagerank(A,struct('alg','eval'));


%
% pagerank.m
% David Gleich
%

%
% 21 February 2006
% -- added approximate PageRank
%
% Revision 1.10
% 28 January 2006
%  -- added different computational modes and timing information
%
% Revision 1.00
% 19 Octoboer 2005
%

%
% The driver does mainly parameter checking, then sends things off to one
% of the computational routines.
% 

[m n] = size(A);
if (m ~= n)
    error('pagerank:invalidParameter', 'the matrix A must be square');
end;    

options = struct('tol', 1e-7, 'maxiter', 500, 'v', ones(n,1)./n, ...
    'c', 0.85, 'verbose', 0, 'alg', 'arnoldi', ...
    'linsys_solver', @(f,v,tol,its) bicgstab(f,v,tol,its), ...
    'arnoldi_k', 8, 'approx_bp', 1e-3, 'approx_boundary', inf,...
    'approx_subiter', 5);

if (nargin > 1)
    options = merge_structs(optionsu, options);
end;


if (size(options.v) ~= size(A,1))
    error('pagerank:invalidParameter', ...
        'the vector v must have the same size as A');
end;

if (~issparse(A))
    A = sparse(A);
end;

% normalize the matrix
P = normout(A);

switch (options.alg)
    case 'dense'
        [x flag hist dt] = pagerank_dense(P, options);
    case 'linsys'
        [x flag hist dt] = pagerank_linsys(P, options);
    case 'gs'
        [x flag hist dt] = pagerank_gs(P, options);
    case 'power'
        [x flag hist dt] = pagerank_power(P, options);
    case 'arnoldi'
        [x flag hist dt] = pagerank_arnoldi(P, options);
    case 'approx'
        [x flag hist dt] = pagerank_approx(P, options);
    case 'eval'
        [x flag hist dt] = pagerank_eval(P, options);
    otherwise
        error('pagerank:invalidParameter', ...
            'invalid computation mode specified.');
end;

   

% ===================================
% pagerank_linsys
% ===================================

function [x flag hist dt] = pagerank_linsys(P, options)

if (options.verbose > 0)
   fprintf('linear system computation...\n');
end;

tol = options.tol;
v = options.v;
maxiter = options.maxiter;
c = options.c;

solver = options.linsys_solver;

% transpose P (see pagerank_linsys_mult docs)
P = P';

f = @(x,varargin) pagerank_linsys_mult(x,P,c,length(varargin));

tic;
[x flag ignore1 ignore2 hist] = solver(f,v,tol,maxiter);
dt = toc;

% renormalize the vector to have norm 1
x = x./norm(x,1);



function y = pagerank_linsys_mult(x,P,c,tflag)
% compute the matrix vector product for the linear system.  This function
% includes the transpose flag (tflag > 0) to indicate a transpose multiply.
% Because many of the algorithms just use A*x (and not A'*x) the matrix P
% should have already been transposed.
if (tflag > 0)
    %y = x - c*P'*x;
    y = x - c*spmatvec_transmult(P,x);
else
    %y = x - c*P*x;
    y = x - c*spmatvec_mult(P,x);
end;
    

% ===================================
% pagerank_dense
% ===================================

function [x flag hist dt]  = pagerank_dense(P, options)
% solve as a dense linear system

if (options.verbose > 0)
   fprintf('dense computation...\n');
end;

v = options.v;
c = options.c;

n = size(P,1);

P = eye(n) - c*full(P)';

tic;
x = P \ v;
dt = toc;

hist = norm(P*x - v,1);
flag = 0;

% renormalize the vector to have norm 1
x = x./norm(x,1);


% ===================================
% pagerank_gs
% ===================================
function [x flag hist dt]  = pagerank_gs(P, options)
% use gauss-seidel computation

if (options.verbose > 0)
   fprintf('gauss-seidel computation...\n');
end;

tol = options.tol;
v = options.v;
maxiter = options.maxiter;
c = options.c;

x = v;
if (isfield(options, 'x0'))
    x = options.x0;
else
    % this is dumb, but we need to make sure
    % we actually get x it's own memory...
    
    % right now, Matlab just has a ``shadow copy''
    x(1) = x(1)-1.0;
    x(1) = x(1)+1.0;    
end;

delta = 1;
iter = 0;
P = -c*P;

hist = zeros(maxiter,1);

dt = 0;
while (delta > tol && iter < maxiter)
    tic;
    xold = pagerank_gs_mult(P,x,(1-c)*v);
    dt = dt + toc;
    
    delta = norm(x - xold,1);
    hist(iter+1) = delta;
    
    if (options.verbose > 0)
        fprintf('iter=%d; delta=%f\n', iter, delta);
    end;
    
    iter = iter + 1;
end;

% resize hist
hist = hist(1:iter);

% renormalize the vector to have norm 1
x = x./norm(x,1);

% default is convergence
flag = 0;

if (delta > tol && iter == maxiter)
    warning('pagerank:didNotConverge', ...
        'The PageRank algorithm did not converge after %i iterations', ...
        maxiter);
    flag = 1;
end;

% ===================================
% pagerank_power
% ===================================

function [x flag hist dt] = pagerank_power(P, options)
% use the power iteration algorithm

if (options.verbose > 0)
   fprintf('power iteration computation...\n');
end;
 

tol = options.tol;
v = options.v;
maxiter = options.maxiter;
c = options.c;

x = v;
if (isfield(options, 'x0'))
    x = options.x0;
end;
    
hist = zeros(maxiter,1);
delta = 1;
iter = 0;
dt = 0;
while (delta > tol && iter < maxiter)
    tic;
    y =c* spmatvec_transmult(P,x);
    w = 1 - norm(y,1);
    y = y + w*v;
    dt = dt + toc;
    
    delta = norm(x - y,1);
    
    hist(iter+1) = delta;
    
    tic;
    x = y;
    dt = dt + toc;
    
    if (options.verbose > 0)
        fprintf('iter=%d; delta=%f\n', iter, delta);
    end;
    
    iter = iter + 1;
end;

% resize hist
hist = hist(1:iter);

flag = 0;

if (delta > tol && iter == maxiter)
    warning('pagerank:didNotConverge', ...
        'The PageRank algorithm did not converge after %i iterations', ...
        maxiter);
    flag = 1;
end;

% ===================================
% pagerank_arnoldi
% ===================================

function [x flag hist dt] = pagerank_arnoldi(P, options)
% use the power iteration algorithm

if (options.verbose > 0)
   fprintf('arnoldi method computation...\n');
end;
 

tol = options.tol;
v = options.v;
maxiter = options.maxiter;
c = options.c;
k = options.arnoldi_k;

x = v;
if (isfield(options, 'x0'))
    x = options.x0;
end;
    
hist = zeros(maxiter,1);

d = dangling(P);
d = double(d);
P = P';

%f = @(x) pagerank_arnoldi_mult(x,P,c,d,v);
f = @(x) pagerank_mult(x,P,c,d,v);

iter = 0;
dt = 0;
delta = 1;
while (delta > tol && iter < maxiter)
    tic;
    [Q H] = pagerank_arnoldi_fact(f,x,k);
    [u,s,v]=svd(H-[speye(k);zeros(1,k)]);  
    x=Q(:,1:k)*v(:,k);
    dt = dt + toc;
    
    % for statistics purposes only
    delta=norm(f(x)-x,1)/norm(x,1);
    
    hist(iter+1) = delta;
    
    if (options.verbose > 0)
        fprintf('iter=%d; delta=%f\n', iter, delta);
    end;
    
    iter = iter + 1;
end;

% ensure correct normalization
x = sign(sum(x))*x;
x = x/norm(x,1);

% resize hist
hist = hist(1:iter);

flag = 0;

if (delta > tol && iter == maxiter)
    warning('pagerank:didNotConverge', ...
        'The PageRank algorithm did not converge after %i iterations', ...
        maxiter);
    flag = 1;
end;


function [V,H] = pagerank_arnoldi_fact(A,V,k)
% [Q,H] = ARNOLDI7(A,Q0,K,c,d,e,v)
%
% ARNOLDI: Reduce an n x n  matrix A to upper Hessenberg form.
%     [Q,H] = ARNOLDI(A,Q0,K) computes (k+1) x k upper
%     Hessenberg matrix H and n x k matrix Q with orthonormal
%     columns and  Q(:,1) = Q0/NORM(Q0), such that 
%     Q(:,1:k+1)'*A*Q(:,1:k) = H.
%
% A can also be a function_handle to return A*x
%

%
% Written by Chen Grief
% modified by David Gleich
%

V(:,1) = V(:,1)/norm(V(:,1));
if (~isa(A,'function_handle'))
    f = @(x) A*x;
    A = f;
end;

w = A(V(:,1));
alpha=V(:,1)'*w;
H(1,1)=alpha;
f(:,1)=w-V(:,1)*alpha;
for j=1:k-1
   beta=norm(f(:,j));
   V(:,j+1)=f(:,j)/beta;
   ejt=[zeros(1,j-1) beta];
   Hhat=[H; ejt];
   w=A(V(:,j+1));
   h=V(:,1:j+1)'*w;
   f(:,j+1)=w-V(:,1:j+1)*h;
   H=[Hhat h];
end

% Extend Arnoldi factorization
beta=norm(f(:,k));
V(:,k+1) = f(:,k)/beta;
ejt=[zeros(1,k-1) beta];
H=[H ;ejt];

% ===================================
% pagerank_approx
% ===================================

function [x flag hist dt] = pagerank_approx(A, options)
% use the power iteration algorithm

if (options.verbose > 0)
   fprintf('approximate computation...\n');
end;
 

tol = options.tol;
v = options.v;
maxiter = options.maxiter;
c = options.c;
bp = options.approx_bp;
subiter = options.approx_subiter;
boundary = options.approx_boundary;


n = size(A,1);

%x = v;
%if (isfield(options, 'x0'))
%    x = options.x0;
%end;

if (length(find(v)) ~= n)
    global_pr = 0;
else
    global_pr = 1;
    error('pagerank:invalidParameter',...
        'approximation computations are not implemented for global pagerank yet');
end;

    
hist = zeros(maxiter,1);
delta = 1;
iter = 0;
dt = 0;

% set the initial set of seed pages
if (global_pr)
    if (isfield(options, 'x0'))
        % the seed pages come from the x0 vector if provided
        p = find(options.x0);
        x = x0(p);
    else
        % the seed pages come from the x0 vector (otherwise, choose random)
        p = unique(ceil(rand(250,1)*size(P,1)));
        x = ones(length(p),1)./length(p);
    end;
else
    % the seed pages come from the x0 vector
    p = find(v);
    x = ones(length(p),1)./length(p);
    v = v(p);
end;

local = [];
active = p;
frontier = p;

tic;
while (iter <= maxiter && delta > tol)
    % expand all pages
    if (boundary == 1)
        
        % if we are running the boundary algorithm...
        
        [ignore sp] = sort(-x);
        cs = cumsum(x(sp));
        spactive = active(sp);
        allexpand_ind = cs < (1-bp);
        % actually, we need to add the first 0 after the last 1 in
        % allexpand_ind because we need cumsum to be larger than 1-bp
        allexpand_ind(min(find(allexpand_ind == 0))) = ~0;
        allexpand = spactive(allexpand_ind);
        toexpand = setdiff(allexpand,local);
    else
        %
        % otherwise, just expand all pages with a sufficient tolerance
        %
        allexpand = active(x > bp);
        toexpand = setdiff(allexpand,local);
    end;
    
    if (length(toexpand) > 0)
        xp = zeros(n,1);
        xp([local frontier]) = x;

        local = [local toexpand];
        frontier = setdiff(find(sum(A(local,:),1)), local);
        active = [local frontier];

        x = xp(local);
    else
        xp = zeros(n,1);
        xp([local frontier]) = x;
        x = xp(local);
    end;
    
    Lp = A(local,active);
    outdegree = full(sum(Lp,2));
    outdegree = [outdegree; zeros(length(frontier),1)];

    siter = 0;
    L = [Lp; sparse(length(frontier),length(active))];
    x2 = [x; xp(frontier)];
    while (siter < subiter)
        y = full(c*L'*(invzero(outdegree).*x2));
        omega = 1 - norm(y,1);
        
        % the ordering of local is preseved, so these are always the 
        % correct vertices
        y(1:length(p)) = y(1:length(p)) + omega*v;
        
        x2 = y;
        
        siter = siter+1;
    end;
    
    
    x2 = [x; xp(frontier)];
    
    delta = norm(y-x2,1);
    hist(iter+1) = delta;
    
    if (options.verbose > 0)
        fprintf('iter=%02i; delta=%0.03e expand=%i\n', iter, delta, length(toexpand));
    end
    
    x = y;
    iter = iter + 1;
end;
dt = toc;
% resize hist
hist = hist(1:iter);

xpartial = x;
x = zeros(n,1);
x([local frontier]) = xpartial;

flag = 0;

if (delta > tol && iter == maxiter)
    warning('pagerank:didNotConverge', ...
        'The PageRank algorithm did not converge after %i iterations', ...
        maxiter);
    flag = 1;
end;

no% ===================================
% pagerank_eval
% ===================================
function [x flag hist dt] = pagerank_eval(P,options)

algs = {'power', 'gs', 'arnoldi', 'linsys', 'linsys'};
extra_opts = {struct(''), struct(''), struct(''), struct(''), ...
    struct('linsys_solver',@(f,v,tol,its) gmres(f,v,8,tol, its))};
names = {'power', 'gs', 'arnoldi8', 'bicgstab', 'gmres8'};

v = options.v;
c = options.c;

x = cell(5,1);
flag = cell(5,1);
hist = cell(5,1);
dt = cell(5,1);

web('text://<html><body>Generating PageRank report...</body></html>','-noaddressbox');

htmlend = '</body></html>';
s = {};
s{1} = '<html><head><title>PageRank runtime report</title></head><body><h1>PageRank Report</h1>';

stemp = s;
stemp{end+1} = '<p>Generating graph statistics...</p>';
stemp{end+1} = htmlend;

A = spones(P);
d = dangling(P);

npages = size(P,1);
nedges = nnz(P);
ndangling = sum(d);
maxindeg = full(max(sum(A,1)));
maxoutdeg = full(max(sum(A,2)));
ncomp = components(A);

s{end+1} = '<h2>Graph statistics</h2>';
s{end+1} = '<table border="0" cellspacing="4">';
s{end+1} = sprintf('<tr><td style="font-weight: bold">%s:</td><td>%i</td></tr>', ...
    'Number of pages', npages);
s{end+1} = sprintf('<tr><td style="font-weight: bold">%s:</td><td>%i</td></tr>', ...
    'Number of edges', nedges);
s{end+1} = sprintf('<tr><td style="font-weight: bold">%s:</td><td>%i</td></tr>', ...
    'Number of dangling nodes', ndangling);
s{end+1} = sprintf('<tr><td style="font-weight: bold">%s:</td><td>%i</td></tr>', ...
    'Max in-degree', maxindeg);
s{end+1} = sprintf('<tr><td style="font-weight: bold">%s:</td><td>%i</td></tr>', ...
    'Max out-degree', maxoutdeg);
s{end+1} = sprintf('<tr><td style="font-weight: bold">%s:</td><td>%i</td></tr>', ...
    'Number of strong components:', ncomp);
s{end+1} = '</table>';

sOut = [stemp{:}];
web(['text://' sOut],'-noaddressbox');

s{end+1} = '<h2>Algorithm performance</h2>';
s{end+1} = '<table border="0">';
s{end+1} = sprintf('<tr><td style="text-align: right">%s</td><td>%0.3f</td></tr>', ...
    'c = ', c);
s{end+1} = sprintf('<tr><td style="text-align: right">%s</td><td>%2.2e</td></tr>', ...
    'tol = ', options.tol);
s{end+1} = sprintf('<tr><td style="text-align: right">%s</td><td>%i</td></tr>', ...
    'maxiter = ', options.maxiter);
s{end+1} = '</table>';

s{end+1} = '<table border="0">';
s{end+1} = ['<tr style="text-align: left">' ...
    '<th style="border-bottom:solid 1px">Algorithm</th>' ...
    '<th style="border-bottom:solid 1px">Time</th>' ...
    '<th style="border-bottom:solid 1px">Iterations</th>' ...
    '<th style="border-bottom:solid 1px">Error</th></tr>'];

for (ii=1:length(algs))
    alg = algs{ii};
    extra_opt = extra_opts{ii};
    name = names{ii};
    
    stemp = s;
    stemp{end+1} = '</table>';
    stemp{end+1} = sprintf('<p>Solving for PageRank with %s...</p>', char(name));
    stemp{end+1} = htmlend;

    sOut = [stemp{:}];
    web(['text://' sOut],'-noaddressbox');
    
    extra_opt = merge_structs(struct('alg',char(alg)),extra_opt);
    
    [pi flagi histi dti] = pagerank(P, merge_structs(extra_opt,options));
    
    p{ii} = pi;
    flag{ii} = flagi;
    hist{ii} = histi;
    dt{ii} = dti;
    
    err = norm(pi - c*(pi'*P)' - c*(d'*pi)*v - (1-c)*v,1);
    
    if (mod(ii,2) == 0)
        s{end+1} = sprintf('<tr style="background-color: #cccccc"><td>%s</td><td>%.2f</td><td>%i</td><td>%2.2e</td></tr>',...
            char(name), dti, length(histi), err);
    else
        s{end+1} = sprintf('<tr><td>%s</td><td>%.2f</td><td>%i</td><td>%2.2e</td></tr>',...
            char(name), dti, length(histi), err);
    end;
end

s{end+1} = '</table>';


s{end+1} = htmlend;
sOut = [s{:}];
web(['text://' sOut],'-noaddressbox');

s{end+1} = sprintf('<tr><td>%s</td><td></td><td></td><td></td></tr>',char(name));

%
% plot the time histogram
%
figure(1);
close(1);
figure(1);

dts = cell2mat(dt);
flags = cell2mat(flag);

h2 = bar(dts.*(flags==0));

    set(h2,'FaceColor',[1 1 1]);
    set(h2,'LineWidth',2.0);
    
    set(gca,'XTick', 1:length(algs));
    set(gca,'XTickLabel',names);
    ylabel('time (sec)');
    

%
% plot the history results
%
figure(2);
close(2);
figure(2);
lso = get(0,'DefaultAxesLineStyleOrder');
lsc = get(0,'DefaultAxesColorOrder');

lso = {'o-', 'x:', '+-.', 's--', 'd-'};

    nlso = length(lso);
    curlso = 0;
    nlsc = length(lsc);
    curlsc = 0;
    
    for ii=1:length(algs)
        histi = hist{ii};
        %legendname = fn{ii};
        %line(1:length(mrval.hist), mrval.hist);
        semilogy(1:length(histi),histi,...
            lso{mod(curlso,nlso)+1}, ...
            'Color',lsc(mod(curlsc,nlsc)+1,:),...
            'MarkerSize',3);
        hold on;
        curlso = curlso+1;
        curlsc = curlsc+1;
    end;

    title('PageRank algorithm convergence (WARNING: DIFFERENT Y-SCALES)');
    xlabel('iteration')';
    ylabel('convergence measure');
    
    legend(names{:});
    

function S = merge_structs(A, B)
% MERGE_STRUCTS Merge two structures.
%
% S = merge_structs(A, B) makes the structure S have all the fields from A
% and B.  Conflicts are resolved by using the value in A.
%

%
% merge_structs.m
% David Gleich
%
% Revision 1.00
% 19 Octoboer 2005
%

S = A;

fn = fieldnames(B);

for ii = 1:length(fn)
    if (~isfield(A, fn{ii}))
        S.(fn{ii}) = B.(fn{ii});
    end;
end;

function P = normout(A)
% NORMOUT Normalize the outdegrees of the matrix A.  
%
% P = normout(A)
%
%   P has the same non-zero structure as A, but is normalized such that the
%   sum of each row is 1, assuming that A has non-negative entries. 
%

%
% normout.m
% David Gleich
%
% Revision 1.00
% 19 Octoboer 2005
%

% compute the row-sums/degrees
d = full(sum(A,2));

% invert the non-zeros in the data
id = invzero(d);

% scale the rows of the matrix
P = diag(sparse(id))*A;

function v = invzero(v)
% INVZERO Compute the inverse elements of a vector with zero entries.
%
% iv = invzero(v) 
%
%   iv is 1./v except where v = 0, in which case it is 0.
%

%
% invzero.m
% David Gleich
%
% Revision 1.00
% 19 Octoboer 2005
%

% sparse input are easy to handle
if (issparse(v))
    [m n] = size(v);
    [i j val] = find(v);
    val = 1./val;
    v = sparse(i,j,val,m,n);
    return;
end;

% so are dense input
 
% compute the 0 mask
zm = abs(v) > eps(1);

% invert all non-zeros
v(zm) = 1./v(zm);

function dmask = dangling(A)
% DANGLING  Compute the indicator vector for dangling links for webgraph A
% 
%  d = dangling(A)
%

d = full(sum(A,2));
dmask = d == 0;

function [k,sizes]=components(A)

% based on components.m from (MESHPART Toolkit)
% which had 
% John Gilbert, Xerox PARC, 8 June 1992.
% Copyright (c) 1990-1996 by Xerox Corporation.  All rights reserved.
% HELP COPYRIGHT for complete copyright and licensing notice

[p,p,r,r] = dmperm(A|speye(size(A)));
sizes = diff(r);
k = length(sizes);