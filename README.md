# SARS-CoV-2 Wastewater Based Ecology

[![Snakemake](https://img.shields.io/badge/snakemake-≥6.11-brightgreen.svg)](https://snakemake.bitbucket.io)
[![Tests](https://github.com/thomasbtf/sars-cov-2-wbe/actions/workflows/main.yaml/badge.svg)](https://github.com/thomasbtf/sars-cov-2-wbe/actions/workflows/main.yaml)

A workflow for quantifying SARS-CoV-2 lineage abundances (e.g., `B.1.167.2` aka `Delta`) in short-read paired-end sequencing data of wastewater.

## Usage

This workflow is written in Snakemake. Its installation instructions and usage are described in the [Snakemake Workflow Catalog](https://snakemake.github.io/snakemake-workflow-catalog/?usage=thomasbtf%2Fsars-cov-2-wbe).

## Results

After you run the workflow, you can find its main output under `results/`. The `.zip` file contains a detailed self-contained HTML report encompassing runtime statistics, provenance information, workflow topology, and results. This report can be passed on to collaborators, provided as a supplementary file in publications, or uploaded to a service like [Zenodo](https://zenodo.org) in order to obtain a citable [DOI](https://en.wikipedia.org/wiki/Digital_object_identifier).

A realistic **example report** from this workflow can be found [here](assets/wbe-report/report.html).

The results are split into two sections. First, the abundance estimations of SARS-CoV-2 are displayed.

![Lineage Abundances](assets/wbe-report/data/raw/28f5f08164a6ece92c9b5411abb289e6fac902627b8a9d98822b92bebe1b8f2f/test-sample.strains.kallisto.svg?raw=true)

The horizontal axis shows the lineage abundances in the sample; the vertical axis shows the called lineage. Lineages below 0.02 are summarized under the term "other".
The estimation is performed with [Kallisto](https://pachterlab.github.io/kallisto/about), taking the SARS CoV-2 Wuhan Sequence `NC_045512.2` as a predefined reference.

The second section display several metrics related to the sequencing itself.

## Citation

If you use this workflow in a paper, don't forget to give credits to the authors by citing the URL of this repository or the following:

```bibtex
@misc{sars-cov-2-wbe,
  author = {Thomas Battenfeld},
  title = {SARS-CoV-2 Wastewater Based Ecology},
  year = {2021},
  publisher = {GitHub},
  journal = {GitHub repository},
  howpublished = {\url{https://github.com/thomasbtf/sars-cov-2-wbe}}
}
```
