# eBay Laptop Data Scraper

This project is a Python-based web scraper designed to extract data from eBay's laptop listings. The scraper automates the process of collecting relevant details such as the title, subtitle, price, best offer availability, shipping cost, country of origin, and the number of units sold for each listing. The extracted data is then saved into a CSV file for further analysis or use.

## Features

- **Automated Pagination Handling**: The scraper automatically detects the total number of pages in the search results and iterates through each page to collect data.
- **Data Filtering**: The scraper skips rows where the title is "Shop on eBay" to ensure only relevant listings are collected.
- **Detailed Data Extraction**: For each laptop listing, the scraper extracts the following information:
  - **Title**: The main title of the listing.
  - **Subtitle**: Additional information provided in the subtitle of the listing.
  - **Price**: The listed price of the laptop.
  - **Best Offer**: Whether the listing has a "Best Offer" option.
  - **Shipping Cost**: The shipping cost associated with the listing.
  - **Country**: The country from which the item will be shipped.
  - **Sold Units**: The number of units sold, if available.

## How It Works

1. **Session Initialization**: The scraper initiates a session using the `requests_html` library to handle dynamic content rendered by JavaScript.
2. **Pagination Detection**: The scraper navigates to the first page of the search results and automatically detects the total number of pages by examining the pagination section.
3. **Data Collection**: The scraper loops through each page, extracting and processing relevant data from each listing. It uses the `BeautifulSoup` library for parsing the HTML content.
4. **Data Storage**: All extracted data is stored in a Pandas DataFrame, which is then exported to a CSV file named `ebay_laptops.csv`.

## Installation

To get started with the eBay Laptop Scraper, you'll need to have Python installed. Then, you can clone this repository and install the required dependencies.
