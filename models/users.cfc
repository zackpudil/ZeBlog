component persistent="true" table="USERS" output="false" {
	//primary key for the user table
	property name="userID" generator="identity";
	//user properties
	property firstName;
	property lastName;
	property email;
	property userName;
	property password;
	//add new property of salt to the user entity.
	property salt;
	//add new property for active
	property active;
	
	//blog children
	property
		name="blog"
		type="array"
		fieldtype="one-to-many"
		fkcolumn="userID"
		cfc="blogs";
	
	//comment children
	property
		name="usercomments"
		type="array"
		fieldtype="one-to-many"
		fkcolumn="userID"
		cfc="comments";
		
	public boolean function isActive() {
		return getActive();
	}
	
	public boolean function isAdmin() {
		return getUserID() == 1;
	}
}