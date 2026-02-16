##India Trade Analytics Hub Pro
A professional R Shiny Business Intelligence (BI) Dashboard designed to visualize and analyze India's import and export dynamics from 2010 to 2021. This tool provides macro-economic insights, seasonal trends, and market concentration analysis to help users understand India's position in global trade.

Getting Started
To run this dashboard on your local machine, follow these steps:

1. Prerequisites
Ensure you have R and RStudio installed on your system.

2. Install Required Libraries
Open your R console or RStudio and run the following command to install the necessary dependencies:

R
install.packages(c("shiny", "shinydashboard", "tidyverse", "plotly", "scales"))
3. File Structure
For the app to run correctly, ensure the following .csv data files are placed in the same directory as your app.R script:

summary_ready.csv

IndiaImportCommodities_2010_2021.csv

IndiaExportCommodities_2010_2021.csv

import_country_ready.csv

export_country_ready.csv

India_Monthly_Trend_Analysis.csv

Project Modules & Analysis
The dashboard is organized into three specialized analytical sections:

1. Overview Analysis (Macro View)
This section provides a bird's-eye view of the Indian economy's trade health.

Key Metrics: High-level summary of Total Exports, Total Imports, Average Trade Balance, and Trade-to-GDP Intensity.

Trade Trajectory: A time-series analysis showing the growth of trade value over a decade.

Macro Indicators:

Trade Intensity: Measures how integrated India is with the global economy relative to its GDP.

Growth Volatility: Identifies specific years of economic shifts or rapid procurement expansion.

2. Import Analysis (Sourcing & Supply Chain)
Focuses on India's procurement profile and supply chain dependencies.

Commodity Dominance: Visualizes the top products (e.g., Petroleum, Electronics, Gold) driving India's import bills.

Sourcing Nations: A breakdown of the top 10 countries providing goods to India.

Seasonal Trends: Uses a hybrid Line & Bar chart to identify procurement cycles and peak months for trade activity.

3. Export Analysis (Market Competitiveness)
Explores India's global strengths and market reach.

Export Drivers: Analysis of high-performing sectors such as Engineering Goods and Pharmaceuticals.

Global Footprint: Features an interactive Choropleth Map visualizing India's market presence worldwide.

Market Concentration (HHI Index): Utilizes the Herfindahl-Hirschman Index to statistically measure if India's exports are diversified or concentrated in too few markets.

Built With
Shiny & shinydashboard: The framework for the web interface.

Tidyverse: For efficient data manipulation and cleaning.

Plotly: For interactive high-quality visualizations.

Scales: For professional data and axis formatting.
