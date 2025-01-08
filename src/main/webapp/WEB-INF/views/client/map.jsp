<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<section>
		<article>
			<p>지도</p>
			<div id ="map" style="width:500px;height:400px;"><br> &nbsp;지도를 표시할 영역 </div>
			
		
		
			<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f5a188d12dc1a09c837b4091032444af"></script>
			<script >
			
			var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
			var options = { //지도를 생성할 때 필요한 기본 옵션
			
			center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
			level: 3 ,//지도의 레벨(확대, 축소 정도)숫자가 크면  해상도 커짐
			scrollwheel:true,
			title:"여기가 내위치 입니다."
				};
			var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
			
			/*  
			 function showMap(){
				map =  new kakao.maps.Map(document.getElementById('map'),{
					zoom:12,
					center:{
						lat:33.450701,
						lng:126.570667
					}
					
				});
				
			}
			 
			 
			function showMarker(lat,lng) {
				new kakao.maps.marker({
					position:{
						lat: lat,
						lng:lng
					},
					map:map
					
				})
			}
			 */
			
			
			
			
			
</script>
			
		</article>
		<aside>
		</aside>
	</section>

</body>
</html>