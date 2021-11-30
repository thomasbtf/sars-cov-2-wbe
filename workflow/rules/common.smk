from os import path

from snakemake.utils import validate
import pandas as pd

validate(config, schema="../schemas/config.schema.yaml")

validate(pep.sample_table, schema="../schemas/samples.schema.yaml")


def get_samples():
    return list(pep.sample_table["sample_name"].values)


def get_fastqs(wildcards):
    return pep.sample_table.loc[wildcards.sample][["fq1", "fq2"]]


def load_strain_genomes(f):
    strain_genomes = pd.read_csv(f, squeeze=True).to_list()
    strain_genomes.append("resources/genomes/main.fasta")
    return expand("{strains}", strains=strain_genomes)


def get_strain_genomes(wildcards):
    with checkpoints.extract_strain_genomes_from_gisaid.get().output[0].open() as f:
        return load_strain_genomes(f)


def get_reads_after_qc(wildcards, read="both"):

    pattern = expand(
        "results/trimmed/{sample}.{read}.fastq.gz",
        **wildcards,
        read=[1, 2],
    )

    if read == "1":
        return pattern[0]
    if read == "2":
        return pattern[1]

    return pattern
