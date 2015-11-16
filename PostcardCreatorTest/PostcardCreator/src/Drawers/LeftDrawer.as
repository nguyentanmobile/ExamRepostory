package Drawers 
{
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.controls.ScrollContainer;
	import feathers.core.PopUpManager;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.HorizontalLayoutData;
	import feathers.layout.VerticalLayout;
	import feathers.layout.VerticalLayoutData;
	import PopUps.AboutTheNCTE;
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import StoredObject.SharedObjectManager;
	import StoredObject.User;
	import Utils.AssetsManager;
	import Utils.Utilities;
	
	/**
	 * ...
	 * @author Andrew Jarman
	 */
	public class LeftDrawer extends ScrollContainer 
	{
		public static const LOGOUT:String = "logout";
		public static const CHANGEPROJECT:String = "changeProject";
		
		private var UserLabel:Label;
		private var ProjectLabel:Label;
		private var changeProject:Button;
		private var Logout:Button;
		
		public function LeftDrawer() 
		{
			super();
			
			this.width = Utilities.GetScaledX(0.25);
			
			UserLabel = new Label();
			UserLabel.wordWrap = true;
			UserLabel.text = "Not Logged in";
			//UserLabel.width = Utilities.GetScaledX(0.2);
			addChild(UserLabel);
			UserLabel.validate();
			UserLabel.alignPivot();
			UserLabel.x = width * 0.5;
			UserLabel.y = Utilities.GetScaledY(0.05);
			
			Logout = new Button();
			Logout.label = "Log Out";
			addChild(Logout);
			Logout.width = Utilities.GetScaledX(0.2);
			Logout.addEventListener(TouchEvent.TOUCH, onLogoutTouch);
			Logout.validate();
			Logout.alignPivot();
			Logout.x = width * 0.5;
			Logout.y = Utilities.GetScaledY(0.15);
			Logout.isEnabled = false;
			
			ProjectLabel = new Label();
			ProjectLabel.wordWrap = true;
			ProjectLabel.text = "No Project open";
			//ProjectLabel.width = Utilities.GetScaledX(0.2);
			addChild(ProjectLabel);
			ProjectLabel.validate();
			ProjectLabel.alignPivot();
			ProjectLabel.x = width * 0.5;
			ProjectLabel.y = Utilities.GetScaledY(0.25);
			
			changeProject = new Button();
			changeProject.label = "Change Project";
			addChild(changeProject);
			changeProject.width = Utilities.GetScaledX(0.2);
			changeProject.addEventListener(TouchEvent.TOUCH, onchangeProjectTouch);
			changeProject.validate();
			changeProject.alignPivot();
			changeProject.x = width * 0.5;
			changeProject.y = Utilities.GetScaledY(0.35);
			changeProject.isEnabled = false;
			
			var logo:Image = new Image(AssetsManager.getAtlas().getTexture("PCC_RWT"));
			addChild(logo);
			logo.alignPivot();
			logo.width = this.width * 0.8;
			logo.scaleY = logo.scaleX;
			logo.x = width * 0.5;
			logo.y = Utilities.GetScaledY(0.7)
			
			
			var about:Button = new Button();
			about.label = "About";
			addChild(about);
			about.width = Utilities.GetScaledX(0.2);
			about.addEventListener(TouchEvent.TOUCH, onAboutTouch);
			about.validate();
			about.alignPivot();
			about.x = width * 0.5;
			about.y = Utilities.GetScaledY(0.8);
			
			this.validate();
		}
		
		private function onAboutTouch(e:TouchEvent):void 
		{
			var b:Button = (e.target as Button);
			if (e.getTouch(b, TouchPhase.ENDED))
			{
				PopUpManager.addPopUp(new AboutTheNCTE());
			}
		}
		
		public function refresh():void 
		{
			if (SharedObjectManager.getCurrentUser() != null)
			{
				UserLabel.text = "Logged in as:\n" + SharedObjectManager.getCurrentUser().name;
				Logout.isEnabled = true;
			}
			else
			{
				UserLabel.text = "Not Logged in";
				Logout.isEnabled = false;
			}
			
			if (SharedObjectManager.getCurrentProject() != null)
			{
				ProjectLabel.text = "Project name:\n" + SharedObjectManager.getCurrentProject().name;
				changeProject.isEnabled = true;
			}
			else
			{
				ProjectLabel.text = "No Project open";
				changeProject.isEnabled = false;
			}
		}
		
		private function onLogoutTouch(e:TouchEvent):void 
		{
			var b:Button = (e.target as Button);
			if (e.getTouch(b, TouchPhase.ENDED))
			{
				dispatchEventWith(LOGOUT);
				
				UserLabel.text = "Not Logged in";
				Logout.isEnabled = false;
				
				ProjectLabel.text = "No Project open";
				changeProject.isEnabled = false;
			}
		}
		
		private function onchangeProjectTouch(e:TouchEvent):void 
		{
			var b:Button = (e.target as Button);
			if (e.getTouch(b, TouchPhase.ENDED))
			{
				dispatchEventWith(CHANGEPROJECT);
				
				ProjectLabel.text = "No Project open";
				changeProject.isEnabled = false;
			}
		}
		
	}

}