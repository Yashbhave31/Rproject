library(shiny)
library(shinydashboard)
library(tidyverse)
library(plotly)
library(scales)

# --- DATA LOADING & PREPARATION ---
summary_data = read.csv("summary_ready.csv")
import_comm_data = read.csv("IndiaImportCommodities_2010_2021.csv")
export_comm_data = read.csv("IndiaExportCommodities_2010_2021.csv")
import_country = read.csv("import_country_ready.csv")
export_country = read.csv("export_country_ready.csv")
monthly_data = read.csv("India_Monthly_Trend_Analysis.csv")

# Ensure months are ordered chronologically for plotting
monthly_data$Month = factor(monthly_data$Month, 
                            levels = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", 
                                       "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"))

# --- USER INTERFACE ---
ui = dashboardPage(
  skin = "black",
  dashboardHeader(title = "India Trade Data Analysis 2010-2021"),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("1. Overview Analysis", tabName = "overview", icon = icon("chart-line")),
      menuItem("2. Import Analysis", tabName = "imports", icon = icon("ship")),
      menuItem("3. Export Analysis", tabName = "exports", icon = icon("globe-americas")),
      hr(),
      sliderInput("year_range", "Year Filter:", 
                  min = 2010, max = 2021, value = c(2010, 2021), sep = "")
    )
  ),
  
  dashboardBody(
    # Custom CSS for styling
    tags$style(HTML("
      .content-wrapper { background-color: #ffffff !important; }
      .box { border-top: 3px solid #333; border-radius: 5px; }
      h2 { font-weight: 800; color: #1a1a1a; border-bottom: 2px solid #eee; padding-bottom: 10px; }
      h4 { font-weight: 700; color: #444; margin-top: 25px; text-transform: uppercase; letter-spacing: 1px; }
    ")),
    
    tabItems(
      # Overview Tab: High-level metrics and macro trends
      tabItem(tabName = "overview",
              h2("Comprehensive Trade Overview"),
              fluidRow(
                valueBoxOutput("v_exp", width = 3),
                valueBoxOutput("v_imp", width = 3),
                valueBoxOutput("v_bal", width = 3),
                valueBoxOutput("v_int", width = 3)
              ),
              h4("Trade Performance & Resilience Analysis"),
              fluidRow(
                box(title = "Annual Trade Trajectory", width = 8, status = "primary", plotlyOutput("ov_trend")),
                box(title = "Top 10 Global Partners", width = 4, status = "primary", plotlyOutput("ov_partners"))
              ),
              h4("Macro-Economic Trade Indicators"),
              fluidRow(
                box(title = "Trade Intensity (Trade-to-GDP Ratio %)", width = 6, plotlyOutput("ov_intensity")),
                box(title = "Export-Import Gap (%)", width = 6, plotlyOutput("ov_gap"))
              ),
              fluidRow(
                box(title = "Growth Volatility (YoY % Change)", width = 12, plotlyOutput("ov_growth_vol"))
              )
      ),
      
      # Import Tab: Detailed sourcing and seasonality analysis
      tabItem(tabName = "imports",
              h2("Import Portfolio & Sourcing Analysis"),
              h4("Import by Commodity"),
              fluidRow(
                box(title = "Dominant Import Commodities", width = 12, status = "danger", plotlyOutput("imp_comm_bar"))
              ),
              h4("Import by Country"),
              fluidRow(
                box(title = "Top 10 Sourcing Nations", width = 7, status = "warning", plotlyOutput("imp_country_bar")),
                box(title = "Supply Chain Dependency Trend", width = 5, status = "warning", plotlyOutput("imp_country_trend"))
              ),
              h4("Seasonal & Monthly Trends"),
              fluidRow(
                box(title = "Monthly Import Seasonality", width = 12, status = "info", plotlyOutput("imp_seasonal_mix"))
              )
      ),
      
      # Export Tab: Market reach and competitiveness
      tabItem(tabName = "exports",
              h2("Export Competitiveness & Market Reach"),
              h4("Export by Commodity"),
              fluidRow(
                box(title = "Primary Export Drivers", width = 7, status = "success", plotlyOutput("exp_comm_bar")),
                box(title = "Sectoral Contribution Share", width = 5, status = "success", plotlyOutput("exp_comm_pie"))
              ),
              h4("Export by Country"),
              fluidRow(
                box(title = "Global Export Footprint", width = 12, status = "primary", plotlyOutput("exp_map"))
              ),
              fluidRow(
                box(title = "Market Concentration (HHI Index)", width = 6, plotlyOutput("exp_hhi")),
                box(title = "Growth Trend in Top Destinations", width = 6, plotlyOutput("exp_dest_trend"))
              )
      )
    )
  )
)

# --- SERVER LOGIC ---
server = function(input, output) {
  
  # Reactive data filtering based on the Year Slider
  f_sum = reactive({ summary_data %>% filter(Year >= input$year_range[1] & Year <= input$year_range[2]) })
  f_imp_c = reactive({ import_comm_data %>% filter(Year >= input$year_range[1] & Year <= input$year_range[2]) })
  f_exp_c = reactive({ export_comm_data %>% filter(Year >= input$year_range[1] & Year <= input$year_range[2]) })
  f_imp_ct = reactive({ import_country %>% filter(Year >= input$year_range[1] & Year <= input$year_range[2]) })
  f_exp_ct = reactive({ export_country %>% filter(Year >= input$year_range[1] & Year <= input$year_range[2]) })
  f_month = reactive({ monthly_data %>% filter(Year >= input$year_range[1] & Year <= input$year_range[2]) })
  
  # Overview Summary Boxes
  output$v_exp = renderValueBox({ valueBox(paste0("$", round(sum(f_sum()$Exports)/1000, 2), "T"), "Total Exports", icon = icon("arrow-up"), color = "green") })
  output$v_imp = renderValueBox({ valueBox(paste0("$", round(sum(f_sum()$Imports)/1000, 2), "T"), "Total Imports", icon = icon("arrow-down"), color = "red") })
  output$v_bal = renderValueBox({ valueBox(paste0("$", round(mean(f_sum()$Trade_Balance), 1), "B"), "Avg Trade Balance", icon = icon("balance-scale"), color = "orange") })
  output$v_int = renderValueBox({ valueBox(paste0(round(mean(f_sum()$Trade_Intensity_Pct)/100, 1), "%"), "Avg Trade-to-GDP", icon = icon("percentage"), color = "blue") })
  
  # Annual Export/Import Trend
  output$ov_trend = renderPlotly({
    plot_ly(f_sum(), x = ~Year) %>%
      add_lines(y = ~Exports, name = "Exports", line = list(color = "#27ae60", width = 3)) %>%
      add_lines(y = ~Imports, name = "Imports", line = list(color = "#e74c3c", width = 3)) %>%
      layout(yaxis = list(title = "Value (USD Billion)"))
  })
  
  # Top Trade Partners (Imports + Exports)
  output$ov_partners = renderPlotly({
    e_ct = f_exp_ct() %>% group_by(Country) %>% summarize(Ex = sum(Value_Bn))
    i_ct = f_imp_ct() %>% group_by(Country) %>% summarize(Im = sum(Value_Bn))
    comb = full_join(e_ct, i_ct, by = "Country") %>% mutate(Total = replace_na(Ex,0) + replace_na(Im,0)) %>% arrange(desc(Total)) %>% head(10)
    plot_ly(comb, x = ~Total, y = ~reorder(Country, Total), type = "bar", orientation = 'h', marker = list(color = "#34495e"))
  })
  
  # Macro Economic Indicators: Intensity, Gap, and Growth Volatility
  output$ov_intensity = renderPlotly({
    plot_ly(f_sum(), x = ~Year, y = ~Trade_Intensity_Pct/100, type = "scatter", mode = "lines+markers", fill = "tozeroy") %>%
      layout(yaxis = list(title = "Intensity %"))
  })
  
  output$ov_gap = renderPlotly({
    plot_ly(f_sum(), x = ~Year, y = ~Export_Import_Gap_Pct, type = "scatter", mode = "lines", line = list(dash = "dot", color = "red"))
  })
  
  output$ov_growth_vol = renderPlotly({
    plot_ly(f_sum(), x = ~Year) %>%
      add_lines(y = ~Export_Growth, name = "Export Growth", line = list(color = "#27ae60")) %>%
      add_lines(y = ~Import_Growth, name = "Import Growth", line = list(color = "#e74c3c")) %>%
      layout(yaxis = list(title = "YoY Growth %"))
  })
  
  # Import Section Visualization Logic
  output$imp_comm_bar = renderPlotly({
    df = f_imp_c() %>% group_by(Commodity) %>% summarize(V = sum(Value_Bn)) %>% arrange(desc(V)) %>% head(10)
    plot_ly(df, x = ~reorder(Commodity, -V), y = ~V, type = "bar", marker = list(color = "#c0392b")) %>%
      layout(xaxis = list(title = "", tickangle = -45), yaxis = list(title = "USD Billion"))
  })
  
  output$imp_country_bar = renderPlotly({
    df = f_imp_ct() %>% group_by(Country) %>% summarize(V = sum(Value_Bn)) %>% arrange(desc(V)) %>% head(10)
    plot_ly(df, x = ~V, y = ~reorder(Country, V), type = "bar", orientation = 'h', marker = list(color = "#d35400"))
  })
  
  output$imp_country_trend = renderPlotly({
    top5 = f_imp_ct() %>% group_by(Country) %>% summarize(V = sum(Value_Bn)) %>% arrange(desc(V)) %>% head(5)
    df = f_imp_ct() %>% filter(Country %in% top5$Country)
    plot_ly(df, x = ~Year, y = ~Value_Bn, color = ~Country, type = "scatter", mode = "lines")
  })
  
  output$imp_seasonal_mix = renderPlotly({
    df = f_month() %>% group_by(Month) %>% summarize(V = mean(Imports))
    plot_ly(df, x = ~Month) %>%
      add_bars(y = ~V, name = "Avg Value", marker = list(color = "rgba(192, 57, 43, 0.3)")) %>%
      add_lines(y = ~V, name = "Trend", line = list(color = "#c0392b", width = 3)) %>%
      layout(yaxis = list(title = "Avg Monthly Import (USD Bn)"))
  })
  
  # Export Section Visualization Logic
  output$exp_comm_bar = renderPlotly({
    df = f_exp_c() %>% group_by(Commodity) %>% summarize(V = sum(Value_Bn)) %>% arrange(desc(V)) %>% head(10)
    plot_ly(df, x = ~V, y = ~reorder(Commodity, V), type = "bar", orientation = 'h', marker = list(color = "#27ae60"))
  })
  
  output$exp_comm_pie = renderPlotly({
    df = f_exp_c() %>% group_by(Commodity) %>% summarize(V = sum(Value_Bn)) %>% arrange(desc(V)) %>% head(6)
    plot_ly(df, labels = ~Commodity, values = ~V, type = "pie", hole = 0.4)
  })
  
  output$exp_map = renderPlotly({
    df = f_exp_ct() %>% group_by(Country) %>% summarize(V = sum(Value_Bn))
    plot_geo(df) %>% add_trace(z = ~V, locations = ~Country, locationmode = "country names", color = ~V, colors = "Greens") %>%
      layout(geo = list(projection = list(type = 'robinson')))
  })
  
  output$exp_hhi = renderPlotly({
    df = f_exp_ct() %>% group_by(Year) %>% mutate(S = Value_Bn/sum(Value_Bn)) %>% summarize(HHI = sum(S^2))
    plot_ly(df, x = ~Year, y = ~HHI, type = "scatter", mode = "lines+markers", line = list(color = "#16a085"))
  })
  
  output$exp_dest_trend = renderPlotly({
    top5 = f_exp_ct() %>% group_by(Country) %>% summarize(V = sum(Value_Bn)) %>% arrange(desc(V)) %>% head(5)
    df = f_exp_ct() %>% filter(Country %in% top5$Country)
    plot_ly(df, x = ~Year, y = ~Value_Bn, color = ~Country, type = "scatter", mode = "lines+markers")
  })
}

# --- LAUNCH APP ---
shinyApp(ui, server)