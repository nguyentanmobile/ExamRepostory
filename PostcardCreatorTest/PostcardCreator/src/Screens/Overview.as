package Screens 
{
	import Controls.InfoPanel;
	import Controls.LowerBar;
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Panel;
	import feathers.controls.Screen;
	import feathers.controls.TextInput;
	import flash.events.Event;
	import PostcardLayouts.OverviewPostcard;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import StoredObject.SharedObjectManager;
	import Utils.Utilities;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Overview extends Screen 
	{
		public static const SHOW_MAILINGADDRESS:String = "show_MailingAddress";
		public static const SHOW_PROJECT:String = "show_ProjectSelect";
		
		private var title:Label;
		private var panel:InfoPanel;
		private var instructions:Label;
		private var postcard:PostcardLayouts.OverviewPostcard;
		private var next:Button;
		private var back:Button;
		
		public function Overview() 
		{
			super();
			
			title = new Label();
			title.text = "Postcard Overview";
			title.x = Utils.Utilities.GetScaledX(0.025);
			title.y = Utils.Utilities.GetScaledY(0.05);
			addChild(title);
			
			panel = new InfoPanel(Utils.Utilities.GetScaledX(0.10));
			panel.x = Utils.Utilities.GetScaledX(0.02);
			panel.y = Utils.Utilities.GetScaledY(0.05);
			
			
			panel.addtext("Tap on each area of the postcard to learn more.");
			panel.addtext("Tap the <b>Next</b> button to start writing your own postcard.");
			addChild(panel);
			
			/*panel = new Panel();
			panel.x = Utils.Utilities.GetScaledX(0.025);
			panel.y = Utils.Utilities.GetScaledY(0.1);
			panel.height = Utils.Utilities.GetScaledY(0.625);
			panel.title = "Instructions";
			
			instructions = new Label(); 
			instructions.wordWrap = true;
			
			instructions.text = "Move your mouse to highlight the parts of the postcard. Clock the Next button at the bottom when you are ready to write your own postcard";
			instructions.width = Utils.Utilities.GetScaledX(0.25);
			
			panel.addChild(instructions);
			instructions.validate();
			addChild( panel );
			panel.validate();*/
			
			
			
			postcard = new PostcardLayouts.OverviewPostcard(Utils.Utilities.GetScaledX(0.975) - (Utils.Utilities.GetScaledX(0.025) + Utils.Utilities.GetScaledX(0.18) + Utils.Utilities.GetScaledX(0.025)), Utils.Utilities.GetScaledY(0.625));
			addChild(postcard);
			postcard.x = Utils.Utilities.GetScaledX(0.025) + Utils.Utilities.GetScaledX(0.18) + Utils.Utilities.GetScaledX(0.025);
			postcard.y = Utils.Utilities.GetScaledY(0.05);
			
			var lowerBar:Controls.LowerBar = new Controls.LowerBar("An example postcard.");
			addChild(lowerBar);
			
			back = new Button();
			back.label = "Back";
			back.styleNameList.add("Back");
			back.addEventListener( TouchEvent.TOUCH, onBackTouched );
			back.width = Utils.Utilities.GetScaledX(0.2);
			back.validate();
			back.alignPivot();
			back.x = Utils.Utilities.GetScaledX(0.125);
			back.y = Utils.Utilities.GetScaledY(0.8);
			
			addChild(back);
			
			
			
			next = new Button();
			next.label = "Next";
			next.styleNameList.add("Next");
			addChild(next);
			next.addEventListener( TouchEvent.TOUCH, onNextTouched );
			next.width = Utils.Utilities.GetScaledX(0.2);
			next.validate();
			next.alignPivot();
			next.x = Utils.Utilities.GetScaledX(0.875);
			next.y = Utils.Utilities.GetScaledY(0.8);
			
			
		}
		
		private function onNextTouched(e:TouchEvent):void 
		{
			if ( e.getTouch( next, TouchPhase.ENDED ) )
			{
				
				this.dispatchEventWith( SHOW_MAILINGADDRESS );
			}
		}
		
		private function onBackTouched(e:TouchEvent):void 
		{
			if ( e.getTouch( back, TouchPhase.ENDED ) )
			{
				this.dispatchEventWith( SHOW_PROJECT );
			}
		}
		
	}

}