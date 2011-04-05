<!---
	ZeBlog
	Author: Zachary Pudil
	File: controllers/main.cfc
		controller for all the actions of the main section
--->
<cfcomponent>
	<cfscript>
		/*
		*	grab the framework api
		* called by the framework at the start of every request
		* @param fw - the framework
		*/
		function init(fw) {
			variables.fw = arguments.fw;
		}

		/**
		* called before the index service is called.
		* ensures that all required arguments are inside the rc (request context) argument
		* @param rc - request context
		*/
		function startIndex(rc) {	
			param arguments.rc.pageCount = 0;
			param arguments.rc.sort = "date";
		}

		/**
		* called when the index service is done.
		* the rc.data is the value that was returned by the service function.
		* puts rc.data into rc.blogs for the view
		* @param rc - request context
		*/
		function endIndex(rc) {
			arguments.rc.blogs = arguments.rc.data;
		}

		/**
		* called before viewblog service is called.
		* cfparams pageCount, and ensures there is an id varible in the
		* rc argument
		* @param rc - request context
		*/
		function startViewblog(rc) {
			param arguments.rc.pageCount = 0;
		}

		/**
		* called after viewblog service as returned.	
		* rc.data is a struct that contains the queries blog, and comments.
		* put into respective places in the rc struct for the view
		* @param - rc (request context)
		*/
		function endViewblog(rc) {
			arguments.rc.blog = arguments.rc.data.blog;
		}

		/**
		* called before commentblog service is called.
		* validates and sets up all required arguments
		* for the service commentblog
		* @param - rc (request context)
		*/
		function startCommentblog(rc) {
			//if there is no session variable for user_id
			//redirect to the login page.
			if(not structKeyExists(session, "user_id")) {
				variables.fw.redirect(action='auth.index');
			}

			//there is some trickery going on,
			//redirect hacker back to main index page.
			if(not structKeyExists(arguments.rc, "blogid") 
						or not structKeyExists(arguments.rc, "text")
						or not len(arguments.rc.text)) {
				variables.fw.redirect(action='main.error');
			}

			//a user does not have the option to pre/post date
			//his/her comment
			arguments.rc.date = createODBCDateTime(now());
			arguments.rc.user_id = session.user_id;
		}

		/**
		* redirect user back to the blog he/she was viewing
		* @param - rc (request context)
		*/
		function endCommentblog(rc) {
			variables.fw.redirect(action='main.viewblog', queryString='id=' & arguments.rc.data);
		}

		/**
		* change the color of the site!
		* @param - rc (request context)
		*/
		function color(rc) {
			param rc.color = "green";
			session.style = rc.color;
		}

	</cfscript>

	<!---
		cannot have function name of default in cfscript (reserved word).
		if the default item is called redirect to index item.
	--->
	<cffunction name="default">
		<cflocation url="?action=main.index" />
	</cffunction>

</cfcomponent>
