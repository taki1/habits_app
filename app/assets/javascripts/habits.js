$(function() {
        // Datepicker の初期化
        //$( "#datepicker" ).datepicker();
        // テキストボックスにフォーカスが当たった時と
        // ボタンがクリックされたときにカレンダーを表示するオプション
        //$( "#datepicker" ).datepicker( "option", "showOn", 'both' );
        $( ".date-picker").datepicker({minDate: new Date(),numberOfMonths: 3, firstDay: 1});
 });
$(document).ready(function() {
    $('#calendar').fullCalendar({
        // タイトルの書式
        titleFormat: { month: 'YYYY/MM' }, 
/*
        {
            month: 'yyyy年MM月',                             // 2013年9月
            week: "yyyy年MM月dd日{ ～ }{[yyyy年]}{[MM月]dd日}", // 2013年9月7日 ～ 13日
            day: "yyyy年MM月dd日'('ddd')'"                  // 2013年9月7日(火)
        },
*/
        // 月名称
        monthNames: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'],
        // 月略称
        monthNamesShort: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'],
        // 曜日名称
        dayNames: ['日曜日', '月曜日', '火曜日', '水曜日', '木曜日', '金曜日', '土曜日'],
        // 曜日略称
        dayNamesShort: ['日', '月', '火', '水', '木', '金', '土'],
        // 選択可
        selectable: true,
        // 選択時にプレースホルダーを描画
        selectHelper: true,

        select: function(start, end, allDay) {
            //console.log('start:' + start);
            //console.log('end:' + end);
            //console.log('allDay:' + allDay);
	        //var title = window.prompt("title");
	        var title = "aaa";
	        var data = {event: {title: title,
	                            start: start,
	                            end: end, 
	                            allDay: allDay}}
	        $.ajax({
		        type: "POST",
		        url: "habits/update_result",
		        data: data,
		        success: function() {
			        //calendar.fullCalendar("refetchEvents");
			        alert(start+"success");
		        },
		        error:  function() {
			        //calendar.fullCalendar("refetchEvents");
			        alert(start+"error");
		        }
	        });
	     }
    })
});
