/** DestroyDirectMessage.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.commands.directMessage
{
	import com.dborisenko.api.enums.ResultFormat;
	import com.dborisenko.api.twitter.net.DirectMessageOperation;
	
	/**
	 * Destroys the direct message specified in the required ID parameter.  
	 * The authenticating user must be the recipient of the specified direct message.
	 *  
	 * @author Denis Borisenko
	 * @see https://dev.twitter.com/docs/api/1/post/direct_messages/destroy/%3Aid
	 */
	public class DestroyDirectMessage extends DirectMessageOperation
	{
		/**
		 * @private
		 */
		protected static const URL:String = "http://api.twitter.com/1/direct_messages/destroy/{id}.json";
		
		/**
		 *  
		 * @param id		Required.  The ID of the direct message to destroy. 
		 * 
		 * @param entities  Optional. Returns entity metadata in the destroyed tweet body.
		 */
		public function DestroyDirectMessage(id:String, entities:Boolean = true)
		{
			super(URL.replace(/\{id\}/gi, id));
			resultFormat = ResultFormat.JSON;
			method = METHOD_POST;
			_requiresAuthentication = true;
			_apiRateLimited = false;
			parameters = {id: id, include_entities:entities};
		}
	}
}