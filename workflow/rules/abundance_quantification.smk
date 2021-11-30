checkpoint extract_strain_genomes_from_gisaid:
    input:
        "resources/gisaid/provision.json",
    output:
        "results/tables/strain-genomes.txt",
    params:
        save_strains_to=config["abundance-quantification"]["extracted-lineage-genomes"],
    log:
        "logs/extract-strain-genomes.log",
    conda:
        "../envs/pandas.yaml"
    script:
        "../scripts/extract-strains-from-gisaid-provision.py"


rule cat_genomes:
    input:
        get_strain_genomes,
    output:
        temp("results/kallisto/strain-genomes.fasta"),
    log:
        "logs/cat-genomes.log",
    conda:
        "../envs/unix.yaml"
    shell:
        "cat {input} > {output}"


rule kallisto_index:
    input:
        fasta="results/kallisto/strain-genomes.fasta",
    output:
        index=temp("results/kallisto/strain-genomes.idx"),
    params:
        extra="",
    log:
        "logs/kallisto-index.log",
    threads: 8
    wrapper:
        "0.80.2/bio/kallisto/index"


rule kallisto_quant:
    input:
        fastq=get_reads_after_qc,
        index="results/kallisto/strain-genomes.idx",
    output:
        directory("results/quant/{sample}"),
    params:
        extra="",
    log:
        "logs/kallisto_quant/{sample}.log",
    threads: 8
    wrapper:
        "0.80.2/bio/kallisto/quant"


rule call_strains_kallisto:
    input:
        quant="results/quant/{sample}",
        fq1=lambda wildcards: get_reads_after_qc(wildcards, read="1"),
    output:
        "results/tables/strain-calls/{sample}.strains.kallisto.tsv",
    log:
        "logs/call-strains/{sample}.log",
    params:
        min_fraction=config["abundance-quantification"]["min-fraction"],
    conda:
        "../envs/python.yaml"
    notebook:
        "../notebooks/call-strains.py.ipynb"


rule plot_strains_kallisto:
    input:
        "results/tables/strain-calls/{sample}.strains.kallisto.tsv",
    output:
        report(
            "results/plots/strain-calls/{sample}.strains.kallisto.svg",
            caption="../report/strain-calls-kallisto.rst",
            category="1. Overview",
            subcategory="Lineage Fraction per Sample",
        ),
    log:
        "logs/plot-strains-kallisto/{sample}.log",
    params:
        min_fraction=config["abundance-quantification"]["min-fraction"],
    conda:
        "../envs/python.yaml"
    notebook:
        "../notebooks/plot-strains-kallisto.py.ipynb"


rule plot_all_strains_kallisto:
    input:
        expand(
            "results/tables/strain-calls/{sample}.strains.kallisto.tsv",
            sample=get_samples(),
        ),
    output:
        report(
            "results/plots/all.{mode,(major|any)}-strain.strains.kallisto.svg",
            caption="../report/all-strain-calls-kallisto.rst",
            category="1. Overview",
            subcategory="Lineage Calls",
        ),
    log:
        "logs/plot-strains/all.{mode}.log",
    conda:
        "../envs/python.yaml"
    notebook:
        "../notebooks/plot-all-strains-kallisto.py.ipynb"
