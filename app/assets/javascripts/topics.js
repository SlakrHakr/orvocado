$(window).scroll(function(e){ 
  var $el = $('.topic-banner'); 
  var isPositionFixed = ($el.css('position') == 'fixed');
  if ($(this).scrollTop() > 44 && !isPositionFixed){ 
    $('.topic-banner').css({'position': 'fixed', 'top': '0px'}); 
  }
  if ($(this).scrollTop() < 44 && isPositionFixed)
  {
    $('.topic-banner').css({'position': 'static', 'top': '0px'}); 
  } 
});