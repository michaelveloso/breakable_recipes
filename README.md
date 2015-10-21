[Recipe Collector](http://breakable-recipes.herokuapp.com/)

### ABOUT:

Recipe Collector is a site for adding and storing your recipes, getting shopping lists based on the recipes you choose, and getting suggestions for other recipes based on ingredients in your shopping list, to reduce waste.

### ER DIAGRAM:

As it currently stands, this is about 30-40% implemented.

![Imgur](http://i.imgur.com/4IFzuOv.png)

### NEXT STEPS:

Next up are social elements: sharing recipes with others, rating and commenting on recipes, look at a user page to see what recipes they've contributed, and taking notes so you can remember your own modifications.

In the future: adding robust search capabilities, photos for users and recipes, grouping recipes into meals for easier planning, sorting shopping list by category to match your local grocery's layout.

Also, admin responsibilities: de-/escalating permissions, deleting inappropriate users, comments, etc.

### TECHNICAL INFO:

Recipe Collector is built on Ruby on Rails, using a PostgreSQL database. Front-end uses JS and JQuery to construct forms dynamically, and the UI is built on Foundation.

Other resources used:

Devise - User authentication / authorization

Selenium - JavaScript testing

Capybara - feature testing

Rspec - feature and unit testing

Factory Girl - feature and unit testing

![Build Status](https://codeship.com/projects/bc77f9e0-4876-0133-3ba9-1a1bdb65cff7/status?branch=master)
![Code Climate](https://codeclimate.com/github/michaelveloso/breakable_recipes.png)
![Coverage Status](https://coveralls.io/repos/michaelveloso/breakable_recipes/badge.png)
