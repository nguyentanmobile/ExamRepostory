package PostcardLayouts 
{
	import feathers.controls.Screen;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.textures.Texture;
	import StoredObject.SharedObjectManager;
	import Utils.AssetsManager;
	
	/**
	 * ...
	 * @author Andrew Jarman
	 */
	public class ReviewPostcardPicture extends Screen 
	{
		private var image:Image;
		
		public function ReviewPostcardPicture(width:Number, height:Number) 
		{
			super();
			
			var outerBackground:Quad = new Quad(width, height, 0xffffff)
			addChild(outerBackground);
			
			if (SharedObjectManager.getCurrentProject().postcard != -1)
			{
				var texture:Texture = AssetsManager.getAtlas().getTexture("postcard");
				image = new Image(texture);
				image.width = width;
				image.height = height;
				addChild( image );
			}
			else if (SharedObjectManager.getCurrentProject().postcardImgData != null)
			{
				var stampimageData:ByteArray = SharedObjectManager.getCurrentProject().postcardImgData;

				var rect:Rectangle = new Rectangle(0,0, SharedObjectManager.getCurrentProject().postcardImgRect.width,
														SharedObjectManager.getCurrentProject().postcardImgRect.height);
				
				var bitmapData:BitmapData = new BitmapData(rect.width, rect.height);
				stampimageData.position = 0;
				bitmapData.setPixels(rect, stampimageData);
				
				var bitmap:Bitmap = new Bitmap(bitmapData);
				var _texture:Texture = Texture.fromBitmap(bitmap);
				image = new Image(_texture);
				image.width = width;
				image.height = height;
				addChild(image);
				
			}
			
		}
		
	}

}