//******    작성자 : 구동현        *****//
//******    작성자 : 구동현        *****//
//******    작성일 : 23.12.15     *****//

$(document).ready(function() {
    // 파일이름에 'tripplan'이 포함되었을 때에만 실행
    // var script = document.createElement('script');
    // script.src = "//dapi.kakao.com/v2/maps/sdk.js?appkey=YOUR_API_KEY&libraries=services";
    // document.head.appendChild(script);

    // 변경된 input value 값이 변경될때마다 실행되는 함수
    $('#spotStartSetTimeContent').on('change', '.timeSC input[type="time"]', function() {
        setTimeout(() => {
            checkTimeIntervals();
        }, 1000);
        
    });

    $(".userBtn").click(function() {
        $("#userLogin").show();
        $("#adminLogin").hide();
        $(".userBtn").addClass("active");
        $(".adminBtn").removeClass("active");
    });

    $(".adminBtn").click(function() {
        $("#userLogin").hide();
        $("#adminLogin").show();
        $(".adminBtn").addClass("active");
        $(".userBtn").removeClass("active");
    });

    /* 메뉴 구성 드롭박스 */
    var $dropdownToggle = $('.dropdown-toggle');
    var $dropdownMenu = $('.dropdown-menu');

    $dropdownMenu.on('mouseover', function() {
        $(this).css('display', 'block');
    });

    $dropdownMenu.on('mouseleave', function() {
        $(this).css('display', 'none');
    });

    $dropdownToggle.on('click', function() {
        var $dropdownMenu = $(this).next('.dropdown-menu');
        $dropdownMenu.css('display', 'block');
    });


    $(".yWJT-new-nav-ux").on('click', function () {
        // console.log("click");
        // 요소에 'pRB0-expanded' 클래스가 있는지 확인
        var isExpanded = $(".pRB0.pRB0-collapsed.pRB0-mod-variant-accordion").hasClass('pRB0-expanded');

        // 클래스 토글
        if (isExpanded) {
            $(".pRB0.pRB0-collapsed.pRB0-mod-variant-accordion").removeClass('pRB0-expanded');
            $("#main").removeClass('JjjA-moved');
        } else {
            $(".pRB0.pRB0-collapsed.pRB0-mod-variant-accordion").addClass('pRB0-expanded');
            $("#main").addClass('JjjA-moved');
        }
    });

    $(".pRB0.pRB0-collapsed.pRB0-mod-variant-accordion").on("mouseenter", function () {
        $(".pRB0.pRB0-collapsed.pRB0-mod-variant-accordion").addClass('pRB0-expanded');
        $("#main").addClass('JjjA-moved');
    });
    $(".pRB0.pRB0-collapsed.pRB0-mod-variant-accordion").on("mouseleave", function () {
        $(".pRB0.pRB0-collapsed.pRB0-mod-variant-accordion").removeClass('pRB0-expanded');
        $("#main").removeClass('JjjA-moved');
    });


    $(".lfBz-field-outline div").on('click', function (event) {
        // console.log("click");
        if ($(event.target).hasClass('iiio-submit')) {
            // 클릭한 요소가 iiio-submit 클래스를 가지고 있으면 YSUE-mod-visible 클래스 제거
            $(".YSUE").removeClass('YSUE-mod-visible');
            $(".sidoModal").css('display','none');
        } else {
            // iiio-submit 클래스를 가지고 있지 않으면 YSUE-mod-visible 클래스 추가
            $(".YSUE").addClass('YSUE-mod-visible');
        }
    });

    // 지역검색 시 나오는 팝업창 생성 및 제거 
    $('.dDYU-viewport').on({
        mouseenter: function () {
            // .dDYU-viewport .dDYU-content(검색 조건 창)에 마우스를 올렸을 때
            $(".YSUE").addClass('YSUE-mod-visible');
        },
        click: function (event) {
            // .dDYU-viewport(어두운 배경화면)를 클릭했을 때 팝업창 제거
            if ($(event.target).hasClass('dDYU-viewport') || $(event.target).closest('.dDYU-viewport .dDYU-content .QdG_').length > 0) {
                $(".YSUE").removeClass('YSUE-mod-visible');
                $(".sidoModal").css('display','none');
            }
        }
    });
    
    // .dDYU-viewport .dDYU-content .QdG_(업데이트)를 클릭했을 때 팝업창 제거
    $('.dDYU-viewport .dDYU-content .QdG_').on('click', function () {
        $(".YSUE").removeClass('YSUE-mod-visible');
        $(".sidoModal").css('display','none');
    });

//    $("#sido .dosi").on("click", function (e) {
//        var sidoValue = $(e.target).text();
//        $(".sidoValues").val(sidoValue);
//        $(".sidoValues").text(sidoValue);
//        $(".sidoModal").css('display','none');
//    });

    $(".pM26").on("click", function () {
        $(".Loading").css('display','block');
        
        $(".Loading").css('display','none');
        $(".sidoModal").css('display','block');
        
    });

    // 사용자 드롭다운 메뉴 보이기/ 감추기
    $("#rogin_label").on("click", function () {
        $(".ui-dialog-Popover").toggleClass("none");
    });
    // 사용자 드롭다운 메뉴 마우스 떠날때 감추기
    $(".ui-dialog-Popover").on("mouseenter", function () {
        $(".ui-dialog-Popover").removeClass("none");
    }).on("mouseleave", function () {
        $(".ui-dialog-Popover").addClass("none");
    });

    // "추가" 버튼에 대한 클릭 이벤트 처리
    $('#placesList').on('click', '.spotBtn', function(event) {
        // 클릭한 .spotBtn 요소를 선택
        var spotBtn = $(this);

        // 클릭한 .spotBtn이 속한 요소의 data-id 속성 값을 가져옴
        var dataIdValue = spotBtn.closest('[data-id]').attr('data-id');
    
        // 해당 data-id 값을 가진 원본 요소를 찾아 sourceElement에 저장
        var sourceElement = $('[data-id="' + dataIdValue + '"]');
        //console.log(sourceElement);


        if (sourceElement.length > 0) {
            // 대상 요소(.spot-container.active .spotListPage)를 찾음
//            var destinationElement = $('.spot-container.active .spotListPage');
            // var desElement = $('#spotTimeSetContent .spotListone');
            
            var sourceName = sourceElement.find('.info-title b').text();
			var sourceAddress = $('#address').val();	        
			var sourceDay = $('.left-plan-container.active').attr('id').replace('day', '');
	        var sourceLatitude = $('#latclick').val();
	        var sourceLongitude = $('#lngclick').val();

            // console.log(sourceName ,sourceAddress, sourceDay, sourceLatitude, sourceLongitude );

            $.ajax({
                url :'/insert_spot.do',
                type: 'get',
                data: {
                    sourceName : sourceName,
                    sourceAddress : sourceAddress,
                    sourceDay : sourceDay,
                    sourceLatitude : sourceLatitude,
                    sourceLongitude : sourceLongitude
                },
                success : function(result){
					// console.log('result:'+result);
                    if(result == 0){
						alert('여행지는 12개까지만 가능합니다!!');
					}else{
						
						// active되어있던 일차페이지를 파라미터로 넘김
						createDefault(result);
					}

                },error : function(e){

                }
            });
        }
    });

    
    
    $("#spotTimeSetDelete").on("click", function () {
        var spotItem = $('#findStepPlaces').closest('.spotListone');
        if (spotItem.length > 0) {
            spotItem.remove(); // 또는 원하는 삭제 작업 수행
        }
        $("#spotTimeSetModal").removeClass('active')
    });

     

    // "삭제" 버튼에 대한 클릭 이벤트 처리
    // $('#findStepPlaces').on('click', '.spotBtn', function(event) {
    //     var spotItem = $(this).closest('.spotListone');
    //     if (spotItem.length > 0) {
    //         spotItem.remove();
    //     }
    // });


    // 리스트 순서 바꾸기 
    // $('#placesList').on('click', '.spotListone', function (event) {
    //     // 초기에 order indicators 업데이트
    //     $('.spot-container .spotListPage').each(function () {
    //         updateOrderIndicators('#' + this.id);
    //     });
    //         // 각 .spot-container에 대한 Sortable 인스턴스 초기화
    //         $('.spot-container .spotListPage').each(function () {
    //         var spotListPageId = '#' + this.id;

    //         var sortableListInstance = new Sortable($(spotListPageId)[0], {
    //             animation: 200,
    //             onUpdate: function (event) {
    //                 //console.log('순서가 변경되었습니다.');
    //                 updateOrderIndicators(spotListPageId);
    //             }
    //         });
    //     });
    //     // 순서 업데이트 함수
    //     function updateOrderIndicators(spotListPageId) {
    //         var orderElements = $(spotListPageId + ' .spotListone');
    //         orderElements.each(function (index, element) {
    //             var checkOrder = $(element).find('.checkOrder');
    //             if (!checkOrder.length) {
    //                 checkOrder = $('<div class="checkOrder"></div>');
    //                 $(element).prepend(checkOrder);
    //             }
    //             // checkOrder.text((index + 1) + '순서');
    //         });
    //     }
    // });

   
    
	//loadGroupMember();

}); /***********window.ready()end**************/




function createGroup() {
    $.ajax({
        url: '/create_Group.do',
            type: 'get',
            success: function(result) {
                alert('여행계획이 생성되었습니다!!');
                //console.log(result);
                var teamObject = JSON.parse(result);
                //console.log(teamObject);
                const teamName= teamObject.team_name;
                const teamUrl = teamObject.team_url;
                
                $('#team_name').val(teamName);
				$('#team_url').val(teamUrl);
				createDefault(1);
            },
            error:function(e) {
                console.log('여행계획 만들기 에러입니다' + e);
            }
    });
} 

//이전 그룹 불러오는 함수
function loadGroupDatas() { 
    $.ajax({
        url: '/load_GroupDatas.do',
            type: 'get',
            success: function(result) {
                if(result == 0) {
                    alert('진행중인 여행계획이 없습니다!! 새로운 여행계획을 생성해보세요!!');
                } else {
                    // 모달 객체 가져오기          
                    $('#selectmodal').modal('hide');
//                  	var selectModal = new bootstrap.Modal(document.getElementById('selectmodal'));
// 						selectModal.hide();
                    
                document.getElementById('groupTableBody').innerHTML = "";
                
                const groupArray = JSON.parse(result);

                // 테이블 내용 추가
                    for(var i=0; i<groupArray.length; i++) {

                    var tableBody = document.getElementById('groupTableBody');
                    var newRow = tableBody.insertRow(i);
                                        
                    newRow.id = groupArray[i].team_id;

                    var cell1 = newRow.insertCell(0);
                    var cell2 = newRow.insertCell(1);
                    var cell3 = newRow.insertCell(2);
                    var cell4 = newRow.insertCell(3);

                    var radio = document.createElement('input');
                    radio.type = 'radio';
                    radio.name = 'groupRadio';
                    //console.log(radio.name);
                    cell1.appendChild(radio);
                    cell2.innerHTML = i + 1;
                    cell3.innerHTML = groupArray[i].team_name;
                    cell4.innerHTML = groupArray[i].team_dest;            
                    }
                    var selectGroup = new bootstrap.Modal(document.getElementById('selectgroup'));
        
                    // 모달 보이기
                    selectGroup.show();
                }
            },
            error:function() {
                console.log('여행계획 불러오기 에러입니다');
            }
    });
}

function loadGroup(){
    var tableBody = document.getElementById('groupTableBody');
    var checkedRadio = tableBody.querySelector('input[type="radio"]:checked');
    
    if(checkedRadio) {                      
        var row = checkedRadio.closest('tr');
        var rowId = row.id;
            // console.log(rowId);
        $.ajax({
            url: '/load_Group.do',
            type: 'get',
            data: {
                teamId : rowId
            },
            success: function(result) {
                
                $('#selectgroup').on('hidden.bs.modal', function() {
                    setTimeout(function() {
                        alert('여행계획을 불러왔습니다!!');
                    }, 100); // 100ms 지연을 줌
                });

                $('#selectgroup').modal('hide');
                
                var teamObject = JSON.parse(result);
                const teamName= teamObject.team_name;
                const teamUrl = teamObject.team_url;
                //console.log(teamName);
                $('#team_name').val(teamName);
				$('#team_url').val(teamUrl);
				
				createDefault(1);
            },
            error:function() {
            console.log('여행계획 불러오기 에러입니다');
            }
        });
        
    } else {
        alert('여행계획을 선택하셔야 합니다');
    } 
}

function getDosi(dosi) {
    $.ajax({
        type: "GET",
        url: "/addressJson.do", // 실제 서버 엔드포인트
        data: {
            dosi: dosi
        },
        success: function(data) {
            // 서버에서 받은 응답 처리
            //console.log(data);
            var jsonData = JSON.parse(data);
            var sido = $("#sido");
                            
            sido.empty();
            // JSON 데이터를 반복하여 div를 추가
            $.each(jsonData, function(index, value) {
                var div = $("<div>").attr('id', value).text(value);
                sido.append(div);
            });
        },
        error: function(error) {
            // 오류 처리
            console.error(error);
        }
    });
}

function showSection(sectionId) {
	createFinanceTable();
	createTodoTable();
    var sections = document.querySelectorAll('.content-section');
    sections.forEach(function (section) {
        if (section.id === sectionId) {
            section.classList.toggle('show'); // 토글로 'show' 클래스 추가 또는 제거
        } else {
            section.classList.remove('show');
        }
    });
}

const btn = document.getElementById('btn'); // 버튼
let addValue = document.getElementById('addValue'); // 할일 입력
let result = document.getElementById('result'); // 추가된 할일



// 할일 추가 시
function addTodo() {
    if (!addValue.value.trim()) { /* 입력값이 없는 경우 */
        alert('내용을 입력하세요!');
        return;
    }
    
    const checklist = addValue.value;
    //console.log(checklist);

    
    $.ajax({
        url: '/add_todo.do',
        type: 'get',
        data: {
            checklist: checklist
        },
        success: function(result) {
            //console.log('준비물을 저장하였습니다');
            createTodoTable();
            addValue.value="";

        },
        error:function() {
            console.log('준비물 저장하기 에러입니다');
        }
    });
                                    
}

// 준비물 테이블 생성 처리
function createTodoTable(){
    
    document.getElementById('todoTableBody').innerHTML = "";
    
    $.ajax({
        url: '/create_todo_table.do',
        type: 'get',
        success: function(result) {
            //console.log('준비물을 불러왔습니다');
            if(result == null) {
                return;
            } else {
                
                const todoArray = JSON.parse(result);
                
                for(let i=0; i<todoArray.length; i++){
                    
                    var tableBody = document.getElementById('todoTableBody');
                    var newRow = tableBody.insertRow(i);
                                        
                    newRow.id = todoArray[i].pre_id;

                    let del = document.createElement('button');
                    
                    
                    var cell1 = newRow.insertCell(0);
                    var cell2 = newRow.insertCell(1);
                    var cell3 = newRow.insertCell(2);

                    var checkbox = document.createElement('input');
                    checkbox.type = 'checkbox';
                    
                    if(todoArray[i].pre_check){
                        checkbox.checked = true;
                    }
                    
                    checkbox.addEventListener('change', function(event) {
                        
                        const checkedlist = event.target.parentNode;
                        var row = checkedlist.closest('tr');
                        var rowId = row.id;
                        
                        if (event.target.checked) {
                            // 체크되었을 때 실행할 작업
                            
                            $.ajax({
                                url: '/check_todo.do',
                                data: {
                                    pre_id : rowId
                                
                                },
                                type: 'get',
                                success: function(result) {
                                    
                                    createTodoTable();

                                },
                                error:function() {
                                    console.log('체크리스트 check 에러입니다');
                                }
                                });
                        
                        } else {
                            // 체크가 해제되었을 때 실행할 작업
                            $.ajax({
                                url: '/uncheck_todo.do',
                                data: {
                                    pre_id : rowId
                                
                                },
                                type: 'get',
                                success: function(result) {
                                    
                                    createTodoTable();

                                },
                                error:function() {
                                    console.log('체크리스트 uncheck 에러입니다');
                                }
                                });
                        
                        }
                    });
                        
                    cell1.appendChild(checkbox);
                    
                    cell2.innerHTML = todoArray[i].pre_name;

                    cell3.appendChild(del);
                    
                    del.innerText = "x"; // 삭제버튼에 들어갈 'x'자 문자
                    del.style.fontSize = "20px";
                    del.style.border = "none";
                    del.style.float = "right";
                    del.style.marginLeft = "5px"; // 버튼 간격 조정
                    del.style.cursor = "pointer";
                    
                    del.addEventListener("click", deleteTodo); // 삭제버튼 클릭 시 리스트 지우기 이벤트 실행

                    
                }
            }
        },
        error:function() {
            console.log('준비물 불러오기 에러입니다');
        }
    });
}

// 삭제 이벤트 처리
function deleteTodo(event) {
    
        //var tableBody = document.getElementById('todoTableBody');
    const deleteRow = event.target.parentNode;
    var row = deleteRow.closest('tr');
            
    var rowId = row.id;
            
            $.ajax({
            url: '/delete_todo.do',
            data: {
                pre_id : rowId
            
            },
            type: 'get',
            success: function(result) {
                
                createTodoTable();

            },
            error:function() {
                console.log('체크리스트 delete 에러입니다');
            }
        });  	

}


function createFinanceTable() {
               
    var totalAmountElement = document.getElementById('totalAmount');

    
    $.ajax({
        url : '/create_finance_table.do',
        type : 'get',
        success : function(result) {
        
        document.getElementById('expenseTableBody').innerHTML = "";
        
        const financeArray = JSON.parse(result);
        
        var totalAmount = 0;
        
        
        for(var i=0; i<financeArray.length; i++) {
            
            var tableBody = document.getElementById('expenseTableBody');
                var newRow = tableBody.insertRow(i);
                
                newRow.id = financeArray[i].id;

                var cell1 = newRow.insertCell(0);
                var cell2 = newRow.insertCell(1);
                var cell3 = newRow.insertCell(2);
                var cell4 = newRow.insertCell(3);
                var checkbox = document.createElement('input');
                checkbox.type = 'checkbox';
                cell1.appendChild(checkbox);
                cell2.innerHTML = financeArray[i].day;
                cell3.innerHTML = financeArray[i].detail;
                cell4.innerHTML = financeArray[i].expense;
                totalAmount += financeArray[i].expense;
            
        }
        
            totalAmountElement.textContent = formatCurrency(totalAmount);
        
        },
        error:function() {
        console.log('가계부 테이블 만들기 에러입니다!');
        }
    });
    

    
}



function addExpense() {
	
    var dateInput = document.getElementById('date');
    var descriptionInput = document.getElementById('description');
    var amountInput = document.getElementById('amount');
    var peopleInput = document.getElementById('people'); // 인원 입력란

    var date = dateInput.value;
    var description = descriptionInput.value;
    var amount = parseFloat(amountInput.value.replace(/,/g, '')); // 콤마 제거
    var people = parseInt(peopleInput.value);

    if (!date || !description || isNaN(amount) || isNaN(people) || people < 1) {
        alert('날짜, 내용, 금액, 인원을 모두 입력하세요.');
        return;
    }

    
    $.ajax({
            url: '/insert_finance.do',
            data: {
            date : date,
            description : description,
            amount : amount,
            
            },
            type: 'get',
            success: function(result) {

            createFinanceTable();

            },
            error:function() {
            console.log('가계부 insert 에러입니당');
            }
    });

    // 입력 필드 초기화
    descriptionInput.value = '';
    amountInput.value = '';    
}

function deleteSelected() {
    var tableBody = document.getElementById('expenseTableBody');
    var checkboxes = tableBody.querySelectorAll('input[type="checkbox"]:checked');

    checkboxes.forEach(function (checkbox) {
        var row = checkbox.closest('tr');
        var rowId = row.id;
        
        $.ajax({
            url: '/delete_finance.do',
            data: {
            fin_id : rowId
            
            },
            type: 'get',
            success: function(result) {

            createFinanceTable();

            },
            error:function() {
            console.log('가계부 delete 에러입니당');
            }
        });
        
    });
}

function formatCurrency(amount) {
    // 천 단위로 콤마 추가
    return amount.toFixed(0).replace(/\d(?=(\d{3})+$)/g, '$&,') + ' 원';
}

// 인원별 금액 계산 및 업데이트
function calculatePerPersonAmount() {
    var totalAmountElement = document.getElementById('totalAmount');
    var amountPerPersonElement = document.getElementById('amountPerPerson');
    var peopleInput = document.getElementById('people');

    var totalAmount = parseFloat(totalAmountElement.textContent.replace(/,/g, '')); // 콤마 제거
    var people = parseInt(peopleInput.value);

    if (isNaN(totalAmount) || isNaN(people) || people < 1) {
        alert('총 금액과 인원을 확인하세요.');
        return;
    }

    var amountPerPerson = totalAmount / people;
    amountPerPersonElement.textContent = formatCurrency(amountPerPerson);
}

function copyUrl() {
	var url = "localhost:8080/joinGroupform.do/"; 
	url += document.getElementById('team_url').value;
    var textarea = document.createElement("textarea");
    document.body.appendChild(textarea);
    textarea.value = url;
    textarea.select();
    document.execCommand("copy");
    document.body.removeChild(textarea);
    alert("링크가 복사되었습니다.");
} 

function focusTextField(){
    $('#team_name').focus();
}

function handleEnter(event) {
  if(event.key == 'Enter') {
      reviseGroupName();
  }
}

function reviseGroupName(){
  
  var teamName = document.getElementById('team_name').value;
  
   $.ajax({
          url: '/revise_group_name.do',
          data: {
          team_name : teamName
          
          },
          type: 'get',
          success: function(result) {
              
              

          },
          error:function() {
          console.log('팀이름 변경 에러입니다');
          }
      });
}
function createDefault(activeDay){
	
	$.ajax({
		url : '/create_dosi_button.do',
		type : 'get',
		success : function(dosi){
			
			$('.sidoValues').html(dosi);
			//$('#keyword').val(dosi);
			//$('.sidoValues').val(dosi);
	
									
		},error : function(e){
									
		}
							
	});
	
	$.ajax({
		url : '/create_day_button.do',
		type : 'get',
		success : function(result){
			var dayObject = JSON.parse(result);
				
			const stringDay = dayObject.startDay + " - " + dayObject.endDay;
			$('.trvl_day').html(stringDay);
				
						
		},error : function(e){
									
		}
							
	});
	
	$.ajax({
		url: '/create_day_option.do',
	    type: 'get',
	    success: function(daysBetween) {
			var strDayOption = '';
			//console.log(daysBetween);
			for(var i=1; i<=daysBetween; i++){
				strDayOption += '<option value=\"' + i +' 일차\">'+ i + ' 일차' +'</option>';
                createSpotBox(i);
			}
			//console.log(strDayOption);
			$('#date').html(strDayOption);
	    },
	    error:function() {
				  
	    }
	});
	
	$.ajax({
		url: '/create_spot_table.do',
	    type: 'get',
	    success: function(result) {
			if(result != 0){
				var dayArray = JSON.parse(result);
				for(var i=0; i<dayArray.length; i++){
					var spotTable ='';
					var spotArray = dayArray[i];
					for(var j=0; j<spotArray.length; j++){
						spotTable += '<div id="' + spotArray[j].id + '" class="item spotListone ft-face-nm"><div class="info"><span></span><span class="info-title"><b>'
						+ spotArray[j].name + '</b></span><span class="info-address"><small>' 
						+ spotArray[j].address + '</small></span>'
						+'<label id="latitude" class="none" style="font-size: 0;">' + spotArray[j].latitude +'</label>'
						+'<label id="longitude" class="none" style="font-size: 0;">' + spotArray[j].longitude +'</label>'
						+'<div><button type="button" class="btn spotDelBtn" onclick="deleteSpot(this)">삭제</button></div></div></div>';
					}
				
					//console.log(spotTable);
					$('#spotListPage'+(i+1)).html(spotTable);

				}
				
				//console.log(activeDay);
				if(activeDay == null){
					$('#day1').addClass('active');
					$('#spotListPage1').addClass('active');
				}else{
					$('#day'+activeDay).addClass('active');
					$('#spotListPage'+activeDay).addClass('active');
				}

			}else {
				alert('저장한 여행지가 없습니다.');
			}

	    },
	    error:function() {
				  
	    }
	});
	
	loadGroupMember();
	
}

function showTimeSetModal() {
    $("#spotTimeSetModal").toggleClass('active');
    $("#spotTimeSetContent").html('');
    $("#spotStartSetTimeContent").html('');
    setTimeout(() => {
         checkTimeIntervals();
    }, 300);
    
    $.ajax({
        url: '/create_spot_table.do',
        type: 'get',
        success: function(result) {
            if (result != 0) {
                var dayArray = JSON.parse(result);

                for (var i = 0; i < dayArray.length; i++) {
                    var spotTable = '';
                    var spotArray = dayArray[i];

                    for (var j = 0; j < spotArray.length; j++) {
                        spotTable += '<div id="' + spotArray[j].id + '" class="item spotListone ft-face-nm"><div class="info"><span></span><span class="info-title"><b>'
                            + spotArray[j].name + '</b></span><span class="info-address"><small>'
                            + spotArray[j].address + '</small></span>'
                            + '<label class="none" style="font-size: 0;" data-name="latitude">' + spotArray[j].latitude + '</label>'
                            + '<label class="none" style="font-size: 0;" data-name="longitude">' + spotArray[j].longitude + '</label>'
                            + '<div></div></div></div>';
                    }

                    var newTimeContent = $('<div>', {
                        class: 'timeSC',
                        id: 'timeSC' + (i + 1),
                        html: spotTable
                    });
                    $('#spotTimeSetContent').append(newTimeContent);

                    // 시작 및 종료 시간 input 요소들을 생성하여 추가
                    var newStartTimeContent = $('<div>', {
                        class: 'timeSC',
                        id: 'timeSTC' + (i + 1)
                    });
                    addTimeBox(newStartTimeContent, spotArray.length);
                    $('#spotStartSetTimeContent').append(newStartTimeContent);

                
                    if ( $('#day'+(i + 1)).hasClass('active') ){
                        $('#timeSC'+(i + 1)).addClass('active');
                        $('#timeSTC'+(i + 1)).addClass('active');
                    } 
                }
                
            } else {
                alert('저장한 여행지가 없습니다.');
            }
        },
        error: function() {
            // 에러 처리
        }
    });
}

// 시작 및 종료 시간 input 요소들을 생성하여 요소에 추가
function addTimeBox(container, createBox) {
    for (let i = 0; i < createBox; i++) {
        let startTime = '10:00'; // 예시로 고정값 사용
        let startTimeObj = new Date('2021-01-01T' + startTime);

        let endTimeObj = new Date(startTimeObj);
        endTimeObj.setHours(endTimeObj.getHours() + 1);

        let newBox = $('<div>', {
            class: 'item',
            html: '<label>시작시간: <input type="time" class="startTime" value="' + formatTime(startTimeObj) + '"></label>' +
                '<label>종료시간: <input type="time" class="endTime" value="' + formatTime(endTimeObj) + '"></label>'
        });

        container.append(newBox);
    }
}


function checkTimeIntervals() {
    var timeGroupsLength = $("#spotStartSetTimeContent .timeSC").length;

    for (var j = 1; j < timeGroupsLength; j++) {
        var timeGroups = $("#spotStartSetTimeContent #timeSTC" + j + " > .item");
        console.log("timeGroups: ", timeGroups);

        timeGroups.each(function (i) {
            var startTime = $(this).find(".startTime").val();
            var endTime = $(this).find(".endTime").val();
        
            var startDateTime = new Date("1970-01-01T" + startTime + ":00");
            var endDateTime = new Date("1970-01-01T" + endTime + ":00");
        
            // 종료 시간이 시작 시간보다 크거나 같으면 경고 메시지 표시 후 종료 시간을 시작 시간 + 1시간으로 변경
            if (endDateTime <= startDateTime) {
                alert('시작 시간이 종료 시간보다 큽니다!');
                endDateTime.setHours(startDateTime.getHours() + 1);
                $(this).find(".endTime").val(formatTime(endDateTime));
            }
        
            // 현재 시작 시간이 이전 종료 시간보다 이르면 시작 시간을 이전 종료 시간 + 1분으로 변경
            if (i > 0) {
                var prevEndTime = new Date("1970-01-01T" + timeGroups.eq(i - 1).find(".endTime").val() + ":00");
                var nowStartTime = new Date("1970-01-01T" + startTime + ":00");
                var nowEndTime = new Date("1970-01-01T" + endTime + ":00");
        
                console.log("변경할 시간들 : ", prevEndTime, nowStartTime, nowEndTime);
        
                if (nowStartTime <= prevEndTime) {
                    nowStartTime.setHours(prevEndTime.getHours());
                    nowStartTime.setMinutes(prevEndTime.getMinutes() + 1);
                    $(this).find(".startTime").val(formatTime(nowStartTime));
                }
        
                // 현재 시간 그룹의 시작 시간과 종료 시간 비교
                if (nowStartTime >= nowEndTime) {
                    nowEndTime.setHours(nowStartTime.getHours() + 1);
                    $(this).find(".endTime").val(formatTime(nowEndTime));
                }
            }
        });
    }
}



// formatTime 함수 정의
// 시간을 "HH:mm" 형식의 문자열로 변환하는 함수
function formatTime(date) {
    var hours = date.getHours();
    var minutes = date.getMinutes();
    return (hours < 10 ? '0' : '') + hours + ':' + (minutes < 10 ? '0' : '') + minutes;
}

function deleteSpot(button){
	
	var spotId = button.closest('.item').id;
	console.log(spotId);
	
	$.ajax({
		url: '/delete_spot.do',
	    type: 'get',
	    data : {
			spotId : spotId
		},
	    success: function(activeDay) {

			createDefault(activeDay);
	    },
	    error:function() {
				  
	    }
	});
}

function searchDosi(){
	
	var dosi = $('.sidoValues').html();

	$('#keyword').val(dosi);
	
	searchPlaces();
	//console.log(dosi)
	
}

function loadGroupMember() {
	
	$.ajax({
		url : 'load_group_member.do',
		type : 'get',
		success : function(memberArray){
			var memberArray = JSON.parse(memberArray);
			
			var memberbox = '';
			for(var i=0; i<memberArray.length; i++){
				var icon = memberArray[i].icon;				
				var nickname = memberArray[i].nickname;
				var mail = memberArray[i].mail;
				
				memberbox +='<div class="list-group">'
				+ '<label class="list-group-item d-flex gap-2" style="margin-left: 10px; width: 330px;"><img src="./icon/'
				+ icon + '.png" alt="Profile" class="rounded-circle" style="width:50px;">'
				+ '<span>' + nickname + '<small class="d-block text-body-secondary">' + mail + '</small></span></label></div>';
			}
			//console.log(memberbox)
			$('#memberTable').html(memberbox);
		},
		error : function(){
			console.log('그룹멤버 불러오기 에러입니다');
		}
	})
}
