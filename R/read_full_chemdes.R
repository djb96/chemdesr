#' Read Full ChemDes
#'
#' @description This function scrapes all available chemical information from ChemDes, a free web-based platform for the calculation of molecular descriptors and fingerprints. This is effectively just a wrapper around read_chemdes which automatically reads in Chemopy, CDK, RDKit, Pybel, and PaDEL data for the given smiles.
#'
#' @param smile A simplified molecular-input line-entry system ("SMILES") string.
#' @param chatty TRUE/FALSE. If TRUE, will print messages to the console updating you of the stage of scraping.
#'
#' @author Jack Davison, \email{jd1184@@york.ac.uk}
#' @return A "wide" tibble of chemical information, labelled with the SMILES string.
#' @export

read_full_chemdes = function(smile, chatty = F){

  chemopy = chemdesr::read_chemdes(smile = smile, desc = "chemopy")
  if(chatty){print(glue::glue("{smile} Chemopy Done."))}

  cdk = chemdesr::read_chemdes(smile = smile, desc = "cdk")
  if(chatty){print(glue::glue("{smile} CDK Done."))}

  rdk = chemdesr::read_chemdes(smile = smile, desc = "rdk")
  if(chatty){print(glue::glue("{smile} RDKit Done."))}

  pybel = chemdesr::read_chemdes(smile = smile, desc = "pybel")
  if(chatty){print(glue::glue("{smile} Pybel Done."))}

  padel = chemdesr::read_chemdes(smile = smile, desc = "padel")
  if(chatty){print(glue::glue("{smile} PaDEL Done."))}

  all = chemopy %>%
    dplyr::inner_join(cdk, by = "smile") %>%
    dplyr::inner_join(rdk, by = "smile") %>%
    dplyr::inner_join(pybel, by = "smile") %>%
    dplyr::inner_join(padel, by = "smile") %>%
    dplyr::relocate(smile) %>%
    tibble::tibble()

  if(chatty){print(glue::glue("{smile} Data Combined."))}

  return(all)

}




