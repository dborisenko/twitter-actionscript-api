/** OAuthTwitterConnection.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.oauth
{
	import com.dborisenko.api.twitter.oauth.events.OAuthTwitterEvent;
	
	import flash.events.EventDispatcher;
	import flash.net.URLRequestHeader;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import org.iotashan.oauth.OAuthConsumer;
	import org.iotashan.oauth.OAuthRequest;
	import org.iotashan.oauth.OAuthSignatureMethod_HMAC_SHA1;
	import org.iotashan.oauth.OAuthToken;
	
    [Event(name="requestTokenError",type="com.dborisenko.api.twitter.oauth.events.OAuthTwitterEvent")]
    [Event(name="requestTokenReceived",type="com.dborisenko.api.twitter.oauth.events.OAuthTwitterEvent")]
    [Event(name="accessTokenError",type="com.dborisenko.api.twitter.oauth.events.OAuthTwitterEvent")]
    [Event(name="authorized",type="com.dborisenko.api.twitter.oauth.events.OAuthTwitterEvent")]
	public class OAuthTwitterConnection extends EventDispatcher
	{
		private static const REQUEST_TOKEN_URL:String = "http://twitter.com/oauth/request_token";
		private static const ACCESS_TOKEN_URL:String = "http://twitter.com/oauth/access_token";
		private static const AUTHORIZE_URL:String = "http://twitter.com/oauth/authorize";
		
		public var consumer:OAuthConsumer = new OAuthConsumer();
		private var signatureMethod:OAuthSignatureMethod_HMAC_SHA1 = new OAuthSignatureMethod_HMAC_SHA1();
		public var requestToken:OAuthToken = new OAuthToken();
		public var accessToken:OAuthToken = new OAuthToken();
		private var _authorized:Boolean = false;
		
		private var userId:String;
		private var screenName:String;
		
		public function OAuthTwitterConnection()
		{
			super();
		}
		
		public function setConsumer(consumerKey:String, consumerSecret:String):void
		{
			consumer.key = consumerKey;
			consumer.secret = consumerSecret;
		}
		
		public function setAccessToken(accessKey:String, accessSecret:String):void
		{
			if (_authorized)
				return;
			
			accessToken.key = accessKey;
			accessToken.secret = accessSecret;
		}
		
		public function authorize(consumerKey:String, consumerSecret:String):void
		{
			if (_authorized)
				return;
			
			consumer.key = consumerKey;
			consumer.secret = consumerSecret;
			getRequestToken();
		}
		
		public function get authorizeURL():String
		{
			if (requestToken.key == null || requestToken.key == "")
				return null;
			
			return AUTHORIZE_URL + "?oauth_token=" + requestToken.key;
		}
		
		public function get authorized():Boolean
		{
			return _authorized;
		}
		
		public function grantAccess(pin:String):void
		{
			if (_authorized)
				return;
			
			getAccessToken(pin);
		}
		
		private function getRequestToken():void
		{
			if (_authorized)
				return;
			
			var oauthRequest:OAuthRequest = new OAuthRequest(OAuthRequest.HTTP_METHOD_GET, REQUEST_TOKEN_URL, null, consumer);
			var url:String = oauthRequest.buildRequest(signatureMethod);
			
			var service:HTTPService = new HTTPService();
			service.url = url;
			service.addEventListener(ResultEvent.RESULT, handleRequestToken);
			service.addEventListener(FaultEvent.FAULT, handleRequestTokenError);
			service.resultFormat = HTTPService.RESULT_FORMAT_TEXT;
			service.send();
		}
		
		private function handleRequestToken(event:ResultEvent):void
		{
			var params:Array = event.result.toString().split("&");
			for (var i:int = 0; i < params.length; i++) 
			{
        		var param:String = params[i];
        		var nameValue:Array = param.split("=");
				if (nameValue.length == 2) 
				{
            		switch (nameValue[0]) 
            		{
            			case "oauth_token":
            				requestToken.key = nameValue[1];
            				break;
            			case "oauth_token_secret":
            				requestToken.secret = nameValue[1];
            				break;
            			default:
            		}
				}
			}
			dispatchEvent(new OAuthTwitterEvent(OAuthTwitterEvent.REQUEST_TOKEN_RECEIVED, requestToken.key));
		}
		
		private function handleRequestTokenError(event:FaultEvent):void
		{
			dispatchEvent(new OAuthTwitterEvent(OAuthTwitterEvent.REQUEST_TOKEN_ERROR, event.fault.message));
		}
		
		private function getAccessToken(pin:String):void 
		{
			if (_authorized)
				return;
				
			var oauthRequest:OAuthRequest = new OAuthRequest(OAuthRequest.HTTP_METHOD_GET, ACCESS_TOKEN_URL, {oauth_verifier: pin}, consumer, requestToken);
			var url:String = oauthRequest.buildRequest(signatureMethod);
			
			var service:HTTPService = new HTTPService();
			service.url = url;
			service.addEventListener(ResultEvent.RESULT, handleAccessToken);
			service.addEventListener(FaultEvent.FAULT, handleAccessTokenError);
			service.resultFormat = HTTPService.RESULT_FORMAT_TEXT;
			service.send();
		}
		
		private function handleAccessToken(event:ResultEvent):void
		{
			var params:Array = event.result.toString().split("&");
			for (var i:int = 0; i < params.length; i++) 
			{
	    		var param:String = params[i];
	    		var nameValue:Array = param.split("=");
				if (nameValue.length == 2) 
				{
	        		switch (nameValue[0]) 
	        		{
	        			case "oauth_token":
	        				accessToken.key = nameValue[1];
	        				break;
	        			case "oauth_token_secret":
	        				accessToken.secret = nameValue[1];
	        				break;
	        			case "user_id":
	        				userId = nameValue[1];
	        				break;
        				case "screen_name":
	        				screenName = nameValue[1];
	        				break;
	        			default:
	        		}
				}
			}
			_authorized = true;
			dispatchEvent(new OAuthTwitterEvent(OAuthTwitterEvent.AUTHORIZED));
		}
		
		private function handleAccessTokenError(event:FaultEvent):void
		{
			dispatchEvent(new OAuthTwitterEvent(OAuthTwitterEvent.ACCESS_TOKEN_ERROR, event.fault.message));
		}
		
		public function createOAuthHeader(method:String, url:String, params:Object=null):URLRequestHeader
		{
			var oauthRequest:OAuthRequest = new OAuthRequest(method, url, params, consumer, accessToken);
			var result:URLRequestHeader = oauthRequest.buildRequest(signatureMethod, OAuthRequest.RESULT_TYPE_HEADER, url) as URLRequestHeader;
			
			return result;
		}
	}
}