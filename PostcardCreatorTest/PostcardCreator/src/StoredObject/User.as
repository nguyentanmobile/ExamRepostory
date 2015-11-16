package StoredObject 
{
	/**
	 * ...
	 * @author Andrew Jarman
	 */
	public class User 
	{
		public var name:String = "";
		private var _projects:Array = new Array();
		
		public function User(Name:String) 
		{
			name = Name;
			projects = new Array();
		}
		
		public function get projects():Array 
		{
			if (_projects == null)
				_projects = new Array();
			return _projects;
		}
		
		public function set projects(value:Array):void 
		{
			_projects = value;
		}
		
	}

}