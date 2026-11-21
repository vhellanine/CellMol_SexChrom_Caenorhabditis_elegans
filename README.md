# Cell and Molecular Biology Laboratory Activity
## Sex-Chromosome Dosage in *Caenorhabditis elegans* Using NCBI, Galaxy, and R

---

## 1. Project Overview

This project investigates sex-chromosome dosage in *Caenorhabditis elegans* (roundworm) using publicly available whole-genome sequencing (WGS) data and a reference genome assembly.

The activity uses genomic data obtained from the National Center for Biotechnology Information (NCBI), processes sequencing reads using Galaxy, and analyzes chromosome-specific sequencing depth using R.

The main objective is to estimate the relative dosage of the X chromosome compared with the autosomes using read-depth analysis.

---

## 2. Objectives

1. Identify a suitable animal species with an established sex-chromosome system and chromosome-level genome assembly.
2. Obtain publicly available whole-genome sequencing reads and a reference genome assembly from NCBI.
3. Perform quality assessment and read alignment using Galaxy.
4. Calculate chromosome-specific sequencing coverage.
5. Compare X-chromosome coverage with median autosomal coverage.
6. Infer the sex-chromosome dosage pattern based on the X-to-autosome ratio.
7. Interpret the results while considering the limitations of read-depth-based sex-chromosome inference.

---

## 3. Selected Species

| Information | Details |
|---|---|
| Species | *Caenorhabditis elegans* |
| Common name | Roundworm |
| Sex-determination system | XX/XO |
| Female/hermaphrodite chromosome complement | XX |
| Male chromosome complement | XO |
| Reference genome assembly | WBcel235 |
| Assembly accession | GCF_000002985.6 |

*Caenorhabditis elegans* was selected because it has a chromosome-level reference genome, identifiable autosomes and an X chromosome, and publicly available whole-genome sequencing data suitable for read-depth analysis.

The species has an XX/XO sex-determination system rather than the conventional XX/XY or ZZ/ZW systems. This exception was approved by the instructor.

---

## 4. NCBI Data Information

### Reference Genome

| Parameter | Information |
|---|---|
| Assembly accession | GCF_000002985.6 |
| Assembly name | WBcel235 |
| Reference organism | *Caenorhabditis elegans* |
| Assembly level | Chromosome-level |
| Assembly BioSample | Not listed in the assembly record used |

### Whole-Genome Sequencing Data

| Parameter | Information |
|---|---|
| SRA Run accession | SRR28207401 |
| BioSample accession | SAMN40240730 |
| Sequencing platform | Illumina HiSeq 4000 |
| Sequencing type | Whole-genome sequencing |
| Library | Genomic DNA |
| Read type | Paired-end |
| Number of spots | Approximately 3.8 million |
| Total bases | Approximately 1.1 billion |

The assembly reference and WGS sample are not confirmed to originate from the same individual.

### Data Sources

- NCBI Genome: https://www.ncbi.nlm.nih.gov/datasets/genome/
- NCBI SRA: https://www.ncbi.nlm.nih.gov/sra
- Assembly accession: `GCF_000002985.6`
- SRA Run accession: `SRR28207401`

---

## 5. Bioinformatics Workflow

The workflow consisted of retrieving genomic data, assessing sequencing quality, aligning sequencing reads to the reference genome, and calculating chromosome-specific coverage.

### Step 1: Reference Genome Retrieval

The reference genome assembly WBcel235 (`GCF_000002985.6`) was obtained from NCBI and uploaded to Galaxy.

### Step 2: WGS Read Retrieval

The paired-end WGS reads associated with SRA accession `SRR28207401` were imported into Galaxy.

### Step 3: Quality Assessment

FastQC was used to assess the quality of the sequencing reads.

Quality assessment included examining:

- Per-base sequence quality
- Per-sequence quality scores
- GC content
- Sequence duplication levels
- Adapter contamination
- Overrepresented sequences

### Step 4: Read Alignment

The paired-end sequencing reads were aligned to the WBcel235 reference genome using BWA-MEM2.

The resulting mapped reads were generated in BAM format.

### Step 5: Chromosome Coverage Analysis

Samtools coverage was used to calculate sequencing coverage for the reference sequences.

The following quality filters were applied:

- Minimum mapping quality: 20
- Minimum base quality: 20

Mean sequencing depth was used for the chromosome dosage analysis.

### Step 6: Chromosome Classification

The chromosome coverage data were classified into autosomes and the X chromosome using a chromosome-group CSV file.

Five autosomes and one X chromosome were included in the analysis.

### Step 7: Statistical Analysis in R

R was used to:

- Import the chromosome classification file
- Import Galaxy chromosome coverage results
- Merge the coverage data with chromosome classifications
- Calculate median autosomal sequencing depth
- Calculate X-chromosome sequencing depth
- Calculate the X-to-autosome ratio
- Generate a chromosome-depth bar plot
- Infer the chromosome dosage pattern

---

## 6. Chromosome Classification

The following nuclear chromosomes were included in the analysis:

| Sequence ID | Chromosome | Group |
|---|---|---|
| NC_003279.8 | Chromosome I | Autosomal (A) |
| NC_003280.10 | Chromosome II | Autosomal (A) |
| NC_003281.10 | Chromosome III | Autosomal (A) |
| NC_003282.8 | Chromosome IV | Autosomal (A) |
| NC_003283.11 | Chromosome V | Autosomal (A) |
| NC_003284.9 | Chromosome X | X chromosome (X) |

The chromosome identifiers were matched to the reference genome and the chromosome names in the Galaxy coverage output.

The mitochondrial sequence and other non-target sequences were excluded from the chromosome dosage calculation.

---

## 7. Chromosome Coverage Results

Mean sequencing depth obtained from Galaxy Samtools coverage:

| Chromosome | Group | Mean Depth |
|---|---|---:|
| I | A | 8.85539 |
| II | A | 9.67868 |
| III | A | 9.07093 |
| IV | A | 9.25777 |
| V | A | 9.64040 |
| X | X | 10.35210 |

### Summary

| Measurement | Result |
|---|---:|
| Median autosomal depth | 9.6404 |
| X-chromosome depth | 10.3521 |
| X-to-autosome ratio | 1.073825 |
| Inferred dosage pattern | XX-like |

---

## 8. X-to-Autosome Ratio Calculation

The X-to-autosome ratio was calculated using:

\[
X:A = \frac{\text{X chromosome mean depth}}{\text{Median autosomal depth}}
\]

Substituting the observed values:

\[
X:A = \frac{10.3521}{9.6404}
\]

\[
X:A = 1.073825
\]

The calculated ratio was approximately **1.07**.

---

## 9. Interpretation of Results

The median autosomal sequencing depth was 9.6404×, while the X-chromosome sequencing depth was 10.3521×.

The calculated X-to-autosome ratio of 1.073825 indicates an X-chromosome coverage pattern consistent with a two-copy-like dosage relative to the autosomes.

Using the classroom interpretation thresholds:

| X:A Ratio | Interpretation |
|---|---|
| ≥ 0.80 | Two-copy-like |
| ≤ 0.65 | One-copy-like |
| 0.66–0.79 | Ambiguous |

The observed ratio of 1.073825 falls within the two-copy-like category.

### Final Inference

**The WGS sample showed an XX-like X-chromosome dosage pattern based on relative sequencing depth.**

This result represents a coverage-based inference and does not independently confirm the sample's actual karyotype.

---

## 10. Visualization

The chromosome-depth visualization was generated in R using a bar plot to compare the mean sequencing depth among the five autosomes and the X chromosome.

The red dashed horizontal line represents the median autosomal depth.

The X chromosome was highlighted separately to facilitate comparison of its sequencing depth with the autosomal baseline.

---

## 11. Limitations

Several limitations should be considered when interpreting the results:

1. The assembly reference and WGS sample were not confirmed to originate from the same individual.
2. Read-depth analysis provides an inference of chromosome dosage and is not equivalent to direct karyotyping.
3. Sequencing depth may vary among chromosomes due to mapping bias, GC-content variation, repetitive sequences, and technical factors.
4. The analysis included only five autosomes and one X chromosome.
5. The species has an XX/XO sex-determination system, which differs from the conventional XX/XY or ZZ/ZW systems.
6. The analysis depends on the accuracy of the reference genome and chromosome classification.
7. The observed X-to-autosome ratio should be interpreted as an XX-like dosage pattern rather than definitive identification of the donor's sex or chromosome complement.

---

## 12. Conclusion

The sex-chromosome dosage analysis of *Caenorhabditis elegans* was performed using publicly available whole-genome sequencing data aligned to the WBcel235 reference genome.

The median autosomal depth was 9.6404×, and the X-chromosome depth was 10.3521×. The calculated X-to-autosome ratio was 1.073825, indicating an XX-like dosage pattern.

The results demonstrate how chromosome-specific sequencing depth can be used as a bioinformatics approach to estimate sex-chromosome dosage. However, because the assembly and sequencing sample were not confirmed to be from the same donor and because read-depth analysis has technical limitations, the inferred dosage pattern should be interpreted cautiously.

---

## 13. Files Included in This Repository

The repository is organized to document the workflow, analysis, and results.

```text
CellMol_SexChrom_Caenorhabditis_elegans/
│
├── README.md
│
├── data/
│   ├── chromosome_groups.csv
│   └── chromosome_coverage_results.csv
│
├── scripts/
│   └── sex_dosage_analysis.R
│
├── results/
│   └── sex_dosage_results.csv
│
├── figures/
│   └── chromosome_mean_depth.png
│
├── galaxy_screenshots/
│   ├── fastqc_results.png
│   ├── bwa_mem2_alignment.png
│   ├── samtools_idxstats.png
│   └── samtools_coverage.png
│
└── report/
    └── laboratory_report_answers.md
