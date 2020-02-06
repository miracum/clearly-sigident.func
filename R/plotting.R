#' @title plot_deg_heatmap
#'
#' @description Helper function to create DEG heatmap
#'
#' @param filename A character string indicating the filename. If default
#'   (\code{NULL}) a plot named `DEG_heatmap.png` will be created
#'   inside the directory "./plots".
#' @param genes A object. The output of the function `identify_degs()`.
#' @param patientcolors A object. The ouput of the function `color_heatmap()`.
#'
#' @inheritParams sigidentDEG
#'
#' @export
plot_deg_heatmap <- function(mergeset,
                             genes,
                             patientcolors,
                             filename = NULL) {
  if (is.null(filename)) {
    filename <- "./plots/DEG_heatmap.png"
    if (!dir.exists("./plots/")) {
      dir.create("./plots/")
    }
  }

  grDevices::png(
    filename = filename,
    res = 150,
    height = 2000,
    width = 3000
  )
  print({
    gplots::heatmap.2(
      mergeset[genes, ],
      ColSideColors = patientcolors,
      key = TRUE,
      symkey = FALSE,
      density.info = "none",
      scale = "none",
      trace = "none",
      col = grDevices::topo.colors(100),
      cexRow = 0.4,
      cexCol = 0.4
    )
  })
  grDevices::dev.off()
}

#' @title color_heatmap
#'
#' @description Helper function to color the heatmap
#'
#' @inheritParams sigidentDEG
#'
#' @export
color_heatmap <- function(sample_metadata) {

  targetcol <- "target"
  controlname <- "Control"

  discoverydata <- sample_metadata[[targetcol]]

  return(
    unlist(
      lapply(
        discoverydata, function(tumor) {
          #% healthy=blue
          return(
            ifelse(tumor == controlname,
                   "#0000FF",
                   "#FF0000")
          )
        }
      )
    )
  )
}


#' @title plot_enriched_barplot
#'
#' @description Helper function to create enrichted barplots
#'
#' @param filename A character string indicating the filename. If default
#'   (\code{NULL}) a plot named `Enriched_{type}.png` will be created
#'   inside the directory "./plots".
#' @param enrichmentobj An object resulting from the function
#'   `go_enrichment_analysis()`.
#' @param type A character string. One of eiter "GO" or "KEGG".
#' @param show_category An integer. Indicating the number of maximum categories
#'   to show in barplot.
#'
#' @export
plot_enriched_barplot <- function(enrichmentobj,
                                  type,
                                  filename = NULL,
                                  show_category = 20) {

  stopifnot(is.character(type),
            type %in% c("GO", "KEGG"),
            is.numeric(show_category))

  if (is.null(filename)) {
    filename <- paste0("./plots/Enriched_", type, ".png")
    if (!dir.exists("./plots/")) {
      dir.create("./plots/")
    }
  }

  grDevices::png(
    filename = filename,
    res = 150,
    height = 1000,
    width = 2000
  )
  print({
    graphics::barplot(
      enrichmentobj,
      showCategory = show_category) +
      ggplot2::ggtitle(paste0("Enriched ", type, " terms")) +
      ggplot2::ylab("Gene count")
  })
  grDevices::dev.off()
}
