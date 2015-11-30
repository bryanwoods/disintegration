jQuery(function() {
  var $ = jQuery;

  var iframe = $('<iframe />', {
    src: 'http://disintegration.herokuapp.com',
    frameborder: 0,
    scrolling: "auto",
    width: 800,
    height: 3000
  });

  $('.entry-content').first().html(iframe);
});
