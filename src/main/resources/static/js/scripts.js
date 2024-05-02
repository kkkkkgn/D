//******    작성자 : 구동현        *****//
//******    작성자 : 구동현        *****//
//******    작성일 : 24.01.10 (갱신)     *****//

/** 문서가 준비되면 실행되는 함수 (초기화 및 설정작업 관련 내용) **/
$(document).ready(function() {
    $(document).on("input", ".expenseTableDiv.active.show td .addExpense", function () {
        formatAmount(this);
    });

    // 확정버튼을 클릭했을때 
    $("#confirmBtn").on("click", function () {
        alertBody.text('');
        alertBody.text("여행 계획를 완료하시겠습니까?")
        $(".modal-footer").html('');
        $(".modal-footer").html(
            '<a href="/user/time_machine.do"><button type="button" class="btn btn-primary" data-bs-dismiss="modal" aria-label="Close">완료</button></a>' +
            '<button type="button" class="btn btn-primary" data-bs-dismiss="modal" aria-label="Close">취소</button>'
        );
        alertShowBtn.click(); 
    });

    

    //*****************************************************  검색창 슬라이드 처리 함수  *******************************************//   
    var clickFindSlideBtn = 0;
    $("#findPlacesSlideBtn").on("click", function () {
        clickFindSlideBtn++;
        if( clickFindSlideBtn === 1){
            $("#findPlaces").css({
                'min-width': '0' ,
                'width': '0' ,
                'padding': '0' ,
                'overflow' : 'hidden',
                'opacity' : '0' ,
            });
            $("#findPlacesSlideBtn div .bi-caret-left-fill").addClass("none");
            $("#findPlacesSlideBtn div .bi-caret-right-fill").removeClass("none");
            setTimeout(() => {
                map.relayout();
            }, 900);
                
    
        } else {
            $("#findPlaces").css({
                'min-width': '368px' ,
                'width': '368px' ,
                'opacity' : '1' ,
            });
            clickFindSlideBtn = 0;
            $("#findPlacesSlideBtn div .bi-caret-left-fill").removeClass("none");
            $("#findPlacesSlideBtn div .bi-caret-right-fill").addClass("none");
            setTimeout(() => {
                map.relayout();
            }, 900);
        }
    });
    
    
    
    //*****************************************************  클릭+키 관련 이벤트 처리 함수들  *******************************************//   
    /** 변수 선언 **/
    var isKeyDown = false;
    
    /** 키보드 다운 이벤트 처리 **/
    $(document).on('keydown', '#nav-tabContent .tab-pane.active .timeSC input[type="time"]', function(e) {
        if (e.key !== 'Enter') {
            isKeyDown = true;
        }
    });
    
    /** 키보드 업 이벤트 처리 **/
    $(document).on('keyup', '#nav-tabContent .tab-pane.active .timeSC input[type="time"]', function(e) {
        if (e.key === 'Enter') {
            // 조건 1: 시간 변경 시 실행
            handleEnterKey.call(this);
        }
        isKeyDown = false;
    });
    
    /** 마우스 클릭 이벤트 처리 **/
    $(document).on('focus', '#nav-tabContent .tab-pane.active .timeSC input[type="time"]', function () {
        // blur 이벤트 핸들러 등록
        $(this).one('blur', blurEventHandler);
    });
    
    
    var alertShown = false;
    /** 여행계획 시간 설정 함수 **/
    function handleEnterKey() {
        if (alertShown) { return; }
    
       // 현재 요소의 부모 중 '.timeSC' 클래스 ID 값 가져옴
        var updateTimeId = $(this).closest('.timeSC').attr('id');
        var updateTimeValue = this.value;
        const timeSCElements = $('.spotListPage.active').find('.timeSC');
        var flag = 1;
        // timeSCElements를 각각 반복하며 실행
        timeSCElements.each((index, element) => {
            if (element.id != updateTimeId) {
             //해당 요소 내부의 'input[type="time"]' 요소의 값을 가져옴
                const inputTimeValue = element.querySelector('input[type="time"]').value;
                
                //요소 내부의 시간과 설정한 시간이 같을 때 flag를 0으로 처리
                if (updateTimeValue === inputTimeValue) {
                    flag = 0;
                } 
            }
        });
    
       //updateTimeValue(설정한 시간)와 inputTimeValue(이미 설정된 시간)가 같을 때
        if (flag == 0) {
            alertShown = true;
            alert('시작 시간이 겹칩니다! 다시 설정하세요!');
            flag = 1;
            setTimeout(() => {
                alertShown = false; 
            }, 100);
            return;
        } else {
            alertShown;
            $(this).blur();
            var id = updateTimeId.replace('timeSTC', '');
            // 활성화된 '.left-plan-container' 요소의 ID에서 'day'를 제거한 값을 activeDay 변수에 저장
            var activeDay = $('#nav-tab .nav-link.active .loadDay').text();
            
            return;
        }
    }
    /** 키보드로 키가 눌리지 않은 상황에서의 처리 **/
    function blurEventHandler() {
        // 조건 2: 키보드로 키다운 중이 아닌 경우 실행
        if (!isKeyDown) {
            // 조건 3: 포커스가 아웃될 때 한 번만 실행
            handleEnterKey.call(this);
        }
    }
    
    
    $(".tab-content").on("click", ".spotMemo", function () {
        $(this).focus();
        // alert("엔터를 누르면 저장됩니다. "+ '\b' +"Shift + Enter 를 누를경우 줄 바꿈 입니다.");
    });
    
    // textarea에 엔터 키 이벤트 리스너 추가
    $(".tab-content").on("keydown",".spotMemo", function (e) {
        if (e.key === "Enter" && e.shiftKey) {
    
        } else if (e.key === "Enter") {
            e.preventDefault(); // Enter 키의 기본 동작 방지
            $(this).blur(); // 포커스를 제거하여 submit()을 호출하도록 함
        }
    });
    
    // 포커스가 아웃되면 Ajax를 사용하여 데이터를 서버로 전송
    $(".tab-content").on("blur", ".spotMemo", function () {
        var textareaValue = $(this).val();
        var spotId = $(this).closest('.spotListone').attr('id');
        // Ajax로 데이터를 서버로 전송
        $.ajax({
            url: '/user/saveSpotMemo.do',
            method: 'POST',
            data: { 
                newMemo: textareaValue ,
                spotId : spotId
            },
            success: function (data) {
                var activeDay = $('#nav-tab .nav-link.active .loadDay').text();
                createDefault(activeDay);
            }
        });
    });
    
    
    //_끝
    
        $("#nav-tab").on("click", ".nav-link.active", function () {
            var activeDay = $('#nav-tab .nav-link.active .loadDay').text();
            createDefault(activeDay);

            if (activeDay == null) {
                $('#day1').addClass('active show');
                $('#day1Tab').addClass('active show');
                $('#day1finance').addClass('active show');
                $('#finance1').addClass('active show');
            } else {
                $('#day' + activeDay).addClass('active show');
                $('#day' + activeDay + 'Tab').addClass('active show');
                $('#day'+activeDay+'finance').addClass('active show');
                $('#finance'+activeDay).addClass('active show');
            }
    
            // searchDosi();
            // memberRefresh();
        });
    
        $("#nav-sideTab").on("click", function () {
            var activeDay = $('#nav-dayfinance .nav-link.active .loadDay').text();
            setTimeout(() => {
                $("#soonGif").css("display","none");
                
            }, 500);
           
            memberRefresh();
            if (activeDay == null) {
                $('#day1').addClass('active show');
                $('#day1Tab').addClass('active show');
                $('#day1finance').addClass('active show');
                $('#finance1').addClass('active show');
            } else {
                $('#day' + activeDay).addClass('active show');
                $('#day' + activeDay + 'Tab').addClass('active show');
                $('#day'+activeDay+'finance').addClass('active show');
                $('#finance'+activeDay).addClass('active show');
            }

            setTimeout(() => {
                totalDayAmount();
                calculatePerPersonAmount();

            }, 900);
            
            
        });
      

        $("#nav-dayfinance").on("click", function () {
            $("#soonGif").css("display","block");
            var activeDay = $('#nav-dayfinance .nav-link.active .loadDay').text();
            if (activeDay == null) {
                $('#day1').addClass('active show');
                $('#day1Tab').addClass('active show');
                $('#day1finance').addClass('active show');
                $('#finance1').addClass('active show');
            } else {
                $('#day' + activeDay).addClass('active show');
                $('#day' + activeDay + 'Tab').addClass('active show');
                $('#day'+activeDay+'finance').addClass('active show');
                $('#finance'+activeDay).addClass('active show');
            }
            createDefault(activeDay);
            setTimeout(() => {
                totalDayAmount();
                calculatePerPersonAmount();
            }, 900);
            // memberRefresh();
            setTimeout(() => {
                $("#soonGif").css("display","none");
            }, 1000);
        });
    
        $('#memberRefreshBtn').on('click', function(){
            var activeDay = $('#nav-tab .nav-link.active .loadDay').text();
            createDefault(activeDay);
            setTimeout(() => {
                memberRefresh();
            }, 200);
           
        });
    
        $(document).on("change", "#team_num" , function () {      
            setTimeout(() => {
                calculatePerPersonAmount();
            }, 500);      
        });
    
    
       /** '.userBtn' 클래스를 가진 요소가 클릭되었을 때 실행 **/
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
        
        $(".pRB0.pRB0-collapsed.pRB0-mod-variant-accordion").on({
            mouseenter: function () {
                $(this).addClass('pRB0-expanded');
                $("#main").addClass('JjjA-moved');
            },
            mouseleave: function () {
                $(this).removeClass('pRB0-expanded');
                $("#main").removeClass('JjjA-moved');
            }
        });
        $("#tripplan .pRB0.pRB0-collapsed.pRB0-mod-variant-accordion").off('mouseenter mouseleave').on({
            mouseenter: function () {
            },
            mouseleave: function () {
            }
        });
    
    
    
    
    
    
        $(".lfBz-field-outline div").on('click', function (event) {

            if ($(event.target).hasClass('iiio-submit')) {
                // 클릭한 요소가 iiio-submit 클래스를 가지고 있으면 YSUE-mod-visible 클래스 제거
                $(".YSUE").removeClass('YSUE-mod-visible');
                $(".sidoModal").css('display','none');
            } else {
                // iiio-submit 클래스를 가지고 있지 않으면 YSUE-mod-visible 클래스 추가
                $(".YSUE").addClass('YSUE-mod-visible');
            }
        });
    
    
    //*****************************************************  클릭+키 관련 이벤트 처리 함수 END  *******************************************//
    
    
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
    
    
    //********************************************************  여행지 관련 이벤트 처리 함수 **********************************************//
    
    
    
    
        /** 지역검색 시 나오는 팝업창 생성 및 제거 **/
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
        
        /** .dDYU-viewport .dDYU-content .QdG_(업데이트)를 클릭했을 때 팝업창 제거 **/
        $('.dDYU-viewport .dDYU-content .QdG_').on('click', function () {
            $(".YSUE").removeClass('YSUE-mod-visible');
            $(".sidoModal").css('display','none');
        });
    
    
        $(".pM26").on("click", function () {
            $(".Loading").css('display','block');
            
            $(".Loading").css('display','none');
            $(".sidoModal").css('display','block');
            
        });
    
        /** "추가" 버튼에 대한 클릭 이벤트 처리 **/
        $('#placesList').on('click', '.spotBtn', function(event) {
            // 클릭한 .spotBtn 요소를 선택
            var spotBtn = $(this);
    
            // 클릭한 .spotBtn이 속한 요소의 data-id 속성 값을 가져옴
            var dataIdValue = spotBtn.closest('[data-id]').attr('data-id');
        
            // 해당 data-id 값을 가진 원본 요소를 찾아 sourceElement에 저장
            var sourceElement = $('[data-id="' + dataIdValue + '"]');
    
    
            if (sourceElement.length > 0) {
    
                var sourceName = sourceElement.find('.pname').text();
             var sourceDay = $('#nav-tab .nav-link.active .loadDay').text()
               var sourceLatitude = sourceElement.find('.info-address.plat').text();
               var sourceLongitude = sourceElement.find('.info-address.plong').text();
             var sourceAddress = sourceElement.find('.paddress').text();
                var sourceRoadAddress = sourceElement.find('.proadaddress').text(); 
                var sourceCategory = sourceElement.find('.pcategory').text();
                var sourcePhone = sourceElement.find('.phone').text();
                var sourceImgUrl = sourceElement.find('.pimgUrl').text();
                var sourceMemo = sourceElement.find('.spotMemo').text();
                $.ajax({
                    url :'/user/insert_spot.do',
                    type: 'POST',
                    data: {
                        sourceName : sourceName,
                        sourceDay : sourceDay,
                        sourceLatitude : sourceLatitude,
                        sourceLongitude : sourceLongitude,
                        sourceAddress : sourceAddress,
                        sourceRoadAddress : sourceRoadAddress,
                        sourceImgUrl : sourceImgUrl,
                        sourceCategory : sourceCategory,
                        sourcePhone : sourcePhone,
                        sourceMemo : sourceMemo,
                    },
                    success : function(flag){
                        if(flag == 0){
                    //   alert('여행지는 12개까지만 가능합니다!!');
                      alertBody.text('');
                      alertBody.text("여행지는 12개까지만 가능합니다!!")
                      alertShowBtn.click();
                   }else{
                      // active되어있던 일차페이지를 파라미터로 넘김
                      var activeDay = $('#nav-tab .nav-link.active .loadDay').text();
                      createDefault(activeDay);
                        searchDosi();
                   }
    
                    },error : function(e){
    
                    }
                });
            }
        });    
        
    
    
        
    //********************************************************  여행지 관련 이벤트 처리 함수 END **********************************************//
       
    // 커서로 컨테이너 박스 크기 조절 
    const resizable = function (resizer) {
        const direction = resizer.getAttribute("data-direction") || "horizontal";
        const prevSibling = resizer.previousElementSibling;
        const nextSibling = resizer.nextElementSibling;
      
        //  마우스의 위치값 저장을 위해 선언
        let x = 0;
        let y = 0;
        let prevSiblingHeight = 0;
        let prevSiblingWidth = 0;
      
        // resizer에 마우스 이벤트가 발생하면 실행하는 Handler
        const mouseDownHandler = function (e) {
          // 마우스 위치값을 가져와 x, y에 할당
          x = e.clientX;
          y = e.clientY;
          // 대상 Element에 위치 정보를 가져옴
          const rect = prevSibling.getBoundingClientRect();
          // 기존 높이와 너비를 각각 할당함
          prevSiblingHeight = rect.height;
          prevSiblingWidth = rect.width;
      
          // 마우스 이동과 해제 이벤트를 등록
          document.addEventListener("mousemove", mouseMoveHandler);
          document.addEventListener("mouseup", mouseUpHandler);
        };
      
        const mouseMoveHandler = function (e) {
          // 마우스가 움직이면 기존 초기 마우스 위치에서 현재 위치값과의 차이를 계산
          const dx = e.clientX - x;
          const dy = e.clientY - y;
      
          // 이동 방향에 따라서 별도 동작
          // 기본 동작은 동일하게 기존 크기에 마우스 드래그 거리를 더한 뒤 상위요소(container)를 이용해 퍼센티지를 구함
          // 계산 대상이 x 또는 y인지에 차이가 있음
          switch (direction) {
            case "vertical":
              const h =
                ((prevSiblingHeight + dy) * 100) /
                resizer.parentNode.getBoundingClientRect().height;
              prevSibling.style.height = `${h}%`;
              break;
            case "horizontal":
            default:
              const w =
                ((prevSiblingWidth + dx) * 100) /
                resizer.parentNode.getBoundingClientRect().width;
              prevSibling.style.width = `${w}%`;
              break;
          }
      
          // 크기 조절 중 마우스 커서를 변경함
          // class="resizer"에 적용하면 위치가 변경되면서 커서가 해제되기 때문에 body에 적용
          const cursor = direction === "horizontal" ? "col-resize" : "row-resize";
          resizer.style.cursor = cursor;
          document.body.style.cursor = cursor;
      
          prevSibling.style.userSelect = "none";
          prevSibling.style.pointerEvents = "none";
      
          nextSibling.style.userSelect = "none";
          nextSibling.style.pointerEvents = "none";
        };
      
        const mouseUpHandler = function () {
          // 모든 커서 관련 사항은 마우스 이동이 끝나면 제거됨
          resizer.style.removeProperty("cursor");
          document.body.style.removeProperty("cursor");
      
          prevSibling.style.removeProperty("user-select");
          prevSibling.style.removeProperty("pointer-events");
      
          nextSibling.style.removeProperty("user-select");
          nextSibling.style.removeProperty("pointer-events");
      
          // 등록한 마우스 이벤트를 제거
          document.removeEventListener("mousemove", mouseMoveHandler);
          document.removeEventListener("mouseup", mouseUpHandler);
        };
      
        // 마우스 down 이벤트를 등록
        resizer.addEventListener("mousedown", mouseDownHandler);
      };
      
      // 모든 resizer에 만들어진 resizable을 적용
      document.querySelectorAll(".resizer").forEach(function (ele) {
        resizable(ele);
      });
      
    }); /***********window.ready()end**************/
    
    /********************** 모달통일 변수 선언 **************************/
    // 모달을 불러올 버튼 ex) alertShowBtn.click() 을 할 경우 모달 생성
    var alertShowBtn = $("#alertBtn"); 
    // 모달 전체를 선언하는 변수
    // ex) if( staticBackdrop.hasClass('show') ){} 모달이 띄어질때 뭐 하겠다 할때  
    var staticBackdrop = $("#staticBackdrop");
    // 모달에서 내용을 변경할때 쓰는 변수
    // ex) alertBody.text('') -> alertBody.text('무슨 내용을 쓸지 여기에 작성') 
    var alertBody = $("#staticBackdrop .modal-body");
    // 모달에서 닫기아이콘을 없앨 때 사용하는 변수
    //  ex)modalCloseIcon.addClass('fade'); 
    // 이때 꼭 setTimeout 해서 modalCloseIcon.removeClass('fade'); 로 다시 보이게 해줘야 함
    var modalCloseIcon = $("#modalCloseIcon");
    // 모달에서 아래 버튼을 변경하고 싶을때 사용하는 변수 
    // ctrl + F ( 잘 다녀오마 ) 로 예시 검색 
    // ex) modalFooter.text('') ->  modalFooter.text('<button>새로운 버튼</button>')
    var modalFooter = $("#modalFooter");
    // 모달에서 자동적으로 닫을 때 쓰는 변수
    // ex) modalFooterBtn.click(); 
    var modalFooterBtn = $("#modalFooter button");
    /******************************************** 여행계획 생성 / 불러오기 함수 ******************************************/
    
    /** 여행계획 생성 **/
    function createGroup() {
        $.ajax({
            url: '/user/create_Group.do',
                type: 'POST',
                success: function(result) {
                    // alert('여행계획이 생성되었습니다!!');
                    $('#selectmodal').css('display','none');
                    $('#selectmodal').addClass('fade');
                    $('#selectmodal').removeClass('show');
                    alertBody.text('');
                    alertBody.addClass('flex justify-center align-items-center py-5');
                    alertBody.text("여행계획이 생성되었습니다!!")
                    alertShowBtn.click();
                    modalFooterBtn.click(function() {
                        setTimeout(() => {
                            alertBody.removeClass('flex justify-center align-items-center py-5');
                        }, 2000);
                        setTimeout(() => {
                            $('#selectmodal').removeClass('show');
                            $('#selectmodal').addClass('none');
                            $('#selectmodal').addClass('fade');
                        }, 200);

                    });




                    var teamObject = JSON.parse(result);
                    const teamName= teamObject.team_name;
                    const teamUrl = teamObject.team_url;
                    
                    $('#team_name').val(teamName);
                    $('#team_url').val(teamUrl);
                
                    createDefault();
                    searchDosi();
                    $(".YSUE").addClass('YSUE-mod-visible');
                },
                error:function(e) {
                    console.log('여행계획 만들기 에러입니다' + e);
                }
        });
    } 
    
    /** 여행계획 목록 불러오기 **/
    function loadGroupDatas() { 
        $.ajax({
            url: '/user/load_GroupDatas.do',
                type: 'POST',
                success: function(result) {
                    // searchDosi();
                    if(result == 0) {
                        // alert('진행중인 여행계획이 없습니다!! 새로운 여행계획을 생성해보세요!!');
                        $('#selectmodal').modal('hide');
                        modalCloseIcon.addClass('fade');
                        alertBody.html('');
                        alertBody.html("진행중인 여행계획이 없습니다!!  <br/> 새로운 여행계획을 생성해보세요!!")
                        alertShowBtn.click();
                        modalFooterBtn.click(function() {
                            setTimeout(() => {
                                $('#selectmodal').modal('show');
                            }, 200);

                            modalCloseIcon.removeClass('fade');
                            
                        });
    
                    } else {
                        // 모달 객체 가져오기          
                        $('#selectmodal').modal('hide');
                                                                            
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
                        cell1.appendChild(radio);
                        cell2.innerHTML = i + 1;
                        cell3.innerHTML = groupArray[i].team_name;
                        cell4.innerHTML = groupArray[i].team_dest;            
                        }
                        var selectGroup = new bootstrap.Modal(document.getElementById('selectgroup'));
            
                        //여행계획 모달 보이기
                        selectGroup.show();
                    }
                },
                error:function() {
                    console.log('여행계획 불러오기 에러입니다');
                }
        });
    }
    
    /** 팀 불러오기 **/
    function loadGroup(){
        var tableBody = document.getElementById('groupTableBody');
        var checkedRadio = tableBody.querySelector('input[type="radio"]:checked');
        
        if(checkedRadio) {                      
            var row = checkedRadio.closest('tr');
            var rowId = row.id;
            $.ajax({
                url: '/user/load_Group.do',
                type: 'POST',
                data: {
                    teamId : rowId
                },
                success: function(result) {
                    
                    $('#selectgroup').on('hidden.bs.modal', function() {
                        setTimeout(function() {
                            // alert('여행계획을 불러왔습니다!!');
                            alertBody.text('');
                            alertBody.addClass('text-center');
                            alertBody.text("여행계획을 불러왔습니다!!")
                            alertShowBtn.click();
                            modalFooterBtn.click(function() {
                                $('#selectmodal').removeClass('show');
                                $('#selectmodal').addClass('none');
                                setTimeout(() => {
                                    alertBody.removeClass('text-center');
                                    $('#selectmodal').removeClass('show');
                                }, 200);
                            });
                        }, 100); 
                    });
                    $('#selectgroup').removeClass('show');
                    $('#selectgroup').modal('hide');
                    
                    var teamObject = JSON.parse(result);
                    const teamName= teamObject.team_name;
                    const teamUrl = teamObject.team_url;
                    $('#team_name').val(teamName);
                $('#team_url').val(teamUrl);
                
                createDefault();
                },
                error:function() {
                console.log('여행계획 불러오기 에러입니다');
                }
            });
            
        } else {
            alert('여행계획을 선택하셔야 합니다');
           
        } 
    }
    
    
    /** 도시 리스트 불러오기 **/
    function getDosi(dosi) {
       
        $.ajax({
            type: "POST",
            url: "/user/addressJson.do", // 실제 서버 엔드포인트
            data: {
                dosi: dosi
            },
            success: function(data) {
                // 서버에서 받은 응답 처리
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
    
    /**  친구 초대 / 가계부 / 준비물 모달 보이기  **/
    function showSection(sectionId) {
       
       // 유사 실시간 실행
       var activeDay = $('#nav-tab .nav-link.active .loadDay').text();
       createDefault(activeDay);
       
        var sections = document.querySelectorAll('.content-section');
        sections.forEach(function (section) {
            if (section.id === sectionId) {
                section.classList.toggle('show'); // 토글로 'show' 클래스 추가 또는 제거
            } else {
                section.classList.remove('show');
            }
        });
    }
    
    
    /********************************************* 준비물 관련 함수 *********************************************/
    function showTodoInputText(){
        $('#todoTableBody').append('<tr style="text-align:center;display:table; width:100%;"><td style="width:20%"><input type="checkbox"/></td><td style="width:60%"><input type="text" id="addValue" class="form-control addValue" placeholder="준비물을 입력해주세요"></td><td style="width:20%"><i onclick="deleteTodoInputText(event)" class="bi bi-trash deleteInput" style="color:#555555"></i></td></tr>');
    }
    
    // 저장 전 행 삭제할 경우
    function deleteTodoInputText(event){
    
        var deleteIcon = event.target;  
                
        var trElement = deleteIcon.closest('tr');
                
        var todoTbody = document.querySelector('#todoTableBody'); 
                
        todoTbody.removeChild(trElement);
    };
    
    /** 준비물 저장 버튼을 눌렀을 때 실행되는 함수 **/
    
    
    // 전역으로 사용할 Deferred 객체 생성
    var ajaxDeferred = $.Deferred().resolve();
    
    function addTodo() {
        var addValueInputText = document.querySelectorAll('.addValue');
    
        addValueInputText.forEach(function (inputText) {
            var inputTextId = inputText.closest('tr').id;
            var checkboxState = inputText.closest('tr').querySelector('td > input[type=checkbox]').checked;
            var inputTextValue = inputText.value.trim();
    
            // 새로 추가된 행인지 여부 확인
            var isNewRow = inputTextId === '';
    
            // 새로 추가된 행이면
            if (isNewRow && inputTextValue !== '') {
                // 이전 호출이 완료된 후에 다음 호출을 진행하도록 Deferred 사용
                ajaxDeferred = ajaxDeferred.then(function () {
                    return saveTodoData('/user/add_todo.do', checkboxState, inputTextValue, '새로운 준비물 저장 성공입니다');
                });
            }
            // 기존 행이면
            else if (!isNewRow) {
                if (inputTextValue === '') {
                    ajaxDeferred = ajaxDeferred.then(function () {
                        return deleteTodoData('/user/delete_todo.do', inputTextId, '준비물 삭제 성공입니다');
                    });
                } else {
                    ajaxDeferred = ajaxDeferred.then(function () {
                        return saveTodoData('/user/resave_todo.do', checkboxState, inputTextValue, '준비물 재저장 성공입니다', inputTextId);
                    });
                }
            }
        });
        
        // 유사 실시간 실행
        var activeDay = $('#nav-tab .nav-link.active .loadDay').text();
        
        ajaxDeferred = ajaxDeferred.then(function(){
            return createDefault(activeDay);
        });
        
    }
    
    // 공통으로 사용되는 데이터 저장 함수
    function saveTodoData(url, checkboxState, inputTextValue, successMessage, inputTextId) {
        var deferred = $.Deferred();
    
        $.ajax({
            url: url,
            type: 'POST',
            data: {
                pre_id: inputTextId,
                checkboxState: checkboxState,
                checklist: inputTextValue
            },
            success: function (result) {
                deferred.resolve(result);
            },
            error: function () {
                console.log('준비물 저장하기 에러입니다');
                deferred.reject();
            }
        });
    
        return deferred.promise();
    }
    
    // 삭제 함수
    function deleteTodoData(url, inputTextId, successMessage) {
        var deferred = $.Deferred();
    
        $.ajax({
            url: url,
            type: 'POST',
            data: {
                pre_id: inputTextId,
            },
            success: function (result) {

                deferred.resolve(result);
            },
            error: function () {
                console.log('준비물 저장하기 에러입니다');
                deferred.reject();
            }
        });
    
        return deferred.promise();
    }
    
    
    /** 삭제 이벤트 처리 **/
    function deleteTodo(event) {
    
        const deleteRow = event.target.parentNode;
        var row = deleteRow.closest('tr');
                
        var rowId = row.id;
                
                $.ajax({
                url: '/user/delete_todo.do',
                data: {
                    pre_id : rowId
                
                },
                type: 'POST',
                success: function(result) {
                    
                    // 유사 실시간 실행
                   var activeDay = $('#nav-tab .nav-link.active .loadDay').text();              
                    createDefault(activeDay);
    
                },
                error:function() {
                    console.log('체크리스트 delete 에러입니다');
                }
            });     
    
    }
    /********************************************* 준비물 관련 함수 END *********************************************/
    
    
    /******************************************** 가계부 관련 함수 *************************************************/
    
    function showExpenseInputText(){
        var activeTabDay = $('#nav-tab .nav-link.active .loadDay').text();
            
        $('#expenseTableBody' + activeTabDay).append(
            '<tr class="expenseTr" style="text-align:center;display:table;width:100%">' + 
                // '<div class="flex gap-1">' +
                    '<td class="" style="width:18%;"><span class="addDay">' + activeTabDay + '일차</span></td>'+
                    '<td style="width:42%;"><input type="text" class="form-control addDetail" placeholder="내용 입력"></td>'+
                    '<td style="width:30%;"><input type="text" oninput="formatAmount(this)" class="form-control addExpense" placeholder="비용 입력"></td>'+
                    '<td class=""  style="width:10%;"><i onclick="deleteExpenseInputText(event)" class="bi bi-trash deleteExpense" style="color:#555555"></i></td>'+
                // '</div>'+
            '</tr>');
    
    }
    
    function deleteExpenseInputText(event) {
        
        var deleteIcon = event.target;  
        
                
        var trElement = deleteIcon.closest('tr');
        
        var financeDivId = $('.expenseTableDiv.active').attr('id');
		
		var activeDay = financeDivId.replace('finance', '');
		                
        var expenseTbody = document.querySelector('#expenseTableBody' + activeDay); 
                
        expenseTbody.removeChild(trElement);
    }
    
    var ajaxDeferred2 = $.Deferred().resolve();
    
    /** 가계부 내용 추가 **/
    function addExpense() {
        
        var expenseTrs = document.querySelectorAll('.expenseTr');
        
        var activeTabDay = $('#nav-tab .nav-link.active .loadDay').text();
        
        expenseTrs.forEach(function(expenseTr){

            var trId = expenseTr.id;
            var addDay = expenseTr.querySelector('td > .addDay').innerHTML.replace('일차','');	
            var addDetail = expenseTr.querySelector('td > .addDetail').value.trim();
            var addExpenseInput = expenseTr.querySelector('td > .addExpense').value.trim();
            
            var addExpense = parseFloat(addExpenseInput.replace(/,/g, '')); 
            
            
    
            var isNewRow = trId === '';
            
            if(activeTabDay === addDay){
                
                if(isNewRow && addDetail !== '' && !isNaN(addExpense)){
                ajaxDeferred2 = ajaxDeferred2.then(function(){

                    return saveExpenseData('/user/add_expense.do', addDay, addDetail, addExpense, '새로운 가계부 저장 성공입니다');
                });
            }
            
            else if(!isNewRow){
                if(addDetail === '' || isNaN(addExpense)) {
                    ajaxDeferred2 = ajaxDeferred2.then(function() {

                        return deleteExpenseData('/user/delete_expense.do', trId, '가계부 삭제 성공입니다');
                    });
                } else {		
                    ajaxDeferred2 = ajaxDeferred2.then(function() {

                        return saveExpenseData('/user/resave_expense.do', addDay, addDetail, addExpense, '가계부 재저장 성공입니다', trId);
                    });
                }
            }
                
            }
            
        });
        
        var activeDay = $('#nav-tab .nav-link.active .loadDay').text();
        
        ajaxDeferred2 = ajaxDeferred2.then(function(){
    
            return createDefault(activeDay);
        });
        setTimeout(() => {
            totalDayAmount();
            calculatePerPersonAmount();
        }, 500);
    }
    
    function totalDayAmount() {
        // 총 지출액을 저장할 변수 초기화
        var totalExpense = 0;

        // id가 "nav-financeContent"인 요소 하위에서 클래스가 ".expenseTableDiv"이면서 활성화되어 있고 표시되는 요소들을 찾음
        $("#nav-financeContent")
            .children(".expenseTableDiv.active.show").find(".expenseTr").each(function() {
                // 각 ".expenseTr" 요소 내에서 클래스가 ".addExpense"인 요소를 찾음
                // 해당 요소의 값을 가져와서 쉼표를 빈 문자열로 대체하고 정수로 변환
                var expenseValue = $(this).find('.addExpense').val().replaceAll(',', '');
                
                // 만약 변환된 값이 비어 있다면 0으로 설정
                expenseValue = (expenseValue === '' ? 0 : expenseValue);
                // console.log('expenseValue :', expenseValue);

                // 변환된 지출액 값을 totalExpense 변수에 더함
                totalExpense += parseInt(expenseValue === '' ? 0 : expenseValue);
        });
        var formattedTotalExpense = numberWithCommas(totalExpense);
        // console.log('formattedTotalExpense : ', formattedTotalExpense);
    
        // 총 합계를 #daytotalAmount에 표시
        $("#daytotalAmount").text(formattedTotalExpense + " 원");
    }
    
    
    function teamExpense(){
        var totalAmount = parseInt($("#daytotalAmount").text().trim().replaceAll(',','').replace('원',''));
        var teamMemberCount = parseInt($("#team_num").val());
    
        var teamtotalAmount = 0;
    
        teamtotalAmount = totalAmount / teamMemberCount;
    
        var formattedTotalExpense = numberWithCommas(teamtotalAmount);
    
        $("#dayamountPerPerson").text(formattedTotalExpense + " 원");
    }
    
    function saveExpenseData(url, addDay, addDetail, addExpense, successMassage, trId) {
            
            var deferred = $.Deferred();
            
            $.ajax({
                url : url,
                type : 'POST',
                data : {
                    day : addDay,
                    detail : addDetail,
                    expense : addExpense,
                    id : trId
                },
                success : function(result){

                    deferred.resolve(result);
                },
                error : function(error) {
                    console.log(error);

                    deferred.reject();
                }
            });
            
            return deferred.promise();
    }
    
    /** 친구초대 새로고침 시 수행 **/
    function memberRefresh() {
        var memberItems = $("#memberTable .list-group .list-group-item");
        var memberCount = memberItems.length;
    
        // 최적화된 선택자 및 캐싱을 사용하도록 변경
        var memberCapacity = $("#memberCapacity");
        
        // 최적화된 HTML 문자열 생성
        var memberhtml = '';
        for (var i = 1; i <=5; i++) {
            memberhtml += '<i class="bi bi-person' + (i <= memberCount ? '-fill' : '') + '"></i>';
        }
    
        // 최적화된 DOM 조작
        memberCapacity.html(memberhtml);
    }
    
    function deleteExpenseData(url, trId, successMessage) {
        
        var deferred = $.Deferred();
        
        $.ajax({		
            url : url,
            type : 'POST',
            data : {
                id : trId
            },
            success : function(result){

                deferred.resolve(result);
            },
            error : function(){
                console.log('가계부 삭제 에러입니다');
                deferred.reject();
            }
            
        });
        
        return deferred.promise();
    }
    
    function formatAmount(input) {
        // 현재 입력값에서 콤마 제거
        var unformattedValue = input.value.replace(/,/g, '');
        unformattedValue === '' ? 0 : unformattedValue;
        // 입력값이 숫자인 경우에만 처리
        if (!isNaN(unformattedValue)) {
            // 콤마 추가
            var formattedValue = numberWithCommas(unformattedValue);
            input.value = formattedValue;
            return formattedValue;
        }
    }
    
    // 콤마 추가 함수
    function numberWithCommas(number) {
        var integerPart = Math.round(number);
        
        return integerPart.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }

    /** 가계부 삭제 **/
    function deleteExpense(event) {
           
       const deleteRow = event.target.parentNode;
       var row = deleteRow.closest('tr');
       
       var rowId = row.id;
       
            $.ajax({
                url: '/user/delete_expense.do',
                data: {
                    id : rowId
                
                },
                type: 'POST',
                success: function(result) {
    
                     var activeDay = $('#nav-tab .nav-link.active .loadDay').text();         
                    createDefault(activeDay);
                },
                error:function() {
                console.log('가계부 delete 에러입니당');
                }
            });
    
    }
    
    /** 가격 단위 설정**/
    function formatCurrency(amount) {
        // 천 단위로 콤마 추가
        return amount.toFixed(0).replace(/\d(?=(\d{3})+$)/g, '$&,') + ' 원';
    }
    
    /** 인원별 금액 계산 및 업데이트 **/
    function calculatePerPersonAmount() {
        var totalAmountElement = document.getElementById('totalAmount');
        var amountPerPersonElement = document.getElementById('amountPerPerson');
        var peopleInput = document.getElementById('team_num');
    
        var totalAmount = totalAmountElement.textContent.replace(/,/g, ''); // 콤마 제거
        totalAmount = parseFloat(totalAmount === '' ? 0 : totalAmount);
        var people = parseInt(peopleInput.value);
    
        if (isNaN(totalAmount) || isNaN(people) || people < 1) {
            alertBody.text('');
            alertBody.text("총 금액과 인원을 확인하세요.")
            alertShowBtn.click();
            return;
        }
    
        var amountPerPerson = totalAmount / people;
        amountPerPersonElement.textContent = formatCurrency(amountPerPerson);
        teamExpense();
    }
    
    
    /******************************************** 가계부 관련 함수 END ********************************************/
    
    
   
    /******************************************** 팀 이름 수정 ****************************************************/
    
    /** 텍스트 필드에 포커스 설정 **/
    function focusTextField(){
        $('#team_name').focus();
    }
    
    /** 키보드 이벤트 처리 **/
    function handleEnter(event) {
      //Enter눌렀을 때 그룹이름 수정될 수 있도록 설정
      if(event.key == 'Enter') {
          reviseGroupName();
      }
    }
    
    /** 그룹 이름 수정하는 함수 **/
    function reviseGroupName(){
      
      var teamName = document.getElementById('team_name').value;
      
       $.ajax({
              url: '/user/revise_group_name.do',
              data: {
              team_name : teamName
              
              },
              type: 'POST',
              success: function(result) {
    
              },
              error:function() {
              console.log('팀이름 변경 에러입니다');
              }
          });
    }
    /******************************************** 팀 이름 수정 END ************************************************/
    
    
    /******************************************** 여행계획 관련 함수 ************************************************/
    
    /** 일차별 여행지 삭제 **/
    function deleteSpot(button){
       
       var spotId = button.closest('.item').id;

       
       $.ajax({
          url: '/user/delete_spot.do',
           type: 'POST',
           data : {
             spotId : spotId
          },
           success: function(activeDay) {
              var activeDay = $('#nav-tab .nav-link.active .loadDay').text();
             createDefault(activeDay);
                searchDosi();
           },
           error:function() {
                  
           }
       });
    }
    
    /** 도시 검색 **/
    function searchDosi(){
        initializeMap();
    }
    
    /*********************************** createDefault() - 유사 실시간 구현 *************************************/
    function createDefault(activeDay){

        memberRefresh();
       // 도시 버튼 - 팀의 여행 지역 정보 반환
       $.ajax({
          url : '/user/create_dosi_button.do',
          type : 'POST',
          success : function(dosi){
             
             $('.sidoValues').html(dosi);   
          },error : function(e){
                               
          }
                         
       });
       
       // 캘린더 버튼 - 팀의 여행 날짜 정보를 반환   
       $.ajax({
          url : '/user/create_day_button.do',
          type : 'POST',
          success : function(result){
             var dayObject = JSON.parse(result);
                
             const stringDay = dayObject.startDay + " - " + dayObject.endDay;
             $('.trvl_day').html(stringDay);
                
                      
          },error : function(e){
                               
          }
                         
       });
       
       // 가계부 - 일차 선택 박스 생성
       $.ajax({
          url: '/user/create_day_option.do',
           type: 'POST',
           success: function(daysBetween) {
             var strDayOption = '';
             for(var i=1; i<=daysBetween; i++){
                strDayOption += '<option value=\"' + i +' 일차\">'+ i + ' 일차' +'</option>';
                    createSpotBox(i);
             }
             $('#date').html(strDayOption);
             $('#hiddenDay').val(daysBetween);
           },
           error:function() {
                  
           }
       });
       
       // 친구 초대 모달 - 팀 멤버 목록 불러오기
       $.ajax({
          url : '/user/load_group_member.do',
          type : 'POST',
          success : function(memberArray){
             var memberArray = JSON.parse(memberArray);
             
             var memberbox = '';
             for(var i=0; i<memberArray.length; i++){
                var icon = memberArray[i].icon;            
                var nickname = memberArray[i].nickname;
                var mail = memberArray[i].mail;
                
                memberbox +='<div class="list-group">'
                + '<label class="list-group-item d-flex gap-2" style="margin-left: 10px; width: 330px;"><img src="/icon/'
                + icon + '.png" alt="Profile" class="rounded-circle" style="width:50px;">'
                + '<span>' + nickname + '<small class="d-block text-body-secondary">' + mail + '</small></span></label></div>';
             }
             $('#memberTable').html(memberbox);
          },
          error : function(){
             console.log('그룹멤버 불러오기 에러입니다');
          }
       });
       
       
       // 가계부 - 모달에 테이블 생성
        var totalAmountElement = document.getElementById('totalAmount');
    
        $.ajax({
            url : '/user/create_finance_table.do',
            type : 'POST',
            success : function(result) {
            
            var allAay = $('#hiddenDay').val();
            for(var i=1; i<=allAay; i++){
                document.getElementById('expenseTableBody' + i).innerHTML = "";
            }       
            
            const financeArray = JSON.parse(result);
            
            var totalAmount = 0;
            
            
            for(var i=0; i<financeArray.length; i++) {
                
                var day = financeArray[i].day;
                var tableBody = document.getElementById('expenseTableBody' + day);
                    var newRow = tableBody.insertRow(-1);
                    
                    newRow.id = financeArray[i].id;
                    newRow.classList.add('expenseTr');
                    newRow.style.textAlign = 'center';
					newRow.style.display = 'table';
					newRow.style.width = '100%';
					    
                    var cell1 = newRow.insertCell(0);
                    var cell2 = newRow.insertCell(1);
                    var cell3 = newRow.insertCell(2);
                    var cell4 = newRow.insertCell(3);
                    
                    cell1.style.width  = '18%';
                    cell2.style.width  = '42%';
                    cell3.style.width  = '30%';
                    cell4.style.width  = '10%';
                    
                    var detailText = document.createElement('input');
                    detailText.className = 'form-control addDetail';
                    detailText.type = 'text';
                    detailText.value = financeArray[i].detail;
                    
                    var expenseText = document.createElement('input');
                    expenseText.className = 'form-control addExpense';
                    expenseText.type = 'text';
                    expenseText.value = financeArray[i].expense === '' ? 0 : financeArray[i].expense;
                    // console.log(' expenseText.value :' ,  expenseText.value);
                    expenseText.value = formatAmount(expenseText);
                    
                
                     
                    var icon = document.createElement('i');
                    icon.className = 'bi bi-trash deleteExpense';
                    icon.style = 'color: #555555;';
                    icon.type = 'button';
                                    
                    cell1.innerHTML = '<span class="addDay">' + financeArray[i].day + '일차' + '</span>';
                    cell1.classList.add('addDay');
                    
                    cell4.style.verticalAlign  = 'middle';
                    
                    cell2.appendChild(detailText);
                    cell3.appendChild(expenseText);
                    cell4.appendChild(icon);
                    totalAmount += financeArray[i].expense;
                    
                    icon.addEventListener("click", deleteExpense);
                
            }
            
                totalAmountElement.textContent = formatCurrency(totalAmount);
            
            },
            error:function() {
            console.log('가계부 테이블 만들기 에러입니다!');
            }
        });
       
       
       // 준비물 - 준비물 목록 불러오기 
       document.getElementById('todoTableBody').innerHTML = "";
        //준비물 불러오기
        $.ajax({
            url: '/user/create_todo_table.do',
            type: 'POST',
            success: function(result) {
                if(result == null) {
                    return;
                } else {
                    
                    const todoArray = JSON.parse(result);
                    
                    for(let i=0; i<todoArray.length; i++){
                        
                        var tableBody = document.getElementById('todoTableBody');
                        var newRow = tableBody.insertRow(i);
                                            
                        newRow.id = todoArray[i].pre_id;
                        
                        newRow.style.textAlign = 'center';
                        newRow.style.display = 'table';
                        newRow.style.width = '100%'
    
                        let del = document.createElement('button');
                        
                        
                        var cell1 = newRow.insertCell(0);
                        var cell2 = newRow.insertCell(1);
                        var cell3 = newRow.insertCell(2);
                        
                        cell1.style.width = '20%';
                        cell2.style.width = '60%';
                        cell3.style.width = '20%';
    
                        var checkbox = document.createElement('input');
                        checkbox.type = 'checkbox';
                        
                        var inputText = document.createElement('input');
                        inputText.className = 'form-control addValue';
                        inputText.type = 'text';
                        inputText.value = todoArray[i].pre_name;
                        
                        var icon = document.createElement('i');
                        icon.className = 'bi bi-trash deleteTodo';
                        icon.style = 'color: #555555;';
                        icon.type = 'button';
                        
                        
                        
    
                        
                        if(todoArray[i].pre_check){
                            checkbox.checked = true;
                        }
                        
       
                        cell1.appendChild(checkbox);
                        
                        cell2.appendChild(inputText);
    
                        cell3.appendChild(icon);
                        
                        
                        icon.addEventListener("click", deleteTodo); // 삭제버튼 클릭 시 리스트 지우기 이벤트 실행
                        
    
               
                    }
                }
            },
            error:function() {
                console.log('준비물 불러오기 에러입니다');
            } 
        });
          
        
        //검색 내용에 대한 여행지 리스트 생성 ajax
       $.ajax({
            url: '/user/create_spot_table.do',
            type: 'POST',
            success: function (result) {
                if (result != 0) {
                    var dayArray = JSON.parse(result);
        
                    for (var i = 0; i < dayArray.length; i++) {
                        var spotTable = '';
                        var spotArray = dayArray[i];
            
                        for (var j = 0; j < spotArray.length; j++) {
                            var categoryClass = '';
                            if (spotArray[j].category == "카페" || spotArray[j].category == "음식점") {
                                categoryClass = 'meal';
                            } else if (spotArray[j].category == "숙박") {
                                categoryClass = 'hotel';
                            }
                            var phoneClass = '';
                            if(spotArray[j].phone == ""){
                                phoneClass = 'none';
                            }else {
                                phoneClass= '';
                            }
                            spotTable += 
                            '<div id="' + spotArray[j].id + '" class="item spotListone sortable-item ft-face-nm ' + categoryClass + '">' +
                                '<div class="info">' + 
                                    '<div class="flex" style="justify-content: space-between; padding-top:10px; padding-left:10px; padding-right:10px;">' +
                                        '<span class="info-title"><p class="pname" style="margin:0;">' + spotArray[j].name + '</p></span>' +
                                        '<div class="timeSC active" id="timeSTC'+ spotArray[j].id +'" style="margin-right: 35px;">' + 
                                        '</div>' +
                                    '</div>' +
                                    '<span class="info-address plat none"><small>' + spotArray[j].latitude +'</small></span>' +
                                    '<span class="info-address plong none"><small>' + spotArray[j].longitude +'</small></span>' + 
                                    '<span class="info-address paddress"><small>' + spotArray[j].roadaddress + '</small></span>' + 
                                    '<span class="info-address proadaddress"><small>' + spotArray[j].address + '</small></span>' +
                                    '<div class="flex gap-2">' +
                                        '<span class="info-address pimgUrl none"><small>' + spotArray[j].imgUrl + '</small></span>' +
                                        '<span class="info-address pimgUrl" title="홈페이지로 이동"><a href="'+spotArray[j].imgUrl+'"><i style="color:#5b5b5b;" class="bi bi-house-door-fill"></i></a></span>' +
                                        '<span class="info-address pcategory none"><small>' + spotArray[j].category + '</small></span>' +
                                        '<span class="info-address phone '+phoneClass+'"><i  style="color:#5b5b5b;" class="bi bi-telephone-fill"></i><small class="ml-2">' + spotArray[j].phone + '</small></span>' +
                                    '</div>' +
                                    '<div style="padding:0 10px;" ><textarea class="spotMemo" style="word-break:keep-all;color:#333;width:100%;padding:3px;font-size:13px;resize:none;margin-top:5px;height:75px; letter-spacing: 0.02rem; border:1px solid #ccc;" name="infoText'+spotArray[j].id+'" placeholder=" 메모를 입력할 수 있어요! \n enter를 누르면 자동 저장입니다.\n enter+shift 를 누르면 줄 바꿈입니다.">'+ spotArray[j].memo +'</textarea></div>' +
                                '</div>' +
                                '<div style="position:absolute;right:32px;top:0px;"><button type="button" class="btn spotDelBtn" onclick="deleteSpot(this)"><i class="bi bi-x-lg"></i></button></div>'+
                            '</div>';
                        }
        
                        $('#day' + (i + 1)).html(spotTable);
    
                    }
    
                    if (activeDay == null) {
                        $('#day1').addClass('active show');
                        $('#day1Tab').addClass('active show');
                        $('#day1finance').addClass('active show');
                        $('#finance1').addClass('active show');
                    } else {
                        $('#day' + activeDay).addClass('active show');
                        $('#day' + activeDay + 'Tab').addClass('active show');
                        $('#day'+activeDay+'finance').addClass('active show');
                        $('#finance'+activeDay).addClass('active show');
                    }
    
                    initializeMap();
    
                } else {
                    alertBody.text('');
                    alertBody.text("저장한 여행지가 없습니다.")
                    alertShowBtn.click();
                }
            },
            error: function () {
                // 에러 처리 로직 추가
            }
        });
    
       
    }
    
    
    /******************************************** 여행계획 관련 함수 END ********************************************/