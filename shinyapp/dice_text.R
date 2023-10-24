library(shiny)

ui <- fluidPage(
  titlePanel("주사위 던지기 모사"),
  sidebarLayout(
    sidebarPanel(
      actionButton("roll", "주사위 던지기")
    ),
    mainPanel(
      textOutput("result")
    )
  )
)

server <- function(input, output) {
  observeEvent(input$roll, {
    dice_result <- sample(1:6, 1)
    output$result <- renderText({
      paste("주사위 눈은 ", dice_result, "이다.")
    })
  })
}

shinyApp(ui = ui, server = server)
