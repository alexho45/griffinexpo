$(function () {

  var acc = document.getElementsByClassName("accordion");
  var i;

  for (i = 0; i < acc.length; i++) {
    acc[i].onclick = function(){
      this.classList.toggle("active");
      this.nextElementSibling.classList.toggle("show");
    }
  }

  $(document).on('click', '[name="report_type"]', function (e) {
    e.preventDefault();
    dataset = $(this)[0].dataset;
    url = dataset.path;
    eventId = $('#event_id').val();
    path = dataset.sendPath;
    companyType = dataset.type;
    $.ajax({
      url: url,
      method: 'POST',
      dataType: 'json',
      cache: false,
      data: {
        event_id:     eventId,
        path:         path,
        company_type: companyType
      },
      success: function(data) {
        console.log(data);
        $('#report_content').html(data.html);
      },
      error: function(data) {
      }
    });
  });

});
