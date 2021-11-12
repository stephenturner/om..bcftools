#!/usr/bin/env sh

# Create example vcf to work with (requires vcflib and bcftools)

vcfrandom | sed 's/^one/1/g' > 1.vcf
bgzip 1.vcf
tabix 1.vcf.gz

vcfrandom | sed 's/^one/2/g' > 2.vcf
bgzip 2.vcf
tabix 2.vcf.gz

bcftools concat 1.vcf.gz 2.vcf.gz | sed 's/bill$/example/g' | bcftools view -Oz -o example.vcf.gz
tabix example.vcf.gz
