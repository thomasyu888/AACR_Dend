library(iHeatmap)
library(shiny)
library(htmlwidgets)
library(synapseClient)
synapseLogin()

total <- data.frame(AM = c('syn4260756','syn4260757','syn4382386',6),
                    CL = c('syn4588477','syn4588476','syn4588478',4), 
                    ET = c('syn4588480','syn4588479','syn4588481',8), 
                    MCB= c('syn4588483','syn4588482','syn4588484',5),
                    MCB10 = c('syn4591713','syn4591712','syn4591714',5),
                    TB = c('syn4588486','syn4588485','syn4588487',7))

