$(function () {

  var checkAvailability = function () {
    var checked = $('.checked_buses').is(':checked');
    if (checked) {
      var attendeesCount = parseInt($('#attendees_count').val());
      var checkedBuses = $('.bus-checkbox:checked');
      var availableSeats = 0;
      checkedBuses.each( function (index, bus) {
        availableSeats += parseInt(bus.dataset.seats);
      });
      showError(availableSeats < attendeesCount);
      showOvernightWarning(checkOvernightBuses());
    }
    else {
      showError(false);
      showOvernightWarning(false);
    }
  };

  var checkOvernightBuses = function () {
    var arr = $('.bus-checkbox:checked').map(function() { return this.dataset.overnight; });
    var included = jQuery.inArray("true", arr) > -1;
    return included;
  }

  var showOvernightWarning = function (show) {
    if (show) {
      $('.overnight-buses').show();
    }
    else {
      $('.overnight-buses').hide();
    }
  };

  var showError = function (show) {
    if (show) {
      $('.buses-error').show();
    }
    else {
      $('.buses-error').hide();
    }
    $('.next').prop('disabled', show);
  };

  if ($('.checked_buses').length > 0) {
    checkAvailability();
    showOvernightWarning(checkOvernightBuses());
  }

  $(document).on('change', '.bus-checkbox', function () {
    $('.checked_buses').prop('checked', true);
    checkAvailability();
  });

  $(document).on('change', '[name="checked_buses"]', function () {
    if (!$('.checked_buses').is(':checked')) {
      $('.bus-checkbox').prop('checked', false);
      showOvernightWarning(false);
    }
    checkAvailability();
  });

});
