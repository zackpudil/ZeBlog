<!---
	Unit tests for admin Service.
	Just adding these tests to see if they work (which they should because it already exists)
--->
<cfcomponent displayname="AdminServiceTest" extends="mxunit.framework.TestCase" output="false">
	
	<!---
		Test the admin's create and delete blog services
	--->
	<cffunction name="testCreateblog" access="public" returntype="void">
		<cfscript>
			var adminService = createObject("component", "ZeBlog.services.admin");
			var blog_id = adminService.createblog(
				title="TestBlog!", 
				text="This is a test blog! Created in MXUnit framework",
				date=now(),
				user_id=1
			);
			
			var blogCheck = entityLoad("blogs", blog_id);
			assertTrue(arrayLen(blogCheck) == 1);
			
			entityDelete(blogCheck[1]);
		</cfscript>
	</cffunction>
	<!---
		Test for the moderate function when both commands have been passed to it.
	--->
	<cffunction name="testModerate" access="public" returntype="void">
		<cfscript>
			var adminService = createObject("component", "ZeBlog.services.admin");
			var expected = ormExecutequery("from blogs order by blogPostDate desc");
			var actual = adminService.moderate("blog");
			assertEquals(expected, actual);
			
			expected = entityLoad("blogs", 1, true).getBlogComments();
			var actual = adminService.moderate("comment", 1);
			assertEquals(expected, actual);
		</cfscript>
	</cffunction>
	
	<!---
		Test for the deleteblog method in the admin service. Create a test blog and check if it is deleted.
	--->
	<cffunction name="testDeleteblog" access="public" returntype="void">
		<cfscript>
			var adminService = createObject("component", "ZeBlog.services.admin");
			var blogTest = entityNew("blogs");
			blogTest.setTitle("Test Blog");
			blogTest.setText("This blog is for testing purposes.");
			blogTest.setBlogPostDate(now());
			blogTest.setUser(entityLoad("users", 1, true));
			blogTest.setViews(0);
			
			entitySave(blogTest);
			ormflush();
			
			adminService.deleteblog(id=blogTest.getBlogID());
			assertTrue(arrayLen(entityLoad("blogs", blogTest.getBlogID())) == 0);
		</cfscript>
	</cffunction>
	
	<cffunction name="testDeleteComment" access="public" returntype="void">
		<cfscript>
			var adminService = createObject("component", "ZeBlog.services.admin");
			var blogTest = entityLoad("blogs")[1];
			
			var commentTest = entityNew("comments");
			commentTest.setUser(entityLoad("users", 1, true));
			commentTest.setBlog(blogTest);
			commentTest.setText("This is a test comment on a random blog");
			commentTest.setCommentPostDate(now());

			entitySave(commentTest);
			ormflush();
			
			adminService.deletecomment(commentTest.getCommentID(), blogTest.getBlogID());
			assertTrue(arrayLen(entityLoad("comments", commentTest.getCommentID())) == 0);
		</cfscript>
	</cffunction>
</cfcomponent>