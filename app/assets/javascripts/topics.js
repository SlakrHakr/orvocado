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

$( document ).ready(function() {
  $(".topic > .topic-side")
    .click(function(){
      selectPosition($(this));
    });

    function selectPosition(item){
      var positionId = $(item).data('position-id');

      var left = $(item).hasClass('topic-side-left');
      var right = $(item).hasClass('topic-side-right');

      var url = '/position/' + positionId + '/select';
      var type = 'POST';
      if ($(item).hasClass('selected')){
        url = '/position/' + positionId + '/deselect';
        type = 'DELETE';
        left = false;
        right = false;
      }

      var container = $(item).closest('.topic-container');
      $.ajax({
        type: type,
        url: url,   
        success: function (result) {
          $(container).load('/topics/' + result['id'], function() {
              $(container).find('.topic-side')
                .click(function(){
                  selectPosition($(this));
                });

              if ($('.reasons').length){
                  $('.reasons').removeClass('selected');
                  $('.reasons').removeClass('deselected');
              }

              if (left){
                  $('.reasons-left-side').addClass('selected');
                  $('.reasons-right-side').addClass('deselected');
              }else if (right){
                  $('.reasons-right-side').addClass('selected');
                  $('.reasons-left-side').addClass('deselected');
              }
          });
        }
      });
    }
});