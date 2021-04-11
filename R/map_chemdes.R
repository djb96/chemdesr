#' Map ChemDes
#'
#' @description This function is a wrapper around read_full_chemdes, allowing for a vector of SMILES strings to be mapped over. This function should take roughly 30 seconds per compound.
#'
#' @param smiles A vector of simplified molecular-input line-entry system ("SMILES") strings.
#' @param chatty TRUE/FALSE. If TRUE, will print messages to the console updating you of the stage of scraping.
#'
#' @author Jack Davison, \email{jd1184@@york.ac.uk}
#' @return A "wide" tibble of chemical information, labelled with the SMILES string.
#' @export

map_chemdes = function(smiles, chatty = F){

  df = purrr::map_dfr(.x = smiles,
                      .f = chemdesr::read_full_chemdes,
                      chatty = chatty)

  return(df)

}

read_chemdes = function(smile, desc = "chemopy"){

  desc = dplyr::if_else(desc == "RDKit", "rdk", desc)

  url = paste0("http://www.scbdd.com/",tolower(desc),"_desc/index/")

  session = rvest::session(url)

  form = rvest::html_form(session)[[1]] %>%
    rvest::html_form_set("Smiles" = smile)

  new_sesh = rvest::session_submit(x = session, form = form)

  df = rvest::html_table(new_sesh)[[1]][2:3] %>%
    tidyr::pivot_wider(names_from = X2, values_from = X3) %>%
    dplyr::mutate(smile = smile)

  return(df)

}
