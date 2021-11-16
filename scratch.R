library(outsider)
library(outsider.base)
library(om..bcftools)
outsider.devtools::module_build()
outsider.devtools::module_check()
outsider.devtools::module_test()

bcftools("view", "-r", "2", "inst/extdata/example.vcf.gz")
bcftools("view", "-r", "2", "inst/extdata/example.vcf.gz", "-Ov", "-o", "2.vcf")
bgzip("inst/extdata/2.vcf")
tabix("inst/extdata/2.vcf.gz")
file.remove("inst/extdata/2.vcf")
file.remove("inst/extdata/2.vcf.gz")
file.remove("inst/extdata/2.vcf.gz.tbi")


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
  otsdr <- outsider_init(pkgnm = 'om..bcftools', cmd = 'bash',
                         arglist = '__outsider.sh', wd = wd,
                         files_to_send = c(script_path, files_to_send))
  # run the command
  run(otsdr)
  invisible(file.remove(file.path(wd, "__outsider.sh")))
}



bcftools("query", "inst/extdata/example.vcf.gz", "-f", "'%CHROM\\t%POS\\t%ID\\t[%TGT]\\n'", output_file = "query.txt")
bcftools("query", "inst/extdata/example.vcf.gz", "-f '%CHROM\\t%POS\\t%ID\\t[%TGT]\\n'")

bcftools("stats", "inst/extdata/example.vcf.gz")
bcftools("query", "inst/extdata/2.vcf.gz", "-f", "%CHROM\\t%POS\\t%ID\\t[%TGT]\\n", output_file = "2.tsv")
arglist <- c("query", "inst/extdata/2.vcf.gz", "-f", "%CHROM\\t%POS\\t%ID\\t[%TGT]\\n")
output_file = "2.tsv"
