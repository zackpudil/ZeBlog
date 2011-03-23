<!---
	ZeBlog
	Author: Zachary Pudil
	File: services\main.cfc
		service for all actions in the main section
--->
<cfcomponent>
	<cfscript>
		/**
		*	service for the index action
		* @param - sort ( enum for how to sort the blog entries )
		* @return - queryObject
		*/
		function index(sort) {
			var sortVar = "";

			//find out how to sort.
			switch(arguments.sort) {
				case "date": {
					sortVar="blogPostDate";
					break;
				}
				
				case "commented": {
					sortVar="commented";
					break;
				}

				case "viewed": {
					sortVar="views";
					break;
				}

				default: {
					sortVar="blogPostDate";
				}
			}

			//only grab blog entries that are dated today or earler
			var today = createODBCDate(createDate(Year(now()), Month(now()), Day(now())));

			if(sortVar == "commented") {
				//if the sortVar eq commented, then grab all the blogs
				//and manually sort then by the length of thier blogcomments arrays
				var blogs = entityLoad('blogs');
				for(var i = arrayLen(blogs); i >= 0; i--) {
					for(var j = 2; j <= i; j++) {
						if(arrayLen(blogs[j-1].getBlogComments()) < arrayLen(blogs[j].getBlogComments())) {
								var temp = blogs[j-1];
								blogs[j-1] = blogs[j];
								blogs[j] = temp;
						}
					}
				}
			} else {
				//else use hql to order by the postdate.
				var blogs = ormExecuteQuery("from blogs 
									where blogPostDate <= ? order by " & sortVar & " desc", 
									[today]
				);
			}
	

			return blogs;
		}

		/**
		* service for the viewblog action
		* @param id - blogID of the blog entry
		* @return - struct (
		* 	blog queryObject,
		* 	comments queryObject
		* )
		*/
		function viewblog(id) {
			//get the blog, as array.
			var blog = entityLoad("blogs", arguments.id, true);
			blog.setViews(blog.getViews()+1);
			//write to the database.
			ormflush();
			ret.blog = blog;
			return ret;
		}

		/*
		* action for the commentblog entry, has no view
		* @param blogid - id fo the blog
		* @param text - the text of the comment
		* @param date - date to post the comment
		* @param user_id - the user's UserID in the users table
		* @return - passed in blogid
		*/
		function commentblog(belogid, text, date, user_id) {
			//create a new comment entity.
			var comment = entityNew("comments");

			//set the comment properties.
			comment.setUser(entityLoad('users', arguments.user_id, true));
			comment.setBlog(entityLoad("blogs", arguments.blogid, true));
			comment.setText(text);
			comment.setCommentPostDate(date);

			//save the entity.
			entitySave(comment);
			//write to the database.
			ormflush();

			return arguments.blogid;
		}
	</cfscript>
</cfcomponent>
