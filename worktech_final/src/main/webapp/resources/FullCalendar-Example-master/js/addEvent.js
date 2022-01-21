var eventModal = $('#eventModal');

var modalTitle = $('.modal-title');
var editAllDay = $('#edit-allDay');
var editTitle = $('#edit-title');
var editStart = $('#edit-start');
var editEnd = $('#edit-end');
var editType = $('#edit-type');
var editColor = $('#edit-color');
var editDesc = $('#edit-desc');
var editShare = $('#edit-share');

var addBtnContainer = $('.modalBtnContainer-addEvent');
var modifyBtnContainer = $('.modalBtnContainer-modifyEvent');


/* 일정 추가 */
var newEvent = function(start, end, eventType) {

	$("#contextMenu").hide(); 

	modalTitle.html('일정 추가');
	editType.val(eventType).prop('selected', true);
	editTitle.val('');
	editStart.val(start);
	editEnd.val(end);
	editDesc.val('');
	

	addBtnContainer.show();
	modifyBtnContainer.hide();
	eventModal.modal('show');


	$('#save-event').unbind();
	$('#save-event').on(
			'click',
			function() {

				var eventData = {
					title : editTitle.val(),
					start : editStart.val(),
					end : editEnd.val(),
					description : editDesc.val(),
					type : editType.val(),
					backgroundColor : editColor.val(),
					textColor : '#ffffff',
					allDay : false,
					share : false
					
				};

				if (eventData.start > eventData.end) {
					alert('종료일을 다시 선택해주세요.');
					return false;
				}

				if (eventData.title === '') {
					alert('일정 제목을 입력하세요.');
					return false;
				}

				var realEndDay;

				if (editAllDay.is(':checked')) {
					eventData.start = moment(eventData.start).format('YYYY-MM-DD');
					eventData.end = moment(eventData.end).add(1, 'days')
							.format('YYYY-MM-DD');

					eventData.allDay = true;
				}
				
				if(editShare.is(':checked')) {
					eventData.share = true;
				}

				$("#calendar").fullCalendar('renderEvent', eventData, true);
				eventModal.find('input, textarea').val('');
				editAllDay.prop('checked', false);
				editShare.prop('checked', false);
				eventModal.modal('hide');

				var json = {
					description : eventData.description
					, title : eventData.title
					, start : moment(eventData.start).format() 
					, end : moment(eventData.end).format()
					, backgroundColor : eventData.backgroundColor
					, allDay : eventData.allDay
					, textColor : eventData.textColor
					, type : eventData.type
					, share : eventData.share
				}

				// 새로운 일정 저장
				$.ajax({
					url : "insertTodo.to",
					type : 'POST',
					data : JSON.stringify(json),
			        contentType: "application/json",
					success : function(response) {
						console.log(response);
					}
				});
			});
};