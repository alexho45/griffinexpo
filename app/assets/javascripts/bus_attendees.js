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

  if ($('.checked_buses').length > 0)
    checkAvailability();

  $(document).on('change', '.bus-checkbox', function () {
    $('.checked_buses').prop('checked', true);
    checkAvailability();
  });

  $(document).on('change', '[name="checked_buses"]', function () {
    if (!$('.checked_buses').is(':checked'))
      $('.bus-checkbox').prop('checked', false);
    checkAvailability();
  });

});
