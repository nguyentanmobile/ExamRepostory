package Screens 
{
	import com.milkmangames.nativeextensions.events.GVMailEvent;
	import com.milkmangames.nativeextensions.GoViral;
	import Controls.InfoPanel;
	import Controls.LowerBar;
	import feathers.controls.Button;
	import feathers.controls.Callout;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.motion.Flip;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display3D.Context3D;
	import flash.events.ErrorEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.setTimeout;
	import PostcardLayouts.ReviewPostcard;
	import PostcardLayouts.ReviewPostcardPicture;
	import starling.core.RenderSupport;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import StoredObject.SharedObjectManager;
	import Utils.Utilities;
	
	if (CONFIG::air)
	{
		import flash.media.CameraRoll;
	}
	else
	{
		import flash.net.FileReference;
		import flash.printing.PrintJob;
		import flash.printing.PrintJobOptions;
		import flash.printing.PrintJobOrientation;
	}
	
	/**
	 * ...
	 * @author ...
	 */
	public class Review extends Screen
	{
		public static const SHOW_POSTCARDBACK:String = "show_Back";
		public static const SHOW_PROJECT:String = "show_ProjectSelect";
		
		private var title:Label;
		private var saveImage:Button;
		private var back:Button;
		private var postcard:PostcardLayouts.ReviewPostcard;
		private var email:Button;
		private var _navigator:ScreenNavigator;
		private var postcardFront:ReviewPostcardPicture;
		private var flip:Button;
		private var panel:InfoPanel;
		
		public function Review() 
		{
			super();
			
			
			
			title = new Label();
			title.text = "Postcard Review";
			title.x = Utils.Utilities.GetScaledX(0.05);
			title.y = Utils.Utilities.GetScaledY(0.05);
			addChild(title);
			
			var lowerBar:Controls.LowerBar = new Controls.LowerBar("");
			addChild(lowerBar);
			
			panel = new InfoPanel(Utils.Utilities.GetScaledX(0.10));
			panel.x = Utils.Utilities.GetScaledX(0.025);
			panel.y = Utils.Utilities.GetScaledY(0.1)
			
			
			panel.addtext("Tap on the stamp to rotate it if you want.");
			addChild(panel);
			
			this._navigator = new ScreenNavigator();
			this.addChild( this._navigator );
			
			_navigator.x = Utils.Utilities.GetScaledX(0.2);
			_navigator.y = Utils.Utilities.GetScaledY(0.05);
			
			postcard = new ReviewPostcard(Utils.Utilities.GetScaledX(0.75), Utils.Utilities.GetScaledY(0.6));
			postcardFront = new ReviewPostcardPicture(Utils.Utilities.GetScaledX(0.75), Utils.Utilities.GetScaledY(0.6));
			
			var _postcardBack:ScreenNavigatorItem = new ScreenNavigatorItem( postcard );
			this._navigator.addScreen( "Back", _postcardBack );
			
			var _postcardFront:ScreenNavigatorItem = new ScreenNavigatorItem( postcardFront );
			this._navigator.addScreen( "Front", _postcardFront );
			
			
			this._navigator.showScreen( "Back" );
			
			
			flip = new Button();
			flip.label = "Flip";
			flip.styleNameList.add("Next");
			flip.addEventListener( TouchEvent.TOUCH, onFlipTouched );
			flip.width = Utils.Utilities.GetScaledX(0.2);
			flip.validate();
			flip.alignPivot();
			flip.x = Utils.Utilities.GetScaledX(0.6);
			flip.y = Utils.Utilities.GetScaledY(0.7);
			
			addChild(flip);
			
			
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
			
			saveImage = new Button();
			
			if (CONFIG::air)
			{
				saveImage.label = "Save Image";
			}
			else
			{
				saveImage.label = "Print";
			}
			addChild(saveImage);
			saveImage.addEventListener( TouchEvent.TOUCH, onSaveImageTouched );
			saveImage.width = Utils.Utilities.GetScaledX(0.2);
			saveImage.validate();
			saveImage.alignPivot();
			saveImage.x = Utils.Utilities.GetScaledX(0.875);
			saveImage.y = Utils.Utilities.GetScaledY(0.8);
			
			
			
			//if (CONFIG::air && GoViral.isSupported() && GoViral.goViral.isEmailAvailable())
			{
				email = new Button();
				email.label = "Send as Email";
				addChild(email);
				email.addEventListener( TouchEvent.TOUCH, onEmailTouched );
				email.width = Utils.Utilities.GetScaledX(0.2);
				email.validate();
				email.alignPivot();
				email.x = Utils.Utilities.GetScaledX(0.65);
				email.y = Utils.Utilities.GetScaledY(0.8);
			}
		}
		
		private function onFlipTouched(e:TouchEvent):void 
		{
			if ( e.getTouch( flip, TouchPhase.ENDED ) )
			{
				if (_navigator.activeScreenID == "Front")
				{
					toBack();
				}
				else
					toFront();
			}
		}
		
		private function toBack():void 
		{
			this._navigator.transition = Flip.createFlipRightTransition();
			this._navigator.showScreen( "Back" );
		}
		
		private function toFront():void 
		{
			this._navigator.transition = Flip.createFlipRightTransition();
			this._navigator.showScreen( "Front" );
		}
		
		private function onEmailTouched(e:TouchEvent):void 
		{
			if ( e.getTouch( email, TouchPhase.ENDED ) )
			{
				GoViral.goViral.showEmailComposerWithBitmap(
				"Check out my Postcard!",
				"",
				"I made this with the <a href=\"http://www.readwritethink.org/classroom-resources/student-interactives/postcard-creator-30061.html\">Postcard Creator App</a>&nbsp;from <a href=\"http://www.readwritethink.org/\">ReadWriteThink.org</a>!",
				true,
				GetFrontAndBack(),
				SharedObjectManager.getCurrentUser().name);
				
				GoViral.goViral.addEventListener(GVMailEvent.MAIL_CANCELED, onMailEvent);
				GoViral.goViral.addEventListener(GVMailEvent.MAIL_FAILED, onMailEvent);
				GoViral.goViral.addEventListener(GVMailEvent.MAIL_SAVED,onMailEvent);
				GoViral.goViral.addEventListener(GVMailEvent.MAIL_SENT, onMailEvent);
			}
		}
		
		private function onMailEvent(e:GVMailEvent):void
		{
			switch(e.type)
			{
				case GVMailEvent.MAIL_CANCELED:
					break;
				case GVMailEvent.MAIL_FAILED:
					break;
				case GVMailEvent.MAIL_SAVED:
					break;
				case GVMailEvent.MAIL_SENT:
					break;
			}
		}
		
		private function onSaveImageTouched(e:TouchEvent):void 
		{
			if ( e.getTouch( saveImage, TouchPhase.ENDED ) )
			{
				if (CONFIG::air)
				{
					if (CameraRoll.supportsAddBitmapData)
					{
						
						var cameraRoll:CameraRoll = new CameraRoll();
						cameraRoll.addEventListener(ErrorEvent.ERROR, onCameraRollError);
						cameraRoll.addEventListener(flash.events.Event.COMPLETE, onCameraRollComplete);
						cameraRoll.addBitmapData(GetFront());
					}
					else
					{
						var label:Label = new Label();
						label.text = "not supported.";
						label.wordWrap = true;
						label.width = Utils.Utilities.GetScaledX(0.25);
						Callout.show( label, saveImage, Callout.DIRECTION_UP );
					}
				}
				else
				{
					var printJob:PrintJob = new PrintJob();
					var displayObject:Sprite = new Sprite();
					printJob.start();
					displayObject.addChild(new Bitmap(GetFront()));//TODO: TAN REPEAR
					if (printJob.orientation != null)
					{
						displayObject.rotation = 90;
						printJob.addPage(displayObject);
						printJob.send();
					}
				}
				
			}
		}
		
		private function onCameraRollComplete(e:flash.events.Event):void 
		{
			var label:Label = new Label();
			label.text = "Saved";
			label.wordWrap = true;
			var c:Callout = Callout.show( label, saveImage, Callout.DIRECTION_UP );
			
			setTimeout(c.close, 1000, true);
			
		}
		
		private function onCameraRollError(e:Event):void 
		{
			var label:Label = new Label();
			label.text = "Access error";
			label.wordWrap = true;
			Callout.show( label, saveImage, Callout.DIRECTION_UP );
		}
		
		private function onBackTouched(e:TouchEvent):void 
		{
			if ( e.getTouch( back, TouchPhase.ENDED ) )
			{
				this.dispatchEventWith( SHOW_POSTCARDBACK );
			}
		}
		
		public function copyAsBitmapData(displayObject : DisplayObject, resultRect : Rectangle = null , OrthographicProjection : Rectangle = null):BitmapData 
		{
			if (displayObject == null) return null;
				
			var context : Context3D 	= Starling.context;
			var support : RenderSupport = new RenderSupport();
			RenderSupport.clear();
			support.resetMatrix();
			support.setProjectionMatrix(OrthographicProjection.x,OrthographicProjection.y,OrthographicProjection.width, OrthographicProjection.height, Starling.current.stage.width, Starling.current.stage.height);
			support.transformMatrix(displayObject);
			support.translateMatrix( resultRect.x, resultRect.y);
			//var scale:Number = Math.min(resultRect.width / OrthographicProjection.width, resultRect.height / OrthographicProjection.height);
			//support.scaleMatrix(scale, scale);
			var result:BitmapData = new BitmapData(resultRect.width, resultRect.height, true);
			support.pushMatrix();

			support.blendMode = displayObject.blendMode;
			support.transformMatrix(displayObject);
			displayObject.render(support, 1.0);
			support.popMatrix();
			support.finishQuadBatch();
	
			context.drawToBitmapData(result);
			//context.present();
			return result;
		}
		
		public function GetFrontAndBack():BitmapData
		{
			var sprite:starling.display.Sprite = new starling.display.Sprite();
			
			var p1:ReviewPostcard = new ReviewPostcard(Utils.Utilities.GetScaledX(0.6), Utils.Utilities.GetScaledY(0.48));
			var p2:ReviewPostcardPicture = new ReviewPostcardPicture(Utils.Utilities.GetScaledX(0.6), Utils.Utilities.GetScaledY(0.48));
			
			sprite.addChild(p1);
			sprite.addChild(p2);
			p2.y = -p1.height;
			
			return copyAsBitmapData(sprite, new Rectangle( 0, p1.height *1.2, p1.width, p1.height *2), new Rectangle(0, 0, Starling.current.stage.width, Starling.current.stage.height));
		}
		
		public function GetFront():BitmapData
		{
			return copyAsBitmapData(postcard, new Rectangle( 0, postcard.height * 0.8, postcard.width, postcard.height), new Rectangle(0, 0, Starling.current.stage.width, Starling.current.stage.height));
		}
		
	}

}