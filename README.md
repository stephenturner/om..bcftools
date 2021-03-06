
# Run `bcftools` with `outsider` in R

This module allows you to run bcftools in R via Docker. See the full
[bcftools
documentation](http://samtools.github.io/bcftools/bcftools.html) for
more information.

## Installation

``` r
# install.packages("outsider")
library(outsider)
module_install(repo = "stephenturner/om..bcftools")
```

## Examples

After installing the bcftools outsider module, import the `bcftools()`,
`bgzip()`, and `tabix()` functions into your global environment.

``` r
library(outsider)
bcftools <- module_import(fname = 'bcftools', repo = "stephenturner/om..bcftools")
bgzip <- module_import(fname = 'bgzip', repo = "stephenturner/om..bcftools")
tabix <- module_import(fname = 'tabix', repo = "stephenturner/om..bcftools")
```

If you’d like, copy an example VCF file from the package to your current
working directory to work with.

``` r
file.copy(from=system.file("extdata", "example.vcf", package = "om..bcftools"), to=".")
```

Take a look at it:

``` r
bcftools("view", "example.vcf")
```

    ##fileformat=VCFv4.0
    ##FILTER=<ID=PASS,Description="All filters passed">
    ##source=vcfrandom
    ##reference=/d2/data/references/build_37/human_reference_v37.fa
    ##phasing=none
    ##INFO=<ID=NS,Number=1,Type=Integer,Description="Number of samples with data">
    ##INFO=<ID=DP,Number=1,Type=Integer,Description="Total read depth at the locus">
    ##INFO=<ID=AC,Number=1,Type=Integer,Description="Total number of alternate alleles in called genotypes">
    ##INFO=<ID=AN,Number=1,Type=Integer,Description="Total number of alleles in called genotypes">
    ##INFO=<ID=AF,Number=1,Type=Float,Description="Estimated allele frequency in the range (0,1]">
    ##FORMAT=<ID=GT,Number=1,Type=String,Description="Genotype">
    ##FORMAT=<ID=GQ,Number=1,Type=Integer,Description="Genotype Quality, the Phred-scaled marginal (or unconditional) probability of the called genotype">
    ##FORMAT=<ID=DP,Number=1,Type=Integer,Description="Read Depth">
    ##contig=<ID=1>
    ##contig=<ID=2>
    ##bcftools_concatVersion=1.12+htslib-1.12
    ##bcftools_concatCommand=concat 1.vcf.gz 2.vcf.gz; Date=Fri Nov 12 09:06:27 2021
    ##bcftools_viewVersion=1.12+htslib-1.12
    ##bcftools_viewCommand=view -Oz -o example.vcf.gz; Date=Fri Nov 12 09:06:27 2021
    #CHROM  POS ID  REF ALT QUAL    FILTER  INFO    FORMAT  example
    1   1   .   A   C,G 100 .   DP=65   GT:DP   0/1:12
    1   2   .   G   A,G 100 .   DP=41   GT:DP   0/1:77
    1   3   .   T   T,G 100 .   DP=36   GT:DP   0/1:65
    1   4   .   C   T,A 100 .   DP=0    GT:DP   0/1:77
    1   5   .   T   T,C 100 .   DP=92   GT:DP   0/1:6
    1   6   .   T   G,A 100 .   DP=57   GT:DP   0/1:7
    1   7   .   G   C,T 100 .   DP=32   GT:DP   0/1:16
    1   8   .   C   A,A 100 .   DP=94   GT:DP   0/1:76
    1   9   .   A   T,A 100 .   DP=78   GT:DP   0/1:64
    2   1   .   C   A,G 100 .   DP=10   GT:DP   0/1:21
    2   2   .   C   G,A 100 .   DP=61   GT:DP   0/1:87
    2   3   .   C   T,A 100 .   DP=20   GT:DP   0/1:0
    2   4   .   A   G,G 100 .   DP=47   GT:DP   0/1:37
    2   5   .   G   T,T 100 .   DP=49   GT:DP   0/1:71
    2   6   .   A   C,G 100 .   DP=52   GT:DP   0/1:94
    2   7   .   A   A,T 100 .   DP=74   GT:DP   0/1:78
    2   8   .   T   A,A 100 .   DP=48   GT:DP   0/1:87
    2   9   .   A   G,A 100 .   DP=3    GT:DP   0/1:48

Compress and tabix index it:

``` r
bgzip("example.vcf")
tabix("example.vcf.gz")
```

Query just chromosome 2 to get chromosome, position, ref, alternate
alleles, and the genotype, in a tab delimited output.

``` r
bcftools("query", "-r 2", "-f '%CHROM\\t%POS\\t%REF\\t%ALT\\t[%TGT]\\n'", "example.vcf.gz")
```

    2   1   C   A,G C/A
    2   2   C   G,A C/G
    2   3   C   T,A C/T
    2   4   A   G,G A/G
    2   5   G   T,T G/T
    2   6   A   C,G A/C
    2   7   A   A,T A/A
    2   8   T   A,A T/A
    2   9   A   G,A A/G

Add an `output_file=<filename>` to write it to file:

``` r
bcftools("query", "-r 2", "-f '%CHROM\\t%POS\\t%REF\\t%ALT\\t[%TGT]\\n'", "example.vcf.gz", output_file="example.vcf.query.tsv")
```

Read it back in:

``` r
read.table("example.vcf.query.tsv")
```

      V1 V2 V3  V4  V5
    1  2  1  C A,G C/A
    2  2  2  C G,A C/G
    3  2  3  C T,A C/T
    4  2  4  A G,G A/G
    5  2  5  G T,T G/T
    6  2  6  A C,G A/C
    7  2  7  A A,T A/A
    8  2  8  T A,A T/A
    9  2  9  A G,A A/G

Plugins work too!

``` r
bcftools("plugin --list-plugins")
```

    GTisec
    GTsubset
    ad-bias
    add-variantkey
    af-dist
    allele-length
    check-ploidy
    check-sparsity
    color-chrs
    contrast
    counts
    dosage
    fill-AN-AC
    fill-from-fasta
    fill-tags
    fixploidy
    fixref
    frameshifts
    guess-ploidy
    gvcfz
    impute-info
    indel-stats
    isecGT
    mendelian
    missing2ref
    parental-origin
    prune
    remove-overlaps
    scatter
    setGT
    smpl-stats
    split
    split-vep
    tag2tag
    trio-dnm2
    trio-stats
    trio-switch-rate
    variantkey-hex

Clean up:

``` r
file.remove(c("example.vcf", "example.vcf.gz", "example.vcf.gz.tbi", "example.vcf.query.tsv"))
```

## Links

Find out more by visiting the [bcftools’s manual
page](http://samtools.github.io/bcftools/bcftools.html).

## Please cite

-   Turner, S.D. (2021). Bcftools outsider module.
    <https://github.com/stephenturner/om..bcftools>.
-   Bennett et al., (2020). outsider: Install and run programs, outside
    of R, inside of R. Journal of Open Source Software, 5(45), 2038,
    <https://doi.org/10.21105/joss.02038>
-   Danecek, Petr, et al. “Twelve years of SAMtools and BCFtools.”
    Gigascience 10.2 (2021):
    <https://doi.org/10.1093/gigascience/giab008>.

------------------------------------------------------------------------

<img align="left" width="120" height="125" src="https://raw.githubusercontent.com/ropensci/outsider/master/logo.png">

**An `outsider` module**

Learn more at [outsider website](https://docs.ropensci.org/outsider/).
Want to build your own module? Check out [`outsider.devtools`
website](https://docs.ropensci.org/outsider.devtools/).
