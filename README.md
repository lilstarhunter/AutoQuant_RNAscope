# Transcriptomic Validation Pipeline

## Objective: Automated quantification of in situ hybridization used to validate single nuclei transcriptmoic changes.

Validated differential expression genes identified by single nuclei RNAsequencing (10x Genomics) to assess the transcriptional changes that occur from chronic volitional self-administration in rodents. 

Two gene targets and 2 reporter genes for phenotypic characterization

4 animals per group. 4 sections were isolated from each animal at the level of the nucleus accumbens in order to capture a snapshot throughout the entire nucleus accumbens. Total of 32 sections each with 3 separate images for the respective fluorescent channels (DAPI = Channel1, Target = Channel 2, Reporter = Channel 3) for a total of 64 images requiring analysis. 

**Workflow**

1. Rename files and update folder structure for more organized batch processing
2. Preprocess Images
    - DAPI channel used for nuclear mask, segmentation of cells to define region of interest
        - Convert to 8-bit binary
        - Dilate
        - Fill holes
        - watershed segmentation
    - Channel 2 & 3 - convereted to 8-bit 
3. Filtering and Quality Control
    - Regions of interest with an area of >0.01 or <1.0px were excluded
    - isoDATA algorithmic thereholding to exclude partial or dying cells
    - Otus thresholding applied to reporter and target.
4. Identify and analyze only cells (regions of interest) with BOTH target and reporter
5. Calculated linear Threshold Overlap Score to identify regions of interest.
6. Calculated integrated density for the target as a measurement of signal intensity

![](images/Fig4.tif)