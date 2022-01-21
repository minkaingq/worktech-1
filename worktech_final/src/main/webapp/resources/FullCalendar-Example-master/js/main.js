var draggedEventIsAllDay
var activeInactiveWeekends = true
var calendar = $('#calendar').fullCalendar({
  /***************************************************************************
	 * OPTIONS
	 **************************************************************************/
  locale: 'ko',
  timezone: 'local',
  nextDayThreshold: '09:00:00',
  allDaySlot: true,
  displayEventTime: true,
  displayEventEnd: true,
  firstDay: 1, 
  weekNumbers: false,
  selectable: true,
  weekNumberCalculation: 'ISO',
  eventLimit: true,
  views: {
    month: {eventLimit: 12}, 
  },
  eventLimitClick: 'week', 
  navLinks: true,
  defaultDate: moment(new Date()), 
  timeFormat: 'HH:mm',
  defaultTimedEventDuration: '01:00:00',
  editable: true,
  minTime: '00:00:00',
  maxTime: '24:00:00',
  slotLabelFormat: 'HH:mm',
  weekends: true,
  nowIndicator: true,
  dayPopoverFormat: 'MM/DD dddd',
  longPressDelay: 0,
  eventLongPressDelay: 0,
  selectLongPressDelay: 0,
  header: {
    left: 'today, prevYear, nextYear, viewWeekends',
    center: 'prev, title, next',
    right: 'month, agendaWeek, agendaDay, listWeek',
  },
  views: {
    month: {
      columnFormat: 'dddd',
    },
    agendaWeek: {
      columnFormat: 'M/D ddd',
      titleFormat: 'YYYY년 M월 D일',
      eventLimit: false,
    },
    agendaDay: {
      columnFormat: 'dddd',
      eventLimit: false,
    },
    listWeek: {
      columnFormat: '',
    },
  },
//  customButtons: {
//    viewWeekends: {
//      text: '주말',
//      click: function () {
//        activeInactiveWeekends
//          ? (activeInactiveWeekends = false)
//          : (activeInactiveWeekends = true)
//        $('#calendar').fullCalendar('option', {
//          weekends: activeInactiveWeekends,
//        })
//      },
//    },
//  },

  eventRender: function (event, element, view) {
    // 일정에 hover시 요약
	  var flag = false;
	  
	  if(event.description == null) {
		  event.description = '';
	  }
	  
    element.popover({
      title: $('<div />', {
        class: 'popoverTitleCalendar',
        text: event.title,
      }).css({
        background: event.backgroundColor,
        color: event.textColor,
      }),
      content: $('<div />', {
        class: 'popoverInfoCalendar',
      })
        .append('<p><strong>등록자:</strong> ' + event.name + '</p>')
        .append('<p><strong>구분:</strong> ' + event.type + '</p>')
        .append(
          '<p><strong>시간:</strong> ' + getDisplayEventDate(event) + '</p>'
        )
        .append(
          '<div class="popoverDescCalendar"><strong>설명:</strong> ' +
            event.description +
            '</div>'
        ),
      delay: {
        show: '50',
        hide: '50',
      },
      trigger: 'hover',
      placement: 'top',
      html: true,
      container: 'body',
    })
    
    var url = window.location.href;
    console.log(url);
    if(url.includes('home.do')) { 
    	return true;
    } else {
    	return filtering(event)
    }
  },

  events: function (start, end, timezone, callback) {
	  
    $.ajax({
      type: 'get',
      url: 'getAllList.to',
      data: {
        startDate : moment(start).format('YYYY-MM-DD'),
        endDate   : moment(end).format('YYYY-MM-DD')
      },
      success: function (response) {
        var fixedDate = response.map(function (array) {
          return array
        })
        callback(fixedDate)
      },
    })
  },

  eventAfterAllRender: function (view) {
    if (view.name == 'month') $('.fc-content').css('height', 'auto')
  },

  eventResize: function (event, delta, revertFunc, jsEvent, ui, view) {
    $('.popover.fade.top').remove()

    var newDates = calDateWhenResize(event)
    var json = {
    		tNo : event.tNo,
    		start : moment(newDates.startDate).format(),
    		end : moment(newDates.endDate).format(),
    }

    $.ajax({
      type: 'POST',
      url: 'updateToDo.to',
      contentType: "application/json",
      data: JSON.stringify(json),
      success: function (response) {
        alert('수정: ' + newDates.startDate + ' ~ ' + newDates.endDate)
      },
    })
  },

  eventDragStart: function (event, jsEvent, ui, view) {
    draggedEventIsAllDay = event.allDay
  },

  eventDrop: function (event, delta, revertFunc, jsEvent, ui, view) {
    $('.popover.fade.top').remove()
    
        var newDates = calDateWhenResize(event)
        var json = {
    		tNo : event.tNo,
    		start : moment(newDates.startDate).format(),
    		end : moment(newDates.endDate).format(),
    }
    if (view.type === 'agendaWeek' || view.type === 'agendaDay') {
      if (draggedEventIsAllDay !== event.allDay) {
        alert('시간 변경 불가')
        location.reload()
        return false
      }
    }

    var newDates = calDateWhenDragnDrop(event)

    $.ajax({
        type: 'POST',
        url: 'updateToDo.to',
        contentType: "application/json",
        data: JSON.stringify(json),
      success: function (response) {
        alert('수정: ' + newDates.startDate + ' ~ ' + newDates.endDate)
      },
    })
  },

  select: function (startDate, endDate, jsEvent, view) {
    $('.fc-body').unbind('click')
    $('.fc-body').on('click', 'td', function (e) {
      $('#contextMenu').addClass('contextOpened').css({
        display: 'block',
        left: e.pageX,
        top: e.pageY,
      })
      return false
    })

    var today = moment()

    if (view.name == 'month') {
      startDate.set({
        hours: today.hours(),
        minute: today.minutes(),
      })
      startDate = moment(startDate).format('YYYY-MM-DD HH:mm')
      endDate = moment(endDate).subtract(1, 'days')

      endDate.set({
        hours: today.hours() + 1,
        minute: today.minutes(),
      })
      endDate = moment(endDate).format('YYYY-MM-DD HH:mm')
    } else {
      startDate = moment(startDate).format('YYYY-MM-DD HH:mm')
      endDate = moment(endDate).format('YYYY-MM-DD HH:mm')
    }

    var $contextMenu = $('#contextMenu')
    $contextMenu.on('click', 'a', function (e) {
      e.preventDefault()

      if ($(this).data().role !== 'close') {
        newEvent(startDate, endDate, $(this).html())
      }

      $contextMenu.removeClass('contextOpened')
      $contextMenu.hide()
    })

    $('body').on('click', function () {
      $contextMenu.removeClass('contextOpened')
      $contextMenu.hide()
    })
  },

  eventClick: function (event, jsEvent, view) {
    editEvent(event)
  },
})

function getDisplayEventDate(event) {
  var displayEventDate
  
  if (event.allDay == true) {
	displayEventDate = '하루종일'
  } else {
	  var startTimeEventInfo = moment(event.start).format('HH:mm')
	  var endTimeEventInfo = moment(event.end).format('HH:mm')
	  displayEventDate = startTimeEventInfo + ' - ' + endTimeEventInfo
  }
  return displayEventDate
}

function filtering(event) {
  var show_username = true
  var show_type = true
  var username = $('input:checkbox.filter:checked')
    .map(function () {
      return $(this).val()
    })
    .get()
  var types = $('#type_filter').val()
  
  if(username.length <= 1 && event.share == 'true') {
	  show_username = false;
  }
  
  if (types && types.length > 0) {
    if (types[0] == 'all') {
      show_type = true
    } else {
      show_type = types.indexOf(event.type) >= 0
    }
  }

  return show_username && show_type
}

function calDateWhenResize(event) {
  var newDates = {
    startDate: '',
    endDate: '',
  }

  if (event.allDay == true) {
    newDates.startDate = moment(event.start._d).format('YYYY-MM-DD')
    newDates.endDate = moment(event.end._d)
      .subtract(1, 'days')
      .format('YYYY-MM-DD')
  } else {
    newDates.startDate = moment(event.start._d).format('YYYY-MM-DD HH:mm')
    newDates.endDate = moment(event.end._d).format('YYYY-MM-DD HH:mm')
  }

  return newDates
}

function calDateWhenDragnDrop(event) {
  var newDates = {
    startDate: '',
    endDate: '',
  }

  if (!event.end) {
    event.end = event.start
  }

  if (event.allDay == true && event.end === event.start) {
    newDates.startDate = moment(event.start._d).format('YYYY-MM-DD')
    newDates.endDate = newDates.startDate
  }

  else if (event.allDay == true && event.end !== null) {
    newDates.startDate = moment(event.start._d).format('YYYY-MM-DD')
    newDates.endDate = moment(event.end._d)
      .subtract(1, 'days')
      .format('YYYY-MM-DD')
  }

  else if (event.allDay == false) {
    newDates.startDate = moment(event.start._d).format('YYYY-MM-DD HH:mm')
    newDates.endDate = moment(event.end._d).format('YYYY-MM-DD HH:mm')
  }

  return newDates
}
