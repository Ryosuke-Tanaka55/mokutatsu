$(function () {
    function eventCalendar() {
        return $('#calendar').fullCalendar({});
        }

        function clearCalendar() {
        $('#calendar').html('');
        }

  $('#calendar').fullCalendar({
    events: '/events.json',

    titleFormat: 'YYYY年 M月',
    dayNamesShort: ['日', '月', '火', '水', '木', '金', '土'],
    

    header: {
        left: 'prev,next today',
        center: 'title',
        right: 'month,agendaWeek,agendaDay'
    },

    defaultTimedEventDuration: '03:00:00',
    navLinks: true,
    businessHours: true,
    editable: true,
    locale: 'ja',
    buttonText: {
      prev: '前',
      next: '次',
      prevYear: '前年',
      nextYear: '翌年',
      today: '今日',
      month: '月',
      week: '週',
      day: '日',
      allDay:'終日',
    },
    timeFormat: 'HH:mm',
    eventColor: '#63ceef',
    eventTextColor: '#000000',

    defaultDate: new Date(),
    navLinks: true, // can click day/week names to navigate views
    selectable: true,
    selectHelper: true,
    slotDuration: '00:15:00',
    slotLabelInterval: '01:00',
    nowIndicator: true,
    defaultView: 'month',
    weekends:true,
    resourceLabelText: 'リソース',
    
    select: function(start, end) {
        // Display the modal.
        // You could fill in the start and end fields based on the parameters
        $('.modal').modal('show');

    },
    eventClick: function(event, element) {
        // Display the modal and set the values to the event values.
        $('.modal').modal('show');
        $('.modal').find('#title').val(event.title);
        $('.modal').find('#starts-at').val(event.start);
        $('.modal').find('#ends-at').val(event.end);

    },
    editable: true,
    eventLimit: true // allow "more" link when too many events

});

// Bind the dates to datetimepicker.
// You should pass the options you need
$("#starts-at, #ends-at").datetimepicker();

// Whenever the user clicks on the "save" button om the dialog
$('#save-event').on('click', function() {
    var title = $('#title').val();
    if (title) {
        var eventData = {
            title: title,
            start: $('#starts-at').val(),
            end: $('#ends-at').val()
        };
        $('#calendar').fullCalendar('renderEvent', eventData, true); // stick? = true
    }
    $('#calendar').fullCalendar('unselect');

    // Clear modal inputs
    $('.modal').find('input').val('');

    // hide modal
    $('.modal').modal('hide');
  });
});