package Screens.Editor 
{
	import feathers.controls.Screen;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.events.FeathersEventType;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author NGUYEN NGOC TAN
	 */
	public class EditorScreen extends Screen 
	{
		public static const SHOW_GETSTARTED:String = "showEditorScreen";
		
		public static const PAGE_ONE:String = "page1";
		public static const PAGE_TWO:String = "page2";
		public static const PAGE_THREE:String = "page3";
		public static const PAGE_FOUR:String = "page4";
		public static const PAGE_FIVE:String = "page5";
		public static const PAGE_SIX:String = "page6";
		
		private var _navigator:ScreenNavigator;
		
		public function EditorScreen() 
		{
			super();
			initValue();
			this.addEventListener(FeathersEventType.TRANSITION_IN_COMPLETE, OnTransitionInComplete);
		}
		
		private function initValue():void 
		{
			_navigator = new ScreenNavigator();
			this.addChild(_navigator);
			
			var ItemOne:ScreenNavigatorItem = new ScreenNavigatorItem( new PageScreen(0) );
			ItemOne.setScreenIDForEvent( PageScreen.NEXT, PAGE_TWO);
			ItemOne.setFunctionForEvent( PageScreen.BACK, onShowGetStated);
			_navigator.addScreen( PAGE_ONE, ItemOne );
			
			var ItemTwo:ScreenNavigatorItem = new ScreenNavigatorItem( new PageScreen(1) );
			ItemTwo.setScreenIDForEvent( PageScreen.BACK, PAGE_ONE);
			ItemTwo.setScreenIDForEvent( PageScreen.NEXT, PAGE_THREE);
			_navigator.addScreen( PAGE_TWO, ItemTwo );
			
			var ItemThree:ScreenNavigatorItem = new ScreenNavigatorItem( new PageScreen(2) );
			ItemThree.setScreenIDForEvent( PageScreen.BACK, PAGE_TWO);
			ItemThree.setScreenIDForEvent( PageScreen.NEXT, PAGE_FOUR);
			_navigator.addScreen( PAGE_THREE, ItemThree );
			
			var ItemFour:ScreenNavigatorItem = new ScreenNavigatorItem( new PageScreen(3) );
			ItemFour.setScreenIDForEvent( PageScreen.BACK, PAGE_THREE);
			ItemFour.setScreenIDForEvent( PageScreen.NEXT, PAGE_FIVE);
			_navigator.addScreen( PAGE_FOUR, ItemFour );
			
			var ItemFive:ScreenNavigatorItem = new ScreenNavigatorItem( new PageScreen(4) );
			ItemFive.setScreenIDForEvent( PageScreen.BACK, PAGE_FOUR);
			ItemFive.setScreenIDForEvent( PageScreen.NEXT, PAGE_SIX);
			_navigator.addScreen( PAGE_FIVE, ItemFive );
			
			var ItemSix:ScreenNavigatorItem = new ScreenNavigatorItem( new PageScreen(5) );
			ItemSix.setScreenIDForEvent( PageScreen.BACK, PAGE_FIVE);			
			_navigator.addScreen( PAGE_SIX, ItemSix );
			
			this._navigator.showScreen( PAGE_ONE );
		}
		private function OnTransitionInComplete(e:Event):void 
		{
			trace("Screen: EditorScreen");
		}
		
		private function onShowGetStated():void 
		{
			dispatchEventWith(SHOW_GETSTARTED);
		}
	}

}