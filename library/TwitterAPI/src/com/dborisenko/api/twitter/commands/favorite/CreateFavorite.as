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
	 * @see http://apiwiki.twitter.com/Twitter-REST-API-Method%3A-favorites%C2%A0create
	 */
	public class CreateFavorite extends StatusOperation
	{
		protected static const URL:String = "http://twitter.com/favorites/create/{id}.xml";
		
		/**
		 * 
		 * @param id		Required.  The ID of the status to favorite. 
		 * 
		 */
		public function CreateFavorite(id:String)
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