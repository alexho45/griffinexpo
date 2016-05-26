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
      showError(availableSeats < attendeesCount)
    }
    else
      showError(false);
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

  var alreadyDone = $('#already_done').val() == 'true';
  if (!alreadyDone)
    checkAvailability();

  $(document).on('change', '.bus-checkbox', function () {
    checkAvailability();
  });

  $(document).on('change', '[name="checked_buses"]', function () {
    checkAvailability();
  });

});
