$(function(){
  $("div.stars.stars-show-big.stars-show-0.set_stars  input[type='radio']").hover(function(){
    var parentDiv = $(this).parents('div.stars.stars-show-big')[0],
        value = $(this).val(),
        msgs = ["Eek! Methinks Not!", "Meh...Could be better", "A-OK", "Yay! I'm a fan", "Wohoo! as good as it gets"],
        msgContainer = $(parentDiv).next('span')[0];

    parentDiv.className = 'stars stars-show-big set_stars stars-show-' + (value * 10);
    $(msgContainer).text(msgs[ value - 1 ])
    $(this).click();
  })
  
})