<cfcomponent displayname="MainServiceTest" extends="mxunit.framework.TestCase" output="false">
	
	<!---
		Test for the index item in the main service.
	--->
	<cffunction name="testIndex" access="public" returnType="void">
		<cfscript>
			var mainService = createObject("component", "ZeBlog.services.main");
			var blogTest = ormExecutequery(
				"from blogs where blogPostDate <= ? order by blogPostDate", 
				[now()]
			);
			
			assertEquals(blogTest, mainService.index("date"));
			
			blogTest = ormExecutequery(
				"from blogs where blogPostDate <= ? order by views",
				[now()]
			);
			
			assertEquals(blogTest, mainService.index("viewed"));
			
			blogTest = entityLoad('blogs');
			for(var i = arrayLen(blogTest); i >= 0; i--) {
				for(var j = 2; j <= i; j++) {
					if(arrayLen(blogTest[j-1].getBlogComments()) < arrayLen(blogTest[j].getBlogComments())) {
							var temp = blogTest[j-1];
							blogTest[j-1] = blogTest[j];
							blogTest[j] = temp;
					}
				}
			}
			
			assertEquals(blogTest, mainService.index("commented"));
		</cfscript>
	</cffunction>
	
	<!---
		Test for teh viewblog item in the main service.
	--->
	<cffunction name="testViewblog" access="public" returnType="void">
		<cfscript>
			var mainService = createObject("component", "ZeBlog.services.main");
			var blogTest = entityLoad("blogs", 1, true);
			blogTest.setViews(blogTest.getViews()+1);
			
			var actual = mainService.viewblog(1);
			
			assertEquals(blogTest, actual.blog);
			assertEquals(blogTest.getViews(), actual.blog.getViews());
		</cfscript>
	</cffunction>
	
	<!---
		Test for the commentblog item in the main service.
	--->
	<cffunction name="testCommentblog" access="public" returnType="void">
		<cfscript>
			var mainService = createObject("component", "ZeBlog.services.main");
			var blogTest = entityLoad("blogs")[1];
			
			var today = now();
			
			var commentTest = entityNew("comments");
			commentTest.setUser(entityLoad("users", 1, true));
			commentTest.setBlog(blogTest);
			commentTest.setText("TEst Comment on random blog");
			commentTest.setCommentPostDate(today);
			entitySave(commentTest);
			
			var blogActual = entityLoad(
				"blogs", 
				mainService.commentblog(
					blogTest.getBlogID(),
					"TEst Comment on random blog",
					today,
					1
				),
				true
			);
			
			assertEquals(blogTest, blogActual);
			
			var deleteComment = ormExecutequery("from comments where commentPostDate=?", [today]);
			for(var i = 1; i <= arrayLen(deleteComment); i++) {
				entityDelete(deleteComment[i]);
			}
			ormflush();
		</cfscript>
	</cffunction>
</cfcomponent>