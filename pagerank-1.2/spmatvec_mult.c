/*
 * ==============================================================
 * spmatvec_mult.c  Compute a sparse matrix vector multiplication
 *
 * David Gleich
 * 14 February 2006
 * =============================================================
 */

#include "mex.h"

/*
 * The mex function just computes one matrix-vector product.
 *
 * function y = A*x;
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
    
    double xval;
    
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
        
    /* The first input must be a vector. */
    if (mxGetM(prhs[1])*mxGetN(prhs[1]) != ncols ||
        mxIsSparse(prhs[1]) || !mxIsDouble(prhs[1]))
    {
        mexErrMsgTxt("Invalid vector.");
    }
    
    /* Get the sparse matrix */
    A_val = mxGetPr(prhs[0]);
    A_row = mxGetIr(prhs[0]);
    A_col = mxGetJc(prhs[0]);
    
    /* Get the vector x */
    x = mxGetPr(prhs[1]);
    
    plhs[0] = mxCreateDoubleMatrix(mrows,1,mxREAL);
    y = mxGetPr(plhs[0]);
    
    for (i = 0; i < ncols; i++)
    {
        xval = x[i];
        
        for (j = A_col[i]; j < A_col[i+1]; ++j)
        {
            y[A_row[j]] += A_val[j]*xval;
        }
    }
}

