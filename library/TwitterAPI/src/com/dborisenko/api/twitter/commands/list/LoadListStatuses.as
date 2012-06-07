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
	 * Returns tweet timeline for members of the specified list. 
	 * Historically, retweets were not available in list timeline responses but you 
	 * can now use the include_rts=true parameter to additionally receive retweet objects.
	 * 
	 * @author Denis Borisenko
	 * @see https://dev.twitter.com/docs/api/1/get/lists/statuses
	 */
	public class LoadListStatuses extends StatusesOperation implements ISinceIdOperation
	{
		/**
		 * @private
		 */
		protected static const URL:String = "https://api.twitter.com/1/lists/statuses.json";
		
		/**
		 * 
		 * @param listId           Optional. Id of the list.
		 *  
		 * @param slug             Optional. The slug of the list. If specified, the ownerId or ownerScreenName is required.
		 * 
		 * @param ownerScreenName  Optional. The list owner's screen name. This or ownerId is required if using slug.
		 * 
		 * @param ownerId          Optional. The list owner's id. This or ownerScreenName is required if using slug.
		 * 
		 * 
		 *  
		 * @param sinceId		   Optional. Returns only statuses with an ID greater than (that is, more recent than) 
		 * 						     the specified ID. 
		 * 						     Example: since_id=12345
		 * @param maxId			   Optional. Returns only statuses with an ID less than (that is, older than) 
		 * 						     or equal to the specified ID. 
		 * 						     Example: max_id=54321
		 * 
		 * @param perPage		   Optional. Specifies the number of statuses to retrieve. May not be greater than 200.  
		 * 						     Example: per_page=5 
		 * 
		 * @param entities         Optional. Whether or not to include status entities.
		 * 
		 * @param includeRetweets  Optional. Whether or not to include Retweets.
		 * 
		 */
		public function LoadListStatuses(listId:String, slug:String = null, ownerScreenName:String = null, ownerId:String = null,
										 sinceId:String = null, maxId:String = null, perPage:int = -1, entities:Boolean = true,
										 includeRetweets:Boolean = true)
		{
			super(URL);
			resultFormat = ResultFormat.JSON;
			method = METHOD_GET;
			_requiresAuthentication = true;
			_apiRateLimited = true;
			parameters = {list_id:listId, slug:slug, owner_screen_name:ownerScreenName, owner_id:ownerId,
							since_id: sinceId, max_id: maxId, per_page: perPage, include_entities:entities, include_rts:includeRetweets};
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