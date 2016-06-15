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

  if ($('#company_info_form').length > 0) {
    if ($('.nested-fields').length == 0) {
      $(".add_fields").click();
    }

    $('#company_info_form').submit( function(e) {
      if ($('.nested-fields').length == 0) {
        e.preventDefault();
        $('.attendees-count-error').show();
      }
    });
  }

  $(document).on('change', '#i_am_an_attendee', function () {
    if (this.checked && $('.nested-fields').length > 0) {
      registrantName = $('#company_registrant').val().split(" ");
      firstName = registrantName[0];
      lastName = registrantName[1];
      email = $('#company_representative_email').val();
      phone = $('#company_representative_phone').val();

      $('.attendee-first-name').first().val(firstName);
      $('.attendee-last-name').first().val(lastName);
      $('.attendee-email').first().val(email);
      $('.attendee-phone').first().val(phone);
    }
  });


  if ($('.company-name-input').length > 0) {
    var companies_search_url = $('.company-name-input')[0].dataset.path;
  }

  $( ".company-name-input" ).autocomplete({
      minLength: 2,
      source: companies_search_url,
      select: function( event, ui ) {
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
