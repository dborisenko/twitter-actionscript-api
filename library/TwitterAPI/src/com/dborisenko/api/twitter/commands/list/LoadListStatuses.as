/** LoadListStatuses.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.commands.list
{
	import com.dborisenko.api.enums.ResultFormat;
	import com.dborisenko.api.twitter.interfaces.ISinceIdOperation;
	import com.dborisenko.api.twitter.net.StatusesOperation;
	
	/**
	 * Show tweet timeline for members of the specified list.
	 * 
	 * @author Denis Borisenko
	 * @see http://apiwiki.twitter.com/Twitter-REST-API-Method%3A-GET-list-statuses
	 */
	public class LoadListStatuses extends StatusesOperation implements ISinceIdOperation
	{
		/**
		 * @private
		 */
		protected static const URL:String = "http://api.twitter.com/1/{user}/lists/{list_id}/statuses.xml";
		
		/**
		 * 
		 * @param user
		 * @param listId
		 * @param sinceId		Optional.  Returns only statuses with an ID greater than (that is, more recent than) 
		 * 						the specified ID. 
		 * 						Example: since_id=12345
		 * @param maxId			Optional.  Returns only statuses with an ID less than (that is, older than) 
		 * 						or equal to the specified ID. 
		 * 						Example: max_id=54321
		 * @param perPage		Optional.  Specifies the number of statuses to retrieve. May not be greater than 200.  
		 * 						Example: per_page=5 
		 * @param page			Optional. Specifies the page of results to retrieve. Note: there are pagination limits
		 * 						( http://apiwiki.twitter.com/Things-Every-Developer-Should-Know#6Therearepaginationlimits ).
		 * 						Example: page=3 
		 * 
		 * @see http://apiwiki.twitter.com/Things-Every-Developer-Should-Know#6Therearepaginationlimits
		 */
		public function LoadListStatuses(user:String, listId:String, sinceId:String=null, maxId:String=null, 
										 perPage:int=-1, page:int=-1)
		{
			super(URL.replace(/\{user\}/gi, user).replace(/\{list_id\}/gi, listId));
			resultFormat = ResultFormat.XML;
			method = METHOD_GET;
			_requiresAuthentication = true;
			_apiRateLimited = true;
			parameters = {since_id: sinceId, max_id: maxId, per_page: perPage, page: page};
		}
		
		/**
		 * 
		 * Optional.  Returns only statuses with an ID greater than (that is, more recent than) the specified ID. 
		 * 		Example: since_id=12345
		 * 
		 */		
		public function get sinceId():String
		{
			return parameters["since_id"];
		}
		public function set sinceId(value:String):void
		{
			if (value)
			{
				parameters["since_id"] = value;
			}
			else if (parameters["since_id"])
			{
				delete parameters["since_id"];
			}
		}
	}
}