# Newegg iPhone Data Scraper

This project is a Python-based web scraper designed to extract data from Newegg's iPhone listings. The scraper automates the process of collecting relevant details such as the product name, price, product link, and features for each listing. The extracted data is then saved into a CSV file for further analysis or use.

## Features

- **Headless Browser**: The scraper uses Selenium in headless mode to navigate and load Newegg's iPhone product listings without opening a browser window.
- **Dynamic Content Handling**: It ensures all JavaScript-rendered content is loaded by using Selenium with a wait mechanism.
- **Detailed Data Extraction**: For each iPhone listing, the scraper extracts the following information:
  - **Product Name**: The name of the iPhone product.
  - **Price**: The listed price of the iPhone.
  - **Product Link**: The direct link to the iPhone product page.
  - **Features**: A list of key features of the iPhone, such as color, capacity, etc.

## How It Works

1. **Session Initialization**: The scraper initiates a headless session using Selenium with ChromeDriver to handle dynamic content and load Newegg's search results.
2. **Data Collection**: It parses the HTML content using `BeautifulSoup` and locates relevant elements like product names, prices, links, and features.
3. **Data Cleaning**: The extracted data is cleaned to remove any unnecessary characters or white spaces using regular expressions.
4. **Data Storage**: The collected data is stored in a CSV file named `newegg_iphone_data.csv` for further use or analysis.

## Installation

To get started with the Newegg iPhone Data Scraper, you'll need to have Python installed. Then, clone this repository and install the required dependencies.

### Install Dependencies:

```bash
pip install selenium beautifulsoup4 webdriver-manager
