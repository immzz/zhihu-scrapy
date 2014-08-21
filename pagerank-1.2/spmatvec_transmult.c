/*
 * =============================================================
 * spmatvec_mult.c  Compute a sparse matrix vector multiplication
 * using a transposed matrix.
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
 * function y = A'*x
 */
void mexFunction(int nlhs, mxArray *plhs[],
                 int nrhs, const mxArray *prhs[])
{
    int i, j, k;
    int mrows, ncols;
    
    /* sparse matrix */
    int *A_row, *A_col;
    double *A_val;
    
    double *x;
    double *y;
    
    double yval;
    
    if (nrhs != 2) 
    {
        mexErrMsgTxt("2 inputs required.");
    }
    else if (nlhs > 1) 
    {
        mexErrMsgTxt("Too many output arguments");
    }
    
    mrows = mxGetM(prhs[0]);
    ncols = mxGetN(prhs[0]);
    if (!mxIsSparse(prhs[0]) ||
        !mxIsDouble(prhs[0]) || 
        mxIsComplex(prhs[0])) 
    {
        mexErrMsgTxt("Input must be a noncomplex sparse matrix.");
    }
        
    /* The second input must be a vector. */
    if (mxGetM(prhs[1])*mxGetN(prhs[1]) != mrows ||
        mxIsSparse(prhs[1]) || !mxIsDouble(prhs[1]))
    {
        mexErrMsgTxt("Invalid vector 2.");
    }
    
    /* Get the sparse matrix */
    A_val = mxGetPr(prhs[0]);
    A_row = mxGetIr(prhs[0]);
    A_col = mxGetJc(prhs[0]);
    
    /* Get the vector x */
    x = mxGetPr(prhs[1]);
    
    plhs[0] = mxCreateDoubleMatrix(ncols,1,mxREAL);
    y = mxGetPr(plhs[0]);
    
    for (i = 0; i < ncols; i++)
    {
        yval = 0.0;
        
        for (j = A_col[i]; j < A_col[i+1]; ++j)
        {
            yval += A_val[j]*x[A_row[j]];
        }
        
        y[i] = yval;
    }
}

