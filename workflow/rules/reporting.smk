rule snakemake_reports:
    input:
        "results/plots/all.major-strain.strains.kallisto.svg",
        "results/qc/multiqc.html",
        expand(
            "results/plots/strain-calls/{sample}.strains.kallisto.svg",
            sample=get_samples(),
        ),
    output:
        "results/wbe-report.zip",
    params:
        for_testing=(
            "--snakefile ../workflow/Snakefile" if config.get("testing") else ""
        ),
    conda:
        "../envs/snakemake.yaml"
    log:
        "logs/snakemake_reports.log",
    shell:
        "snakemake --nolock --report-stylesheet resources/custom-stylesheet.css {input} "
        "--report {output} {params.for_testing} "
        "> {log} 2>&1"
