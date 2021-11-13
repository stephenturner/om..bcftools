bcftools <-   function(...) {
  arglist = arglist_get(...)
  files_to_send <- filestosend_get(arglist)
  vcfgz <- grep("vcf\\.gz$", files_to_send, value=TRUE)
  if(length(vcfgz)>0) files_to_send <- c(files_to_send, paste0(vcfgz[length(vcfgz)], ".tbi"))
  working_dir <- normalizePath(dirname(vcfgz))
  arglist <- arglist_parse(arglist)
  otsdr <- outsider_init(pkgnm = 'om..bcftools', cmd = 'bcftools',
                         wd = working_dir, files_to_send = files_to_send,
                         arglist = arglist)
  run(otsdr)
}

arglist <- c("view", "-r one", "inst/extdata/test.vcf")
bgzip("inst/extdata/test.vcf", outdir="inst/extdata/")
tabix(arglist = c("-f", "inst/extdata/test.vcf.gz"), outdir="inst/extdata")
bcftools("view", "-r", "one", "inst/extdata/test.vcf.gz")
