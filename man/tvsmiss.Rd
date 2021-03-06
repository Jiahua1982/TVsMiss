% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/TVsMiss.R
\name{tvsmiss}
\alias{tvsmiss}
\title{fit and select variable(s) for data with missing value}
\usage{
tvsmiss(x, y, penalty = c("lasso", "MCP", "SCAD"), method = c("CV", "BIC",
  "BIC1", "BIC2", "sBIC", "sBIC1", "sBIC2", "sVS", "sEST"), lambda = NULL,
  fold = 5, cv.ind = NULL, repeat_b = 20, alpha_n = 0.1, refit = F,
  gamma = switch(penalty, SCAD = 3.7, MCP = 3, lasso = NA), use.penalty = T)
}
\arguments{
\item{x}{the covariate matrix, should be in matrix format and at least two columns, each row is an observation}

\item{y}{the response variable}

\item{penalty}{the penalty used for regularization, can be lasso, SCAD, or MCP. The default is lasso.}

\item{method}{the variable selection method, can be cross-validation (CV), Bayesian information criterion (BIC),
BIC1 and BIC2 are adapted for the consistency in the high dimension, sBIC is the information stability,
sBIC1 and sBIC2 are information stability for high dimension data, sVS is the variable selection stability,
sEST is the estimation stability}

\item{lambda}{lambda path used in the regularization path. If not specified by user, the path will be generated automatically}

\item{fold}{the number of folds used to divided data, will be used in CV, sBIC, sBIC1, sBIC2, sVS, and sEST method}

\item{cv.ind}{a vector to indicate what fold each observations belong, useful to make reproducible research}

\item{repeat_b}{B parameter in sVS method, the repeating time to calculate selection stability criteria}

\item{alpha_n}{the parameter used to take care of variables with weak effect in sVS method}

\item{refit}{If TRUE, refit technique will be used to get estimation, i.e., use selection variable to refit
the model to get estimation}

\item{gamma}{the tuning parameter of the SCAD/MCP. Default is 3.7 for SCAD and 3 for MCP}

\item{use.penalty}{If TRUE, use penalty and variable selection techniques; if FALSE, just fit a logistic regression model with
paired data}
}
\description{
Fit a model based on a pseudo likelihood and select variable(s) through one of multiple techniques. The regularization path is computed for lasso, SCAD, or MCP.
Three steps are used to finish this the variable selection purpose: 1. remove missing and pair each observations;
2. use penalty to get lambda path and corresponding beta matrix; 3. use specific method to finish variable selection.
}
\examples{
n <- 50
p <- 8
beta <- c(3,0,1.5,0,2,rep(0,p-5))
xm <- matrix(rnorm(n*p),ncol = p, nrow = n)
y <- xm \%*\% beta + rnorm(n)
colnames(xm) <- paste0("Var_",1:p)

fit01 <- tvsmiss(x=xm,y=y)
fit01$selection_beta

fit02 <- tvsmiss(x=xm,y=y,method = "BIC")
fit02$selection_beta
fit02$beta_matrix

fit06 <- tvsmiss(x=xm,y=y,penalty = "SCAD",method = "sVS",fold = 5)
fit06$selection_beta
fit06$beta_matrix

}
