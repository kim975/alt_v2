var basketService = (function(){
	
	//장바구니 등록
	function add(basket, callback, error){
		console.log("basket-add: ......");
		
		$.ajax({ 
			//전송유형
			type: 'post', 
			//컨트롤러 메소드 호출 URL
			url: '/board/basket', 
			//브라우저가 서버에게 보내는 데이터유형
			//data 키에 설정되는 값은 컨트롤러 메소드의 consumes 속성 설정 값의 데이터유형과 일치
			data: JSON.stringify(basket), 
			//서버에게 보내는 데이터 유형(MIME 타입)
			contentType: "application/json; charset=utf-8", 
			//xhr(XML Http Request)
			success: function(result, status, xhr){ 
				//callback 매개변수에 함수가 있으면 참, 없으면 거짓
				if(callback){
					callback(result);
				}
			},
			error: function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		})
	}
	
	function addZim(zim, callback, error){
		console.log("basket-add: ......");
		
		$.ajax({ 
			type: 'post', 
			url: '/board/doZim', 
			data: JSON.stringify(zim), 
			contentType: "application/json; charset=utf-8", 
			success: function(result, status, xhr){ 
				if(callback){
					callback(result);
				}
			},
			error: function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		})
	}
	
	return {
		add:add,
		addZim:addZim
	};
})();