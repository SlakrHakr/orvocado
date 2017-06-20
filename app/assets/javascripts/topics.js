$(window).scroll(function(e){
  /**
   * Fixes topic banner to top of screen if scrolling far down page.
   * @param  {[type]} $ [description]
   * @return {[type]}   [description]
   */
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
    /**
     * Handles clicking event on a topic position.
     * @return {[type]} [description]
     */
    $('body').on('click', '.topic > .topic-side', function(){
        if ($(this).hasClass('semi-selected')){
          var topicId = $(this).data('topic-id');
          loadTopic(this, topicId);
        }else if ($(this).hasClass('selected')){
          selectPosition($(this));
        }else{
          semiSelectPosition($(this));
        }
    });

    /**
     * Handles actual submission event of topic position and reason.
     * @return {[type]} [description]
     */
    $('body').on('click', '.submit', function(){
        var position = $(this).closest('.topic').find('.topic-side.semi-selected')
        var reason = $(this).closest('.reason-area').find('textarea').val();

        addReason(position, reason);
        selectPosition($(position));
    });

    /**
     * Displays topic mid-selection with input for reason.
     * @param  {[type]} item [description]
     * @return {[type]}      [description]
     */
    function semiSelectPosition(item){
      var positionId = $(item).data('position-id');
      var container = $(item).closest('.topic-container');
      $(container).load('/position/' + positionId + '/almost');
    }

    /**
     * Posts reason to storage.
     * @param {[type]} position [description]
     * @param {[type]} reason   [description]
     */
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

    /**
     * Handles posting position selection to storage and rendering of topic
     * with new position displayed.
     * @param  {[type]} item [description]
     * @return {[type]}      [description]
     */
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

      $.ajax({
        type: type,
        url: url,
        success: function (result) {
          loadTopic(item, result['id']);
        }
      });
    }

    /**
     * Renders topic.
     * @param  {[type]} topicId [description]
     * @return {[type]}         [description]
     */
    function loadTopic(item, topicId){
      var container = $(item).closest('.topic-container');
      $(container).load('/topics/' + topicId, function() {
          // if ($('.reasons').length){
          //     $('.reasons').removeClass('selected');
          //     $('.reasons').removeClass('deselected');
          // }
          //
          // if (left){
          //     $('.reasons-left-side').addClass('selected');
          //     $('.reasons-right-side').addClass('deselected');
          // }else if (right){
          //     $('.reasons-right-side').addClass('selected');
          //     $('.reasons-left-side').addClass('deselected');
          // }
      });
    }

});
