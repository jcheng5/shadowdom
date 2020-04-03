#' Wrap htmltools tag objects in shadow DOM
#'
#' Creates a `<x-with-shadow-dom>...</x-width-shadow-dom>` tag, which is a
#' custom element that isolates the styling of its contents using a Shadow DOM.
#' See https://caniuse.com/#feat=shadowdomv1 for browser compatibility
#' information (notably, Internet Explorer 11 is not supported).
#'
#' @inheritParams htmltools::tags
#'
#' @examples
#' library(htmltools)
#'
#' ex <- div(
#'   tags$style(HTML(
#'     "p { color: blue; }"
#'   )),
#'   p("Here's a regular <p> tag; it's blue."),
#'   shadow_dom(p("Here's a <p> tag in a shadow DOM; it's NOT blue.")),
#'   shadow_dom(
#'     tags$style(HTML("p { color: green; }")),
#'     p("Here's a <p> tag in a shadow DOM with its own CSS; it's green.")
#'   )
#' )
#'
#' print(ex, browse = TRUE)
#'
#' @export
shadow_dom <- function(..., .noWS = NULL) {
  htmltools::attachDependencies(
    htmltools::tag("x-with-shadow-dom", list(...), .noWS = .noWS),
    shadow_dom_deps(),
    append = TRUE
  )
}

#' Shadow DOM render function for knitr
#'
#' Use this function as a knitr render function.
#'
#' @param classes If provided, then the object to be printed by knitr must
#'   inherit from at least one of these classes to be wrapped in [shadow_dom()];
#'   objects that do not match will be forwarded to the `fallback` function.
#' @param fallback The render function to use if an object doesn't match
#'   `classes`.
#'
#' @examples
#' \dontrun{
#' ```{r render=shadow_dom_knit_print("gt_tbl")}
#' exibble %>% gt()
#' ```
#' }
#'
#' @export
shadow_dom_knit_print <- function(classes = NULL, fallback = knitr::knit_print) {
  force(classes)
  force(fallback)

  function(x, ...) {
    if (is.null(classes) || inherits(x, classes)) {
      x <- shadow_dom(x)
    }
    fallback(x, ...)
  }
}

shadow_dom_deps <- function() {
  list(
    htmltools::htmlDependency(
      "shadowdom",
      utils::packageVersion("shadowdom"),
      src = "assets",
      package = "shadowdom",
      script = "js/x-with-shadow-dom.js"
    )
  )
}
