package StoredObject 
{
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Andrew Jarman
	 */
	public class Project 
	{
		public var name:String = "";
		public var imageTitle:String = "";
		public var imageDescription:String = "";
		public var imageCredit:String = "";
		public var greeting:String = "";
		public var body:String = "";
		public var closing:String = "";
		public var sendersName:String = "";
		public var stamp:int = -1;
		public var postcard:int = -1;
		public var mailingAddress:String = "";
		public var stampimageData:ByteArray = null;
		public var stampimagerect:Rectangle = null;
		public var postcardImgData:ByteArray = null;
		public var postcardImgRect:Rectangle = null;
		
		public function Project(Name:String) 
		{
			name = Name;
		}
		
	}

}