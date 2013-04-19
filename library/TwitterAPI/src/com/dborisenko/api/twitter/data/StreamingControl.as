package com.dborisenko.api.twitter.data
{
	public class StreamingControl
	{
		
		public var uri:String; // /:version/site/c/:stream_id
		public var version:String;
		public var streamId:String;
		public var infoURI:String; // /:version/site/c/:stream_id/info.json
		public var addUserURI:String; // /:version/site/c/:stream_id/add_user.json (message body: user_id:[USER_ID])
		public var removeUserURI:String; // /:version/site/c/:stream_id/remove_user.json (message body: user_id:[USER_ID])
		public var userInfoURI:String; // /:version/site/c/:stream_id/friends/ids.json (message body: user_id:[USER_ID]) -- gets user followings / friends
		
		
		/**
		 * Upon establishing a Site Streams connection, Twitter will send a preamble before starting regular message delivery. 
		 * This preamble will contain a control message which may be used to modify the Site Streams connection without reconnecting
		 * 
		 * https://dev.twitter.com/docs/streaming-apis/streams/site/control
		 **/
		public function StreamingControl(data:Object = null)
		{
			if(data)
				parseData(data);
		}
		
		
		/**
		 * {
			  "control":{
			    "control_uri": "/2b/site/c/01_225167_334389048B872A533002B34D73F8C29FD09EFC50"
			  }
			}
		**/
		public function parseData(data:Object):void
		{
			if(data['control'] == null){
				return;
			}
			
			this.uri = data['control']['control_uri'];
			var uriParts:Array = this.uri.substring(1).split('/'); // get rid of the first slash and then split into pieces
			this.version = uriParts[0]; // the first part is the version number
			this.streamId = this.uri.split('/')[uriParts.length - 1]; // the last part is the stream id.
			this.infoURI = "/" + this.version + "/site/c/" + this.streamId + "/info.json";
			this.addUserURI = "/" + this.version + "/site/c/" + this.streamId + "/add_user.json";
			this.removeUserURI = "/" + this.version + "/site/c/" + this.streamId + "/remove_user.json";
			this.userInfoURI = "/" + this.version + "/site/c/" + this.streamId + "/friends/ids.json";
			
		}
	}
}