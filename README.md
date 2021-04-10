# {chemdesr} 📦
Functions used to scrape chemical information from the ChemDes platform, more specifically to assist with running the model found at https://dan-wacl.shinyapps.io/rie_shiny_app/.

To install, type the below code into your R console:

```
devtools::install_github('jack-davison/chemdesr')
```

## Functions
There are two key functions in `chemdesr`:
* `read_chemdes`: Provided a simplified molecular-input line-entry system ("SMILES") string and a specific descriptor (e.g. Chemopy, CDK, etc.), scrapes the ChemDes platform and returns a *wide* data frame of the relevant chemical information. 
* `read_full_chemdes`: A wrapper around `read_chemdes` which automatically reads in Chemopy, CDK, RDKit, Pybel, and PaDEL data for a given *SMILES* string. There is an option to make this function "chatty" if you would like it to update you on its progress.

## Example Workflows
It is very simple to scrape a single compound using `chemdesr`. Your workflow may look something like this:

```
single_smiles = "OC(C)(C(CC(O)=O)CC(O)=O)C"

chemdesr::read_chemdes(single_smiles, desc = "chemopy")

chemdesr::read_full_chemdes(single_smiles, chatty = T)
```

For multiple compounds, I'd suggest using a `map` function from `purrr`. For many compounds, I would recommend enabling the "chatty" option to be kept abreast of the function's progress.

```
my_smiles = c("OC(C)(C(CC(O)=O)CC(O)=O)C", 
              "C(C=CC1)=CC=1C(=O)O", 
              "CC1(C)OC(=O)CC1CC(O)=O")

purrr::map_dfr(.x = my_smiles, .f = chemdesr::read_full_chemdes, chatty = T)
```
