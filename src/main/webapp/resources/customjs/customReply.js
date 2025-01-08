//alert("Reply Module......");
//console.log("Reply Module......");

var replyService = (function(){
	
	//댓글 목록 (페이징 처리 고려 .)
	function getList(param, callback, error) {

		var sno = param.sno;
		var page = param.page || 1;

		$.getJSON("/replies/pages/" + sno + "/" + page + ".json",
			function(data) {
				if (callback) {

					callback(data.replyCnt, data.list, data.replyImg);
				}
			}).fail(function(xhr, status, err) {
				if (error) {
					error();
			}
		});
	}

	return {
		
		getList:getList //댓글 목록
	};
})();