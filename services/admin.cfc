<!---
	ZeBlog
	Author: Zachary Pudil
	File: services/admin.cfc
		services for all actions in the admin section.
--->
<cfcomponent>
	<cfscript>
		/**
		* createblog service.
		* @param - title: title of the blog
		* @param - text: the body of the blog.
		* @param - date: date to post the blog.
		* @param - user_id: the owner of the blog.
		* @return - the metadata about the insert statement.
		*/
		function createblog(title, text, date, user_id) {

			//create new blog entity.
			var blog = entityNew("blogs");
			//populate blog properties.
			blog.setTitle(arguments.title);
			blog.setText(arguments.text);
			blog.setBlogPostDate(arguments.date);
			blog.setUser(entityLoad("users", arguments.user_id, true));
			blog.setViews(0);
			//save the blog entity.
			entitySave(blog);
			//write to database.
			ormFlush();

			//return the blogs id.
			return blog.getBlogID();
		}

		/**
		* service for the moderate command.
		* what to return depends on the command argument.
		* @param command - enum ( blog or comment)
		* @return queryObject
		*/
		function moderate(command, id) {
			if(arguments.command == "blog") {
				//use hql to order by the blog's post date.
				var blogs = ormExecuteQuery("from blogs order by blogPostDate desc");
				return blogs;
			} else if(arguments.command == "comment") {
				var blog = entityLoad("blogs", arguments.id, true);
				//get all the comments of the blog.
				var comments = blog.getBlogComments();
				return comments;
			}
		}


		/**
		* deletes a blog
		* @param - id: blog to delete
		*/
		function deleteblog(id) {
			//get the blog,
			var blog = entityLoad('blogs', arguments.id, true);
			//get the comments of the blog.
			var comments = blog.getBlogComments();
			//delete every comment first,
			//since the database has referential integrity, having
			//the cascade option doesn't work.  YOU HAVE TO DELETE THE
			//CHILDREN BEFORE YOU KILL THE PARENT
			if(isDefined("comments") && arrayLen(comments)) {
				for(var i = 1; i <= arrayLen(comments); i++) {
					entityDelete(comments[i]);
				}
			}
			//flush the database after the comments are deleted.
			ormflush();
			entityDelete(blog);
			//delete the blog and flush again.
			ormflush();
		}

		/**
		* delete comment.
		* @param id - comment id
		* @param blogid - id of blog that contains comment.
		* @return blogid
		*/
		function deletecomment(id, blogid) {
			//retrieve the comment entity, delete it, and flush.
			var comments = entityLoad('comments', arguments.id, true);
			entityDelete(comments);
			ormFlush();
			return arguments.blogid;
		}
	</cfscript>
</cfcomponent>
