component persistent="true" table="USERS" output="false" {
				//primary key for the user table
				property name="userID" generator="identity";
				//user properties
				property firstName;
				property lastName;
				property email;
				property userName;
				property password;

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
}
