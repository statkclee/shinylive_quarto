# Using Unicode characters, 
# the faces can be shown in text using the range U+2680 to U+2685 
# or using decimal &#9856; to &#9861;

library(shiny)

ui <- fluidPage(
  titlePanel("주사위 던지기 모사"),
  sidebarLayout(
    sidebarPanel(
      actionButton("roll", "주사위 던지기")
    ),
    mainPanel(
      htmlOutput("result")
    )
  )
)

server <- function(input, output, session) {
  observeEvent(input$roll, {
    dice_result <- sample(1:6, 1)
    unicode_dice <- intToUtf8(9855 + dice_result)
    output$result <- renderUI({
      HTML(
        paste(
          "<span style='font-size:48px;'>", 
          unicode_dice, 
          "</span>",
          "<h3>", 
          paste("주사위 눈은 ", dice_result, "이다."), 
          "</h3>"
        )
      )
    })
  })
}

shinyApp(ui = ui, server = server)
