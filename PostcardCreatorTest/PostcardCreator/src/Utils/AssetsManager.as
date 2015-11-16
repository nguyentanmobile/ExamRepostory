package Utils 
{
	import flash.utils.describeType
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	/**
	 * ...
	 * @author ...
	 */
	public class AssetsManager 
	{
		
		[Embed(source="../../bin/assets/PCC_Stamps.png")]
		private static const ATLAS_BITMAP:Class;

		[Embed(source="../../bin/assets/PCC_Stamps.xml",mimeType="application/octet-stream")]
		private static const ATLAS_XML:Class;

		static private var atlas:TextureAtlas;
		
		
		private static var stamps:Array;
		
		static public function getStamps():Array 
		{
			if (stamps == null)
			{
				stamps = new Array();
				
				for (var i:int = 1; i <= 12; i++)
				{
					stamps.push(getAtlas().getTexture("postcard-stamp" + i));
				}
				
			}
			return stamps;
		}
		
		
		static private function createTextureAtlas():void
		{
			var atlasTexture:Texture = Texture.fromEmbeddedAsset( ATLAS_BITMAP );
			var atlasXML:XML = XML( new ATLAS_XML() );
			atlas = new TextureAtlas( atlasTexture, atlasXML );
		}
		
		static public function getAtlas():TextureAtlas
		{
			if (atlas == null)
				createTextureAtlas();
			return atlas;
		}
	}
}