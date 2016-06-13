$(function () {

  $(".phone-mask").mask("(999) 999-9999", {autoclear: false});

  $(".phone-mask").on("blur", function() {
    updatePhoneField($(".phone-mask"));
  });

  var updatePhoneField = function(phoneField) {
    var last = phoneField.val().substr( phoneField.val().indexOf("-") + 1 );

    if( last.length == 3 ) {
      var move = phoneField.val().substr( phoneField.val().indexOf("-") - 1, 1 );
      var lastfour = move + last;
      var first = phoneField.val().substr( 0, 9 );

      phoneField.val( first + '-' + lastfour );
    }
  }

  if ($('#company_info_form').size() > 0) {
    $(".add_fields").click();

    $('#company_info_form').submit( function(e) {
      if ($('.nested-fields').size() == 0) {
        e.preventDefault();
        $('.attendees-count-error').show();
      }
    });
  }


  var companies_search_url = $('.company-name-input')[0].dataset.path;

  $( ".company-name-input" ).autocomplete({
      minLength: 2,
      source: companies_search_url,
      select: function( event, ui ) {
        console.log(ui.item)
        $('#company_registrant').val(ui.item.registrant);
        $('#company_name').val(ui.item.name);
        $('#company_address').val(ui.item.address);
        $('#company_representative_email').val(ui.item.representative_email);
        $('#company_representative_phone').val(ui.item.representative_phone);
        $('#company_zip_code').val(ui.item.zip_code);
        $('#company_us_state').val(ui.item.us_state);
        $('#company_city').val(ui.item.city);
 
        return false;
      }
    })
    .autocomplete( "instance" )._renderItem = function( ul, item ) {
      return $( "<li>" )
        .append("<a>" + item.name + "<br>(" + item.address + ")</a>" )
        .appendTo( ul );
    };

});
