/** DestroyFavorite.as
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
	 * Un-favorites the status specified in the ID parameter as the authenticating user. 
	 * Returns the un-favorited status in the requested format when successful.
	 * 
	 * @author Denis Borisenko
	 * @see https://dev.twitter.com/docs/api/1/post/favorites/destroy/%3Aid
	 */
	public class DestroyFavorite extends StatusOperation
	{
		/**
		 * @private
		 */
		protected static const URL:String = "https://api.twitter.com/1/favorites/destroy/{id}.json";
		
		/**
		 * 
		 * @param id		Required.  The ID of the status to un-favorite. 
		 * 
		 */
		public function DestroyFavorite(id:String)
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