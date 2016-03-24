source("helpers.R")

shinyServer(
  function(input, output, session) {

    n1 <- reactive({ input$n1 })
    n2 <- reactive({ input$n2 })
    mu1 <- reactive({ input$mu1 })
    mu2 <- reactive({ input$mu2 })
    sd1 <- reactive({ input$sigma1 })
    sd2 <- reactive({ input$sigma2 })
    
    experiment <- reactive({ 
      input$expt
      function(){
        x1 <- rnorm(n1(), mean=mu1(), sd=sd1())
        x2 <- rnorm(n2(), mean=mu2(), sd=sd2())
        xbar1 <- mean(x1)
        xbar2 <- mean(x2)
        s1 <- sd(x1)
        s2 <- sd(x2)
        s <- sqrt(s1^2/n1() + s2^2/n2())
        list(
          x1 = x1, 
          x2 = x2,
          t = (xbar1 - xbar2)/s, 
          df = s^4/((s1^2/n1())^2/(n1()-1) +  (s2^2/n2())^2/(n2()-1))
        )
      }
    })
    
    # for background histogram:
    data <- reactive({
      nexpt <- 1000
      lapply(1:nexpt, function(i) experiment()())
    })
    t <- reactive({ sapply(data(), function(x) x$t) })
    df <- reactive({ sapply(data(), function(x) x$df) })
    
    # for single sample instance:
    x <- reactive({ experiment()() })
    output$ttest <- renderPrint({
      welch.test(x()$x1, x()$x2)
    })
    output$boxplot <- renderPlot({
      plot.test(x()$x1, x()$x2)
    })
    output$histplot <- renderPlot({
      t0 <- x()$t
      xlim <- if(t0>0) c(-max(t()),max(t())) else c(min(t()),-min(t()))
      hist(t(), freq=FALSE,
           xlim=xlim,
           xlab="t statistic", 
           main="", col='lightgrey', border='lightgrey')
      curve(dt(x, df=mean(df())), add=TRUE, col='red', lwd=2)
      
      # p-value:
      pv <- if(t0>0) 2*(1 - pt(t0, df=x()$df)) else 2*pt(t0, df=x()$df) 
      line <- if(t0<0) seq(min(t()), t0, by=(t0 - min(t()))/50) else seq(t0, max(t()), by=(max(t()) - t0)/50)
      tline <- dt(line, df=mean(df()))
      polygon(c(line, rev(line)), c(rep(0,51), rev(tline)), col=addTrans("red",100), border="red")
      points(t0, 0, pch='X', col='blue', cex=2)
    })
  }
)

