India Trade Analytics Hub Pro

A professional R Shiny Business Intelligence (BI) Dashboard designed to visualize and analyze India's import and export dynamics from 2010 to 2021. This tool provides macro-economic insights, seasonal trends, and market concentration analysis to help users understand India's position in global trade.

🏁 Getting Started

Follow these steps to run the dashboard locally on your machine.

1. Prerequisites

Ensure you have R and RStudio installed on your system.

2. Install Required Libraries

Open your R console or RStudio and run the following command to install all necessary dependencies:

install.packages(c("shiny", "shinydashboard", "tidyverse", "plotly", "scales"))

3. File Structure

Ensure the following .csv data files are placed in the same directory as your app.R script:

summary_ready.csv

IndiaImportCommodities_2010_2021.csv

IndiaExportCommodities_2010_2021.csv

import_country_ready.csv

export_country_ready.csv

India_Monthly_Trend_Analysis.csv

📊 Project Modules & Analysis

The dashboard is organized into three specialized analytical sections:

1. Overview Analysis (Macro View)

Provides a high-level overview of India’s trade health.

Key Metrics:

Total Exports

Total Imports

Average Trade Balance

Trade-to-GDP Intensity

Trade Trajectory:

Time-series analysis showing the growth of trade value over a decade

Macro Indicators:

Trade Intensity: Measures India’s integration with the global economy relative to GDP

Growth Volatility: Identifies specific years of economic shifts or rapid procurement expansion

2. Import Analysis (Sourcing & Supply Chain)

Focuses on India’s procurement profile and supply chain dependencies.

Commodity Dominance:

Top products driving India’s import bills (e.g., Petroleum, Electronics, Gold)

Sourcing Nations:

Breakdown of top 10 countries providing goods to India

Seasonal Trends:

Hybrid Line & Bar charts to identify procurement cycles and peak trade months

3. Export Analysis (Market Competitiveness)

Explores India’s global strengths and market reach.

Export Drivers:

High-performing sectors such as Engineering Goods and Pharmaceuticals

Global Footprint:

Interactive Choropleth Map visualizing India’s market presence worldwide

Market Concentration (HHI Index):

Uses the Herfindahl-Hirschman Index to measure if India’s exports are diversified or concentrated

🛠 Built With

Shiny
 & shinydashboard
: Web interface framework

Tidyverse
: Data manipulation and cleaning

Plotly
: Interactive visualizations

Scales
: Professional data and axis formatting
