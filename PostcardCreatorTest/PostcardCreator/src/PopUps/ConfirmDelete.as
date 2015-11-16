package PopUps 
{
	import feathers.controls.Button;
	import feathers.controls.Panel;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.HorizontalLayoutData;
	import feathers.layout.VerticalLayout;
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
	public class ConfirmDelete extends Sprite
	{
		public static const DELETE:String = "DELETE";
		public static const CANCEL:String = "CANCEL";
		
		private var Delete:Button;
		private var Cancel:Button;
		
		private var overlay:Quad;
		
		private var index:int;
		
		public function ConfirmDelete(Index:int, toDelete:String) 
		{
			index = Index;
			
			overlay = new Quad( Utilities.GetScaledX(1), Utilities.GetScaledY(1), 0x00000 );
			overlay.alpha = 0;
			overlay.addEventListener(TouchEvent.TOUCH, onBackgroundTouch);
			
			var panel:Panel = new Panel();
			panel.styleNameList.add("Popup");
			panel.title = "Are you sure you wish to delete this " + toDelete + "?"; 
			
			var layout:HorizontalLayout = new HorizontalLayout();
			layout.padding = 20;
			layout.gap = 20;
			layout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
			layout.verticalAlign = HorizontalLayout.VERTICAL_ALIGN_JUSTIFY;
			
			panel.layout = layout;
			
			var buttonLayoutData:HorizontalLayoutData = new HorizontalLayoutData();
			buttonLayoutData.percentWidth = 50;
			
			
			Delete = new Button();
			Delete.label = "Delete";
			Delete.addEventListener(TouchEvent.TOUCH, onDeleteTouched);
			Delete.layoutData = buttonLayoutData;
			Delete.validate();
			Delete.alignPivot();
			
			Cancel = new Button();
			Cancel.label = "Cancel";
			Cancel.addEventListener(TouchEvent.TOUCH, onCancelTouched);
			Cancel.layoutData = buttonLayoutData;
			Cancel.validate();
			Cancel.alignPivot();
			
			
			panel.addChild(Delete);
			panel.addChild(Cancel);
			
			
			panel.validate();
			panel.alignPivot();
			panel.x = Utilities.GetScaledX(0.5);
			panel.y = Utilities.GetScaledY(0.5);
			
			addChild(overlay);
			addChild(panel);
			
		}
		
		private function onCancelTouched(e:TouchEvent):void 
		{
			if (e.getTouch(Cancel, TouchPhase.ENDED))
			{
				this.removeFromParent();
				dispatchEventWith(CANCEL);
			}
		}
		
		private function onBackgroundTouch(e:TouchEvent):void 
		{
			if (e.getTouch(overlay, TouchPhase.ENDED))
			{
				this.removeFromParent();
				dispatchEventWith(CANCEL);
			}
		}
		
		private function onDeleteTouched(e:TouchEvent):void 
		{
			if (e.getTouch(Delete, TouchPhase.ENDED))
			{
				this.removeFromParent();
				dispatchEventWith(DELETE, false, index );
			}
		}
		
	}

}