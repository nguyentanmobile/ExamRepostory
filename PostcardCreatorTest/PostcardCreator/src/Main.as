package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import starling.core.Starling;
	import starling.events.ResizeEvent;
	
	/**
	 * ...
	 * @author Andrew Jarman
	 */
	
	[SWF(width="1280", height="720", frameRate="60", backgroundColor="#123456")]
	public class Main extends Sprite 
	{
		
		private var _starling:Starling;
		
		public function Main() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			
			// Entry point
			//set up starling			 
			_starling = new Starling(Game, stage);
			
			_starling.start();
			
			trace("ScaleFactor: " + _starling.contentScaleFactor);			
			stage.addEventListener(ResizeEvent.RESIZE, resizeStage);
		}
		
		private function deactivate(e:Event):void 
		{
			// make sure the app behaves well (or exits) when in background
			//NativeApplication.nativeApplication.exit();
		}
		
		
 
		private function resizeStage(e:Event):void {
			var viewPortRectangle:Rectangle = new Rectangle();
			viewPortRectangle.width = stage.stageWidth;
			viewPortRectangle.height = stage.stageHeight;
			Starling.current.viewPort = viewPortRectangle;
 
			_starling.stage.stageWidth = stage.stageWidth;
			_starling.stage.stageHeight = stage.stageHeight;
		}
		
		
		//function to work out of on mobile or not
		public static function isAndroid():Boolean
		{
			return (Capabilities.version.substr(0,3) == "AND");
		}
		public static function isIOS():Boolean
		{
			return (Capabilities.version.substr(0,3) == "IOS");
		}

		public static function isMobile():Boolean
		{
			return (isAndroid() || isIOS());
		}
		
	}
	
}