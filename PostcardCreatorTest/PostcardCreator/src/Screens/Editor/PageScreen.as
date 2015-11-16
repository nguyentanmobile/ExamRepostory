package Screens.Editor 
{
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.core.PopUpManager;
	import PopUps.PageScreenPopUp;
	import starling.display.Quad;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import Utils.Utilities;
	
	/**
	 * ...
	 * @author NGUYEN NGOC TAN
	 */
	public class PageScreen extends Screen 
	{
		public static var NEXT:String = "next";
		public static var BACK:String = "back";
		
		private var ID:int;
		
		private var back:Button;
		private var next:Button;
		
		private var tip:Button;
		private var quab:Quad;
		public function PageScreen(ID:int = 0) 
		{
			super();
			this.ID = ID;
			
			initValue();
			initEvent();
		}
		
		
		
		private function initValue():void 
		{
			
			quab =  new Quad(Utilities.GetScaledX(0.5), Utilities.GetScaledX(0.25), 0xffffff);
			quab.pivotX = quab.width / 2;
			quab.pivotY = quab.height / 2;
			quab.x = Utilities.GetScaledX(0.5);
			quab.y = Utilities.GetScaledX(0.2);
			addChild(quab);
			
			var pageNumber:Label = new Label();
			pageNumber.text = (ID + 1) + " of 6";
			addChild(pageNumber);
			pageNumber.validate();
			pageNumber.alignPivot();
			pageNumber.x = Utilities.GetScaledX(0.5);
			pageNumber.y = Utilities.GetScaledY(0.775);
			
			back = new Button();
			back.label = "Back";
			
			back.width = Utilities.GetScaledX(0.2);
			back.validate();
			back.alignPivot();
			back.x = Utilities.GetScaledX(0.125);
			back.y = Utilities.GetScaledY(0.775);
			addChild(back);
			
			next = new Button();
			next.label = "Next";
			
			if (ID == 5)
			{
				next.label = "Finish";
			}
			
			
			next.width = Utilities.GetScaledX(0.2);
			next.validate();
			next.alignPivot();
			next.x = Utilities.GetScaledX(0.875);
			next.y = Utilities.GetScaledY(0.775);
			addChild(next);
			
			tip = new Button();
			tip.label = "Tip";
			tip.width = Utilities.GetScaledX(0.1);
			tip.height = Utilities.GetScaledX(0.05);
			tip.x = Utilities.GetScaledX(0.5) + quab.width / 2 -tip.width;
			tip.y = quab.y + quab.height / 2 -tip.height ;
			
			addChild(tip);
			
			
		}
		
		private function initEvent():void 
		{
			back.addEventListener( TouchEvent.TOUCH, onTouched );
			next.addEventListener( TouchEvent.TOUCH, onTouched );
			tip.addEventListener(TouchEvent.TOUCH, onTouched);
		}
		
		private function onTouched(e:TouchEvent):void 
		{
			if (e.getTouch(next, TouchPhase.ENDED))
			{
				dispatchEventWith(NEXT);
				
			}else if (e.getTouch(back, TouchPhase.ENDED))
			{
				dispatchEventWith(BACK);
				
			}else if (e.getTouch(tip, TouchPhase.ENDED))
			{
				PopUpManager.addPopUp(new PageScreenPopUp());
				
			}
			
			
		}
		
		
		
	}

}