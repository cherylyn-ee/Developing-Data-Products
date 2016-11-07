# Load packages needed - ISLR & shiny
library(shiny)
library(ISLR)
library(caret)
library(gbm)

data("College")

shinyUI(fluidPage(
        titlePanel("Best Match College & Grad Rate Predictor"),
        sidebarLayout(
                sidebarPanel(
                        h3("Input College Criteria"),
                        helpText("Drag and check checkbox to view college choices according to criteria below."),
                        checkboxInput("private", "Private Yes", value=TRUE),
                        sliderInput("outstate", "Out-of-state tuition", 2300, 22000, value = 50),
                        sliderInput("personroom", "Personal & Room and Board Costs", 2500, 12000, value = 50),
                        sliderInput("top25", "Pct. new students from top 25% of H.S. class", 0, 100, value = 1),
                        sliderInput("apps", "Number of applications received", 80, 50000, value = 200),
                        submitButton("Submit")
                ),
                mainPanel(
                        tabsetPanel(type = "tabs", tabPanel("Table", br(), dataTableOutput('table1')),
                                                    tabPanel("Predict Graduation Rate", 
                                                             h3("Graduation Rate Prediction According To Input"),
                                                             helpText("Estimated Rate of Graduation based on criteria in input"),
                                                             br(), textOutput("pred1"))
                
                        
                                    )
                        )
        )
))
                
  
 
