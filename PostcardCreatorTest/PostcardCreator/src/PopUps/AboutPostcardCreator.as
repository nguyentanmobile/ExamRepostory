package PopUps 
{
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Panel;
	import feathers.controls.TextInput;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import Utils.Utilities;
	/**
	 * ...
	 * @author ...
	 */
	public class AboutPostcardCreator extends Sprite
	{
		private var Continue:Button;
		private var body:Label;
		private var overlay:Quad;
		
		public function AboutPostcardCreator() 
		{
			overlay = new Quad( Utilities.GetScaledX(1), Utilities.GetScaledY(1), 0x00000 );
			overlay.alpha = 0;
			overlay.addEventListener(TouchEvent.TOUCH, onBackgroundTouch);
			
			
			var panel:Panel = new Panel();
			panel.styleNameList.add("Popup");
			panel.title = "About Postcard Creator";
			
			var layout:VerticalLayout = new VerticalLayout();
			layout.padding = 20;
			layout.gap = 20;
			layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			layout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_MIDDLE;
			panel.layout = layout;
			
			
			body = new Label();
			body.styleNameList.add("dark-label");
			body.text = "In this activity, you'll learn how to write and correctly format a postcard. Once finished, you'll be able to save it or send it by mail.";
			body.width = Utils.Utilities.GetScaledX(0.4);
			body.wordWrap = true;
			body.validate();
			
			
			Continue = new Button();
			Continue.label = "Continue";
			Continue.addEventListener(TouchEvent.TOUCH, onContinueTouched);
			Continue.width = Utils.Utilities.GetScaledX(0.2);
			Continue.validate();
			Continue.width = Utils.Utilities.GetScaledX(0.2);
			
			panel.addChild( body);
			panel.addChild(Continue);
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
		
		private function onContinueTouched(e:TouchEvent):void 
		{
			if (e.getTouch(Continue, TouchPhase.ENDED))
			{
				this.removeFromParent();
			}
		}
	}

}