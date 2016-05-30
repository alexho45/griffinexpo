$(function () {

  $(".phone-mask").mask("(999) 999-9999");

  $(".phone-mask").on("blur", function() {
      var last = $(this).val().substr( $(this).val().indexOf("-") + 1 );

      if( last.length == 3 ) {
          var move = $(this).val().substr( $(this).val().indexOf("-") - 1, 1 );
          var lastfour = move + last;
          var first = $(this).val().substr( 0, 9 );

          $(this).val( first + '-' + lastfour );
      }
  });

});
