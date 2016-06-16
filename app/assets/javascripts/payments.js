$(function () {

  if ($('#billing').length > 0) {
    $.getScript( "https://js.braintreegateway.com/v2/braintree.js", function() {
      braintree.setup(
        $('#billing')[0].dataset.token,
        'dropin', {
          container: 'dropin'
        }
      );
    });
  }

});
