#' server function for shiny app
#'
#' @importFrom magrittr %>%
#' @import ggplot2
#'
shinypackage_server <- function(input, output) {

    getFilteredBirthDt <- function() {
        message('filtered birth dt function has been called with ', input$period)

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
