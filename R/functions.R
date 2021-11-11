#' @name bcftools
#' @title bcftools
#' @description Run bcftools
#' @param ... Arguments
#' @example /examples/example.R
#' @details Find more help online \url{https://github.com/stephenturner/om..bcftools}.
#' @export
bcftools <- function(...) {
  # convert the ... into a argument list
  arglist <- arglist_get(...)
  # create an outsider object: describe the arguments and program
  otsdr <- outsider_init(pkgnm = 'om..bcftools', cmd = 'bcftools',
                         arglist = arglist)
  # run the command
  run(otsdr)
}
#' @name tabix
#' @title tabix
#' @description Run tabix
#' @param ... Arguments
#' @example /examples/example.R
#' @details Find more help online \url{https://github.com/stephenturner/om..bcftools}.
#' @export
tabix <- function(...) {
  # convert the ... into a argument list
  arglist <- arglist_get(...)
  # create an outsider object: describe the arguments and program
  otsdr <- outsider_init(pkgnm = 'om..bcftools', cmd = 'tabix',
                         arglist = arglist)
  # run the command
  run(otsdr)
}
#' @name bgzip
#' @title bgzip
#' @description Run bgzip
#' @param ... Arguments
#' @example /examples/example.R
#' @details Find more help online \url{https://github.com/stephenturner/om..bcftools}.
#' @export
bgzip <- function(...) {
  # convert the ... into a argument list
  arglist <- arglist_get(...)
  # create an outsider object: describe the arguments and program
  otsdr <- outsider_init(pkgnm = 'om..bcftools', cmd = 'bgzip',
                         arglist = arglist)
  # run the command
  run(otsdr)
}
