# Load packages needed - ISLR & shiny
library(shiny)
library(caret)
library(ISLR)
library(dplyr)
library(gbm)

data("College")
College2<-College
College2$Cost <- College$Personal+College$Room.Board
College2$Name <- row.names(College)

shinyServer(function(input, output) {
        output$table1 <- renderDataTable({
        oustate_out <- seq(from = 2300, to = input$outstate, by = 1)
        personroom_out <- seq(from = 2500, to = input$personroom, by = 1)
        top25_out <- seq(from = input$top25, to = 100, by = 0.1)
        app_out <- seq(from = 80, to = input$apps, by = 1)
        private_out <- ifelse(input$private == TRUE, "Yes", "No")
        College2 <- filter(College2, Outstate %in% oustate_out, Private %in% private_out, Cost %in% personroom_out,
                           Top25perc %in% top25_out, Apps %in% app_out)
       myvars <- c("Name","Private","Cost","Outstate","Top25perc","Apps")
       
       College2 <- College2[myvars]
       College2
        }, options = list(lengthMenu = c(5, 15, 30), pageLength = 30)) 
        model1 <- train(Grad.Rate ~ Outstate + Top25perc + Apps + Cost + Private , method='gbm', 
                data=College2, verbose=FALSE) 
        
       
        model1pred <- reactive({
                private_out <- ifelse(input$private == TRUE, "Yes", "No")
                predict(model1, newdata = data.frame(Outstate = input$outstate, Top25perc = input$top25, 
                                                   Apps = input$apps, Cost =  input$personroom, Private = private_out ))
                })
                output$pred1 <- renderText({
                        model1pred()
                
         }) })
        
                
        
          

        






        
