library(shinyBS)

shinyUI(fluidPage(
  
  # suppresses spurious 
  # 'progress' error messages after all the debugging 
  # is done:
  tags$style(type="text/css",
             ".shiny-output-error { visibility: hidden; }",
             ".shiny-output-error:before { visibility: hidden; }"
  ),
  HTML("<hr>"),
  # the main stuff:
    fluidPage( 
      column(
        width=3,
        sidebarPanel(
              width="100%",
              helpText("Population means:"),
              sliderInput("mu1",
                          label = "", 
                          min = 1, max = 10, step=0.5,
                          value = 5.0),
             sliderInput("mu2",
                          label = "", 
                         min = 1, max = 10, step=0.5,
                          value = 5.0),
             helpText("Population std deviations:"),
             sliderInput("sigma1", 
                          label = "", 
                         min = 1.0, max = 10.0, step=0.5,
                          value = 5.0),
             sliderInput("sigma2", 
                          label = "", 
                         min = 1.0, max = 10.0, step=0.5,
                          value = 5.0),
             helpText("Sample sizes:"),
             numericInput("n1", 
                          label = "", step=50,
                          value = 100),
             numericInput("n2", 
                          label = "", step=50,
                          value = 100),
             wellPanel(actionButton("expt", "New samples"))
        )
      ),
      column(
        width=9,
        fluidRow( 
             column(width=9, plotOutput("histplot")),
             column(width=3, plotOutput("boxplot"))
             ),
        fluidRow( 
               verbatimTextOutput("ttest")
        )
      )
    ),
    HTML("<hr>")
  )
)