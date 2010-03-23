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
	 * @see http://apiwiki.twitter.com/Twitter-REST-API-Method%3A-direct_messages%C2%A0destroy
	 */
	public class DestroyDirectMessage extends DirectMessageOperation
	{
		/**
		 * @private
		 */
		protected static const URL:String = "http://twitter.com/direct_messages/destroy/{id}.xml";
		
		/**
		 *  
		 * @param id		Required.  The ID of the direct message to destroy. 
		 * 
		 */
		public function DestroyDirectMessage(id:String)
		{
			super(URL.replace(/\{id\}/gi, id));
			resultFormat = ResultFormat.XML;
			method = METHOD_POST;
			_requiresAuthentication = true;
			_apiRateLimited = false;
			parameters = {id: id};
		}
	}
}