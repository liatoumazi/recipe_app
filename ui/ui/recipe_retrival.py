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

    # Extract the recipe information from each recipe card
    recipes = []
    for card in recipe_cards:
        # title = card.find("h4", class_="standard-card-new__article-title qa-card-link")
        title_element = card.find('a')
        if title_element is not None:
            title = title_element.text
            link = title_element["href"]
            recipes.append({"title": title, "link": link})

    # Return the list of recipes
    return recipes

# Example usage
user_ingredients = input("Enter ingredients separated by commas: ")
ingredients = user_ingredients.replace(",", "%2C" )
recipes = get_recipes(ingredients)

recipes_data = {}

# Check if any recipes were found
if not recipes:
    print("No recipes found.")
else:
    for recipe in recipes:
        print("Title: " + recipe["title"])
        print("Link: " + 'https://www.bbcgoodfood.com/recipes/' + recipe["link"] + "\n")

