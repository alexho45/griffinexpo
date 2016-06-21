$(function () {

  $(".phone-mask").mask("(999) 999-9999", {autoclear: false});

  $(".phone-mask").on("blur", function() {
    updatePhoneField($(this));
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
      $('.phone-mask').each(function (index, entry) {
        if ($(entry).val().length < 14) {
          e.preventDefault();
          $('.phone-number-length-error').show();
        }
      });
    });
  }

  $(document).on('change', '#i_am_also_an_attendee', function () {
    if (this.checked) {
      registrantName = $('#company_registrant').val().split(" ");
      firstName = registrantName[0];
      lastName = registrantName[1];
      email = $('#company_representative_email').val();
      phone = $('#company_representative_phone').val();

      if ($('.nested-fields').length == 0) {
        $(".add_fields").click();
      }
      else if (!!$('.attendee-first-name').last().val() && !!$('.attendee-last-name').last().val() && !!$('.attendee-email').last().val() && !!$('.attendee-phone').last().val()) {
        $(".add_fields").click();
      }

      $('.attendee-first-name').last().val(firstName);
      $('.attendee-last-name').last().val(lastName);
      $('.attendee-email').last().val(email);
      $('.attendee-phone').last().val(phone);
    }
  });


  // if ($('.company-name-input').length > 0) {
  //   var companies_search_url = $('.company-name-input')[0].dataset.path;
  // }

  // $( ".company-name-input" ).autocomplete({
  //     minLength: 2,
  //     source: companies_search_url,
  //     select: function( event, ui ) {
  //       $('#company_registrant').val(ui.item.registrant);
  //       $('#company_name').val(ui.item.name);
  //       $('#company_address').val(ui.item.address);
  //       $('#company_representative_email').val(ui.item.representative_email);
  //       $('#company_representative_phone').val(ui.item.representative_phone);
  //       $('#company_zip_code').val(ui.item.zip_code);
  //       $('#company_us_state').val(ui.item.us_state);
  //       $('#company_city').val(ui.item.city);
  //       $('#company_warehouse').val(ui.item.warehouse);
  //       $('#company_account_number').val(ui.item.account_number);
 
  //       return false;
  //     }
  // })
  // .autocomplete( "instance" )._renderItem = function( ul, item ) {
  //   return $( "<li>" )
  //     .append("<a>" + item.name + "<br>(" + item.address + ")</a>" )
  //     .appendTo( ul );
  // };

  $('.credit-card-redirect').hide();
  $(document).on('change', '[name="company[payment_type]"]', function() {
    var val = $(this).val();
    if (val == 'credit_card') {
      $('.credit-card-redirect').show();
    }
    else {
      $('.credit-card-redirect').hide();
    }
  });

});
