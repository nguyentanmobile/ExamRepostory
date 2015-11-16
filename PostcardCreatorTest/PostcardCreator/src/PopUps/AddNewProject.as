package PopUps 
{
	import feathers.controls.Button;
	import feathers.controls.Panel;
	import feathers.controls.TextInput;
	import feathers.layout.VerticalLayout;
	import Screens.UserSelect;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import StoredObject.SharedObjectManager;
	import Utils.Utilities;
	/**
	 * ...
	 * @author ...
	 */
	public class AddNewProject extends Sprite
	{
		private var Cancel:Button;
		private var Add:Button;
		private var input:TextInput;
		private var overlay:Quad;
		
		public static const PROJECT_ADDED:String = "ProjectAdded";
		public static const CANCLED:String = "Cancled";
		
		public function AddNewProject() 
		{
			
			overlay = new Quad( Utilities.GetScaledX(1), Utilities.GetScaledY(1), 0x00000 );
			overlay.alpha = 0;
			overlay.addEventListener(TouchEvent.TOUCH, onBackgroundTouch);
			
			
			var panel:Panel = new Panel();
			panel.styleNameList.add("Popup");
			panel.title = "Title Your New Project";
			
			var layout:VerticalLayout = new VerticalLayout();
			layout.padding = 20;
			layout.gap = 20;
			layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			layout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_MIDDLE;
			panel.layout = layout;
			
			
			input = new TextInput();
			input.styleNameList.add("PopupInput");
			input.prompt = "Project Name";
			input.width = Utils.Utilities.GetScaledX(0.35);
			input.validate();
			input.alignPivot();
			input.maxChars = 100;
			
			Add = new Button();
			Add.label = "Add";
			Add.addEventListener(TouchEvent.TOUCH, onAddTouched);
			Add.width = Utils.Utilities.GetScaledX(0.2);
			Add.validate();
			Add.alignPivot();
			
			panel.addChild( input );
			panel.addChild(Add);
			panel.validate();
			panel.alignPivot();
			panel.x = Utilities.GetScaledX(0.5);
			panel.y = Utilities.GetScaledY(0.5);
			
			addChild(overlay);
			addChild(panel);
			
		}
		
		private function onBackgroundTouch(e:TouchEvent):void 
		{
			if (e.getTouch(overlay, TouchPhase.ENDED))
			{
				this.removeFromParent();
			}
		}
		
		private function onAddTouched(e:TouchEvent):void 
		{
			if (e.getTouch(Add, TouchPhase.ENDED))
			{
				if (input.text != "")
				{
					SharedObjectManager.addProject(input.text);
					removeFromParent();
					this.dispatchEventWith(PROJECT_ADDED);
				}
			}
		}
		
	}

}