🇮🇳 India Trade Analytics Hub Pro
A professional R Shiny BI Dashboard designed to visualize and analyze India's import and export dynamics from 2010 to 2021. This tool provides macro-economic insights, seasonal trends, and market concentration analysis to help users understand India's position in global trade.

🚀 Getting Started
To run this dashboard on your local machine, follow these steps:

1. Prerequisites
Ensure you have R and RStudio installed.

2. Download Libraries
Open your R console and run the following command to download the necessary packages:

R
install.packages(c("shiny", "shinydashboard", "tidyverse", "plotly", "scales"))
3. File Structure
Ensure the following .csv data files are in the same folder as your app.R script:

summary_ready.csv

IndiaImportCommodities_2010_2021.csv

IndiaExportCommodities_2010_2021.csv

import_country_ready.csv

export_country_ready.csv

India_Monthly_Trend_Analysis.csv

📊 Project Modules & Analysis
The project is divided into three key analytical sections:

1. Overview Analysis (Macro View)
This section provides a "bird's-eye view" of the Indian economy's trade health.

Key Metrics: Instant summary of Total Exports, Total Imports, Average Trade Balance, and Trade-to-GDP Intensity.

Trade Trajectory: A time-series analysis of how trade has grown year-over-year.

Macro Indicators: * Trade Intensity: Measures how integrated India is with the global economy relative to its GDP.

Growth Volatility: Identifies years of economic instability or rapid expansion.

2. Import Analysis (Sourcing & Supply Chain)
Focuses on what India buys and where it comes from.

Commodity Dominance: Identifies the top products (like Petroleum and Electronics) driving import bills.

Sourcing Nations: A breakdown of the top 10 countries India depends on for goods.

Seasonal Trends: A hybrid Line & Bar chart that identifies procurement cycles, showing which months typically see the highest import volumes.

3. Export Analysis (Market Competitiveness)
Focuses on India’s strengths and global market reach.

Export Drivers: Analysis of high-performing sectors such as Engineering Goods and Pharmaceuticals.

Global Footprint: An interactive Choropleth Map visualizing India’s market presence across the globe.

Market Concentration (HHI Index): A specialized statistical index that measures if India's exports are diversified or overly dependent on a few specific markets.

🛠 Built With
Shiny & shinydashboard - The web framework for R.

Tidyverse - For data manipulation and cleaning.

Plotly - For interactive, high-quality visualizations.

Scales - For advanced data formatting.

