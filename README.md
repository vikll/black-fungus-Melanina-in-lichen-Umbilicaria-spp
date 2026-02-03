# Ubiquitous occurrence of the black fungus *Melanina gundecimermaniae* in the lichen *Umbilicaria pustulata*

This repository provides scripts used throughout the analyses of the manuscript, Keller et al. (2026), in Current Biology.

## Abstract
Lichen symbioses frequently include additional fungal-associates beyond the canonical mycobiont (fungus) and photobiont (alga/cyanobacterium). Despite the prevalence and diversity of these lichen-cohabitants, their geographic distribution and role within the lichen consortium remain poorly understood.  Combining genomics, metagenomics, and advanced microscopy, we identified the black fungus *Melanina gundecimermaniae* as a constant cohabitant in the lichen *Umbilicaria pustulata*. We analyzed metagenomes from 149 individuals across 15 populations, spanning the Europe-wide range of *U. pustulata*. Additionally, we screened pooled metagenomes of *U. pustulata* and *Umbilicaria phaea* along five elevation gradients (Europe, North America). Genome mapping, using a near-complete reference genome of *M. gundecimermaniae*, revealed that the black fungus was present in 100% of the screened lichen metagenomes, with 0.85–3.78% of reads mapping against the reference. Among all lichen-associated fungi, it was one of the most common. These findings indicate that the black fungus is widely distributed and associates with different lichen species, underscoring its potential ecological significance. Using fluorescence in situ hybridization coupled with confocal laser scanning microscopy, we confirmed the presence of *M. gundecimermaniae* within various structures of *U. pustulata*, including vegetative symbiotic propagules involved in dispersal. Elucidating the widespread occurrence across continents, consistent presence in *U. pustulata*, and ability to be dispersed together with the lichens’ canonical partners, our findings suggest a potential interaction of *M. gundecimermaniae* that extends beyond incidental colonization. Our study contributes to the growing body of evidence that organismal complexity within lichens is a prevalent and largely unexplored dimension of the lichen symbiosis. 

## Datasets

This study analyzes the occurrence of the black fungus *Melanina gundecimermaniae* in metagenomes of the lichens *Umbilicaria pustulata* and *Umbilicaria phaea*.
1. Hi-C genome of *M. gundecimermaniae* was assembled, ([Keller et al.](https://doi.org/10.1002/iub.2934))
2. Lichen metagenome datasets were analyzed using [BWA](Dependencies) and [kraken2](Dependencies)/[bracken](Dependencies).

Underlying lichen metagenome datasets:
* Generated in this study: Europe-wide *U. pustulata* dataset. 10 (9) individuals were sampled at 15 locations across Europe, in 12 different countries, resulting in 149 metagenomes of *U. pustulata*.
* Three elevation gradient datasets of *U. pustulata* sampled in Europe (2x Spain, 1x Itlay) were retrieved from [Dal Grande et al.](https://doi.org/10.1186/s12862-017-0929-8), [Dal Grande et al.](https://doi.org/10.3390/biology11010024), and [Valim et al.](https://doi.org/10.1111/mec.17252). The datasets consist of, in total, 15 pooled metagenomes (100 individuals/sampling site = 1 pooled metagenome).
* Two elevation gradient datasets of *U. phaea* sampled in North America (2x USA, CA) were retrieved from [Merges et al.](https://doi.org/10.1111/1462-2920.15802). The datasets consist of, in total, 11 pooled metagenomes (50 individuals/sampling site = 1 pooled metagenome).


## Notes

This repository is intended to provide reproducibility of the workflow used to conduct this study. Please review all scripts carefully before attempting to rerun the workflow. If you encounter any issues, feel free to report them. Do not hesitate to reach out with any questions.

## Data availability

All underlying data has been retrieved from or deposited at [NCBI](https://www.ncbi.nlm.nih.gov/).
* *Melanina gundecimermaniae* Hi-C rawdata is available under SRR35021504, the assembly can be found under JBAWTZ020000000. The genomic rawdata was retrieved via the SRA accession SRR28254731.
* The Europe-wide *Umbilicara pustulata* metagenome dataset is available under the BioProject accession PRJNA1348468.
* The two spanish *U. pustulata* elevation gradients were retrieved via the BioProject accession PRJEB69222, the italian elevation gradient from PRJEB11664.
* Both North American *U. phaea* elevation gradients were retrieved via the BioProject accession PRJNA693984.

## Dependencies
### Tools
* [ccs/6.4.0](https://github.com/PacificBiosciences/pbbioconda)
* [lima/2.7.1](https://github.com/PacificBiosciences/pbbioconda)
* [bamtools/2.5.2](https://github.com/pezmaster31/bamtools)
* [flye/2.9.1](https://github.com/mikolmogorov/Flye)
* [chromap/0.2.6](https://github.com/haowenz/chromap)
* [samtools/1.20](https://www.htslib.org/)
* [yahs/1.2.2](https://github.com/c-zhou/yahs)
* [ncbi-blast/2.13.0](https://blast.ncbi.nlm.nih.gov/Blast.cgi)
* [diamond/2.0.15](https://uni-tuebingen.de/fakultaeten/mathematisch-naturwissenschaftliche-fakultaet/fachbereiche/informatik/lehrstuehle/algorithms-in-bioinformatics/software/diamond/)
* [megan/6.24.16](https://uni-tuebingen.de/fakultaeten/mathematisch-naturwissenschaftliche-fakultaet/fachbereiche/informatik/lehrstuehle/algorithms-in-bioinformatics/software/megan6/)
* [busco/v5.4.5](https://gitlab.com/ezlab/busco)
* [tapestry/1.0.1](https://github.com/johnomics/tapestry)
* [fcs/0.5.0](https://github.com/ncbi/fcs)
* [trimmomatic/0.39](https://github.com/usadellab/Trimmomatic)
* [bwa/0.7.17](https://github.com/lh3/bwa)
* [kraken/2.1.3](https://github.com/DerrickWood/kraken2)
* [bracken/2.9](https://github.com/jenniferlu717/Bracken)
### R packages
* [ggplot2 v4.0.1](https://ggplot2.tidyverse.org)
* [performance v0.15.3](https://doi.org/10.21105/joss.03139)

## Acknowledgements

Credits go to the developers and maintainers of the [above-mentioned tools and packages](Dependencies), and for the additional data(sets) used in this analysis to:
* [Dal Grande, F.](https://doi.org/10.1186/s12862-017-0929-8), Sharma, R., Meiser, A., Rolshausen, G., Büdel, B., Mishra, B., Thines, M., Otte, J., Pfenninger, M., & Schmitt, I. (2017). Adaptive differentiation coincides with local bioclimatic conditions along an elevational cline in populations of a lichen-forming fungus. BMC Evolutionary Biology, 17, 93.
* [Dal Grande, F.](https://doi.org/10.3390/biology11010024), Jamilloux, V., Choisne, N., Calchera, A., Rolshausen, G., Petersen, M., Schulz, M., Nilsson, M. A., & Schmitt, I. (2022). Transposable Elements in the Genome of the Lichen-Forming Fungus Umbilicaria pustulata and Their Distribution in Different Climate Zones along Elevation. Biology, 11(1), 24.
* [Valim, H. F.](https://doi.org/10.1111/mec.17252), Dal Grande, F., Wong, E. L., & Schmitt, I. (2024). Circadian clock-and temperature-associated genes contribute to overall genomic differentiation along elevation in lichenized fungi. Molecular Ecology, 33(4), e17252.
* [Keller, V.](https://doi.org/10.1002/iub.2934), Calchera, A., Otte, J., & Schmitt, I. (2025). Genomic features of lichen-associated black fungi. IUBMB Life, 77(1), e2934.

## Citation

* [Keller, V.](https://doi.org/10.1016/j.cub.2025.12.046), Calchera, A., Otte, J., Tuovinen Nogerius, V., & Schmitt, I. (2026). Ubiquitous occurrence of the black fungus *Melanina gundecimermaniae* in the lichen *Umbilicaria pustulata*. Current Biology, 36, 748-759.e5.
* Please also cite the respective [tool](Dependencies) or [dataset](Acknowledgements) appropriately, in accordance with the respective owners' citation guidelines.

## License
For details see [MIT LICENSE](LICENSE).
