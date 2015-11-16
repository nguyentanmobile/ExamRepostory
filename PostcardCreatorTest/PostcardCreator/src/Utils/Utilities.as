package Utils 
{
	import starling.core.Starling;
	/**
	 * ...
	 * @author ...
	 */
	public class Utilities 
	{
		
		public static function GetScaledX(pos:Number):Number
		{
			return Starling.current.stage.stageWidth * pos;
		}
		public static function GetScaledY(pos:Number):Number
		{
			return Starling.current.stage.stageHeight * pos;
		}
		public static function GetUniformScale(ScaleFactor:Number):Number
		{
			return (Starling.current.stage.stageHeight / 768) * ScaleFactor;
		}
		
		
	}

}