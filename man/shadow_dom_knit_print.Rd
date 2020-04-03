% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/shadow_dom.R
\name{shadow_dom_knit_print}
\alias{shadow_dom_knit_print}
\title{Shadow DOM render function for knitr}
\usage{
shadow_dom_knit_print(classes = NULL, fallback = knitr::knit_print)
}
\arguments{
\item{classes}{If provided, then the object to be printed by knitr must
inherit from at least one of these classes to be wrapped in [shadow_dom()];
objects that do not match will be forwarded to the `fallback` function.}

\item{fallback}{The render function to use if an object doesn't match
`classes`.}
}
\description{
Use this function as a knitr render function.
}
\examples{
\dontrun{
```{r render=shadow_dom_knit_print("gt_tbl")}
exibble \%>\% gt()
```
}

}