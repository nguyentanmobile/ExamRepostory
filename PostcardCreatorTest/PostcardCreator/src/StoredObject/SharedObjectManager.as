package StoredObject 
{
	import flash.net.SharedObject;
	/**
	 * ...
	 * @author ...
	 */
	public class SharedObjectManager 
	{
		private static var shared:SharedObject;
		private static var users:Array = new Array();
		
		private static var currentUser:int = -1;
		private static var currentProject:int = -1;
		
		public static function save():void
		{
			shared = SharedObject.getLocal("PostcardCreator");
			shared.data.Users = Users;
			shared.flush();
		}
		
		public static function load():void
		{
			shared = SharedObject.getLocal("PostcardCreator");
			users = shared.data.Users;
			if (users == null)
				users = new Array();
		}
		
		public static function addUser(name:String):void
		{
			Users.push(new User(name));
			save();
		}
		
		static public function deleteUser(index:int):void 
		{
			users.splice(index, 1);
			save();
		}
		
		static public function get Users():Array 
		{
			return users;
		}
		
		static public function getCurrentProject():Object 
		{
			if(getCurrentUser() != null)
				return getCurrentUser().projects[currentProject];
			else
				return null;
		}
		
		static public function setCurrentProject(value:int):void 
		{
			currentProject = value;
		}
		
		static public function getCurrentUser():Object
		{
			return users[currentUser];
		}
		
		static public function setCurrentUser(value:int):void 
		{
			currentUser = value;
		}
		static public function addProject(ProjectName:String):void
		{
			var proj:Project = new Project(ProjectName);
			getCurrentUser().projects.push(proj);
			save();
		}
		
		static public function deleteProject(index:int):void 
		{
			getCurrentUser().projects.splice(index, 1);
			save();
		}
		
		
	}

}