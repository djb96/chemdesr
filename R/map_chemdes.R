#' Map ChemDes
#'
#' @description This function is a wrapper around \code{read_full_chemdes}, allowing for a vector of SMILES strings to be mapped over. This function should take roughly 30 seconds per compound.
#'
#' @param smiles A vector of simplified molecular-input line-entry system ("SMILES") strings.
#' @param chatty TRUE/FALSE. If TRUE, will print messages to the console updating you of the stage of scraping.
#'
#' @author Jack Davison, \email{jd1184@@york.ac.uk}
#' @return A "wide" tibble of chemical information, labelled with the SMILES string.
#' @export

map_chemdes = function(smiles, chatty = T){

  df = purrr::map_dfr(.x = smiles,
                      .f = chemdesr::read_full_chemdes,
                      chatty = chatty)

  return(df)

}
