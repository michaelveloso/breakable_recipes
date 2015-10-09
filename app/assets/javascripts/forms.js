var catOption, $catBlock, newCatHTML;

var ingOption, $ingBlock, newIngHTML;

var stepOption, $stepBlock, newStepHTML;

$(document).ready(function(){

  catOption = $catBlock.html();
  ingOption = $ingBlock.html();
  stepOption = $stepBlock.html();

  $('#new-category-button').on('click', function(event){
    event.preventDefault();
    $catBlock.append(newCatHTML(catOption));
  });

  $('#new-ingredient-button').on('click', function(event){
    event.preventDefault();
    $ingBlock.append(newIngHTML(ingOption));
  });

  $('#new-step-button').on('click', function(event){
    event.preventDefault();
    $stepBlock.append(newStepHTML(stepOption));
  });
});

//information for categories

$catBlock = $("#recipe-add-categories");

newCatHTML = function(originalHTML){
  var catIndex, catIndexArray, catIndexUS, catString;
  catIndex = $(".category-box").length;
  catIndexArray = "[" + catIndex + "]"
  catIndexUS = "_" + catIndex + "_"
  catString = originalHTML.replace(/\[0\]/g, catIndexArray)
  catString = catString.replace(/\_0\_/g, catIndexUS)
  return catString;
};


//information for ingredients

$ingBlock = $("#recipe-add-ingredients");

newIngHTML = function(originalHTML){
  var ingIndex, ingIndexArray, ingIndexUS, ingString;
  ingIndex = $(".ingredient-box").length;
  ingIndexArray = "[" + ingIndex + "]"
  ingIndexUS = "_" + ingIndex + "_"
  ingString = originalHTML.replace(/\[0\]/g, ingIndexArray)
  ingString = ingString.replace(/\_0\_/g, ingIndexUS)
  return ingString;
};

//information for recipe steps

$stepBlock = $("#recipe-add-steps");

newStepHTML = function(originalHTML){
  var stepIndex, stepIndexArray, stepIndexUS, stepString;
  stepIndex = $(".step-box").length;
  stepIndexArray = "[" + stepIndex + "]";
  stepIndexUS = "_" + stepIndex + "_";
  stepIndexStep = "Step " + (stepIndex + 1)
  stepString = originalHTML.replace(/\[0\]/g, stepIndexArray);
  stepString = stepString.replace(/\_0\_/g, stepIndexUS);
  stepString = stepString.replace(/Step [0-9][0-9]?/g, stepIndexStep);
  return stepString;
};
