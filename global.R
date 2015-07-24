library(iHeatmap)
library(shiny)
library(htmlwidgets)
library(synapseClient)
synapseLogin()
#Matrix,Annotations,Terms
total <- data.frame(AM = c('syn4260756','syn4260757','syn4382386',7),
                    CL = c('syn4588477','syn4588476','syn4588478',4), 
                    ET = c('syn4588480','syn4588479','syn4588481',8), 
                    MCB= c('syn4588483','syn4588482','syn4588484',5),
                    MCB10 = c('syn4591713','syn4591712','syn4591714',5),
                    TB = c('syn4588486','syn4588485','syn4588487',7),
                    sage_AM = c('syn4687132','syn4687128','syn4687136',7),
                    sage_CL = c('syn4687143','syn4687139','syn4687147',4),
                    sage_ET = c('syn4687154','syn4687150','syn4687159',7),
                    sage_MCB = c('syn4687167','syn4687163','syn4687171',6),
                    sage_TB = c('syn4687179','syn4687175','syn4687182',7))
cleanFun <- function(htmlString) {
  return(gsub("<.*?>", "", htmlString))
}
