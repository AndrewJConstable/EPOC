#include <R.h>
#include <Rinternals.h>
#include <stdlib.h> // for NULL
#include <R_ext/Rdynload.h>

/*
  The following symbols/expressions for .NAME have been omitted

    .Object@universe$realtimeState$currentMethod

  Most likely possible values need to be added below.
*/

/*
  The following name(s) appear with different usages
  e.g., with different numbers of arguments:

    openRcppFileConn
    writeRcppFileConn

  This needs to be resolved in the tables and any declarations.
*/

/* FIXME: 
   Check these declarations against the C/Fortran source code.
*/

/* .Call calls */
extern SEXP createRcppFileConn(SEXP, SEXP);
extern SEXP getpathRcppFileConn(SEXP);
extern SEXP getmodeRcppFileConn(SEXP);
extern SEXP openconnRcppFileConn(SEXP);
extern SEXP isopenRcppFileConn(SEXP);
extern SEXP openRcppFileConn(SEXP, SEXP, SEXP);
extern SEXP readlineRcppFileConn(SEXP, SEXP);
extern SEXP readRcppFileConn(SEXP);
extern SEXP writeRcppFileConn(SEXP, SEXP, SEXP); 
extern SEXP closeRcppFileConn(SEXP);

static const R_CallMethodDef CallEntries[] = {
    {"createRcppFileConn",    (DL_FUNC) &createRcppFileConn,    2},
    {"getpathRcppFileConn",   (DL_FUNC) &getpathRcppFileConn,   1},
    {"getmodeRcppFileConn",   (DL_FUNC) &getmodeRcppFileConn,   1},
    {"openconnRcppFileConn",  (DL_FUNC) &openconnRcppFileConn,  1},
    {"isopenRcppFileConn",    (DL_FUNC) &isopenRcppFileConn,    1},
    {"openRcppFileConn",      (DL_FUNC) &openRcppFileConn,      3}, 
    {"readlineRcppFileConn",  (DL_FUNC) &readlineRcppFileConn,  2},
    {"readRcppFileConn",      (DL_FUNC) &readRcppFileConn,      1},
    {"writeRcppFileConn",     (DL_FUNC) &writeRcppFileConn,     3}, 
    {"closeRcppFileConn",     (DL_FUNC) &closeRcppFileConn,     1},
     {NULL, NULL, 0}
};


void R_init_EPOC(DllInfo *dll)
{
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
