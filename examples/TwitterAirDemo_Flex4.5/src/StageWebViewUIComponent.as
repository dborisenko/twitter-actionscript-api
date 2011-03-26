package {
	
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.LocationChangeEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.StageWebView;
	
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	import mx.events.ResizeEvent;
	
	import spark.primitives.Rect;
	
	[Event(name="complete", type="flash.events.Event")]
	[Event(name="locationChanging", type="flash.events.LocationChangeEvent")]
	[Event(name="locationChange", type="flash.events.LocationChangeEvent")]
	
	public class StageWebViewUIComponent extends UIComponent{
		
		public var yOffset:int = 80;
		
		protected var myStage:Stage;
		
		[Bindable]
		public var location:Object;
		
		private var _url:String;
		
		public function set url(url:String):void{
			_url = url;
			location = url;
			
			if(_stageWebView){
				_stageWebView.loadURL(url);
			}
		}

		private var _text:String;
		
		[Bindable]
		private var _stageWebView:StageWebView;
		
		[Bindable]
		public function get stageWebView():StageWebView{
			return _stageWebView;
		}
		
		public function set stageWebView(v:StageWebView):void{
		}
		
		public function StageWebViewUIComponent(){
			addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
			addEventListener(ResizeEvent.RESIZE, onResize);
			addEventListener(FlexEvent.INITIALIZE, onInitialize);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		

		public function set text(text:String):void{
			_text = text;
			
			if(_stageWebView){
				_stageWebView.loadString(text);
			}
		}
		
		public function hide():void{
			_stageWebView.stage = null;
		}
		
		public function show():void{
			_stageWebView.stage = myStage;
		}
		
		public function dispose():void{
			hide();
			_stageWebView.dispose();
		}
		
		protected function addedToStageHandler(event:Event):void{
			myStage = event.currentTarget.document.stage;
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			
			_stageWebView = new StageWebView();
			_stageWebView.stage = myStage;
			_stageWebView.addEventListener(Event.COMPLETE, completeHandler);
			_stageWebView.addEventListener(ErrorEvent.ERROR, errorHandler);
			_stageWebView.addEventListener(LocationChangeEvent.LOCATION_CHANGING, locationChangingHandler);
			_stageWebView.addEventListener(LocationChangeEvent.LOCATION_CHANGE, locationChangeHandler);
			if(_url){
				_stageWebView.loadURL(_url);
			}else if(_text){
				_stageWebView.loadString(_text);
			}
			
			resize();
		}
		
		protected function completeHandler(event:Event):void
		{
			dispatchEvent(event.clone());
		}
		
		protected function locationChangingHandler(event:Event):void
		{
			dispatchEvent(event.clone());
		}
		
		protected function locationChangeHandler(event:Event):void{
			location = _stageWebView.location;
			
			dispatchEvent(event.clone());
		}
		
		protected function errorHandler(event:Event):void
		{
			dispatchEvent(event.clone());
		}
		
		protected function onResize(event:ResizeEvent):void
		{
			resize();
		}
		
		private function resize():void
		{
			if(_stageWebView) {
				var global:Point = localToGlobal(new Point()); 
				var rect:Rectangle = new Rectangle(global.x, global.y, width, height);
				_stageWebView.viewPort = rect;
			}
		}
		
		protected function onCreationComplete(event:FlexEvent):void
		{
			resize();
		}
		
		protected function onInitialize(event:FlexEvent):void
		{
			resize();
		}
		
		protected function onRemoveFromStage(event:Event):void
		{
			hide();
		}
	}
}