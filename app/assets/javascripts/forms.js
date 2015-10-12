var $catBlock, newCatHTML;

var $ingBlock, newIngHTML;

var $stepBlock, newStepHTML;

$.fn.outerHTML = function() {
    var $t = $(this);
    if ($t[0].outerHTML !== undefined) {
        return $t[0].outerHTML;
    } else {
        var content = $t.wrap('<div/>').parent().html();
        $t.unwrap();
        return content;
    }
};

$(document).ready(function(){
  var catHTML, ingHTML, stepHTML;

  catHTML = $catBlock.children().first().outerHTML();
  ingHTML = $ingBlock.children().first().outerHTML();
  stepHTML = $stepBlock.children().first().outerHTML();

  $("#new-category-button").on("click", function(event){
    event.preventDefault();
    $catBlock.append(newCatHTML(catHTML));
  });

  $("#new-ingredient-button").on("click", function(event){
    event.preventDefault();
    $ingBlock.append(newIngHTML(ingHTML));
  });

  $("#new-step-button").on("click", function(event){
    event.preventDefault();
    $stepBlock.append(newStepHTML(stepHTML));
  });
});

//information for categories

$catBlock = $("#recipe-add-categories");

newCatHTML = function(originalHTML){
  var catIndex, catIndexArray, catIndexUS, catString;
  catIndex = $(".category-box").length;
  catIndexArray = "[" + catIndex + "]";
  catIndexUS = "_" + catIndex + "_";
  catString = originalHTML.replace(/\[0\]/g, catIndexArray);
  catString = catString.replace(/\_0\_/g, catIndexUS);
  return catString;
};


//information for ingredients

$ingBlock = $("#recipe-add-ingredients");

newIngHTML = function(originalHTML){
  var ingIndex, ingIndexArray, ingIndexUS, ingString;
  ingIndex = $(".ingredient-box").length;
  ingIndexArray = "[" + ingIndex + "]";
  ingIndexUS = "_" + ingIndex + "_";
  ingString = originalHTML.replace(/\[0\]/g, ingIndexArray);
  ingString = ingString.replace(/\_0\_/g, ingIndexUS);
  return ingString;
};

//information for recipe steps

$stepBlock = $("#recipe-add-steps");

newStepHTML = function(originalHTML){
  var stepIndex, stepIndexArray, stepIndexUS, stepIndexStep, stepString;
  stepIndex = $(".step-box").length;
  stepIndexArray = "[" + stepIndex + "]";
  stepIndexUS = "_" + stepIndex + "_";
  stepIndexStep = "Step " + (stepIndex + 1);
  stepString = originalHTML.replace(/\[0\]/g, stepIndexArray);
  stepString = stepString.replace(/\_0\_/g, stepIndexUS);
  stepString = stepString.replace(/Step [0-9][0-9]?/g, stepIndexStep);
  return stepString;
};
