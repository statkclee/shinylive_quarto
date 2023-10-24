library(shiny)

ui <- fluidPage(
  titlePanel("ASCII 주사위 던지기 모사"),
  sidebarLayout(
    sidebarPanel(
      actionButton("roll", "주사위 던지기")
    ),
    mainPanel(
      uiOutput("result")
    )
  )
)

server <- function(input, output) {
  observeEvent(input$roll, {
    dice_result <- sample(1:6, 1)
    ascii_art <- switch(
      dice_result,
      "1" = "-----\n|   |\n| * |\n|   |\n-----",
      "2" = "-----\n|*  |\n|   |\n|  *|\n-----",
      "3" = "-----\n|*  |\n| * |\n|  *|\n-----",
      "4" = "-----\n|* *|\n|   |\n|* *|\n-----",
      "5" = "-----\n|* *|\n| * |\n|* *|\n-----",
      "6" = "-----\n|* *|\n|* *|\n|* *|\n-----"
    )
    output$result <- renderUI({
      tagList(
        verbatimTextOutput(paste0("ascii_", dice_result)),
        tags$h3(paste("주사위 눈은 ", dice_result, "이다."))
      )
    })
    output[[paste0("ascii_", dice_result)]] <- renderText({ ascii_art })
  })
}

shinyApp(ui = ui, server = server)
