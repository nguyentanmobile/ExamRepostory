package Screens 
{
	import Controls.InfoPanel;
	import Controls.LowerBar;
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.renderers.BaseDefaultItemRenderer;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.Screen;
	import feathers.core.PopUpManager;
	import feathers.data.ListCollection;
	import feathers.display.Scale9Image;
	import feathers.events.FeathersEventType;
	import feathers.layout.VerticalLayout;
	import feathers.textures.Scale9Textures;
	import flash.geom.Rectangle;
	import flash.utils.setTimeout;
	import PopUps.AddNewUser;
	import PopUps.ConfirmDelete;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import StoredObject.SharedObjectManager;
	import Utils.Utilities;
	
	/**
	 * ...
	 * @author Andrew Jarman
	 */
	public class UserSelect extends Screen 
	{
		//navigation event param
		public static const SHOW_PROJECT:String = "showProjectSelect";
		
		
		private var list:List;
		private var NewUser:Button;
		private var DeleteUser:Button;
		private var NewUserPopup:AddNewUser;
		private static const autoLoginNewUsers:Boolean = false;
		private var lowerBar:Controls.LowerBar;
		private var del:ConfirmDelete;
		private var panel:InfoPanel;
		
		
		public function UserSelect() 
		{
			super();
			
			SharedObjectManager.load();
			
			
			panel = new InfoPanel(Utils.Utilities.GetScaledX(0.18));
			trace("panel width"+Utils.Utilities.GetScaledX(0.18))
			panel.x = Utils.Utilities.GetScaledX(0.02);
			panel.y = Utils.Utilities.GetScaledY(0.05);
			
			
			panel.addtext("By creating an account, you can save your own projects.");
			addChild(panel);
			
			list = new List();
			
			var layout:VerticalLayout = new VerticalLayout();
			layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_JUSTIFY;
			layout.gap = 0;
			layout.paddingTop = layout.paddingRight = layout.paddingBottom = layout.paddingLeft = 0;
			list.layout = layout;
			list.width = Utils.Utilities.GetScaledX(0.35);
			list.height = Utils.Utilities.GetScaledY(0.5);
			list.validate();
			list.alignPivot();
			list.x = Utils.Utilities.GetScaledX(0.5);
			list.y = Utils.Utilities.GetScaledY(0.3);
			
			list.customItemRendererStyleName = "AccountList";
			
			
			
			list.itemRendererProperties.labelField = "Name";
			
			list.dataProvider = getListCollection();
			
			list.addEventListener( Event.CHANGE, list_changeHandler );
			
			NewUser = new Button();
			NewUser.styleNameList.add("NewAccount");
			NewUser.label = "New account";
			NewUser.width = list.width;
			NewUser.validate();
			NewUser.alignPivot();
			NewUser.x = list.x;
			NewUser.y = Utils.Utilities.GetScaledY(0.65);
			NewUser.addEventListener(TouchEvent.TOUCH, OnNewUserTouch);
			
			
			
			var image:Scale9Image = new Scale9Image(new Scale9Textures(Utils.AssetsManager.getAtlas().getTexture("PCC_ScrollBoxWindow"),new Rectangle(5, 5, 22, 22)), 1 );
			image.width = list.width;
			image.height = list.height;
			image.alignPivot();
			image.x = list.x;
			image.y = list.y;
			image.touchable = false;
			
			addChild( list );
			addChild(image);
			addChild(NewUser);
			
			lowerBar = new Controls.LowerBar("Choose your account or create a new one.");
			addChild(lowerBar);
			/*  Transition Events:
			//  uncomment and impliment as required
			*/
			
			//These events are called when the screen is being navigated too
			//this.addEventListener(FeathersEventType.TRANSITION_IN_START, OnTransitionInStart);
			this.addEventListener(FeathersEventType.TRANSITION_IN_COMPLETE, OnTransitionInComplete);
			
			//this event is called when the screen has been navigated away from is no longer displayed
			//this.addEventListener(FeathersEventType.TRANSITION_OUT_Start, OnTransitionOutStart);
			//this.addEventListener(FeathersEventType.TRANSITION_OUT_COMPLETE, OnTransitionOutComplete);
		}
		
		private function onUserAdded(e:Event):void 
		{
			if (autoLoginNewUsers)
			{
				SharedObjectManager.setCurrentUser(SharedObjectManager.Users.length -1);
				this.dispatchEventWith( SHOW_PROJECT );
			}
			else
			{
				list.dataProvider = getListCollection();
				list.invalidate();
			}
		}
		
		private function OnNewUserTouch(e:TouchEvent):void 
		{
			if (e.getTouch(NewUser, TouchPhase.ENDED))
			{
				NewUserPopup = new AddNewUser();
				NewUserPopup.addEventListener(AddNewUser.USER_ADDED, onUserAdded);
				PopUpManager.addPopUp(NewUserPopup);
			}
		}
		
		private function list_changeHandler(e:Event):void 
		{
			var list:List = List( e.currentTarget );
			trace( "selectedIndex:", list.selectedIndex );
			SharedObjectManager.setCurrentUser(list.selectedIndex);
			this.dispatchEventWith( SHOW_PROJECT );
			
		}
		
		private function getListCollection():ListCollection 
		{
			var listData:ListCollection = new ListCollection();
			
			for each (var i:Object in SharedObjectManager.Users)
			{
				
				var item 	: Object = { Name: i.name };
				var button 	: Button = new Button();
				button.styleNameList.add("TrashCan");
				button.validate();
				button.width *= 1.33;
				
				
				button.addEventListener(TouchEvent.TOUCH, ClickRemoveUser);
				item.accessory = button;
				item.accessory.visible = true;
				
				listData.addItem(item);
			}
			
			return listData
		}
		
		private function ClickRemoveUser(e:TouchEvent):void 
		{
			var button : Button = Button(e.currentTarget);
			if ( e.getTouch( button, TouchPhase.ENDED ) ) {
				
				del = new ConfirmDelete((button.parent as DefaultListItemRenderer).index, "account");
				PopUpManager.addPopUp(del);
				
				del.addEventListener(ConfirmDelete.CANCEL, OnDeleteCancled);
				del.addEventListener(ConfirmDelete.DELETE, OnDeleteUser);
			}
		}
		
		private function OnDeleteUser(e:Event, data:int):void 
		{
			
			del.removeEventListeners(ConfirmDelete.CANCEL);
			del.removeEventListeners(ConfirmDelete.DELETE);
			
			list.dataProvider.removeItemAt(data);
			SharedObjectManager.deleteUser(data);
		}
		
		private function OnDeleteCancled(e:Event):void 
		{
			del.removeEventListeners(ConfirmDelete.CANCEL);
			del.removeEventListeners(ConfirmDelete.DELETE);
		}
		
		private function OnTransitionInComplete(e:Event):void 
		{
			trace("Screen: UserSelect");
			SharedObjectManager.setCurrentUser( -1);
			SharedObjectManager.setCurrentProject( -1);
		}

		
		private function onNextTriggered(e:Event):void 
		{
			//dispatch navigation event
			
		}
		
	}

}