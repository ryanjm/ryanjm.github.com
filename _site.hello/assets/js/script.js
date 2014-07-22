$(document).ready(function(){
  // On hover, show associated element
  $(".js-hover-show").hover(function(){
    $("."+$(this).attr('data-show')).show();
  },function(){
    $("."+$(this).attr('data-show')).hide();
  });
});
