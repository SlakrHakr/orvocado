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
//= require select2.min
//= require home
//= require pagination
//= require position
//= require topics
//= require user

$( document ).ready(function() {
  $( ".dropdown" ).click(function() {
    $(this).find(".glyphicon").toggleClass('glyphicon-menu-down');
    $(this).find(".glyphicon").toggleClass('glyphicon-menu-up');
    $(this).find(".dropdown-content").toggleClass('show');
  });

  $('.select2').select2({
    tags: true,
    placeholder: "Tag this topic"
  });

  if ($('.notice').length){
    $('.notice').delay(5000).fadeOut();
  }
});
