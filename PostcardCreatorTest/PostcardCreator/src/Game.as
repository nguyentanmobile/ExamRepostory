package
{
	import com.milkmangames.nativeextensions.GoViral;
	import Drawers.LeftDrawer;
	import feathers.controls.Button;
	import feathers.controls.Drawers;
	import feathers.controls.Header;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.core.PopUpManager;
	import feathers.events.FeathersEventType;
	import feathers.themes.CustomTheme;
	import PopUps.AboutPostcardCreator;
	import Screens.Editor.Description;
	import Screens.Editor.MailingAddress;
	import Screens.Editor.Message;
	import Screens.Editor.PostcardBack;
	import Screens.Editor.Stamp;
	import Screens.Editor.EditorScreen;
	import Screens.GetStarted;
	import Screens.Overview;
	import Screens.ProjectSelect;
	import Screens.Review;
	import Screens.Splash;
	import Screens.UserSelect;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import StoredObject.SharedObjectManager;
	import Utils.Utilities;
	
	/**
	 * ...
	 * @author Andrew Jarman
	 */
	public class Game extends Sprite
	{
		private static const SPLASH:String = "splash";
		
		private static const USER_SELECT:String = "userSelect";
		private static const PROJECT_SELECT:String = "projectSelect";
		private static const GET_STARTED:String = "getStarted";
		private static const EDITOR_SCREEN:String = "editorScreen";
		/*private static const MAILING_ADDRESS:String = "mailingAddress";
		private static const OVERVIEW:String = "overview";
		private static const DESCRIPTION:String = "description";
		private static const MESSAGE:String = "message";
		private static const STAMP:String = "stamp";
		private static const POSTCARD_BACK:String = "back";
		private static const REVIEW:String = "review";*/
		private var header:Header;
		private var help:Button;
		private var drawers:Drawers;
		private var Splashscreen:Splash;
		private var openLeftDrawer:Button;
		private var left:LeftDrawer;
		
		protected var _navigator:ScreenNavigator;
		
		public function Game()
		{
			super();
			
			initTheme();
			
			Splashscreen = new Splash()
			Splashscreen.addEventListener(Splash.COMPLETE, onSplashCompete);
			addChild(Splashscreen);
			
			//initalise feathers screen navigation and add event listeners for transitions
			header = new Header();
			header.styleNameList.add("Header");
			header.title = "Postcard Creator";
			header.width = Utilities.GetScaledX(1);
			
			header.gap = 0;
			header.padding = 0;
			
			help = new Button();
			help.styleNameList.add("Info");
			help.addEventListener(TouchEvent.TOUCH, helpButton_triggeredHandler);
			
			header.rightItems = new <DisplayObject>[help];
			
			openLeftDrawer = new Button();
			openLeftDrawer.styleNameList.add("Menu");
			openLeftDrawer.addEventListener(TouchEvent.TOUCH, onOpenLeftDrawer);
			
			header.leftItems = new <DisplayObject>[openLeftDrawer];
			
			header.validate();
			
			this._navigator = new ScreenNavigator();
			
			drawers = new Drawers();
			drawers.content = _navigator;
			
			
			left = new LeftDrawer();
			drawers.leftDrawer = left;			
			drawers.y = header.height;
			drawers.leftDrawerToggleEventType = Event.OPEN;
			left.addEventListener(LeftDrawer.LOGOUT, onLogout);
			left.addEventListener(LeftDrawer.CHANGEPROJECT, onChangeProject);
			drawers.addEventListener(Event.OPEN, OnShowDrawer);
			
			//var skin:Quad = new Quad(10, 10, 0xffffff);
			//skin.alpha = 1;
			//drawers.overlaySkin = skin;
			
			
			initScreens();
			
			if (CONFIG::air)
				if (GoViral.isSupported())
					GoViral.create();
		}
		
		private function onChangeProject(e:Event):void
		{
			this._navigator.showScreen(PROJECT_SELECT);
		}
		
		private function onLogout(e:Event):void
		{
			this._navigator.showScreen(USER_SELECT);
		}
		
		private function OnShowDrawer(e:Event):void
		{
			left.refresh();
		}
		
		private function onOpenLeftDrawer(e:TouchEvent):void
		{
			if (e.getTouch(openLeftDrawer, TouchPhase.ENDED))
			{
				drawers.toggleLeftDrawer(0.5);
				if (drawers.isLeftDrawerOpen)
					left.refresh();
			}
		}
		
		private function initScreens():void
		{
			
			var userSelectItem:ScreenNavigatorItem = new ScreenNavigatorItem(UserSelect);
			userSelectItem.setScreenIDForEvent(UserSelect.SHOW_PROJECT, PROJECT_SELECT);
			this._navigator.addScreen(USER_SELECT, userSelectItem);				
			
			
			var projectSelectItem:ScreenNavigatorItem = new ScreenNavigatorItem(ProjectSelect);
			projectSelectItem.setScreenIDForEvent(ProjectSelect.SHOW_USER, USER_SELECT);
			projectSelectItem.setScreenIDForEvent(ProjectSelect.SHOW_GETSTARTED, GET_STARTED);
			//projectSelectItem.setScreenIDForEvent(ProjectSelect.SHOW_OVERVIEW, OVERVIEW);
			this._navigator.addScreen(PROJECT_SELECT, projectSelectItem);
			
			var getStartedItem:ScreenNavigatorItem = new ScreenNavigatorItem(GetStarted);
			getStartedItem.setScreenIDForEvent(GetStarted.SHOW_EDITOR_SCREEN, EDITOR_SCREEN)
			this._navigator.addScreen(GET_STARTED, getStartedItem);
			
			
			var editorItem:ScreenNavigatorItem = new ScreenNavigatorItem(EditorScreen);
			editorItem.setScreenIDForEvent(EditorScreen.SHOW_GETSTARTED, GET_STARTED)			
			this._navigator.addScreen(EDITOR_SCREEN, editorItem);
			
			/*
			var OverviewItem:ScreenNavigatorItem = new ScreenNavigatorItem(Overview);
			OverviewItem.setScreenIDForEvent(Overview.SHOW_MAILINGADDRESS, MAILING_ADDRESS);
			OverviewItem.setScreenIDForEvent(Overview.SHOW_PROJECT, PROJECT_SELECT);
			this._navigator.addScreen(OVERVIEW, OverviewItem);
			
			var MailingAddressItem:ScreenNavigatorItem = new ScreenNavigatorItem(MailingAddress);
			MailingAddressItem.setScreenIDForEvent(MailingAddress.SHOW_PROJECT, PROJECT_SELECT);
			MailingAddressItem.setScreenIDForEvent(MailingAddress.SHOW_DESCRIPTION, DESCRIPTION);
			this._navigator.addScreen(MAILING_ADDRESS, MailingAddressItem);
			
			var DescriptionItem:ScreenNavigatorItem = new ScreenNavigatorItem(Description);
			DescriptionItem.setScreenIDForEvent(Description.SHOW_MAILINGADDRESS, MAILING_ADDRESS);
			DescriptionItem.setScreenIDForEvent(Description.SHOW_MESSAGE, MESSAGE);
			this._navigator.addScreen(DESCRIPTION, DescriptionItem);
			
			var MessageItem:ScreenNavigatorItem = new ScreenNavigatorItem(Message);
			MessageItem.setScreenIDForEvent(Message.SHOW_DESCRIPTION, DESCRIPTION);
			MessageItem.setScreenIDForEvent(Message.SHOW_STAMP, STAMP);
			this._navigator.addScreen(MESSAGE, MessageItem);
			
			var StampItem:ScreenNavigatorItem = new ScreenNavigatorItem(Stamp);
			StampItem.setScreenIDForEvent(Stamp.SHOW_MESSAGE, MESSAGE);
			StampItem.setScreenIDForEvent(Stamp.SHOW_BACK, POSTCARD_BACK);
			this._navigator.addScreen(STAMP, StampItem);
			
			var BackItem:ScreenNavigatorItem = new ScreenNavigatorItem(PostcardBack);
			BackItem.setScreenIDForEvent(PostcardBack.SHOW_STAMP, STAMP);
			BackItem.setScreenIDForEvent(PostcardBack.SHOW_REVIEW, REVIEW);
			this._navigator.addScreen(POSTCARD_BACK, BackItem);
			
			var ReviewItem:ScreenNavigatorItem = new ScreenNavigatorItem(Review);
			ReviewItem.setScreenIDForEvent(Review.SHOW_PROJECT, PROJECT_SELECT);
			ReviewItem.setScreenIDForEvent(Review.SHOW_POSTCARDBACK, POSTCARD_BACK);
			this._navigator.addScreen(REVIEW, ReviewItem);
			*/
			this._navigator.showScreen(USER_SELECT);
		}
		
		private function onSplashCompete(e:Event):void
		{
			addChild(header);
			addChild(drawers);
			removeChild(Splashscreen);
			Splashscreen = null;
		
		}
		
		private function helpButton_triggeredHandler(e:TouchEvent):void
		{
			if (e.getTouch(help, TouchPhase.ENDED))
			{
				PopUpManager.addPopUp(new AboutPostcardCreator());
			}
		}
		
		private function initTheme():void
		{
			//init metal works with scaling on mobile, doesnt work well for testing on flash player or web
			if (Main.isMobile())
			{
				new CustomTheme();
			}
			else
			{
				new CustomTheme(false);
			}
		}
	}

}