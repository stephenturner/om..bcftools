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
