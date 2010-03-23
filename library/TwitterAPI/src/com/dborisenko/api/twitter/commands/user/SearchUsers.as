/** SearchUsers.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2010.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.commands.user
{
	import com.dborisenko.api.enums.ResultFormat;
	import com.dborisenko.api.twitter.net.UsersOperation;
	
	/**
	 * Run a search for users similar to <a href="http://twitter.com/invitations/find_on_twitter" target="_blank">Find People</a> 
	 * button on <a href="http://twitter.com" target="_blank">Twitter.com</a>; the same results returned by people search on 
	 * Twitter.com will be returned by using this API 
	 * (<a href="http://help.twitter.com/forums/31935/entries/60660" target="_blank">about being listed in the People Search</a>).  
	 * It is only possible to retrieve the first 1000 matches from this API.
	 * 
	 * @author Denis Borisenko
	 * @see http://apiwiki.twitter.com/Twitter-REST-API-Method%3A-users-search
	 */
	public class SearchUsers extends UsersOperation
	{
		/**
		 * @private
		 */
		protected static const URL:String = "http://api.twitter.com/1/users/search.xml";
		
		/**
		 * 
		 * @param query		The query to run against people search. 
		 * 					Example: q=Doug%20Williams
		 * @param perPage	Optional.  Specifies the number of statuses to retrieve. May not be greater than 20. 
		 * 					Example: q=Doug%20Williams&per_page=5 
		 * @param page		Optional. Specifies the page of results to retrieve.
		 * 					Example: q=Doug%20Williams&page=3 
		 * 
		 */
		public function SearchUsers(query:String, perPage:int=-1, page:int=-1)
		{
			super(URL);
			resultFormat = ResultFormat.XML;
			method = METHOD_GET;
			_requiresAuthentication = true;
			_apiRateLimited = true;
			parameters = {q: query, per_page: perPage, page: page};
		}
	}
}