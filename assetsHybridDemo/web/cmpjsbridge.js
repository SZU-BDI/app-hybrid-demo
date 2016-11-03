function s2o(strJson){ try{ var myjson=null; return (new Function('return '+strJson))(); }catch(ex){} };
function o2s(object){
	if(null==object)return "null";

	var type = typeof object;

	if('object'== type){
		if (Array == object.constructor) type = 'array';
		else if (RegExp == object.constructor) type = 'regexp';
		else type = 'object';
	}
	switch(type){
		case 'undefined':
		case 'unknown':
			return; break;//return undefined
		case 'function':
		case 'boolean':
		case 'regexp':
			return object.toString(); break;
		case 'number':
			return isFinite(object) ? object.toString() : 'null'; break;
		case 'string':
			return '"' + object.replace(/(\\|\")/g,"\\$1").replace(/\n|\r|\t/g, function(){ var a = arguments[0]; return (a == '\n') ? '\\n': (a == '\r') ? '\\r': (a == '\t') ? '\\t': "" }) + '"'; break;
		case 'object':
			var pp="";var value ="";
			var results = [];
			try{
				for (var property in object)
				{
					pp=object[property];
					value = o2s(pp);
					if (value !== undefined)
						results.push('"'+property + '":' + value);
				};
			}
			catch(e){ }
			return '{' + results.join(',') + '}';
			break;
		case 'array':
			var results = [];
			if(object.length>=0){
				for(var i = 0; i < object.length; i++){
					var value = o2s(object[i]);
					if (value !== undefined)
						results.push(value);
				};
				return '[' + results.join(',') + ']';
			}
			else{
				for(k in object) {
					var kk=k; var value = o2s(object[k]);
					if (value !== undefined)
						results.push('"'+kk+'":'+value);
				}
				return '{' + results.join(',') + '}';
			}
			break;
	}
};

window.isRootLoaded=true;
window.cmpjsbridge=new (function(){
	this.browser = {
		versions: function() {
			var u = navigator.userAgent, app = navigator.appVersion;
			return {
				android: u.indexOf('Android') > -1,
				iphone: u.indexOf('iPhone') > -1,
				ipad: u.indexOf('iPad') > -1,
				webApp: u.indexOf('Safari') == -1
			};
		}()
	};
	var app_type='Desktop';
	var _browser=this.browser;
	if (_browser.versions.iphone) app_type='iOS';
	if (_browser.versions.ipad) app_type='iOS';
	if (_browser.versions.android) app_type='Android';
	this.app_type=app_type;

	//iOS JS-BRIDGE
	this.ios_js_bridge=function(callback) {
		if (window.WebViewJavascriptBridge) { return callback(WebViewJavascriptBridge); }
		alert("?? WebViewJavascriptBridge ??");
		return null;
		if (window.WVJBCallbacks) { return window.WVJBCallbacks.push(callback); }
		window.WVJBCallbacks = [callback];
		var WVJBIframe = document.createElement('iframe');
		WVJBIframe.style.display = 'none';
		WVJBIframe.src = 'jsb1://__BRIDGE_LOADED__';
		document.documentElement.appendChild(WVJBIframe);
		setTimeout(function() { document.documentElement.removeChild(WVJBIframe) }, 0)
	};


	//Android JS-BRIDGE
	this.android_js_bridge=function(callback){
		if (window.WebViewJavascriptBridge) {
			callback(WebViewJavascriptBridge)
		} else {
			document.addEventListener(
				'WebViewJavascriptBridgeReady'
				, function() {
					callback(WebViewJavascriptBridge)
				},
				false
			);
		}
	};

	console.log("browser.versions", this.browser.versions)


	//this.js_bridge=function(callback){
	//if(this.bridge.versions.android){
	//}
	//};

	this.callHandler=function(funcname,data,cb){
		if(typeof(console)!='undefined'){
			console.log(funcname, data, cb);
		}
		var s="";
		s+="<h1>"+data['header']+"</h1>";
		s+="<pre style='font-size:13pt;'>"+data['body']+"</pre>";
		switch(this.app_type){
			case 'Android':
				this.android_js_bridge(function(bridge){
					bridge.callHandler( funcname, data, function( rt ){
						if (typeof(rt)=='string'){
							try{ rt=s2o(rt); } catch(ex){};
						}
						if (cb) cb(rt);
					});
				});
				break;
			case 'iOS':
				this.ios_js_bridge(function(bridge) {
					bridge.callHandler( funcname, data, cb );
				})
				break;
				//default:
				//window.open('WapPrint.htm?s='+ escape(o2s(s)));//TODO post the data
		}
	}//call
});//cmpjsbridge
