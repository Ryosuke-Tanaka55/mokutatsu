// CRUDを行う際にCSRF対策のtokenを発行
window.onload = function(){ 
  var prepare = function(options, originalOptions, jqXHR) {
    var token;
    if (!options.crossDomain) {
      token = $('meta[name="csrf-token"]').attr('content');
      if (token) {
        return jqXHR.setRequestHeader('X-CSRF-Token', token);
      }
    }
  };
};

 
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


    // カレンダー表示
    $('#calendar').fullCalendar ({
      events: '/users/:user_id/events.json',
      titleFormat: 'YYYY年 M月',
      dayNamesShort: ['日', '月', '火', '水', '木', '金', '土'],

      header: {
        left: 'prev,next prevYear,nextYear today',
        center: 'month,agendaWeek,agendaDay,listMonth',
        right: 'title'
      },

      defaultTimedEventDuration: '03:00:00',
      navLinks: true,
      businessHours: true,
      locale: 'ja',
      firstDay : 1,

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
        listMonth: '予定リスト'
      },

      timeFormat: 'HH:mm',
      eventTextColor: '#000000',
      navLinks: true,
      selectable: true,
      selectHelper: true,
      defaultDate: new Date(),
      navLinks: true, // can click day/week names to navigate views
      editable: true,
      eventLimit: true,
      slotDuration: '00:15:00',
      slotLabelInterval: '01:00',
      nowIndicator: true,
      defaultView: 'month',
      weekends: true,
      resourceLabelText: 'リソース',
    
      // 日付クリック
      dayClick : function (start, end, jsEvent, view) {
        $('#inputScheduleForm').modal('show');
        },
      
      // event クリックで編集、削除
      eventClick : function (event, jsEvent ,view) {
        jsEvent.preventDefault();
        $(`#inputScheduleEditForm${event.id}`).modal('show');
        $(`#inputScheduleEditForm${event.id}`).removeAttr("disabled");
      },

      eventMouseover : function(event, jsEvent, view) {
        jsEvent.preventDefault();
      }
    });
  }
});