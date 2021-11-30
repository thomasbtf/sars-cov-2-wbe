rule fastp_pe:
    input:
        sample=get_fastqs,
    output:
        trimmed=temp(
            [
                "results/trimmed/{sample}.1.fastq.gz",
                "results/trimmed/{sample}.2.fastq.gz",
            ]
        ),
        html="results/trimmed/{sample}.html",
        json="results/trimmed/{sample}.fastp.json",
    params:
        adapters=config["adapters"],
        extra="--qualified_quality_phred {} ".format(
            config["quality-criteria"]["min-PHRED"]
        )
        + "--length_required {}".format(config["quality-criteria"]["min-length-reads"]),
    log:
        "logs/fastp/{sample}.log",
    threads: 2
    wrapper:
        "0.70.0/bio/fastp"
