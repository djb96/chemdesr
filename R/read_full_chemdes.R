#' Read Full ChemDes
#'
#' @description This function scrapes all available chemical information from ChemDes, a free web-based platform for the calculation of molecular descriptors and fingerprints. This is effectively just a wrapper around read_chemdes which automatically reads in Chemopy, CDK, RDKit, Pybel, and PaDEL data for the given smiles.
#'
#' @param smiless A simplified molecular-input line-entry system ("SMILES") string.
#' @param chatty TRUE/FALSE. If TRUE, will print messages to the console updating you of the stage of scraping.
#'
#' @author Jack Davison, \email{jd1184@@york.ac.uk}
#' @return A "wide" tibble of chemical information, labelled with the SMILES string.
#' @export

read_full_chemdes = function(smiles, chatty = F){

  chemopy = chemdesr::read_chemdes(smiles = smiles, desc = "chemopy")
  if(chatty){print(glue::glue("{smiles} Chemopy Done."))}

  cdk = chemdesr::read_chemdes(smiles = smiles, desc = "cdk")
  if(chatty){print(glue::glue("{smiles} CDK Done."))}

  rdk = chemdesr::read_chemdes(smiles = smiles, desc = "rdk")
  if(chatty){print(glue::glue("{smiles} RDKit Done."))}

  pybel = chemdesr::read_chemdes(smiles = smiles, desc = "pybel")
  if(chatty){print(glue::glue("{smiles} Pybel Done."))}

  padel = chemdesr::read_chemdes(smiles = smiles, desc = "padel")
  if(chatty){print(glue::glue("{smiles} PaDEL Done."))}

  all = chemopy %>%
    dplyr::inner_join(cdk, by = "smiles") %>%
    dplyr::inner_join(rdk, by = "smiles") %>%
    dplyr::inner_join(pybel, by = "smiles") %>%
    dplyr::inner_join(padel, by = "smiles") %>%
    dplyr::relocate(smiles) %>%
    tibble::tibble()

  if(chatty){print(glue::glue("{smiles} Data Combined."))}

  return(all)

}




