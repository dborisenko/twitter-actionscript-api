/** TwitterAPI.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter
{
	import com.dborisenko.api.twitter.net.TwitterOperation;
	import com.dborisenko.api.twitter.oauth.OAuthTwitterConnection;
	import com.dborisenko.api.twitter.utils.AsyncQueue;
	
	import flash.events.EventDispatcher;
	
	use namespace twitter_internal;
	
	public class TwitterAPI extends EventDispatcher
	{
		public static const POST_TYPE_NORMAL:String = "normal";
		public static const POST_TYPE_ASYNC:String = "async";
		public static const POST_TYPE_ASYNC_STATIC:String = "asyncStatic";
		
		public static const PRIORITY_LOWEST:int = 1;
		public static const PRIORITY_LOW:int = 3;
		public static const PRIORITY_NORMAL:int = 5;
		public static const PRIORITY_HIGH:int = 7;
		public static const PRIORITY_HIGHEST:int = 9;
		
		protected var _connection:OAuthTwitterConnection = new OAuthTwitterConnection();
		protected var asyncQueue:AsyncQueue = new AsyncQueue();
		
		protected static var staticAsyncQueue:AsyncQueue = new AsyncQueue();
		
		public function TwitterAPI()
		{
			super();
		}
		
		public function get connection():OAuthTwitterConnection
		{
			return _connection;
		}
		
		public function post(operation:TwitterOperation, postType:String=POST_TYPE_NORMAL,
							 priority:int=PRIORITY_NORMAL):TwitterOperation
		{
			switch (postType)
			{
				case POST_TYPE_ASYNC:
					return postAsync(operation, priority);
				case POST_TYPE_ASYNC_STATIC:
					return postAsyncStatic(operation, priority);
				case POST_TYPE_NORMAL:
				default:
					return postSync(operation);
			}
			return null;
		}
		
		protected function postAsyncStatic(operation:TwitterOperation, priority:int=PRIORITY_NORMAL):TwitterOperation
		{
			if (operation.requiresAuthentication)
			{
				if (connection.consumer && connection.accessToken)
				{
					operation.twitter_internal::setTwitterAPI(this);
					staticAsyncQueue.executeOperation(operation, priority);
				}
				else
				{
					throw new Error("Cannot post an operation; you need to be authenticated.");
				}
			}
			else
			{
				staticAsyncQueue.executeOperation(operation, priority);
			}
			return operation;
		}
		
		protected function postAsync(operation:TwitterOperation, priority:int=PRIORITY_NORMAL):TwitterOperation
		{
			if (operation.requiresAuthentication)
			{
				if (connection.consumer && connection.accessToken)
				{
					operation.twitter_internal::setTwitterAPI(this);
					asyncQueue.executeOperation(operation, priority);
				}
				else
				{
					throw new Error("Cannot post an operation; you need to be authenticated.");
				}
			}
			else
			{
				asyncQueue.executeOperation(operation, priority);
			}
			return operation;
		}
		
		protected function postSync(operation:TwitterOperation):TwitterOperation
		{
			if (operation.requiresAuthentication)
			{
				if (connection.consumer && connection.accessToken)
				{
					operation.twitter_internal::setTwitterAPI(this);
					operation.execute();
				}
				else
				{
					throw new Error("Cannot post an operation; you need to be authenticated.");
				}
			}
			else
			{
				operation.execute();
			}
			return operation;
		}
	}
}