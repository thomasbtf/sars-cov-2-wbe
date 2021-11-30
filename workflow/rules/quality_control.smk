rule fastqc:
    input:
        get_fastqs,
    output:
        html="results/qc/fastqc/{sample}.html",
        zip="results/qc/fastqc/{sample}_fastqc.zip",  # the suffix _fastqc.zip is necessary for multiqc to find the file. If not using multiqc, you are free to choose an arbitrary filename
    params:
        "--quiet",
    log:
        "logs/fastqc/{sample}.log",
    threads: 1
    wrapper:
        "0.80.2/bio/fastqc"


# TODO: Change shell invocation to warpper when v1.11 is published.
rule multiqc:
    input:
        expand(
            [
                "results/qc/fastqc/{sample}_fastqc.zip",
                "results/trimmed/{sample}.fastp.json",
            ],
            sample=get_samples(),
        ),
    output:
        report(
            "results/qc/multiqc.html",
            htmlindex="multiqc.html",
            caption="../report/multiqc.rst",
            category="2. Sequencing Details",
        ),
    params:
        input_dirs=lambda w, input: set(path.dirname(fp) for fp in input),
        output_dir=lambda w, output: path.dirname(output[0]),
        output_name=lambda w, output: path.basename(output[0]),
        params="--config resources/multiqc_config.yaml --title 'Results for SARS-CoV-2 WBE'",
    conda:
        "../envs/multiqc.yaml"
    log:
        "logs/multiqc.log",
    shell:
        "multiqc {params.params} --force -o {params.output_dir} "
        "-n {params.output_name} {params.input_dirs} > {log} 2>&1"
