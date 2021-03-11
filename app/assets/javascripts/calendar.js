$(function () {
  // 画面遷移を検知
  $(document).on('turbolinks:load', function () {
    if ($('#calendar').length) {

      function Calendar() {
        return $('#calendar').fullCalendar({
        });
      }
      function clearCalendar() {
        $('#calendar').html('');
      }

      $(document).on('turbolinks:load', function () {
        Calendar();
      });
      $(document).on('turbolinks:before-cache', clearCalendar);

      //events: '/events.json', 以下に追加
      $('#calendar').fullCalendar({
        events: '/events.json',
        //カレンダー上部を年月で表示させる
        titleFormat: 'YYYY年 M月',
        //曜日を日本語表示
        dayNamesShort: ['日', '月', '火', '水', '木', '金', '土'],
        //ボタンのレイアウト
        header: {
          left: 'prev,next today',
          center: 'title',
          right: 'month,agendaWeek,agendaDay'
          },
          //終了時刻がないイベントの表示間隔
          defaultTimedEventDuration: '03:00:00',
          buttonText: {
            prev: '前',
            next: '次',
            prevYear: '前年',
            nextYear: '翌年',
            today: '今日',
            month: '月',
            week: '週',
            day: '日',
            allDay:'終日'
          },
          //イベントの時間表示を24時間に
          timeFormat: 'HH:mm',
          eventColor: '#63ceef',
          eventTextColor: '#000000',

          defaultDate: new Date(),
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
        // Drag & Drop & Resize
        editable: true,
        //イベントの色を変える
        eventColor: '#87cefa',
        //イベントの文字色を変える
        eventTextColor: '#000000',
        eventLimit: true, // allow "more" link when too many events
        eventRender: function(event, element) {
          element.css("font-size", "0.8em");
          element.css("padding", "5px");
        },
      });
    }
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
