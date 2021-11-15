#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(tidytext)

# load the cable news transcripts data
load('cable-news-transcripts.RData')

# get a list of hosts
hosts <- unique(d$host)

# tokenize
tidied_text <- unnest_tokens(d,
                             input = transcript,
                             output = word) %>% 
    # join with sentiment lexicon
    anti_join(get_stopwords()) %>% 
    inner_join(get_sentiments('bing')) %>% 
    # and get the most frequent words by host
    group_by(host) %>% 
    count(word, sort = TRUE) %>% 
    # filter out some words whose sentiment score is problematic
    filter(word != 'like',
           word != 'pretty',
           word != 'well',
           word != 'right') %>% 
    # keep only the most common words per host
    slice_max(n, n=20)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Words Heard On Cable News"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            selectInput("selected_host",
                        "Cable News Host:",
                        choices = hosts)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("topicPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$topicPlot <- renderPlot({
        
        ggplot(data = filter(tidied_text, host == input$selected_host)) +
            geom_col(aes(x = n, y=fct_reorder(word, n))) +
            labs(x = 'Frequency', y = 'Word') +
            theme_minimal()
        
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
