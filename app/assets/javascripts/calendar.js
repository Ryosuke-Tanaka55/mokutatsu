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
        dayClick: function (start, end, jsEvent, view) {
          //クリックした日付情報を取得
          const year = moment(start).year();
          const month = moment(start).month()+1; //1月が0のため+1する
          const day = moment(start).date();
          //イベント登録のためnewアクションを発火
          $.ajax({
            type: 'GET',
            url: '/users/:user_id/events/new',
          }).done(function (res) {
            //イベント登録用のhtmlを作成
            $('.modal-body').html(res);
            //イベント登録フォームの日付をクリックした日付とする
            $('#event_start_time_1i').val(year);
            $('#event_start_time_2i').val(month);
            $('#event_start_time_3i').val(day);
            $('#event_end_time_1i').val(year);
            $('#event_end_time_2i').val(month);
            $('#event_end_time_3i').val(day);
            //イベント登録フォームのモーダル表示
            $('#modal').modal();
            // 成功処理
          }).fail(function (result) {
            // 失敗処理
            alert('エラーが発生しました。運営に問い合わせてください。')
          });
        },
      });
    }
  });  
});

document.addEventListener('turbolinks:load', function() {
  var calendarEl = document.getElementById('calendar');

  var calendar = new Calendar(calendarEl, {
      plugins: [ monthGridPlugin, interactionPlugin, googleCalendarApi ],
      //~省略~//

      events: '/events.json', // <=これを追加
      // 書き方のルールとしては['/コントローラー名.json']としてください

  });

  calendar.render();

  //この下からも追加
  //成功、失敗modalを閉じたときに予定を再更新してくれます
  //これがないと追加しても自動更新されません
  $(".error").click(function(){
      calendar.refetchEvents();
  });
});