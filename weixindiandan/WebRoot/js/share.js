
function getScore(memberid,actionid,commTenaId,acti_busi_id){
	/*
	 * updated by JZH on 2015.07.27 23:03 
	//alert("getScore的js中888");
	*/
	$.ajax({
		url : ctx+"/EmWechatIntegrationDetail/getScore",
		type : "post",
		cache : false,
		data : "commTenaId="+commTenaId+"&ACTION_ID="+actionid+"&ACTI_BUSI_ID="+acti_busi_id+"&MEMBER_ID="+memberid,
		success : function(data) {
		   
		}
	});	
	
}
