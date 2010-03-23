/** Search.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.commands.search
{
	import com.dborisenko.api.enums.ResultFormat;
	import com.dborisenko.api.twitter.net.SearchOperation;
	
	/**
	 * Returns tweets that match a specified query.
	 * @author Denis Borisenko
	 * @see http://apiwiki.twitter.com/Twitter-Search-API-Method%3A-search
	 */
	public class Search extends SearchOperation
	{
		/**
		 * @private
		 */
		protected static const URL:String = "http://search.twitter.com/search.json";
		
		/**
		 * 
		 * @param q
		 * @param callback		Optional. Only available for JSON format. 
		 * 						If supplied, the response will use the JSONP format with a callback of the given name.
		 * 						Example: callback=foo&q=twitter  
		 * @param lang			Optional: Restricts tweets to the given language, given by an ISO 639-1 code
		 * 						( http://en.wikipedia.org/wiki/ISO_639-1 ). 
		 * 						Example: lang=en&q=devo
		 * @param rpp			Optional. The number of tweets to return per page, up to a max of 100. 
		 * 						Example: q=devo&rpp=15
		 * @param page			Optional. The page number (starting at 1) to return, up to a max of roughly 1500 results 
		 * 						(based on rpp * page. Note: there are pagination limits.
		 * 						( http://apiwiki.twitter.com/Things-Every-Developer-Should-Know#6Therearepaginationlimits ) 
		 * 						Example: q=devo&rpp=15&page=2
		 * @param sinceId		Optional. Returns tweets with status ids greater than the given id. 
		 * 						Example: q=twitter&since_id=1520639490
		 * @param geocode		Optional. Returns tweets by users located within a given radius of the given latitude/longitude.  
		 * 						The location is preferentially taking from the Geotagging API, but will fall back to their 
		 * 						Twitter profile. The parameter value is specified by "latitide,longitude,radius", where 
		 * 						radius units must be specified as either "mi" (miles) or "km" (kilometers). Note that you 
		 * 						cannot use the near operator via the API to geocode arbitrary locations; however you can use 
		 * 						this geocode parameter to search near geocodes directly. 
		 * 						Example: geocode=40.757929%2C-73.985506%2C25km
		 * @param showUser		Optional. When true, prepends "<user>:" to the beginning of the tweet. This is useful for 
		 * 						readers that do not display Atom's author field. The default is false. 
		 * 						Example: q=twitterapi&show_user=true
		 * 
		 */
		public function Search(q:String, callback:String=null, lang:String=null, rpp:int=-1, page:int=-1, sinceId:String=null,
							   geocode:String=null, showUser:String=null)
		{
			super(URL);
			resultFormat = ResultFormat.JSON;
			method = METHOD_GET;
			_requiresAuthentication = false;
			_apiRateLimited = true;
			parameters = {q: q, callback: callback, lang: lang, rpp: rpp, page: page,
				since_id: sinceId, geocode: geocode, show_user: showUser}
		}
	}
}