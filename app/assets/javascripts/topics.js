$(window).scroll(function(e){ 
  if(($(document).height() - $('body').height()) > 100){
    var $el = $('.topic-banner'); 
    var isPositionFixed = ($el.css('position') == 'fixed');
    if ($(this).scrollTop() > 44 && !isPositionFixed){ 
      $('.topic-banner').css({'position': 'fixed', 'top': '0px'}); 
    }
    if ($(this).scrollTop() < 44 && isPositionFixed)
    {
      $('.topic-banner').css({'position': 'static', 'top': '0px'}); 
    } 
  }
});

$( document ).ready(function() {
  $(".topic > .topic-side")
    .click(function(){
      if ($(this).hasClass('selected')){
        selectPosition($(this));
      }else{
        semiSelectPosition($(this));
      }
    });

  function semiSelectPosition(item){
    var positionId = $(item).data('position-id');
    var container = $(item).closest('.topic-container');
    $(container).load('/position/' + positionId + '/almost', function() {
      $(container).find('.topic-side')
        .click(function(){
          if ($(this).hasClass('selected')){
            selectPosition($(this));
          }else{
            semiSelectPosition($(this));
          }
        });

      $(".submit")
        .click(function(){
          var position = $(this).closest('.topic').find('.topic-side.semi-selected')
          var reason = $(this).closest('.reason-area').find('textarea').val();

          addReason(position, reason);
          selectPosition($(position));
        });
    });
  }

  function addReason(position, reason){
    $.ajax({
      contentType: 'application/json',
      data: JSON.stringify(
            { "reason" : reason }
        ),
      dataType: 'json',
      type: 'POST',
      url: '/position/' + $(position).data('position-id') + '/reasons'
    });
  }

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
                if ($(this).hasClass('selected')){
                  selectPosition($(this));
                }else{
                  semiSelectPosition($(this));
                }
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