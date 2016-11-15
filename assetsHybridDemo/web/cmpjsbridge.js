function s2o(s){try{var myjson=null;return(new Function('return '+s))();}catch(ex){}};function o2s(o){return JSON.stringify(o);};
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

	console.log("browser.versions=", this.browser.versions)

	this.callHandler=function(funcname,data,cb){
		if(typeof(console)!='undefined'){
			console.log(funcname, data, cb);
		}
		if (window.WebViewJavascriptBridge) {
            return window.WebViewJavascriptBridge.callHandler( funcname, data, function( rt ){
                if (typeof(rt)=='string'){
                    try{ rt=s2o(rt); } catch(ex){};
                }
                if (cb) cb(rt);
            });
	    }else{
		    alert("Not Read.");
	    }
	}
});
