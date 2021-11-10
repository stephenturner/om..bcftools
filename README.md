
<!--
The README should be used to describe the program. It acts like the homepage of
your module.

Edit README.Rmd not README.md. The .Rmd file can be knitted to parse real-code
examples and show their output in the .md file.

To knit, use devtools::build_readme() or outsider.devtools::build()

Edit the template to describe your program: how to install, import and run;
run exemplary, small demonstrations; present key arguments; provide links and
references to the program that the module wraps.

Learn more about markdown and Rmarkdown:
https://daringfireball.net/projects/markdown/syntax
https://rmarkdown.rstudio.com/
-->

# Run `bcftools` with `outsider` in R

[![Build
Status](https://travis-ci.org/stephenturner/om..bcftools.svg?branch=master)](https://travis-ci.org/stephenturner/om..bcftools)

> Summary line of what the program does.

<!-- Install information -->

## Install and look up help

``` r
library(outsider)
module_install(repo = "stephenturner/om..bcftools")
module_help(repo = "stephenturner/om..bcftools")
```

<!-- Detailed examples -->

## A detailed example

<!-- Note: set eval=TRUE to run example and show output -->

``` r
library(outsider)
bcftools <- module_import(fname = 'bcftools', repo = "stephenturner/om..bcftools")
bcftools(arglist = c('--a', '-more=10', '-complicated=a', 'example.txt'))
```

<!-- Remove module after running above example -->

### Key arguments

Describe key arguments and show program output. E.g. in table format.

| Argument    | Usage                | Description          |
|-------------|----------------------|----------------------|
| a           | –a                   | Runs “a” method      |
| more        | -more=\#             | Run \# more          |
| complicated | -complicated=\[a-z\] | Run \[a-z\]          |
| Output file | Final argument       | Where to storeoutput |

## Links

Find out more by visiting the [bcftools’s
homepage](www.external_program.org).

## Please cite

-   Smith, J. et al. (2020) bcftools reference. *Journal of Outsider
    Modules*
-   Bennett et al. (2020). outsider: Install and run programs, outside
    of R, inside of R. *Journal of Open Source Software*, In review

## <!-- Footer -->

<img align="left" width="120" height="125" src="https://raw.githubusercontent.com/ropensci/outsider/master/logo.png">

**An `outsider` module**

Learn more at [outsider website](https://docs.ropensci.org/outsider/).
Want to build your own module? Check out [`outsider.devtools`
website](https://docs.ropensci.org/outsider.devtools/).
