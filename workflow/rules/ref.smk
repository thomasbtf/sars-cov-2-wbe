rule get_genome:
    output:
        "resources/genomes/{accession}.fasta",
    params:
        accession=(
            lambda w: config["virus-reference-genome"]
            if w.accession == "main"
            else w.accession
        ),
    log:
        "logs/genomes/get-genome/{accession}.log",
    conda:
        "../envs/entrez.yaml"
    resources:
        ncbi_api_requests=1,
    shell:
        "((esearch -db nucleotide -query '{params.accession}' | "
        "efetch -format fasta > {output}) && [ -s {output} ]) 2> {log}"


rule get_gisaid_provision:
    output:
        temp("resources/gisaid/provision.json"),
    log:
        "logs/get_gisaid_provision.log",
    conda:
        "../envs/unix.yaml"
    shell:
        "(curl -L -u $GISAID_API_TOKEN https://www.epicov.org/epi3/3p/resseq02/export/provision.json.xz |"
        " xz -d -T0 > {output})"
        " > {log} 2>&1"
