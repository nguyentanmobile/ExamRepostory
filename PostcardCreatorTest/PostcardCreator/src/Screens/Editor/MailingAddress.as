package Screens.Editor 
{
	import Controls.InfoPanel;
	import Controls.LowerBar;
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Panel;
	import feathers.controls.Screen;
	import feathers.controls.TextInput;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import StoredObject.SharedObjectManager;
	import Utils.Utilities;
	
	/**
	 * ...
	 * @author ...
	 */
	public class MailingAddress extends Screen 
	{
		public static var SHOW_PROJECT:String = "showProjectSelect";
		public static var SHOW_DESCRIPTION:String = "showDescription";
		
		private static var newLine:String = "\n";
		private static var tab:String = "\t";
		
		private var back:Button;
		private var title:Label;
		private var panel:InfoPanel;
		private var instructions:Label;
		private var inputTitle:Label;
		private var inputMailingAddress:TextInput;
		private var next:Button;
		
		public function MailingAddress() 
		{
			super();
			
			title = new Label();
			title.text = "Mailing Address";
			title.x = Utils.Utilities.GetScaledX(0.05);
			title.y = Utils.Utilities.GetScaledY(0.05);
			addChild(title);
			
			var lowerBar:Controls.LowerBar = new Controls.LowerBar("Type the name and address of the person who will receive the postcard.");
			addChild(lowerBar);
			
			//panel.height = Utils.Utilities.GetScaledY(0.625);
			//panel.title = "Instructions";
			
			/*instructions = new Label();
			instructions.wordWrap = true;
			var text:String = "Type the name and address of the person or people who will reveice the postcard.  The address appears on the lower right part of the postcard."+ newLine + 
			newLine +
			"General address format:" + newLine  +
			tab + "Person's name" + newLine +
			tab + "Street Address" + newLine +
			tab + "City, State Zip" + newLine +
			newLine +
			"Example address:" + newLine +
			tab + "Walter Lee Younger" + newLine +
			tab + "406 Clybourne Street" + newLine +
			tab + "Clybourne Park, 62865" + newLine;
			
			instructions.width = Utils.Utilities.GetScaledX(0.25);
			*/
			
			panel = new InfoPanel(Utils.Utilities.GetScaledX(0.25));
			panel.x = Utils.Utilities.GetScaledX(0.025);
			panel.y = Utils.Utilities.GetScaledY(0.1);
			
			
			panel.addtext("The address will appear on the lower right part of the postcard.");
			panel.addtext("General address format:<br>Person's name<br>Street Address<br>City, State Zip");
			addChild(panel);
			
			
			inputTitle = new Label();
			inputTitle.text = "Mailing Address";
			inputTitle.x = Utils.Utilities.GetScaledX(0.42);
			inputTitle.y = Utils.Utilities.GetScaledY(0.05);
			addChild(inputTitle);
			
			
			inputMailingAddress = new TextInput();
			inputMailingAddress.x = Utils.Utilities.GetScaledX(0.42);
			inputMailingAddress.y = Utils.Utilities.GetScaledY(0.1);
			inputMailingAddress.width = Utils.Utilities.GetScaledX(0.5);
			inputMailingAddress.height = Utils.Utilities.GetScaledY(0.625);
			addChild(inputMailingAddress);
			inputMailingAddress.addEventListener(Event.CHANGE, inputMailingAddress_change);
			inputMailingAddress.verticalAlign = TextInput.VERTICAL_ALIGN_TOP;
			inputMailingAddress.text = SharedObjectManager.getCurrentProject().mailingAddress;
			
			
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
				dispatchEventWith(SHOW_DESCRIPTION);
			}
		}
		
		private function inputMailingAddress_change(e:Event):void 
		{
			SharedObjectManager.getCurrentProject().mailingAddress = inputMailingAddress.text;
		}
		
		private function onBackTouched(e:TouchEvent):void 
		{
			if ( e.getTouch( back, TouchPhase.ENDED ) )
			{
				dispatchEventWith(SHOW_PROJECT);
			}
		}
		
	}

}