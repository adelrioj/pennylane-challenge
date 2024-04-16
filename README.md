## Problem statement

> **It's dinner time ! Create an application that helps users find the most relevant recipes that they can prepare with the ingredients that they have at home**

## Objective

Deliver an application prototype to answer the above problem statement.

By prototype, we mean:
- something usable, yet as simple as possible
- UI / design is not important
- we do not expect features which are outside the basic scope of the problem

We expect to use this prototype as a starting point to discuss current implementation details, as well as ideas for improvement.

## Setup and dependencies
To run this project in a local machine, you need to have the following dependencies installed:
- Ruby 3.3.0
- PostgreSQL 14

After installing the dependencies, you can run the following commands to setup the project:
```
gem install bundler
bundle install
rails db:setup
```

to run the project, simply run:
```
rails s
``` 

The project will be available at [http://localhost:3000](http://localhost:3000)

## Deployment in fly.io
This project is deployed in fly.io. You can access it [here](https://pennylane-challenge.fly.dev/)

To deploy a new version of the project, you can run the following command:
```
fly deploy
```

## User Stories
I propose 3 very simple user stories for this feature. No need to say, all features should have tests if it applies, and will not pass code review if not. 

#### User Story: System Setup 
As a developer, I want to set up the basic system infrastructure including the database, server, and application framework. This setup should include the necessary configurations for development, testing, and production environments.
This is just a setup task, so there is no need to implement any functionality at this point. Also, there will be no migrations or seeds at this point.

ACs:
The application should use Ruby on Rails.
The application should use Rspec as testing framework.
The application should connect to a PostgreSQL database.
The application should be successfully deployed on a local development and testing environments.
The application should have a production environment configuration ready for deployment.
The application should use fly.io.

#### User Story: Ingredient Inventory 
As a developer, I want to create the necessary models to manage the user's ingredient inventory. 
This inventory comes from  the english language recipes provided by the challenge [here](https://pennylane-interviewing-assets-20220328.s3.eu-west-1.amazonaws.com/recipes-en.json.gz). 
For the sake of simplicity, we will only consider the data structure provided by the file, without improvements or modifications.

Model description: Recipe
- title: string. 
The name of the recipe.
- cook_time: integer. Represents minutes. Always positive. 
The time it takes to cook the recipe.
- prep_time: integer. Represents minutes. Always positive. 
The time it takes to prepare the recipe before cooking.
- ingredients: jsonb
  Contains a json with a list of ingredients, including the quantity. e.g: "1 cup of sugar", "2 eggs".
- ratings: decimal. between 0 and 5. allow two decimals. 
The average rating of the recipe.
- cuisine: string. 
Represents the cuisine of the recipe. e.g: French, Italian.
- category: string.
Represents the category of the recipe. e.g: Main Course, Dessert. One per recipe.
- author: string. 
The name of the author of the recipe.
- image: string. 
URL that contains the image of the prepared dish.

should include an id and timestamps.

Dev Hints:
Use jsonb as the ingredients field type. jsonb takes more time to build and takes more disk space, but it's faster to query thank json. check [here](https://stackoverflow.com/questions/22654170/explanation-of-jsonb-introduced-by-postgresql).

ACs:
The models should be created with the necessary attributes to store the data from the provided recipes, according to the specification above.
The seeds file should contain the data from the provided recipes.
The seeds file should be idempotent, meaning that it should not create duplicated records if run multiple times.

#### User Story: Recipe Suggestions 
As a user, I want the service to suggest recipes that I can make with the ingredients I have at home.
To make this possible, we need to implement a search feature that will return the most relevant recipes based on the ingredients the user has in their inventory. 
This will include the necessary views to make this feature work.
To preserve performance, we will only show one recipe at a time. The recipe will be randomly selected from the list of recipes that match the user's ingredients.

UI Mockup:
(here I would include several mockups of the UI and discuss with the team the best approach)

Dev Hints:
Given that I'm using PostgreSQL, let's take advantage of the built-in [text search features](https://www.postgresql.org/docs/current/textsearch-tables.html#TEXTSEARCH-TABLES-SEARCH).

ACs:
The user should be able to write a list of ingredients they have at home in the input text box.
When requested, the user should be able to see a recipe that they can make with the selected ingredients.
The recipes should contain all the ingredients the user has selected.
The UI should implement the UI mockup provided above (it should be more detailed based on the mockups).

## Comments, assumptions, and future work
- I used Postgres as the DB as it was provided by default by fly.io.
- I have not setup any Redis cache for the application for simplicity. In a production environment it's a must. For the same reason, I will not implement any pagination or authentication, or any other mechanism that we would like to have in prod, but it's not relevant for this exercise.
- In a proper production-focused app, I would have used an API backend and a separate frontend. This improves the scalability and maintainability of the application, and also the separation of tasks in the user stories.
- I have not used docker or docker-compose for this project, but I would have it in any professional project, at least for the local dev env.
- I have included the provided recipes as seeds for simplicity. In a real-world scenario, I may have used a different approach such a pre-seeded image of the DB, or a rake task that reads from a CSV, JSON or even starts a web scrapper.
- Having ingredients in a JSON in the main table fills the purpose of the exercise but it's a mess. I would love to separate the quantity and the unit from the ingredient itself, as this would allow for more complex queries and better user experience managing ingredients. 
- With the same logic as the above, I would like to have a separate model for category-like attributes, such as cuisine and category, for better management.
- Implement recipe management for the user. The user should be able to add, remove, or update recipes. Maybe also a favourite recipes feature.
- The search feature could be improved by using a more advanced search algorithm (maybe Elasticsearch).
- We could allow the user to search for recipes by name, category or other.
- We could allow the user to see more than one recipe at a time.
- We could allow the user to add dietary restrictions.