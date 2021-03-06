$(window).scroll(function(e){
  /**
   * Fixes topic banner to top of screen if scrolling far down page.
   * @param  {[type]} $ [description]
   * @return {[type]}   [description]
   */
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

function initialize_tooltips() {
  $('#topics > .topic-container > .topic > .topic-side.topic-side-left').tooltipster({
    side: ['left', 'right'],
    theme: 'tooltipster-light',
    animation: 'fall',
    arrow: false,
    viewportAware: false,
    minWidth: 300,
    maxWidth: 300,
    delay: [800, 300]
  });

  $('#topics > .topic-container > .topic > .topic-side.topic-side-right').tooltipster({
    side: ['right', 'left'],
    theme: 'tooltipster-light',
    animation: 'fall',
    arrow: false,
    viewportAware: false,
    minWidth: 300,
    maxWidth: 300,
    delay: [800, 300]
  });
}

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

        if($.trim(reason) == ''){
          $(this).closest('.reason-area').find('.alert').addClass('alert-danger');
          $(this).closest('.reason-area').find('.alert').html('A reason for this position is required.');
          return;
        }

        $(this).prop("disabled", true);
        $(this).addClass("disabled");
        $(this).find('.loader').show();
        if ($(this).css('float') != 'right'){
          $(this).css('left', $(this).position().left - 24 + "px");
        }
        $(this).css('opacity', '1');
        addReasonAndSelectPosition(position, reason);
    });

    /**
     * Displays topic mid-selection with input for reason.
     * @param  {[type]} item [description]
     * @return {[type]}      [description]
     */
    function semiSelectPosition(item){
      var positionId = $(item).data('position-id');
      var container = $(item).closest('.topic-container');
      $(container).load('/position/' + positionId + '/almost', function(){
        $('.carousel').carousel({
          interval: 15000,
          pause: 'hover'
        })
      });
    }

    /**
     * Posts reason to storage.
     * @param {[type]} position [description]
     * @param {[type]} reason   [description]
     */
    function addReasonAndSelectPosition(position, reason){
      $.ajax({
        contentType: 'application/json',
        data: JSON.stringify(
              { "reason" : reason }
          ),
        dataType: 'json',
        type: 'POST',
        url: '/position/' + $(position).data('position-id') + '/reasons',
        success: function (html) {
          selectPosition($(position));
        }
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
      $(container).load('/topics/' + topicId, function(){
        initialize_tooltips();
      });

      var reasonsContainer = $('.reasons-container');
      if($(reasonsContainer).length){
          $(reasonsContainer).load('/topics/' + topicId + '/reasons');
      }
    }

    $( ".form-field" ).bind( "keyup", function() {
      enable = true;
      $.each($('.form-field'), function( index, input ) {
        if ($(input).val().trim() == ''){
          enable = false;
        }
      });

      if (enable) {
        $('.create').removeClass('disabled');
        $('.create').prop('disabled', false);
      }else{
        $('.create').addClass('disabled');
        $('.create').prop('disabled', true);
      }
    });

    $('body').on('click', '.select-position', function(){
        $(this).closest('.topic-new').find('.select-position').removeClass('selected');
        $(this).toggleClass('selected');

        if ($(this).hasClass('left-side')){
          $(this).closest('.topic-new').find('.topic-side-right').removeClass('topic-side-right');
          $(this).closest('.topic-side').addClass('topic-side-left');
          $(this).closest('.topic-new').find('.reason-area').removeClass('right-side');
          $(this).closest('.topic-new').find('.reason-area').addClass('left-side');
          $('.left-position-hidden').prop('checked', true);
        }else if ($(this).hasClass('right-side')){
          $(this).closest('.topic-new').find('.topic-side-left').removeClass('topic-side-left');
          $(this).closest('.topic-side').addClass('topic-side-right');
          $(this).closest('.topic-new').find('.reason-area').removeClass('left-side');
          $(this).closest('.topic-new').find('.reason-area').addClass('right-side');
          $('.right-position-hidden').prop('checked', true);
        }

        $(this).closest('.topic-new').find('.reason-area').find('textarea').val('');
        $(this).closest('.topic-new').find('.reason-area').show();

        if ($(this).closest('.reason-area').find('textarea').is(":visible")){
          //selecting
          $($(this).closest('.carousel')).carousel('pause');
          $($(this).closest('.reason-area').find('.submit')).css('margin-bottom', '-20px');
          $(this).closest('.reason-area').find('textarea').val('{"reasonId": ' + $(this).data('reason-id') + '}');
        }else{
          //deselecting
          $($(this).closest('.carousel')).carousel('cycle');
          $($(this).closest('.reason-area').find('.submit')).css('margin-bottom', '0px');
          $(this).closest('.reason-area').find('textarea').val('');
        }
        $(this).closest('.reason-area').find('textarea').toggle();
    });

});
