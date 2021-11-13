#' @name bcftools
#' @title bcftools
#' @description Run bcftools
#' @param ... Arguments
#' @example /examples/example.R
#' @details Find more help online \url{https://github.com/stephenturner/om..bcftools}.
#' @export
bcftools <-   function(...) {
  arglist = arglist_get(...)
  files_to_send <- filestosend_get(arglist)
  # Find the vcf.gz from the list of files.
  vcfgz <- grep("vcf\\.gz$", files_to_send, value=TRUE)
  # Send the tabix index along with it
  if(length(vcfgz)>0) files_to_send <- c(files_to_send, paste0(vcfgz[length(vcfgz)], ".tbi"))
  # Set the working dir to the directory where the vcf.gz lives
  working_dir <- normalizePath(dirname(vcfgz))
  # Get the rest of the non-file arguments
  arglist <- arglist_parse(arglist)
  # Construct the outsider object
  otsdr <- outsider_init(pkgnm = 'om..bcftools', cmd = 'bcftools',
                         wd = working_dir, files_to_send = files_to_send,
                         arglist = arglist)
  # Run it
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
  arglist = arglist_get(...)
  files_to_send <- filestosend_get(arglist)
  if (length(files_to_send)>1L) stop("Usage: tabix('/path/to/vcf.gz')")
  if (length(files_to_send)==1L && !grepl("\\.vcf\\.gz$", files_to_send)) stop("Usage: tabix('/path/to/vcf.gz')")
  working_dir <- normalizePath(dirname(files_to_send))
  arglist <- arglist_parse(arglist)
  otsdr <- outsider_init(pkgnm = 'om..bcftools', cmd = 'tabix',
                         wd = working_dir, files_to_send = files_to_send,
                         arglist = arglist)
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
  arglist <- arglist_get(...)
  files_to_send <- filestosend_get(arglist)
  if (length(files_to_send)>1L) stop("Usage: bgzip('/path/to/vcf')")
  if (length(files_to_send)==1L && !grepl("\\.vcf$", files_to_send)) stop("Usage: bgzip('/path/to/vcf')")
  working_dir <- normalizePath(dirname(files_to_send))
  arglist <- arglist_parse(arglist)
  otsdr <- outsider_init(pkgnm = 'om..bcftools', cmd = 'bgzip',
                         wd = working_dir, files_to_send = files_to_send,
                         arglist = arglist)
  run(otsdr)
}
