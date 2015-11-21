# Hadow DevDataProd Shiny application
# ui.R

mi <- .00000001 # min for numbers
ma <- .99999999 # max fornumbers
ms <- .01      # step

library(shiny)
shinyUI(pageWithSidebar(

headerPanel("Probability of Disease Given a Test Result"),

sidebarPanel(
          tags$div(title="A medical test that gives a positive or negative indication",
                   selectInput("uite", "Test:",
        choices = c('Mammogram','PSA', "HIV", "another"))),
        tags$div(title="The test indication you received",
                 selectInput( "uitr", "Test Result:",
        choices = c('Positive','Negative'))),
        h4("_________________________"),

conditionalPanel(
          condition = "input.uite == 'another'",
          tags$div(title="You can enter a new test or different parameters",
                   textInput("uitn", "Enter Another Test:")),
          tags$div(title="Prevalence is the percent of the population with this disease.
                 High risk populations have a higher number. Enter a number between 0 and 1.0",
                   numericInput("uipr", "Prevalence:",  0.0, min = mi, max=ma, step=ms)),
          tags$div(title="Sensitivity is the proportion of correctly identified positive conditions. Enter a number between 0 and 1.0",
                   numericInput("uise", "Sensitivity:", 0.0, min = mi, max=ma, step=ms)),
          tags$div(title="Specificity is the proportion of correctly identified negative conditions. Enter a number between 0 and 1.0",
                   numericInput("uisp", "Specificity:", 0.0, min = mi, max=ma, step=ms))
  )),

  mainPanel(
    h4('Diagostic Test'),
    verbatimTextOutput("uote"),
    h4('Test Results'),
    verbatimTextOutput("uotr"),
    h4(HTML("<br>")),
    h4(HTML("<br>")),
    h2(HTML("<br>")),
    h5('Disease Prevalence'),
    verbatimTextOutput("uopr"),
    h5('Test Sensitivity'),
    verbatimTextOutput("uose"),
    h5('Test Specificity'),
    verbatimTextOutput("uosp"),
    h4('Predictive Power (Probability that the test result reflects reality)'),
    verbatimTextOutput("uopp"),
    h4("Confusion Matrix"),
    tags$div(title="TP - True Positive; FN - False Negative; FP - False Positive; TN - True Negative",
             verbatimTextOutput("uocm"))
)
))
