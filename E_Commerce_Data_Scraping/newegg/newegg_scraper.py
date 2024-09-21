import csv
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from webdriver_manager.chrome import ChromeDriverManager
from bs4 import BeautifulSoup
import time
import re

chrome_options = Options()
chrome_options.add_argument("--headless")
chrome_options.add_argument('--no-sandbox')
chrome_options.add_argument('--disable-dev-shm-usage')


service = Service(ChromeDriverManager().install())
driver = webdriver.Chrome(service=service, options=chrome_options)

base_url = "https://www.newegg.com/p/pl?d=iPhone"
driver.get(base_url)

time.sleep(5)

page_source = driver.page_source

soup = BeautifulSoup(page_source, 'html.parser')

content = soup.find_all('div', class_='item-cell')

products_data = []


def clean_price(text):
    text = re.sub(r'[^\x00-\x7F]+', '', text)
    return text.strip()


for item in content:
    name = item.find('a', class_='item-title')
    if name:
        product_name = clean_price(name.text)
    else:
        product_name = 'N/A'

    price = item.find('li', class_='price-current')
    if price:
        product_price = clean_price(price.text.strip())
    else:
        product_price = 'N/A'

    link = name['href'] if name else 'N/A'

    features_list = item.find('ul', class_='item-features')
    features = []
    if features_list:
        for li in features_list.find_all('li'):
            features.append(clean_price(li.text.strip()))
    else:
        features = ['N/A']

    features_str = "; ".join(features)

    products_data.append([product_name, product_price, link, features_str])

driver.quit()


csv_filename = "newegg_iphone_data.csv"
with open(csv_filename, mode='w', newline='', encoding='utf-8') as file:
    writer = csv.writer(file)
    writer.writerow(["Product Name", "Price", "Link", "Features"])
    writer.writerows(products_data)
