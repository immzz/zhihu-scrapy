/*
 * =============================================================
 * pagerank_mult.c  Compute the matrix vector multiplication
 * between the PageRank matrix and a vector
 *
 * David Gleich
 * Stanford University
 * 14 February 2006
 * =============================================================
 */

#include "mex.h"

/*
 * The mex function just computes one matrix-vector product.
 *
 * function y = pagerank_mult(x,Pt,c,d,v)
 *      y = c*Pt*x + (c*(d'*x))*v + (1-c)*sum(x)*v;
 */
void mexFunction(int nlhs, mxArray *plhs[],
                 int nrhs, const mxArray *prhs[])
{
    int i, j, k;
    int n, mrows, ncols;
    
    /* sparse matrix */
    int *A_row, *A_col;
    double *A_val;
    
    double *x, *d, *v;
    double c;
    double *y;
    
    double sum_x;
    double dtx;
    double xval;
   
    
    if (nrhs != 5) 
    {
        mexErrMsgTxt("5 inputs required.");
    }
    else if (nlhs > 1) 
    {
        mexErrMsgTxt("Too many output arguments");
    }
    
    mrows = mxGetM(prhs[1]);
    ncols = mxGetN(prhs[1]);
    if (mrows != ncols ||
        !mxIsSparse(prhs[1]) ||
        !mxIsDouble(prhs[1]) || 
        mxIsComplex(prhs[1])) 
    {
        mexErrMsgTxt("Input must be a noncomplex square sparse matrix.");
    }
    
    /* okay, the second input passes */
    n = mrows;
    
    /* The first input must be a vector. */
    if (mxGetM(prhs[0])*mxGetN(prhs[0]) != n ||
        mxIsSparse(prhs[0]) || !mxIsDouble(prhs[0]))
    {
        mexErrMsgTxt("Invalid vector 1.");
    }
    
    /* The third input must be a scalar. */
    if (mxGetM(prhs[2])*mxGetN(prhs[2]) != 1 || !mxIsDouble(prhs[0]))
    {
        mxErrMsgTxt("Invalid scalar 3.");
    }
    
    /* The fourth input must be a scalar. */
    if (mxGetM(prhs[3])*mxGetN(prhs[3]) != n ||
        mxIsSparse(prhs[3]) || !mxIsDouble(prhs[3]))
    {
        mexErrMsgTxt("Invalid vector 4.");
    }
    
    /* The fifth input must be a scalar. */
    if (mxGetM(prhs[4])*mxGetN(prhs[4]) != n ||
        mxIsSparse(prhs[4]) || !mxIsDouble(prhs[4]))
    {
        mexErrMsgTxt("Invalid vector 5.");
    }
    
    /* Get the sparse matrix */
    A_val = mxGetPr(prhs[1]);
    A_row = mxGetIr(prhs[1]);
    A_col = mxGetJc(prhs[1]);
    
    /* Get the vector x */
    x = mxGetPr(prhs[0]);
    
    /* Get the vector d */
    d = mxGetPr(prhs[3]);
    
    /* Get the vector v */
    v = mxGetPr(prhs[4]);
    
    c = mxGetScalar(prhs[2]);
    
    plhs[0] = mxCreateDoubleMatrix(n,1,mxREAL);
    y = mxGetPr(plhs[0]);
    
    sum_x = 0.0;
    dtx = 0.0;
    
    for (i = 0; i < n; i++)
    {
        xval = x[i];
        sum_x += xval;
        dtx += d[i]*xval;
        
        for (j = A_col[i]; j < A_col[i+1]; ++j)
        {
            y[A_row[j]] += c*A_val[j]*xval;
        }
    }
    
    xval = c*dtx + (1-c)*sum_x;
    for (i=0; i < n;i++)
    {
        y[i] += xval*v[i];
    }
}

