package Screens.Editor 
{
	import Controls.InfoPanel;
	import Controls.LowerBar;
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.controls.Panel;
	import feathers.controls.Screen;
	import feathers.layout.TiledRowsLayout;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.PixelSnapping;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.MediaEvent;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.media.CameraRoll;
	import flash.media.MediaPromise;
	import flash.utils.ByteArray;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import StoredObject.SharedObjectManager;
	import Utils.AssetsManager;
	import Utils.Utilities;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Stamp extends Screen 
	{
		public static const SHOW_BACK:String = "show_Back";
		public static const SHOW_MESSAGE:String = "show_message";
		
		private var title:Label;
		private var next:Button;
		private var back:Button;
		private var panel:InfoPanel;
		private var instructions:Label;
		private var container:LayoutGroup;
		private var imageList:Array;
		private var imgBtn:Button;
		private var cr:CameraRoll;
		private var loader:Loader;
		private var lowerBar:Controls.LowerBar;
		private var uploadedImage:Image;
		
		public function Stamp() 
		{
			super();
			
			title = new Label();
			title.text = "Postcard Stamp";
			title.x = Utils.Utilities.GetScaledX(0.05);
			title.y = Utils.Utilities.GetScaledY(0.05);
			addChild(title);
			
			lowerBar = new Controls.LowerBar("");
			addChild(lowerBar);
			
			
			panel = new InfoPanel(Utils.Utilities.GetScaledX(0.18));
			panel.x = Utils.Utilities.GetScaledX(0.025);
			panel.y = Utils.Utilities.GetScaledY(0.1);
			
			
			panel.addtext("Tap on the stamp that you want to use on your postcard.");
			addChild(panel);
			
			
			
			var layout:TiledRowsLayout = new TiledRowsLayout();
			layout.paddingTop = 0;
			layout.paddingRight = 0;
			layout.paddingBottom = 0;
			layout.paddingLeft = 0;
			layout.horizontalGap = 10;
			layout.verticalGap = 10;
			layout.horizontalAlign = TiledRowsLayout.HORIZONTAL_ALIGN_LEFT;
			layout.verticalAlign = TiledRowsLayout.VERTICAL_ALIGN_TOP;
			layout.tileHorizontalAlign = TiledRowsLayout.TILE_HORIZONTAL_ALIGN_CENTER;
			layout.tileVerticalAlign = TiledRowsLayout.TILE_VERTICAL_ALIGN_MIDDLE;
			
			layout.requestedColumnCount = 5;
			
			container = new LayoutGroup();
			container.layout = layout;
			this.addChild( container );
			
			container.x = Utils.Utilities.GetScaledX(0.30);
			container.y = Utils.Utilities.GetScaledY(0.1);
			
			imageList = new Array();
			var texture:Texture;
			for(var i:int = 0; i < AssetsManager.getStamps().length; i++)
			{
				texture = AssetsManager.getStamps()[i];
				var image:Image = new Image(texture);
				image.width = Utils.Utilities.GetScaledX(0.1);
				image.scaleY = image.scaleX;
				container.addChild( image );
				imageList.push(image);
				image.addEventListener(TouchEvent.TOUCH, onImageSelected);
				
				if (i == SharedObjectManager.getCurrentProject().stamp)
					image.alpha = 1;
				else
					image.alpha = 0.5;
			}
			
			
			var stampimageData:ByteArray = SharedObjectManager.getCurrentProject().stampimageData;
			if (stampimageData != null)
			{
				
				var rect:Rectangle = new Rectangle(0,0, SharedObjectManager.getCurrentProject().stampimagerect.width,
														SharedObjectManager.getCurrentProject().stampimagerect.height);
				
				var bitmapData:BitmapData = new BitmapData(rect.width, rect.height);
				stampimageData.position = 0;
				bitmapData.setPixels(rect, stampimageData);
				
				var bitmap:Bitmap = new Bitmap(bitmapData);
				var _texture:Texture = Texture.fromBitmap(bitmap);
				uploadedImage = new Image(_texture);
				
				uploadedImage.width =  Utils.Utilities.GetScaledX(0.1);
				uploadedImage.scaleY = uploadedImage.scaleX;
				container.addChild(uploadedImage);
				uploadedImage.addEventListener(TouchEvent.TOUCH, onUploadedImageTouched);
			}
			
			
			container.validate();
			
			//if (CameraRoll.supportsBrowseForImage)
			//{
				imgBtn = new Button();
				imgBtn.label = "From Camera";
				imgBtn.addEventListener( TouchEvent.TOUCH, onCameraTouched );
				imgBtn.width = Utils.Utilities.GetScaledX(0.2);
				imgBtn.validate();
				imgBtn.alignPivot();
				imgBtn.x = Utils.Utilities.GetScaledX(0.5);
				imgBtn.y = Utils.Utilities.GetScaledY(0.8);
				
				addChild(imgBtn);
			//}
			
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
		
		private function onCameraTouched(e:TouchEvent):void 
		{
			if (CameraRoll.supportsBrowseForImage)
			{
				cr = new CameraRoll();
				cr.browseForImage();
				addBrowseListeners();
			}
		}
		
		
		private function onImageSelected(e:TouchEvent):void 
		{
			var img:Image = e.target as Image;
			if (e.getTouch(img, TouchPhase.ENDED))
			{
				trace("Selected, " + container.getChildIndex(img));
				SharedObjectManager.getCurrentProject().stamp = container.getChildIndex(img);
				
				for (var i:int = 0; i < imageList.length; i++) {
					if (imageList[i] != img) {
						Image(imageList[i]).alpha = 0.5;
					} else {
						Image(imageList[i]).alpha = 1;
					}
				}
				if (uploadedImage != null)
				{
					uploadedImage.alpha = 0.5;
				}
			}
		}
		
		private function deselectImages():void
		{
			for (var i:int = 0; i < imageList.length; i++) {
				Image(imageList[i]).alpha = 0.5;
			}
		}
		
		private function onNextTouched(e:TouchEvent):void 
		{
			if ( e.getTouch( next, TouchPhase.ENDED ) )
			{
				dispatchEventWith( SHOW_BACK );
			}
		}
		
		private function onBackTouched(e:TouchEvent):void 
		{
			if ( e.getTouch( back, TouchPhase.ENDED ) )
			{
				dispatchEventWith( SHOW_MESSAGE );
			}
		}
		
		private function addBrowseListeners():void 
		{
			cr.addEventListener(MediaEvent.SELECT, onImgSelect);
			cr.addEventListener(Event.CANCEL, onCancel);
			cr.addEventListener(ErrorEvent.ERROR, onError);
		}
		
		private function onError(event:ErrorEvent):void 
		{
			
		}
		
		private function onImageLoaded(event:Event):void {
			
			if (uploadedImage != null)
			{
				uploadedImage.removeEventListeners(TouchEvent.TOUCH);
				uploadedImage.removeFromParent(true);
				uploadedImage.dispose();
			}
			
			var isPortrait:Boolean;
			
			var bitmapData:BitmapData = Bitmap(loader.content).bitmapData;
			
			if(bitmapData.height > bitmapData.width){
				isPortrait=true;
			} else {
				isPortrait=false;
			}
			
			
			var scale:Number = Math.min(Utils.Utilities.GetScaledX(0.2) / bitmapData.width, Utils.Utilities.GetScaledY(0.2) / bitmapData.height)
			var matrix:Matrix = new Matrix();
			matrix.scale(scale, scale);
			
			var smallBMD:BitmapData = new BitmapData(bitmapData.width * scale, bitmapData.height * scale, true, 0x000000);
			smallBMD.draw(bitmapData, matrix, null, null, null, true);
			
			var bitmap:Bitmap = new Bitmap(smallBMD, PixelSnapping.NEVER, true);
			
			SharedObjectManager.getCurrentProject().stampimageData = bitmap.bitmapData.getPixels(new Rectangle(0, 0, bitmap.width, bitmap.height));
			SharedObjectManager.getCurrentProject().stampimagerect = new Rectangle(0, 0, bitmap.width, bitmap.height);
			SharedObjectManager.getCurrentProject().stamp = -1;
			deselectImages();
			
			
			var texture:Texture = Texture.fromBitmap(bitmap);
			// and display it with an Image:
			uploadedImage = new Image(texture);
			//uploadedImage.x = Utils.Utilities.GetScaledX(0.025);
			//uploadedImage.y = Utils.Utilities.GetScaledY(0.3);
			uploadedImage.width =  Utils.Utilities.GetScaledX(0.1);
			uploadedImage.scaleY = uploadedImage.scaleX;
			container.addChild(uploadedImage);
			
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onImageLoaded);
			loader.contentLoaderInfo.removeEventListener(ErrorEvent.ERROR, onError);
			
			uploadedImage.addEventListener(TouchEvent.TOUCH, onUploadedImageTouched);

		}
		
		private function onUploadedImageTouched(e:TouchEvent):void 
		{
			if ( e.getTouch( uploadedImage, TouchPhase.ENDED ) )
			{
				deselectImages();
				SharedObjectManager.getCurrentProject().stamp = -1;
				uploadedImage.alpha = 1;
			}
		}
		
		private function onCancel(e:Event):void 
		{
			
		}
		
		private function onImgSelect(e:MediaEvent):void 
		{
			var promise:MediaPromise = e.data as MediaPromise;
			removeBrowseListeners();
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onImageLoaded);
			loader.contentLoaderInfo.addEventListener(ErrorEvent.ERROR, onError);
			loader.loadFilePromise(promise);
		}
		
		private function removeBrowseListeners():void 
		{
			cr.removeEventListener(MediaEvent.SELECT, onImgSelect);
			cr.removeEventListener(Event.CANCEL, onCancel);
			cr.removeEventListener(ErrorEvent.ERROR, onError);
		}
		
	}

}