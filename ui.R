library(shiny)
shinyUI(pageWithSidebar(
  headerPanel("Continuous distributions"),
  sidebarPanel(
    h3('Define distribution'),
    radioButtons("dist", "Distribution type:",
                 c("Normal",
                   "Uniform",
                   "Lognormal")
                ),
    numericInput("mean", "Mean",0),
    numericInput("sd", "Standard Deviation",1),
    numericInput("min", "Minimum x value",-4),
    numericInput("max", "Maximum x value",4),
    submitButton("Update View")
  ),
  mainPanel(
#    verbatimTextOutput('test1'),
    plotOutput('graph')
  )
))