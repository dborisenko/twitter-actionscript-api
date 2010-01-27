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
	 * @see http://apiwiki.twitter.com/Twitter-REST-API-Method%3A-favorites%C2%A0destroy
	 */
	public class DestroyFavorite extends StatusOperation
	{
		protected static const URL:String = "http://twitter.com/favorites/destroy/{id}.xml";
		
		/**
		 * 
		 * @param id		Required.  The ID of the status to un-favorite. 
		 * 
		 */
		public function DestroyFavorite(id:String)
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