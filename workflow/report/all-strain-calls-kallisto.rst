Lineage calls for all samples. 
Horizontal axis shows the count of the respective lineage, vertical axis shows the called lineages.
{% if snakemake.wildcards.mode == "major" %}
Only the major lineage in each sample is counted.
{% else %}
All lineages above {{ snakemake.config["abundance-quantification"]["min-fraction"] * 100 }}% are counted.
{% endif %}

Fraction estimation was performed with `Kallisto <https://pachterlab.github.io/kallisto>`_, taking the following predefined sequences as reference: {{ snakemake.config["virus-reference-genome"] }}.

{% for genome in snakemake.config["abundance-quantification"].get("genomes", []) %}
* {{ genome }}
{% endfor %}