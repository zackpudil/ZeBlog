component persistent="true" table="COMMENTS" output="false" {
				//primary key for the comment table.
				property name="commentID" generator="identity";
				//text
				property text;
				//commentPostDate, named differently so not cause conflicts with
				//blog's post date.
				property name="commentPostDate" column="Date";
				
				//parent, user
				property
								name="user"
								fieldtype="many-to-one"
								fkcolumn="userID"
								cfc="users"
								lazy="true";

				//parent blog
				property
								name="blog"
								fieldtype="many-to-one"
								fkcolumn="blogID"
								cfc="blogs"
								lazy="true";
}
