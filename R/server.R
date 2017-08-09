utils::globalVariables(c("year", "age", "num_birth", "education_level"))

#' server function for shiny app
#'
#' @importFrom magrittr %>%
#' @import ggplot2
#'
#' @param input shiny input
#' @param output shiny output
#'
#' @return a shiny server object
shinypackage_server <- function(input, output) {
    message(
        "contents of root folder to demonstrate full unmodified access:\n",
        paste(list.files(include.dirs = TRUE), collapse = "\n")
    )

    getFilteredBirthDt <- function() {
        cleaned_birth_data %>%
            dplyr::filter(year >= input$period[1] & year <= input$period[2])
    }

    output$birth_dt <- renderDataTable(
        getFilteredBirthDt()
    )

    output$birth_summary_plot <- renderPlot({
        getFilteredBirthDt() %>%
            ggplot(aes(x = age, y = num_birth, fill = education_level)) +
            geom_col(position = 'dodge') +
            facet_grid(year ~ country) +
            theme(legend.position = 'bottom', legend.direction = 'vertical')
    })

}
