library(shiny)

# Define UI for application that demonstrates Bayesian updating of Binomial distribution
shinyUI(fluidPage(
        
        # Application title
        titlePanel("Visual illustration of Bayesian updating of probability of success"),
        
        # Sidebar with a slider input for the mean and variance
        sidebarLayout(
                sidebarPanel(
                        p("Add observations of successes and failures. 
                                \nClick Update button to see how they affect the posterior."),
                        sliderInput(inputId="success",
                                    label="Number of successes",
                                    min = 0,
                                    max = 100,
                                    value = 0,
                                    step=1),
                        sliderInput("failure",
                                    label="Number of failures",
                                    min = 0,
                                    max = 100,
                                    value = 0,
                                    step=1),
                        submitButton("Update!")
                        ),
                        
                # Show a plot of the generated distribution
                mainPanel(
                        p("This app demonstrates Bayesian updating of success probability in a Bernoulli process,
                          i.e. a process that can have either a success or a failure as an outcome. (See e.g. https://en.wikipedia.org/wiki/Bernoulli_distribution.)"),
                        p("We start with an uniform prior, that is, we think that the probability of success can be anything between zero and one with equal probability."),
                        p("As we gather observations of successes and failures, our estimate of the probability of success changes.
                          This is knowledge updating process is demonstrated by this app. The latest estimate, given by the red line,
                          is based on all of the entered observations; the previous estimates are marked in black lines."),
                        p("You can enter observations using the input fields on the left."),
                        p("The updating code has been adapted from http://bayesianbiologist.com/2011/09/10/visualizing-bayesian-updating/"),
                        plotOutput("distPlot")
                        )
                        
        )
))