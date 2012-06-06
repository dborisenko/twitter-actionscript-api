/** DestroyStatus.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.commands.status
{
	import com.dborisenko.api.enums.ResultFormat;
	import com.dborisenko.api.twitter.net.StatusOperation;
	
	/**
	 * Destroys the status specified by the required ID parameter.  
	 * The authenticating user must be the author of the specified status.
	 * 
	 * @author Denis Borisenko
	 * @see https://dev.twitter.com/docs/api/1/post/statuses/destroy/%3Aid
	 */
	public class DestroyStatus extends StatusOperation
	{
		/**
		 * @private
		 */
		protected static const URL:String = "http://twitter.com/statuses/destroy/{id}.json";
		
		/**
		 * 
		 * @param id		 Required.  The ID of the status to destroy. 
		 * 
		 */
		public function DestroyStatus(id:String)
		{
			super(URL.replace(/\{id\}/gi, id));
			resultFormat = ResultFormat.JSON;
			method = METHOD_POST;
			_requiresAuthentication = true;
			_apiRateLimited = false;
			parameters = {id: id};
		}
	}
}