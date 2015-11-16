package Screens 
{
	import feathers.controls.Button;
	import feathers.controls.Panel;
	import feathers.controls.Screen;
	import feathers.controls.TextInput;
	import feathers.events.FeathersEventType;
	import feathers.layout.VerticalLayout;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import StoredObject.SharedObjectManager;
	import Utils.Utilities;
	
	/**
	 * ...
	 * @author NGUYEN NGOC TAN
	 */
	public class GetStarted extends Screen 
	{
		public static const SHOW_EDITOR_SCREEN:String = "showEditorScreen";
		
		private var next:Button;
		private var inputBox:TextInput;
		
		public function GetStarted() 
		{
			super();
			initValue();
		}
		
		private function initValue():void 
		{
			var panel:Panel = new Panel();
			panel.styleNameList.add("Popup");
			panel.title = "Title Your Get Started";
			
			var layout:VerticalLayout = new VerticalLayout();
			layout.padding = 20;
			layout.gap = 20;
			layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			layout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_MIDDLE;
			panel.layout = layout;
			
			
			inputBox = new TextInput();
			inputBox.styleNameList.add("PopupInput");
			inputBox.prompt = "Get stated Name";
			inputBox.width = Utils.Utilities.GetScaledX(0.35);
			inputBox.validate();
			inputBox.alignPivot();
			inputBox.maxChars = 100;
			
			next = new Button();
			next.label = "Next";
			next.addEventListener(TouchEvent.TOUCH, onAddTouched);
			next.width = Utils.Utilities.GetScaledX(0.2);  
			next.validate();
			next.alignPivot();
			
			panel.addChild( inputBox );
			panel.addChild(next);
			panel.validate();
			panel.alignPivot();
			panel.x = Utilities.GetScaledX(0.5);
			panel.y = Utilities.GetScaledY(0.5);			
			
			addChild(panel);
			trace("addChildpanle")
			this.addEventListener(FeathersEventType.TRANSITION_IN_COMPLETE, OnTransitionInComplete);
		}
		
		private function onAddTouched(e:TouchEvent):void 
		{
			if (e.getTouch(next, TouchPhase.ENDED))
			{
				//trace("dispatch")
				
				dispatchEventWith(SHOW_EDITOR_SCREEN);
			}
		}
		private function OnTransitionInComplete(e:Event):void 
		{
			//SharedObjectManager.setCurrentProject( -1);
			trace("Screen: GetStarted");
		}
		
	}

}