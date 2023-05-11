
""" A script designed to scrape food recipes from allrecipes.com 
    using a Python API BeautifulSoup. The scraped data will be 
    saved on filipino_recipes.xlsx. """

import os
import requests
from bs4 import BeautifulSoup
import pandas as pd
from tqdm import tqdm


class Scraper:
    def __init__(self, url):
        self.url = url
        self.recipe_links = []
        self.recipes = []
        self.ingredients = []
        self.directions = []
        self.nutrition = []

    def scrape_links(self):
        page = requests.get(self.url)
        soup = BeautifulSoup(page.content, 'html.parser')
        recipe_div = soup.find('div', {'id': 'mntl-taxonomysc-article-list-group_1-0'})
        links = recipe_div.find_all('a', href=True)
        self.recipe_links = [link['href'] for link in links]

    def scrape_nutrition(self, link):
        recipe_page = requests.get(link)
        recipe_soup = BeautifulSoup(recipe_page.content, 'html.parser')

        nutrition_div = recipe_soup.find('div', {'class': 'comp mntl-nutrition-facts-summary'})
        if nutrition_div is None:
            self.nutrition.append(None)
            return

        nutrition_table = nutrition_div.find('table', {'class': 'mntl-nutrition-facts-summary__table'})
        nutrition_values = []
        for row in nutrition_table.find_all('tr'):
            columns = row.find_all('td')
            if len(columns) == 2:
                nutrition_values.append(columns[0].text.strip() + ' ' + columns[1].text.strip())

        nutrition_summary = '\n'.join(nutrition_values)
        self.nutrition.append(nutrition_summary)

    def scrape_data(self):
        for link in tqdm(self.recipe_links):
            recipe_page = requests.get(link)
            recipe_soup = BeautifulSoup(recipe_page.content, 'html.parser')

            # scraping food recipe title
            recipe_title = recipe_soup.find('h1', {'id': 'article-heading_1-0'}).get_text().strip()

            # scraping ingredients per page
            ingredients_li = recipe_soup.find('ul', {'class': 'mntl-structured-ingredients__list'})

            ingredients = list()
            
            try: 
                for li in range(len(ingredients_li.find_all('li'))):
                    ingredients.append(ingredients_li.find_all('li')[li].get_text())
            except:
                continue

            # scraping directions per page
            directions_li = recipe_soup.find('ol', {'id': 'mntl-sc-block_2-0'})

            directions = list()
            
            try: 
                for li in range(len(directions_li.find_all('li'))):
                    directions.append(f"Step {li+1}: {directions_li.find_all('li')[li].get_text()}")
            except:
                continue

            self.scrape_nutrition(link)
            self.recipes.append(recipe_title)
            self.ingredients.append(''.join(ingredients))
            self.directions.append(''.join(directions))

    def to_dataframe(self):
        data = {
            'Recipe': self.recipes,
            'Ingredients': self.ingredients,
            'Directions': self.directions,
            'Nutrition': self.nutrition
        }
        return pd.DataFrame(data)

    def to_excel(self, filename):
        df = self.to_dataframe()
        df.to_excel(filename, index=False)

def clear_terminal():
    os.system('cls' if os.name == 'nt' else 'clear')

if __name__ == '__main__':
    clear_terminal()
    print("Scraping data...")
    scraper = Scraper("https://www.allrecipes.com/recipes/17494/world-cuisine/asian/filipino/main-dishes/")
    scraper.scrape_links()
    scraper.scrape_data()
    scraper.to_excel("filipino_recipes.xlsx")
    clear_terminal()
    print("Done!")
5