deg_limma <- function(mergeset,
                      design) {

  fit <- limma_fitting(mergeset, design)

  t <- limma::topTable(
    fit,
    coef = 2,
    number = Inf,
    p.value = 0.05,
    lfc = 2
  )
  genes <- rownames(t)
  return(genes)
}

#' @title identify_degs
#'
#' @description Helper function to identify DEGs based on the limma package
#'
#' @param q_value A numeric value for the q-value (false discovery rate)
#'   (default=0.01).
#'
#' @inheritParams sigidentDEG
#'
#' @export
identify_degs <- function(mergeset,
                          diagnosis,
                          q_value = 0.01) {

  stopifnot(
    q_value > 0 | q_value <= 0.05,
    is.numeric(q_value)
  )

  design <- stats::model.matrix(~ diagnosis)

  fit <- limma_fitting(mergeset, design)

  t <- limma::topTable(
    fit,
    coef = 2,
    number = Inf,
    p.value = q_value,
    lfc = 2,
    adjust.method = "BH"
  )
  genes <- rownames(t)
  return(genes)
}

limma_fitting <- function(mergeset,
                          design) {

  fit <- limma::eBayes(limma::lmFit(mergeset, design))

  return(fit)
}


#' @title limma_top_table
#'
#' @description Helper function to get DEG results
#'
#' @inheritParams sigidentDEG
#' @inheritParams identify_degs
#'
#' @export
limma_top_table <- function(mergeset,
                            diagnosis,
                            q_value) {

  design <- stats::model.matrix(~ diagnosis)

  fit <- limma_fitting(mergeset, design)

  t <- limma::topTable(
    fit,
    coef = 2,
    number = Inf,
    p.value = q_value,
    lfc = 2,
    adjust.method = "BH"
  )

  t[, 2:4] <- NULL
  t[, 3] <- NULL
  t <- cbind(rownames(t), t)
  colnames(t) <- c("Probe ID", "logFC", "adj.q_value")

  return(t)
}

#' @title export_deg_annotations
#'
#' @description Helper function to export DEG annotations from mergedset.
#'
#' @param mergedset A large Expression Set. The output of the function
#'   `sigident.preproc::geo_merge`. Please note, that mergedset holds data,
#'   which are not yet batch corrected.
#' @param idtype A character string. The type of ID used to name the
#'   genes. One of 'entrez' or 'affy' intended to use either entrez IDs or
#'   affy IDs. Caution: when using entrez IDs, missing and duplicated IDs
#'   are being removed!
#'
#' @inheritParams plot_deg_heatmap
#'
#' @seealso sigident.preproc
#'
#' @export
export_deg_annotations <- function(mergedset,
                                   genes,
                                   idtype) {

  stopifnot(idtype %in% c("entrez", "affy"))
  ids <- mergedset@featureData@data[, "ID"]
  sym <- Biobase::fData(mergedset)["Gene symbol"][ids, ]
  tit <- Biobase::fData(mergedset)["Gene title"][ids, ]
  gb_acc <- Biobase::fData(mergedset)["GenBank Accession"][ids, ]
  entrez <- Biobase::fData(mergedset)["Gene ID"][ids, ]
  degs_info <- data.table::data.table(cbind(ids,
                                            sym,
                                            tit,
                                            gb_acc,
                                            entrez))
  colnames(degs_info) <-
    c("probe_ID",
      "gene_symbol",
      "gene_title",
      "genebank_accession",
      "entrez_id")

  if (idtype == "entrez") {
    ret <- degs_info[get("entrez_id") %in% genes, ]
  } else if (idtype == "affy") {
    ret <- degs_info[get("probe_ID") %in% genes, ]
  }

  return(ret)
}
