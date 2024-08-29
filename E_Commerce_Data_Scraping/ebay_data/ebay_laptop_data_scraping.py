from requests_html import HTMLSession
from bs4 import BeautifulSoup
from tqdm import tqdm
import pandas as pd


s = HTMLSession()

base_url = "https://www.ebay.com/sch/i.html?_from=R40&_nkw=laptop&_sacat=0&_pgn="

initial_url = base_url + "1"


r = s.get(initial_url)


r.html.render(timeout=20, sleep=2)

soup = BeautifulSoup(r.html.html, 'html.parser')
pagination = soup.find('nav', class_='pagination')
if pagination:
    page_numbers = pagination.find_all('a', class_='pagination__item')
    num_pages = int(page_numbers[-2].text) if page_numbers else 1
else:
    num_pages = 1

print(f"Total number of pages: {num_pages}")


data = []


for page in range(1, num_pages + 1):
    url = base_url + str(page)

    r = s.get(url)
    r.html.render(timeout=20, sleep=2)
    content = r.html.find('div.s-item__info.clearfix')

    for index, item in enumerate(tqdm(content)):
        soup = BeautifulSoup(item.html, 'html.parser')

        title_div = soup.find('div', class_='s-item__title')
        title = title_div.find('span', role='heading').text if title_div and title_div.find('span',
                                                                                            role='heading') else 'No title'
        if title == "Shop on eBay":
            continue

        sub_title_div = soup.find('div', class_='s-item__subtitle')
        sub_title = sub_title_div.find('span', class_='SECONDARY_INFO').text if sub_title_div and sub_title_div.find(
            'span', class_='SECONDARY_INFO') else 'No subtitle'

        price_div = soup.find('div', class_='s-item__details-section--primary')
        price = price_div.find('span', class_='s-item__price').text if price_div and price_div.find('span',
                                                                                                    class_='s-item__price') else 'No price'

        best_offer_div = soup.find('div', class_='s-item__details-section--primary')
        best_offer = best_offer_div.find('span',
                                         class_='s-item__dynamic s-item__formatBestOfferEnabled').text if best_offer_div and best_offer_div.find(
            'span', class_='s-item__dynamic s-item__formatBestOfferEnabled') else 'No best offer'

        shipping_div = soup.find('div', class_='s-item__details-section--primary')
        shipping = shipping_div.find('span',
                                     class_='s-item__shipping s-item__logisticsCost').text if shipping_div and shipping_div.find(
            'span', class_='s-item__shipping s-item__logisticsCost') else 'No shipping'

        country_div = soup.find('div', class_='s-item__details-section--primary')
        country = country_div.find('span',
                                   class_='s-item__location s-item__itemLocation').text if country_div and country_div.find(
            'span', class_='s-item__location s-item__itemLocation') else 'No country'

        sold_div = soup.find('div', class_='s-item__details-section--primary')
        sold = sold_div.find('span', class_='s-item__dynamic s-item__quantitySold').text if sold_div and sold_div.find(
            'span', class_='s-item__dynamic s-item__quantitySold') else 'No sold information'

        data.append([title, sub_title, price, best_offer, shipping, country, sold])

df = pd.DataFrame(data, columns=['Title', 'Subtitle', 'Price', 'Offer', 'Shipping', 'Country', 'Sold'])

df.to_csv('ebay_laptops.csv', index=False)

