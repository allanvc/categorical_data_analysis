library(ggplot2)
library(plotly)

fluidPage(
  
  list(tags$head(HTML('<link rel="icon", href="unb3.png", 
                                   type="image/png" />'))),
  div(style="padding: 1px 0px; width: '55%'",
      titlePanel(
        title="", windowTitle="ROC App"
      )
  ),
  
  
  navbarPage(
  title=div(img(src="unb3.png", height = 20, width = 50), "ROC App"),
             navbarMenu("Informação",
                        tabPanel("App desenvolvido como atividade extra da Disciplina\n Análise de Dados
                                 Categorizados - EST - UnB, "),
                        tabPanel("ministrada pelo Prof. Dr George Freitas von Borries no primeiro semestre de 2018.")),
             navbarMenu("Autores",
                        tabPanel("Allan Vieira - 14/0128492"),
                        tabPanel("Caio Balena - 13/0104566"),
                        tabPanel("Frederico de Lucca - 15/0072139"), 
                        tabPanel("José Cezário - 15/0072414"))
             
            
  ),
  
  titlePanel("Curva ROC"),
  
  sidebarPanel(
    
    # All your styles will go here
    tags$style(HTML(".js-irs-0 .irs-single, .js-irs-0 .irs-bar-edge, .js-irs-0 .irs-bar {background: #D62728}")),
    tags$style(HTML(".js-irs-1 .irs-single, .js-irs-1 .irs-bar-edge, .js-irs-1 .irs-bar {background: #FF7F0E}")),
    tags$style(HTML(".js-irs-2 .irs-single, .js-irs-2 .irs-bar-edge, .js-irs-2 .irs-bar {background: #1F77B4}")),
    
    sliderInput("cut", "Cutoff",
                min = 0, max = 100, value = 50, step = 1),
    
    sliderInput("m1", "Média - Curva Sucessos",
                min = 50, max = 100, value = 63, step = 1),

    sliderInput("m2", "Média - Curva Fracassos",
                min = 0, max = 50, value = 35, step = 1)

    # sliderInput("cut", "Cutoff",
    #             min = 0, max = 100, value = 50, step = 1)
  ),
  
  mainPanel(
    plotlyOutput('distPlot'),
    plotlyOutput('procPlot')
  )
)

