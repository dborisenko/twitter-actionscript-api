/** CreateFavorite.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.commands.favorite
{
	import com.dborisenko.api.enums.ResultFormat;
	import com.dborisenko.api.twitter.net.StatusOperation;
	
	/**
	 * Favorites the status specified in the ID parameter as the authenticating user. 
	 * Returns the favorite status when successful.
	 * 
	 * @author Denis Borisenko
	 * @see https://dev.twitter.com/docs/api/1/post/favorites/create/%3Aid
	 */
	public class CreateFavorite extends StatusOperation
	{
		/**
		 * @private
		 */
		protected static const URL:String = "https://api.twitter.com/1/favorites/create/{id}.json";
		
		/**
		 * 
		 * @param id		Required.  The ID of the status to favorite. 
		 * 
		 * @param entities  Optional. Whether or not to return entities with the status.
		 * 
		 */
		public function CreateFavorite(id:String, entities:Boolean = true)
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