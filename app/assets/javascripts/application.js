// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap.min
//= require jQueryRotate
//= require select2.min
//= require tooltipster.bundle.min
//= require home
//= require pagination
//= require position
//= require topics
//= require user
//= require reasons

$( document ).ready(function() {
  $( document ).ajaxError(function( event, jqxhr, settings, thrownError ) {
    if (jqxhr.status == 401){
      window.location.replace("/users/sign_in");
    }
  });

  var begin = 0;
  var end = 180;
  $( ".dropdown" ).click(function() {
    $('.glyphicon-chevron-down').rotate({
        angle: begin,
        animateTo: end,
        duration: 500
      });
    begin += 180
    end += 180

    $(this).find(".dropdown-content").toggleClass('show');
  });

  $('.select2').select2({
    tags: true,
    placeholder: "Tag this topic",
    dir: "rtl"
  });

  if ($('.alert-notice').length){
    $('.alert-notice').delay(5000).slideUp('slow');
  }
  if ($('.alert-error').length){
    $('.alert-error').delay(5000).slideUp('slow');
  }
  if ($('.alert-alert').length){
    $('.alert-alert').delay(5000).slideUp('slow');
  }
  if ($('.alert-success').length){
    $('.alert-success').delay(5000).slideUp('slow');
  }

  $('#topics > .topic-container > .topic > .topic-side.topic-side-left').tooltipster({
    side: ['left'],
    theme: 'tooltipster-light',
    animation: 'fall',
    arrow: false,
    viewportAware: false
  });

  $('#topics > .topic-container > .topic > .topic-side.topic-side-right').tooltipster({
    side: ['right'],
    theme: 'tooltipster-light',
    animation: 'fall',
    arrow: false,
    viewportAware: false
  });

  // window.setInterval(function(){
  //   var positions = $( "#topics > .topic-container > .topic > .topic-side" )
  //   var position = $(positions[Math.floor(Math.random()*positions.length)])
  //   if (!isElementInViewport(position)){
  //     while(!isElementInViewport(position)){
  //       var position = $(positions[Math.floor(Math.random()*positions.length)])
  //     }
  //   }
  //   $(position).tooltipster('open');
  //   setTimeout(function (){
  //     $(position).tooltipster('close');
  //   }, 10000);
  // }, 20000);
  //
  // function isElementInViewport (el) {
  //     if (typeof jQuery === "function" && el instanceof jQuery) {
  //         el = el[0];
  //     }
  //
  //     var rect = el.getBoundingClientRect();
  //
  //     return (
  //         rect.top >= 0 &&
  //         rect.left >= 0 &&
  //         rect.bottom <= (window.innerHeight || document.documentElement.clientHeight) && /*or $(window).height() */
  //         rect.right <= (window.innerWidth || document.documentElement.clientWidth) /*or $(window).width() */
  //     );
  // }
});
