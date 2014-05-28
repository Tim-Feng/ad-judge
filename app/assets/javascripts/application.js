// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require bootstrap
//= require jquery.infinitescroll
$().ready(function() {
$(document).on('click','.social_share_column', function(){
    var slug = $(this).attr("post-id");
    FB.ui({
      method: 'share',
      href: 'http://www.ad-judge.com/posts/' + encodeURIComponent(slug),
    }, function(response){    
      if (response && !response.error_code) {
        window.close();
      } else {
        alert('Error while posting.');
      }
    });
  });
});
  