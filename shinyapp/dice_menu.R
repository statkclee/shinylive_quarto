# Load required package
library(shiny)

# UI layout
ui <- fluidPage(
  titlePanel("통합 주사위 던지기 모사"),
  sidebarLayout(
    sidebarPanel(
      selectInput("display_mode", "표시 방식 선택", 
                  c("텍스트", "ASCII 아트", "유니코드", "이미지")),
      actionButton("roll", "주사위 던지기")
    ),
    mainPanel(
      uiOutput("result_ui"),
      textOutput("result_text"),
      htmlOutput("result_html")
    )
  )
)

# Server logic
server <- function(input, output, session) {
  observeEvent(input$roll, {
    dice_result <- sample(1:6, 1)
    
    # Text mode
    if (input$display_mode == "텍스트") {
      output$result_text <- renderText({
        paste("주사위 눈은 ", dice_result, "이다.")
      })
      output$result_ui <- renderUI({})
      output$result_html <- renderUI({})
    }
    
    # ASCII art mode
    if (input$display_mode == "ASCII 아트") {
      ascii_art <- switch(
        dice_result,
        "1" = "-----\\n|   |\\n| * |\\n|   |\\n-----",
        "2" = "-----\\n|*  |\\n|   |\\n|  *|\\n-----",
        "3" = "-----\\n|*  |\\n| * |\\n|  *|\\n-----",
        "4" = "-----\\n|* *|\\n|   |\\n|* *|\\n-----",
        "5" = "-----\\n|* *|\\n| * |\\n|* *|\\n-----",
        "6" = "-----\\n|* *|\\n|* *|\\n|* *|\\n-----"
      )
      output$result_ui <- renderUI({
        tagList(
          verbatimTextOutput(paste0("ascii_", dice_result)),
          tags$h3(paste("주사위 눈은 ", dice_result, "이다."))
        )
      })
      output[[paste0("ascii_", dice_result)]] <- renderText({ ascii_art })
    }
    
    # Unicode mode
    if (input$display_mode == "유니코드") {
      unicode_dice <- intToUtf8(9855 + dice_result)
      output$result_text <- renderText({})
      output$result_ui <- renderUI({})
      output$result_html <- renderUI({
        HTML(paste("<span style='font-size: 48px;'>", unicode_dice, "</span>"))
      })
    }
    
    # Image mode (assuming images are stored in a 'www' folder)
    if (input$display_mode == "이미지") {
      output$result_text <- renderText({})
      output$result_ui <- renderUI({
        imageOutput("dice_image")
      })
      output$result_html <- renderUI({})
      output$dice_image <- renderImage({
        list(
          src = paste0("www/dice_0", dice_result, ".png"),
          contentType = "image/png",
          alt = paste("주사위 눈은 ", dice_result, "이다.")
        )
      }, deleteFile = FALSE)
    }
  })
}

# Run the app
shinyApp(ui, server)
