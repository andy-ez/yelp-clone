$(function(){
  $('.c-hamburger').off('click').on('click', function(){
    $(this).toggleClass("is-active");
    $('body > header > nav').slideToggle(500);
  })
})