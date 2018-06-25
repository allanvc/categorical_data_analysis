library(ggplot2)
library(plotly)

function(input, output) {
  
  # pacote
  library(ggplot2)
  library(plotly)
  # paleta de cores:
  plotly_pallette <- c('#1F77B4', '#FF7F0E', '#2CA02C', '#D62728')
  
  
  # m1 = 63; m2 = 35; cut = 50
  output$distPlot <- renderPlotly({
    
    p1 <- ggplot(data = data.frame(x = c(-50, 150)), aes(x)) +
      stat_function(fun = dnorm, n = 301, args = list(mean = input$m1, sd = 10),
                    size = 1.2, aes(colour = "Sucessos"))+
      stat_function(fun = dnorm, n = 301, args = list(mean = input$m2, sd = 10),
                    size = 1.2, aes(colour = "Fracassos"))+
      geom_vline(xintercept = input$cut, colour = plotly_pallette[4], linetype = "dotted", alpha = 0.5)+
      # scale_fill_manual(name = "", values = c("bar.label" = "grey")) +
      scale_color_manual(name = "", values = c(plotly_pallette[1], plotly_pallette[2])) + # ggplot2 ordena por ordem alfabetica
      #... primeira cor vai para fracassos e segunda para sucessos
      labs(x="Cutoff", y="Probability Density")+
      ggtitle("Distributions")+
      theme_bw()+
      theme(panel.border = element_blank())+ # para ficar igual o plotly
      guides(color=guide_legend(title=NULL))+
      theme(plot.title = element_text(hjust=0.5))
    
    ggplotly(p1)
    
    
    
  })
  
  
  output$procPlot <- renderPlotly({
    
    # testes:
    x <- seq(-50, 150, by=0.1)
    # y <- dnorm(x, mean=63, sd=10)
    # plot(x,y)
    # pnorm(q = 63, mean = 63, sd = 10)
    
    # pc1 = pnorm(q = x, mean = 65, sd = 10) # ainda nao eh sensibilidade
    # 
    # 
    # pc2 = pnorm(q = x, mean = 35, sd = 10) # ainda nao eh especificidade
    
  
    # plot( 1-pc2, 1-pc1) # soh assim bate com uma ROC -- talvez seja pq estamos adaptando 
    # ... e nao ajustando um modelo e fazendo acertos vs erros
    
    # curva 1 = acerto
    # curva 2 = erro
    
    pc1 = pnorm(q = x, mean = input$m1, sd = 10) # ainda nao eh sensibilidade
    
    pc2 = pnorm(q = x, mean = input$m2, sd = 10) # ainda nao eh especificidade
    
    # ponto do cutoff na ROC
    pcut1 = pnorm(q = input$cut, mean = input$m1, sd = 10)
    pcut2 = pnorm(q = input$cut, mean = input$m2, sd = 10)
    
    p2 <- ggplot()+
      geom_line(aes(x=1-pc2, y=1-pc1), colour = plotly_pallette[3], size=1.2)+
      geom_line(aes(x=c(0,1), y=c(0,1)), colour = "black", size=0.5,
                alpha = 0.5)+ # passar sem criar data frame, senao ele reclama
      #... de nao terem o mesmo tamanho
      geom_hline(yintercept = 1-pcut1, colour = plotly_pallette[4], linetype = "dotted", alpha = 0.5)+
      geom_vline(xintercept = 1-pcut2, colour = plotly_pallette[4], linetype = "dotted", alpha = 0.5)+
      labs(x="1 - Especificidade", y="Sensibilidade")+
      ggtitle("Curva ROC")+
      theme_bw()+
      theme(panel.border = element_blank())+ # para ficar igual o plotly
      guides(color=guide_legend(title=NULL))+
      theme(plot.title = element_text(hjust=0.5))
    
    ggplotly(p2)
    
    
    # c1 <- rnorm(input$x)
    # x <- rnorm(input$n)
    # y <- rnorm(input$n)
    # plot(x, y)
  })
  

}

