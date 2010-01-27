/** LoadFavorites.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.commands.favorite
{
	import com.dborisenko.api.enums.ResultFormat;
	import com.dborisenko.api.twitter.net.StatusesOperation;
	
	/**
	 * Returns the 20 most recent favorite statuses for the authenticating user or user 
	 * specified by the ID parameter in the requested format.
	 * 
	 * @author Denis Borisenko
	 * @see http://apiwiki.twitter.com/Twitter-REST-API-Method%3A-favorites
	 */
	public class LoadFavorites extends StatusesOperation
	{
		protected static const URL:String = "http://twitter.com/favorites.xml";
		
		/**
		 * 
		 * @param id		Optional.  The ID or screen name of the user for whom to request a list of favorite statuses. 
		 * @param page		Optional. Specifies the page of favorites to retrieve.
		 * 
		 */
		public function LoadFavorites(id:String=null, page:int=-1)
		{
			super(URL);
			resultFormat = ResultFormat.XML;
			method = METHOD_GET;
			_requiresAuthentication = true;
			_apiRateLimited = true;
			parameters = {id: id, page: page};
		}
	}
}