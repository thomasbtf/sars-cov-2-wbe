Lineage calls for {{ snakemake.wildcards.sample }}. 
Horizontal axis shows the fraction in the sample, vertical axis shows the called lineages.
Lineage below {{ snakemake.params.min_fraction }} are summarized under the term "other".

Fraction estimation was performed with `Kallisto <https://pachterlab.github.io/kallisto>`_, taking the following predefined sequences as reference: {{ snakemake.config["virus-reference-genome"] }}.

{% for genome in snakemake.config["abundance-quantification"].get("genomes", []) %}
* {{ genome }}
{% endfor %}