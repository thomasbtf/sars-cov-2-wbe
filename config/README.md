# General settings

To configure this workflow, modify `config/config.yaml` according to your needs, following the explanations provided in the file.

## API Token
This workflow downloads all available and up-to-date SARS-CoV-2 reference lineages via an API provided by [GISAID](https://www.gisaid.org/) is used.  To access this API, first, one must [register with GISAID](https://www.gisaid.org/registration/register/). After you log in, you can send a programmatic access request [via the Contact Form](https://www.gisaid.org/help/contact/).

After programmatic access has been granted, export the API token as `GISAID_API_TOKEN` environment variable, e.g., via:

```bash
export GISAID_API_TOKEN=<USER>:<TOKEN>
```
