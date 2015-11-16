package PopUps
{
	import com.greensock.easing.Cubic;
	import feathers.controls.Button;
	import feathers.controls.Panel;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.controls.TabBar;
	import feathers.data.ListCollection;
	import feathers.layout.AnchorLayoutData;
	import feathers.motion.transitions.TabBarSlideTransitionManager;
	import Screens.Editor.SaveTab;
	import starling.events.Event;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import Utils.Utilities;
	
	/**
	 * ...
	 * @author NGUYEN NGOC TAN
	 */
	public class PageScreenPopUp extends Sprite
	{
		public static const SAVE_TAB:String = "savetab";
		public static const TAB_1:String = "tab1";
		public static const TAB_2:String = "tab2";
		private var Continue:Button;
		private var overlay:Quad;
		private var tabBar:TabBar;
		
		
		private var tabManager:ScreenNavigator;
		private var background:Quad;
		private var _transitionManager:TabBarSlideTransitionManager;
		
		public function PageScreenPopUp()
		{
			super();
			initValue();
			initEvent();
		}
		
		private function initValue():void
		{
			overlay = new Quad(Utilities.GetScaledX(1), Utilities.GetScaledY(1), 0x00000);
			overlay.alpha = 0;
			
			background =  new Quad(Utilities.GetScaledX(0.5), Utilities.GetScaledX(0.25), 0xffffff);			
			background.x = Utilities.GetScaledX(0.5)-background.width/2;
			background.y = Utilities.GetScaledX(0.25)-background.height/2;
			Continue = new Button();
			Continue.label = "Continue";
			Continue.addEventListener(TouchEvent.TOUCH, onTouch);
			Continue.width = Utilities.GetScaledX(0.2);
			
			Continue.x = Utilities.GetScaledX(0.5) - Continue.width / 2; //Continue.width/2;
			Continue.y = background.y+background.height
			Continue.validate();
			trace(Continue.height)
			
			
			tabManager = new ScreenNavigator();
			var tabSave:ScreenNavigatorItem = new ScreenNavigatorItem( new SaveTab(1) );
			tabManager.addScreen(SAVE_TAB, tabSave);
			var tab1:ScreenNavigatorItem = new ScreenNavigatorItem( new SaveTab(2) );
			tabManager.addScreen(TAB_1, tab1);
			var tab2:ScreenNavigatorItem = new ScreenNavigatorItem( new SaveTab(3) );
			tabManager.addScreen(TAB_2, tab2);
			tabManager.x = Utilities.GetScaledX(0.5)-background.width/2;
			tabManager.y = Utilities.GetScaledX(0.28)-background.height/2;
			
			tabBar = new TabBar();
			tabBar.customTabStyleName= "feathers-sidebar-tab-bar-tab";
			tabBar.width = Utilities.GetScaledX(0.5);
			tabBar.height = Utilities.GetScaledX(0.03);
			tabBar.x =Utilities.GetScaledX(0.5)-background.width/2;
			tabBar.y = Utilities.GetScaledX(0.25)-background.height/2;
			tabBar.direction = TabBar.DIRECTION_HORIZONTAL;
			tabBar.layoutData = new AnchorLayoutData( NaN, 0, NaN, 10 );
			tabBar.dataProvider = new ListCollection([
				{ label: "Save"},
				{ label: "Tab 1" },
				{ label: "Tab 2" }
				
			]);
			tabManager.showScreen(SAVE_TAB);
			tabBar.selectedIndex = 0;
			this._transitionManager = new TabBarSlideTransitionManager(tabManager, tabBar);
			this._transitionManager.duration = 0.4;
			//this._transitionManager.ease = Cubic.easeOut;
			/*tabBar.tabFactory = function() : Button {
				var tab : Button = new Button();
				tab.iconPosition = Button.ICON_POSITION_TOP;
				tab.gap = 0;
				tab.iconOffsetY = 12;
				tab.labelOffsetY = -6;
				tab.height = 88;
				return tab;
			}*/
			tabBar.addEventListener(Event.CHANGE, onTabChanged);
			addChild(overlay);
			addChild(background);
			addChild(tabBar);
			addChild(tabManager);
			addChild(Continue);
		}
		
		private function onTabChanged(e:Event):void
		{
			switchTo(tabBar.selectedItem.label);
		}
		
		private function switchTo(s:String):void 
		{
			switch(s)
			{
				case "Save":
					//currentScreen =  names;
					tabBar.selectedIndex = 0;
					tabManager.showScreen(SAVE_TAB);
				break;
				case "Tab 1":
					//currentScreen =  personalInfo;
					tabBar.selectedIndex = 1;
					tabManager.showScreen(TAB_1);
					break;
				case "Tab 2":
					//currentScreen =  aboutMe;
					tabBar.selectedIndex = 2;
					tabManager.showScreen(TAB_2);
					break;
			}
		}
		
		
		
		private function initEvent():void
		{
			overlay.addEventListener(TouchEvent.TOUCH, onTouch);
			Continue.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(e:TouchEvent):void
		{
			if (e.getTouch(overlay, TouchPhase.ENDED))
			{
				this.removeFromParent();
			}
			if (e.getTouch(Continue, TouchPhase.ENDED))
			{
				this.removeFromParent();
			}
		}
	
	}

}