#' Read ChemDes
#'
#' @description This function scrapes chemical information from ChemDes, a
#' free web-based platform for the calculation of molecular descriptors and
#' fingerprints.
#'
#' @param smile A simplified molecular-input line-entry system ("SMILES") string.
#' @param desc The descriptors you wish to scrape. One of "Chemopy", "CDK", "RDKit", "Pybel", or "PaDEL" (not case sensitive).
#'
#' @author Jack Davison, \email{jd1184@@york.ac.uk}
#' @return A "wide" tibble of chemical information, labelled with the SMILES string.
#' @export

read_chemdes <- function(smile, desc = "chemopy") {
  desc <- dplyr::if_else(desc == "RDKit", "rdk", desc)

  url <- paste0("http://www.scbdd.com/", tolower(desc), "_desc/index/")

  session <- rvest::session(url)

  form <- rvest::html_form(session)[[1]] %>%
    rvest::html_form_set("Smiles" = smile)

  new_sesh <- rvest::session_submit(x = session, form = form)

  df <- rvest::html_table(new_sesh)[[1]][2:3] %>%
    tidyr::pivot_wider(names_from = X2, values_from = X3) %>%
    dplyr::mutate(smile = smile)

  return(df)
}
