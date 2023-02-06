# MIT License

# Copyright (c) 2023 Lia Toumazi

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.




import requests
from bs4 import BeautifulSoup

# Define the base URL for the BBC Good Food recipes search
base_url = "https://www.bbcgoodfood.com/search/recipes?q="


# Function to get the list of recipes matching the search criteria
def get_recipes(ingredients):
    # Create the search query by concatenating the ingredients and restrictions
    search_query = ingredients

    # Use the requests library to get the HTML content of the search page
    response = requests.get(base_url + search_query)
    soup = BeautifulSoup(response.content, "html.parser")

    # Find the recipe cards on the page
    recipe_cards = soup.find_all("div", class_="standard-card-new__display-row")

    # Check if any recipe cards were found
    if not recipe_cards:
        return []

    # create json file
    recipes = {}

    # Extract the recipe information from each recipe card
    for card in recipe_cards:
        title_element = card.find('a')
        if title_element is not None:
            title = title_element.text
            link = title_element["href"]
            recipes[link] = {"title": title, "link": link}

    # Find the photos of recipe cards on the page
    # recipe_photos = soup.find_all("div", class_="standard-card-new__thumbnail")
    # # Check if any recipe cards were found
    # if not recipe_photos:
    #     return []

    # # Extract the recipe information from each recipe card
    # for card in recipe_photos:
    #     photo_link = card.find('a')
    #     photo_element = card.find('img')
    #     if photo_link is not None:
    #         link = photo_link["href"]
    #         for l in recipes[link]:
    #             if photo_element is not None:
    #                 photo = photo_element["data-src"]
    #                 recipes[link] = {"photo": photo}

    # Return the list of recipes
    return recipes

# Example usage
user_ingredients = input("Enter ingredients separated by commas: ")
ingredients = user_ingredients.replace(",", "%2C" )
recipes = get_recipes(ingredients)

# Check if any recipes were found
if not recipes:
    print("No recipes found.")
else:
    for recipe in recipes:
        print(recipe)
        # print("Title: " + recipe["title"])
        # print("Link: " + 'https://www.bbcgoodfood.com/recipes/' + recipe["link"] + "\n")
