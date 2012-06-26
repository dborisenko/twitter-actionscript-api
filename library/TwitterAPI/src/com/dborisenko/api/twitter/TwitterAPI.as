/** TwitterAPI.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter
{
	import com.dborisenko.api.twitter.interfaces.ITwitterOperation;
	import com.dborisenko.api.twitter.net.TwitterOperation;
	import com.dborisenko.api.twitter.oauth.OAuthTwitterConnection;
	import com.dborisenko.api.twitter.utils.AsyncQueue;
	
	import flash.events.EventDispatcher;
	
	use namespace twitter_internal;
	
	/**
	 * Twitter API class.
	 * <br/><br/>
	 * Example:<br/>
	 * <code>
	 * var twitterApi:TwitterAPI = new TwitterAPI();<br/>
	 * twitterApi.connection.setAccessToken(key, secret);<br/>
	 * var op:TwitterOperation = new VerifyCredentials();<br/>
	 * var handler:Function = function (event:TwitterEvent):void<br/>
	 * {<br/>
	 *         op.removeEventListener(TwitterEvent.COMPLETE, handler);<br/>
	 *         if (event.success)<br/>
	 *         {<br/>
	 *                 trace("Credentials verified. User is: " + TwitterUser(event.data).screenName);<br/>
	 *         }<br/>
	 *         else<br/>
	 *         {<br/>
	 *                 trace("Verification error. Twitter error message: " + event.data);<br/>
	 *         }<br/>
	 * };<br/>
	 * op.addEventListener(TwitterEvent.COMPLETE, handler);<br/>
	 * twitterApi.post(op, TwitterAPI.POST_TYPE_ASYNC_STATIC, TwitterAPI.PRIORITY_HIGHEST);<br/>
	 * </code>
	 * 
	 * @author Denis Borisenko
	 * 
	 */
	public class TwitterAPI extends EventDispatcher
	{
		/**
		 * Normal post type. Not to put operation in the queue. Execute operation immediately.
		 */
		public static const POST_TYPE_NORMAL:String = "normal";
		/**
		 * Async post type. Put operation in the queue. Execute operation in the queue. 
		 * Each instance has his own queue of operations.
		 */
		public static const POST_TYPE_ASYNC:String = "async";
		/**
		 * Async post type. Put operation in the queue. Execute operation in the static queue.
		 * Common static queue of operations.
		 */
		public static const POST_TYPE_ASYNC_STATIC:String = "asyncStatic";
		
		public static const PRIORITY_LOWEST:int = 1;
		public static const PRIORITY_LOW:int = 3;
		public static const PRIORITY_NORMAL:int = 5;
		public static const PRIORITY_HIGH:int = 7;
		public static const PRIORITY_HIGHEST:int = 9;
		
		/**
		 * Connection of OAuth authentication to Twitter.
		 * @private
		 */
		protected var _connection:OAuthTwitterConnection = new OAuthTwitterConnection();
		/**
		 * Each instance has his own queue of operations.
		 * @private
		 */
		protected var asyncQueue:AsyncQueue = new AsyncQueue();
		
		/**
		 * Common static queue of operations.
		 * @private
		 */
		protected static var staticAsyncQueue:AsyncQueue = new AsyncQueue();
		
		public function TwitterAPI()
		{
			super();
		}
		
		/**
		 * Connection of OAuth authentication to Twitter.
		 */
		public function get connection():OAuthTwitterConnection
		{
			return _connection;
		}
		
		/**
		 * Post operation for executing.
		 * 
		 * @param operation		Instance of the operation.
		 * @param postType		Post type of the operation. 
		 * 						Can be <code>POST_TYPE_NORMAL</code>, <code>POST_TYPE_ASYNC</code> or 
		 * 						<code>POST_TYPE_ASYNC_STATIC</code>
		 * @param priority		Priority of executing of the operation
		 * @return 				Twitter Operation
		 * 
		 */		
		public function post(operation:ITwitterOperation, postType:String=POST_TYPE_NORMAL,
							 priority:int=PRIORITY_NORMAL):ITwitterOperation
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
		
		/**
		 * @private 
		 */
		protected function postAsyncStatic(operation:ITwitterOperation, priority:int=PRIORITY_NORMAL):ITwitterOperation
		{
			if (operation.requiresAuthentication)
			{
				if (connection.consumer && connection.accessToken)
				{
					operation.setTwitterAPI(this);
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
		
		/**
		 * @private 
		 */
		protected function postAsync(operation:ITwitterOperation, priority:int=PRIORITY_NORMAL):ITwitterOperation
		{
			if (operation.requiresAuthentication)
			{
				if (connection.consumer && connection.accessToken)
				{
					operation.setTwitterAPI(this);
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
		
		/**
		 * @private 
		 */
		protected function postSync(operation:ITwitterOperation):ITwitterOperation
		{
			if (operation.requiresAuthentication)
			{
				if (connection.consumer && connection.accessToken)
				{
					operation.setTwitterAPI(this);
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