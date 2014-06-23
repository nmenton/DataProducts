library(shiny)
shinyServer(
  function(input, output) {
      logmean<-reactive({log(input$mean^2/sqrt(input$sd^2+input$mean^2))})
      logsd<-reactive({sqrt(log(1+input$sd^2/input$mean^2))})
      unimin<-reactive({input$mean-sqrt(3*input$sd)})
      unimax<-reactive({input$mean+sqrt(3*input$sd)})
      output$graph <- renderPlot({
        validate(
          need(input$max-input$min>=0, "Maximum must be greater than minimum"),
          need(input$sd>0, "Standard Deviation must be greater than zero")
        )
        x<-seq(input$min,input$max,length=10000)
        hx<-switch(input$dist,
                 Normal = dnorm(x,input$mean,input$sd),
                 Lognormal = dlnorm(x,logmean(),logsd()),
                 Uniform = dunif(x,unimin(),unimax()))
        title<-switch(input$dist,
                 Normal = "Normal",
                 Lognormal = "Lognormal",
                 Uniform = "Uniform")
        dens<-data.frame(x,hx)
        ggplot(dens, aes(x=x,y=hx)) + 
          geom_line() +
          geom_vline(xintercept=input$mean) +
          ggtitle(title) +
          ylab("density")
    })  
  }
)