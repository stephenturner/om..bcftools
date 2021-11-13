bcftools("view", "-r", "2", "inst/extdata/example.vcf.gz")
bcftools("view", "-r", "2", "inst/extdata/example.vcf.gz", "-Ov", "-o", "2.vcf")
bgzip("inst/extdata/2.vcf")
tabix("-f", "inst/extdata/2.vcf.gz")
file.remove("inst/extdata/2.vcf")
file.remove("inst/extdata/2.vcf.gz")
file.remove("inst/extdata/2.vcf.gz.tbi")

bcftools <-   function(..., output_file=NULL) {
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
  if (!is.null(output_file)) {
    # write out the results of figlet to output_file
    arglist <- c(arglist, '>', basename(output_file))
  }
  # Construct the outsider object
  otsdr <- outsider_init(pkgnm = 'om..bcftools', cmd = 'bcftools',
                         wd = working_dir, files_to_send = files_to_send,
                         arglist = arglist)
  # Run it
  run(otsdr)
}

bcftools("query", "inst/extdata/example.vcf.gz", "-f", "%CHROM\\t%POS\\t%ID\\t[%TGT]\\n")
x <- capture.output(bcftools("query", "inst/extdata/example.vcf.gz", "-f", "%CHROM\\t%POS\\t%ID\\t[%TGT]\\n"))
x

x <- capture.output(bcftools("query", "inst/extdata/2.vcf.gz", "-f", "%CHROM\\t%POS\\t%ID\\t[%TGT]\\n"))
readr::read_tsv(I(x))
bcftools("stats", "inst/extdata/2.vcf.gz")
bcftools("query", "inst/extdata/2.vcf.gz", "-f", "%CHROM\\t%POS\\t%ID\\t[%TGT]\\n", output_file = "2.tsv")
arglist <- c("query", "inst/extdata/2.vcf.gz", "-f", "%CHROM\\t%POS\\t%ID\\t[%TGT]\\n")
output_file = "2.tsv"
