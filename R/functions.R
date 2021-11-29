#' @name bcftools
#' @title bcftools
#' @description Run bcftools
#' @param ... Arguments passed to bcftools
#' @param output_file Name of output file to be written at same location as input vcf.gz
#' @example /examples/example.R
#' @details Find more help online \url{https://github.com/stephenturner/om..bcftools}.
#' @export
bcftools <-   function(..., output_file=NULL) {
  # Initialize the arglist and files to send
  arglist = arglist_get(...)
  files_to_send <- filestosend_get(arglist)
  # Find the vcf.gz from the list of files.
  vcfgz <- grep("vcf\\.gz$", files_to_send, value=TRUE)
  # Send the tabix index along with it
  if(length(vcfgz)>0) files_to_send <- c(files_to_send, paste0(vcfgz, ".tbi"))
  # Set the working dir to the directory where the ultimate vcf.gz lives
  wd <- normalizePath(dirname(vcfgz[length(vcfgz)]))
  # Get the rest of the non-file arguments
  arglist <- arglist_parse(arglist)
  # Stick bcftools in front of the arglist
  arglist <- c("bcftools", arglist)
  # If you have an output file, redirect to that file
  if (!is.null(output_file)) {
    arglist <- c(arglist, '>', basename(output_file))
  }
  # write arglist to temp file
  script_path <- file.path(tempdir(), '__outsider.sh')
  on.exit(file.remove(script_path))
  # ensure script is written in binary format
  script <- file(script_path, 'wb')
  cmds <- paste(arglist, collapse = ' ')
  message(cmds)
  write(x = cmds, file = script)
  close(script)
  # initialise outsider container by specifying the command,
  # the arguments, the files to be sent, and the directory to where
  # returned files should be sent
  otsdr <- outsider_init(pkgnm = 'om..bcftools', cmd = 'sh',
                         arglist = '__outsider.sh', wd = wd,
                         files_to_send = c(script_path, files_to_send))
  # run the command
  run(otsdr)
  invisible(file.remove(file.path(wd, "__outsider.sh")))
}

#' @name bgzip
#' @title bgzip
#' @description Run bgzip
#' @param ... Path to input vcf to compress with bgzip
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

#' @name tabix
#' @title tabix
#' @description Run tabix
#' @param ... Path to vcf.gz
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

