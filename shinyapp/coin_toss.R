# Shiny 패키지 불러오기
library(shiny)

# UI 정의
ui <- fluidPage(
  # 앱 제목
  titlePanel("동전 던지기"),
  
  # 사용자 입력을 위한 사이드바 레이아웃
  sidebarLayout(
    sidebarPanel(
      # 슬라이더 입력 추가 (범위 1~10으로 제한)
      sliderInput("num_flips", "던지기 횟수:", min = 1, max = 10, value = 1),
      # 버튼 추가
      actionButton("flip_button", "동전 던지기")
    ),
    
    # 출력을 표시할 메인 패널
    mainPanel(
      uiOutput("result")
    )
  )
)

# 서버 로직 정의
server <- function(input, output) {
  
  # 버튼이 클릭될 때마다 동전 던지기 결과 출력
  observeEvent(input$flip_button, {
    # 선택된 던지기 횟수에 따라 동전 던지기
    coin_results <- sample(c("앞면", "뒷면"), input$num_flips, replace = TRUE)
    # 결과 카운트
    heads_count <- sum(coin_results == "앞면")
    tails_count <- sum(coin_results == "뒷면")
    # 모든 경우의 수 계산
    total_cases <- 2^input$num_flips
    # 결과 출력
    result_text <- paste(
      "동전 던지기 결과: ", paste(coin_results, collapse = ", "),
      "<br><br>앞면 횟수:", heads_count,
      "<br><br>뒷면 횟수:", tails_count,
      "<br><br>총 던지기 횟수:", input$num_flips,
      "<br><br><br>총 경우의 수:", total_cases,
      sep = ""
    )
    output$result <- renderUI({
      HTML(result_text)
    })
  })
  
}

# 앱 실행
shinyApp(ui = ui, server = server)
