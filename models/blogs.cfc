component persistent="true" table="BLOGENTRIES" output="false" {
				//primary key for the blogentries table
				property name="blogID" generator="identity";
				property title;
				property text;
				property name="blogPostDate" column="Date";
				property views;


				//user parent.
				property
								name="user"
								fieldtype="many-to-one"
								fkcolumn="userID"
								cfc="users"
								lazy="true";

				//blog children
				property
								name="blogcomments"
								type="array"
								fieldtype="one-to-many"
								fkcolumn="blogID"
								cfc="comments"
								orderby="Date DESC";
}
