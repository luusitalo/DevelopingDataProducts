## Simulate Bayesian Binomial updating
## Modified from http://bayesianbiologist.com/2011/09/10/visualizing-bayesian-updating/
library(shiny)
s<<-NULL
f<<-NULL
totSucc<<-0
totFail<<-0

shinyServer(function(input, output, session) {
        
        output$distPlot <- renderPlot({
                #prior
                
                curve(dbeta(x,1,1), xlim=c(0,1), ylim=c(0,20), xlab='Probability of success',ylab='Probability Density',lty=2)
                legend('topright',legend=c('Prior','Old Posteriors','Latest Posterior'),lty=c(2,1,1),col=c('black','black','red'))
               
                totSucc <<- totSucc + input$success
                totFail <<- totFail + input$failure
                
                if (!exists("s")){
                        s<<-input$success
                        input$success<<-0
                }
                else {
                s <<- c(s,totSucc)
                }
                
                if (!exists("f")){
                        f <<- input$failure
                        input$failure<<-0
                }
                else {
                        f <<- c(f,totFail)
                }
                
                #previous posteriors
                if (length(s)>1){
                        for (i in 2:length(s)-1){
                                curve(dbeta(x,s[i]+1,f[i]+1),add=TRUE)
                        }
                }
                
                #latest posterior
                curve(dbeta(x,totSucc+1,totFail+1),add=TRUE, col='red', lwd=1.5)
                
                text(0.2,17, paste("Total number of \nsuccesses is ", totSucc, "\nand failures ", totFail))
                
                #reset the input fields to zero
                updateNumericInput(session, "success", value = 0)
                updateNumericInput(session, "failure", value = 0)
                
        }) 
        
})