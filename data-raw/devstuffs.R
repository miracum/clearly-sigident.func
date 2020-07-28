packagename <- "sigident.func"

# remove existing description object
unlink("DESCRIPTION")
# Create a new description object
my_desc <- desc::description$new("!new")
# Set your package name
my_desc$set("Package", packagename)
# Set author names
my_desc$set_authors(c(
    person("Lorenz A.", "Kapsner", email = "lorenz.kapsner@uk-erlangen.de", role = c('cre', 'aut'),
           comment = c(ORCID = "0000-0003-1866-860X")),
    person("Johannes", "Vey", role = c('aut'),
           comment = c(ORCID = "0000-0002-2610-9667")),
  person("Meik", "Kunz", role = c('aut')),
  person("Andreas", "Pittroff", role = c('aut'))
))
# Remove some author fields
my_desc$del("Maintainer")
# Vignette Builder
my_desc$set("VignetteBuilder" = "knitr")
# Set the version
my_desc$set_version("0.0.4")
# The title of your package
my_desc$set(Title = "Sigident Functional Analysis")
# The description of your package
my_desc$set(Description = "Functional analysis. Part of the sigident package framework.")
# The description of your package
my_desc$set("Date" = as.character(Sys.Date()))
# The urls
my_desc$set("URL", "https://github.com/miracum/clearly-sigident.func")
my_desc$set("BugReports", "https://github.com/miracum/clearly-sigident.func/issues")
# License
my_desc$set("License", "GPL-3")

# BioConductor stuff
my_desc$set("biocViews" = "")


# Save everyting
my_desc$write(file = "DESCRIPTION")

# License
usethis::use_gpl3_license(name = "Universitätsklinikum Erlangen")


# add Imports and Depends
# Listing a package in either Depends or Imports ensures that it’s installed when needed
# Imports just loads the package, Depends attaches it
# Loading will load code, data and any DLLs; register S3 and S4 methods; and run the .onLoad() function.
##      After loading, the package is available in memory, but because it’s not in the search path,
##      you won’t be able to access its components without using ::.
##      Confusingly, :: will also load a package automatically if it isn’t already loaded.
##      It’s rare to load a package explicitly, but you can do so with requireNamespace() or loadNamespace().
# Attaching puts the package in the search path. You can’t attach a package without first loading it,
##      so both library() or require() load then attach the package.
##      You can see the currently attached packages with search().

# Depends

# Imports (CRAN packages)
usethis::use_package("data.table", type="Imports")
usethis::use_package("ggplot2", type="Imports")
usethis::use_package("gplots", type="Imports")
usethis::use_package("sigident.preproc", type="Imports")

# Bioconductor
# https://github.com/r-lib/devtools/issues/700
usethis::use_package("Biobase", type="Import")
usethis::use_package("clusterProfiler", type = "Imports")
usethis::use_package("pathfindR", type = "Suggests")
usethis::use_package("pathview", type = "Imports")
usethis::use_package("limma", type="Imports")


# Development package
preproc_tag <- "v0.0.5"
devtools::install_github("miracum/clearly-sigident.preproc", ref = preproc_tag, upgrade = "always")
# https://cran.r-project.org/web/packages/devtools/vignettes/dependencies.html
desc::desc_set_remotes(c(
  paste0(
    "github::miracum/clearly-sigident.preproc@", preproc_tag)
),
file = usethis::proj_get())



# Suggests
usethis::use_package("testthat", type = "Suggests")
usethis::use_package("rmarkdown", type = "Suggests")
usethis::use_package("qpdf", type = "Suggests")
usethis::use_package("knitr", type = "Suggests")
usethis::use_package("lintr", type = "Suggests")

# buildignore
usethis::use_build_ignore(".gitlab-ci.yml")
usethis::use_build_ignore("data-raw")
usethis::use_build_ignore("vignettes/geodata")
usethis::use_build_ignore("vignettes/plots")
usethis::use_build_ignore("geodata")
usethis::use_build_ignore("plots")
usethis::use_build_ignore("csv")
usethis::use_build_ignore("ci")
usethis::use_build_ignore(".vscode")
usethis::use_build_ignore(".lintr")

# gitignore
usethis::use_git_ignore("/*")
usethis::use_git_ignore("/*/")
usethis::use_git_ignore("*.log")
usethis::use_git_ignore("!/.gitignore")
usethis::use_git_ignore("!/.gitlab-ci.yml")
usethis::use_git_ignore("!/data-raw/")
usethis::use_git_ignore("!/DESCRIPTION")
usethis::use_git_ignore("!/inst/")
usethis::use_git_ignore("!/LICENSE.md")
usethis::use_git_ignore("!/man/")
usethis::use_git_ignore("!NAMESPACE")
usethis::use_git_ignore("!/R/")
usethis::use_git_ignore("!/ci/")
usethis::use_git_ignore("!/vignettes/")
usethis::use_git_ignore("/vignettes/*")
usethis::use_git_ignore("!/vignettes/*.Rmd")
usethis::use_git_ignore("!/README.md")
usethis::use_git_ignore("!/tests/")
usethis::use_git_ignore("/.Rhistory")
usethis::use_git_ignore("!/*.Rproj")
usethis::use_git_ignore("/.Rproj*")
usethis::use_git_ignore("/.RData")
usethis::use_git_ignore("/.vscode")
usethis::use_git_ignore("!/.lintr")

# code coverage
#covr::package_coverage()

# lint package
#lintr::lint_package()
