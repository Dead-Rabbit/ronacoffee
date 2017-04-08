/**
 * 用于发送json
 */
var conTest = "";
var xmlHttpReq = null;//XMLHttpRequest对象
// 去除字符串两边空格
//Ajax请求 参数接受json格式
function sendMesge(message){
	
    var parameter = "message=" + JSON.stringify(message);
    var requestURL = "http://localhost:8080/weixindiandan/ItemsServlet";
    xmlHttpReq = createXMLHttpRequest();
    
    xmlHttpReq.open("POST",requestURL,true);
    xmlHttpReq.setRequestHeader("Content-Type","application/x-www-form-urlencoded;");
    // xmlHttpReq.setRequestHeader("Content-Type","text/html");
    xmlHttpReq.send(parameter);
    console.log(parameter)
    
    xmlHttpReq.onreadystatechange = function(){
        if(xmlHttpReq.readyState == 4){
            switch(xmlHttpReq.status){
                case 200:
                    var getJson = eval('(' + xmlHttpReq.responseText + ')');
                    conTest = getJson;
                    receiveItems(getJson);
                    // console.log(JSON.ifArray(getJson));
                    break;
                case 400:
                    alert("错误的请求！\nError Code:400!");
                    break;
                case 403:
                    alert("拒绝请求！\nError Code:403!");
                    break;
                case 404:
                    alert("请求地址不存在！\nError Code:404!");
                    break;
                case 500:
                    alert("内部错误！\nError Code:500!");
                    break;
                case 503:
                    alert("服务不可用！\nError Code:503!");
                    break;
                default:
                    alert("请求返回异常！\nError Code:"+xmlHttpReq.status);
                    break;
            }
        }
    }
}
//创建XMLHttpRequest对象
function createXMLHttpRequest() {
    if (window.XMLHttpRequest) {// IE 7.0及以上版本和非IE的浏览器
        xmlHttpReq = new XMLHttpRequest();
    } else {// IE 6.0及以下版本
        try {
            xmlHttpReq = new ActiveXObject("MSXML2.XMLHTTP");
        }catch (e) {
            try {
                xmlHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
            }catch (e) {}
        }
    }
    if (!xmlHttpReq) {
        alert("当前浏览器不支持!");
        return null;
    }
    return xmlHttpReq;
}