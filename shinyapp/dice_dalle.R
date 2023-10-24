library(shiny)

ui <- fluidPage(
  titlePanel("주사위 던지기 모사"),
  sidebarLayout(
    sidebarPanel(
      actionButton("roll", "주사위 던지기")
    ),
    mainPanel(
      imageOutput("result", width = "20%", height = "auto"),
      htmlOutput("dice_text")
    )
  )
)

server <- function(input, output, session) {
  observeEvent(input$roll, {
    dice_result <- sample(1:6, 1)
    output$result <- renderImage({
      list(
        src = paste0("www/dice_0", dice_result, ".png"),
        contentType = "image/png",
        alt = paste("주사위 눈은 ", dice_result, "이다.")
      )
    }, deleteFile = FALSE)
    
    output$dice_text <- renderUI({
      HTML(paste("<h3>주사위 눈은 ", dice_result, "이다.</h3>"))
    })
  })
}

shinyApp(ui = ui, server = server)
