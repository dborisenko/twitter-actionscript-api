/** SearchOperation.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.net
{
	import com.dborisenko.api.twitter.data.TwitterSearch;
	import com.dborisenko.api.twitter.data.TwitterStatus;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;

	public class SearchOperation extends TwitterOperation
	{
		public function SearchOperation(url:String)
		{
			super(url, false, params, RESULT_FORMAT_JSON);
		}
		
		[Bindable]
		public function get searchData():TwitterSearch
		{
			return data as TwitterSearch;
		}
		public function set searchData(value:TwitterSearch):void
		{
			data = value;
		}
		
		override protected function handleResult(event:Event) : void
        {
			var json:Object = getJSON();
        	searchData = new TwitterSearch();
        	if ("results" in json)
        	{
        		var res:ArrayCollection = new ArrayCollection();
        		var array:Array = json["results"] as Array;
        		for each (var item:Object in array)
        		{
        			var status:TwitterStatus = new TwitterStatus(item, null, false);
        			res.addItem(status);
        		}
        		searchData.results = res;
        	}
        	if ("query" in json)
        	{
        		searchData.query = json["query"].toString();
//        		searchData.query = data.query.replace(/%40/g, "@");
//				searchData.query = data.query.replace(/%23/g, "#");
        	}
            super.handleResult(event);
        }
	}
}