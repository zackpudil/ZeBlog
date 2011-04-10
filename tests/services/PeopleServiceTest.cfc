<!---
	Unit tests for the people service.
--->
<cfcomponent displayname="PeopleServiceTest" extends="mxunit.framework.TestCase" output="false">
	<!---
		The index method should just return all users in the site.
	--->
	<cffunction name="testIndex" access="public" returnType="void">
		<cfscript>
			people = createObject("component", "ZeBlog.services.people");
			expected = entityLoad("users");
			actual = people.index();
			assertEquals(expected, actual);
		</cfscript>
	</cffunction>
	
	<!---
		The viewuser method should return the user of what ever id was passed.
		(TODO) - expect a struct that has a success boolean variable in it to indicate whether or not the
		user exists.
	--->
	<cffunction name="testViewuser" access="public" returntype="void">
		<cfscript>
			people = createObject("component", "ZeBlog.services.people");
			expected = entityload("users", 1, true);
			actual = people.viewuser(1);
			assertEquals(expected, actual);
		</cfscript>
	</cffunction>
</cfcomponent>