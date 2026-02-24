# beautifulsoup
from playwright.sync_api import sync_playwright
from bs4 import BeautifulSoup

with sync_playwright() as p:
  browser = p.chromium.launch(headless=False)
  page = browser.new_page()
  page.goto('https://quotes.toscrape.com/')
  html = page.content()
  soup = BeautifulSoup(html, 'lxml')
  #print(soup.find('span', class_='text').get_text())
  print(soup.select_one('span.text').text)
  print(soup.select_one('small.author').text)
  
  print(soup.select('div.quote'))
  
  page.wait_for_timeout(5000)
  browser.close()
  
 