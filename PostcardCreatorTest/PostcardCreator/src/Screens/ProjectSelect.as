package Screens 
{
	import Controls.InfoPanel;
	import Controls.LowerBar;
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.controls.renderers.BaseDefaultItemRenderer;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.Screen;
	import feathers.core.PopUpManager;
	import feathers.data.ListCollection;
	import feathers.display.Scale9Image;
	import feathers.events.FeathersEventType;
	import feathers.layout.TiledRowsLayout;
	import feathers.layout.VerticalLayout;
	import feathers.textures.Scale9Textures;
	import flash.geom.Rectangle;
	import PopUps.AddNewProject;
	import PopUps.ConfirmDelete;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import StoredObject.SharedObjectManager;
	import Utils.AssetsManager;
	import Utils.Utilities;
	
	/**
	 * ...
	 * @author Andrew Jarman
	 */
	public class ProjectSelect extends Screen 
	{
		//navigation event param
		public static const SHOW_USER:String = "showUserSelect";
		public static const SHOW_GETSTARTED:String = "showGetstarted";
		//public static const SHOW_MAILING_ADDRESS:String = "showMailingAddress";
		//public static const SHOW_OVERVIEW:String = "showOverview";
		
		private var back:Button;//temporary button to test navigation
		private var list:List;
		private var listData:ListCollection;
		private var NewProject:Button;
		private var NewProjectPopup:AddNewProject;
		private var deleteProject:Button;
		private var del:ConfirmDelete;
		private var panel:InfoPanel;
		
		public function ProjectSelect() 
		{
			super();
			
			setListCollection();
			
			NewProjectPopup = new AddNewProject();
			NewProjectPopup.addEventListener(AddNewProject.PROJECT_ADDED, onProjectAdded);
			
			var lowerBar:Controls.LowerBar = new Controls.LowerBar("Create a new postcard or edit an old one.");
			addChild(lowerBar);
			
			panel = new InfoPanel(Utils.Utilities.GetScaledX(0.18));
			panel.x = Utils.Utilities.GetScaledX(0.02);
			panel.y = Utils.Utilities.GetScaledY(0.05);
			
			
			panel.addtext("Your postcards will auto-save as you edit and complete them.");
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
			
			list.customItemRendererStyleName = "ProjectList";
			
			list.itemRendererProperties.labelField = "Name";
			
			list.dataProvider = listData;
			
			list.addEventListener( Event.CHANGE, list_changeHandler );
			
			addChild( list );
			
			var image:Scale9Image = new Scale9Image(new Scale9Textures(Utils.AssetsManager.getAtlas().getTexture("PCC_ScrollBoxWindow"),new Rectangle(5, 5, 22, 22)), 1 );
			image.width = list.width;
			image.height = list.height;
			image.alignPivot();
			image.x = list.x;
			image.y = list.y;
			image.touchable = false;
			addChild(image);
			
			
			NewProject = new Button();
			NewProject.styleNameList.add("NewProject");
			NewProject.label = "New Project";
			NewProject.width = list.width;
			NewProject.validate();
			NewProject.alignPivot();
			NewProject.x = list.x;
			NewProject.y = Utils.Utilities.GetScaledY(0.65);
			NewProject.addEventListener(TouchEvent.TOUCH, OnNewProjectTouch);
			
			
			
			addChild(NewProject);
			
			this.addEventListener(FeathersEventType.TRANSITION_IN_COMPLETE, OnTransitionInComplete);
		}
		
		private function OnDeleteTouch(e:TouchEvent):void 
		{
			if (e.getTouch(deleteProject, TouchPhase.ENDED))
			{
				for ( var i : int = 0; i < list.dataProvider.length; i++) {
					var obj : Object = list.dataProvider.getItemAt(i);
					obj.accessory.visible  = !obj.accessory.visible;
				}	
			}
		}
		
		private function onProjectAdded(e:Event):void 
		{
			SharedObjectManager.setCurrentProject(SharedObjectManager.getCurrentUser().projects.length - 1);
			list.dataProvider = getListCollection(); //new
			list.invalidate(); //new
			//dispatchEventWith(SHOW_OVERVIEW); //old
		}
		
		private function OnNewProjectTouch(e:TouchEvent):void 
		{
			if (e.getTouch(NewProject, TouchPhase.ENDED))
			{
				PopUpManager.addPopUp(NewProjectPopup);
			}
		}
		
		private function setListCollection():void 
		{
			listData = new ListCollection();
			
			for each (var i:Object in SharedObjectManager.getCurrentUser().projects)
			{
				
				var item 	: Object = { Name: i.name };
				var button 	: Button = new Button();
				button.styleNameList.add("TrashCan");
				button.validate();
				button.width *= 1.33;
				
				
				button.addEventListener(TouchEvent.TOUCH, ClickRemoveProject);
				item.accessory = button;
				item.accessory.visible = true;
				
				listData.addItem(item);
			}
		}
		
		private function getListCollection():ListCollection  //new
		{
			var listData:ListCollection = new ListCollection();
			
			for each (var i:Object in SharedObjectManager.getCurrentUser().projects)
			{
				
				var item 	: Object = { Name: i.name };
				var button 	: Button = new Button();
				button.styleNameList.add("TrashCan");
				button.validate();
				button.width *= 1.33;
				
				
				button.addEventListener(TouchEvent.TOUCH, ClickRemoveProject);
				item.accessory = button;
				item.accessory.visible = true;
				
				listData.addItem(item);
			}
			
			return listData
		}
		
		private function ClickRemoveProject(e:TouchEvent):void 
		{
			var button : Button = Button(e.currentTarget);
			if ( e.getTouch( button, TouchPhase.ENDED ) ) {
				
				del = new ConfirmDelete((button.parent as DefaultListItemRenderer).index, "project");
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
			SharedObjectManager.deleteProject(data);
		}
		
		private function OnDeleteCancled(e:Event):void 
		{
			
			del.removeEventListeners(ConfirmDelete.CANCEL);
			del.removeEventListeners(ConfirmDelete.DELETE);
		}
		
		
		private function list_changeHandler(e:Event):void 
		{
			var list:List = List( e.currentTarget );
			trace( "selectedIndex:", list.selectedIndex );
			SharedObjectManager.setCurrentProject(list.selectedIndex);
			dispatchEventWith(SHOW_GETSTARTED);
			trace("show")
		}
		
		private function OnTransitionInComplete(e:Event):void 
		{
			SharedObjectManager.setCurrentProject( -1);
			trace("Screen: ProjectSelect");
		}
		
	}

}