var categoriesPresent, optionsHTML, $categoryBlock, newCategoryHTML;

$(document).ready(function(){
  $('#new-category-button').on('click', function(event){
    event.preventDefault();
    $categoryBlock.append(newCategoryHTML());
  });
});

optionsHTML = $("#recipe_categories_attributes_0_id").html();

newCategoryHTML = function(){
  categoryIndex = $(".category-box").length;
  string = "<div class='small-4 columns category-box end'>";
  string += "<select name='recipe[categories_attributes]";
  string += "[" + categoryIndex + "]";
  string += "[id]' id='recipe_categories_attributes_" + categoryIndex + "_id'>"
  string += optionsHTML;
  string += "</select>"
  string += "</div>";
  return string;
};

$categoryBlock = $("#recipe-add-categories");
