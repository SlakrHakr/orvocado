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

  initialize_tooltips();

  $('#create-topic').tooltipster({
    side: ['left'],
    theme: 'tooltipster-borderless'
  });

});
