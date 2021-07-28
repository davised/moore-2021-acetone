# Moore et al. 2021 - Acetone monooxygenase analysis in SAR11 & Tara Oceans

Additional methods for Figure 4 - Acetone monooxygenase expression map

Tara Ocean Gene Atlas - https://tara-oceans.mio.osupytheas.fr/ocean-gene-atlas/

To generate the data:

Reference sequence:
```
>OM-RGC.v2.002142823
SGKDLGGTWYWNRYPGARCDSESHTYNFTFSKEIFENWSWPERYSKQDIILEYLNYVVEKLSLKKDMLFDNKVIKAHFDE
KSNLWNIKTNKDKTFLCKYLISAVGCLSAANIPKINGLRKFKGKWYHTGKWPHTGVDFKNKRVAQIGVGSTGIQLAPEIA
KSAKKLSIFQRSPNFSIPARNEIVNDKYKKKIKDNYQEIRDLIKSTPTGHAFNFSSQSTFDVSNEDRKKIYENGWQKGGL
GFRGLFKDITTNLDANKTIVNFIKEKVETTMLNKHYAKVVTDFNYPFATRRPTLNTDYYETFNKDNVELIDISKDSIKEI
TETGISTTENKYEFDIIVFATGYDAITGALLSIDMVGKNNIKLSELWKNGPLTYLGLQIPGFPNFFTITGPGSPSVLTNV
PMAIEQHVEFITDCISHMEKNKYSTIETNNDYSLKWREVIDKAVDETLIPESKSSWLYGGNIEGKPKVFMPYPSGLPKYK
KICEDIVLKNYEGFNFDKH
```
See `OM-RGC.v2.002142823.fasta` file as well.

1. Choose OM-RGCv2+T - the metatranscriptome data
2. Input OM-RGC.v2.002142823 sequence from above
3. Download abundances of the homologs and environmental data
4. Remove the extra header line of the abundance data (abd_mat_head.tsv)
5. Run the code in the `acetone_abundance_figure_TARA.R` file

We subset the data to just the surface samples, but the full dataset is provided
here. We also have a subset just to SAR11 clade organisms, but as determining
the accuracy (both false negative and false positive SAR11 IDs) we decided that
we would present just the surface sample data in the manuscript.

# Copyright
Oregon State University 2021
