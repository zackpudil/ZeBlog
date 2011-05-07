<!---
	ZeBlog
	Author: Zachary Pudil
	File: controllers/admin.cfc
		controller for all actions in the admin section.
--->
<cfcomponent>
	<cfscript>
		/**
		* (see controllers/main.cfc)
		*/
		function init(fw) {
			variables.fw = arguments.fw;
		}

		/**
		* called at the start of every request for the admin section.
		* checks to see if the session hasn't timed out.
		* @param - rc : (request context)
		*/
		function before(rc) {
			if(not structKeyExists(session, "user_id")) {
				structClear(session);
				session.isAdmin = false;
				session.logged_in = false;
				variables.fw.redirect(action='auth.index');	
			}

			if(not session.isAdmin) {
				variables.fw.redirect(action='main.index');
			}
		}

		/**
		* called before createblog service,
		* validate user input, and ensure that
		* the blog wasn't post dated in the past.
		* @param - rc : (request context)
		*/
		function startCreateblog(rc) {
			//if there is no title or text, redirect back
			//to the form with an error message.
			if(not structKeyExists(arguments.rc, "title")
							or not structKeyExists(arguments.rc, "text")
							or not len(arguments.rc.title)
							or not len(arguments.rc.text)
			) {
				variables.fw.redirect(action='admin.index',	
									queryString='message=All+Fields+Are+Required');
			}

			if(not structKeyExists(arguments.rc, "month")
							or not structKeyExists(arguments.rc, "day")
							or not structKeyExists(arguments.rc, "year")
							or not len(arguments.rc.month) or not isNumeric(arguments.rc.month)
							or not len(arguments.rc.day) or not isNumeric(arguments.rc.day)
							or not len(arguments.rc.year) or not isNumeric(arguments.rc.year)
			) {
				variables.fw.redirect(action='admin.index',
								queryString='message=Please+specify+date&text=' 
										& arguments.rc.text & '&title=' & arguments.rc.title);
			} else {
				//create the date.
				var thedate = createDate(arguments.rc.year, arguments.rc.month, arguments.rc.day);
				//make sure that the date isn't in the past.
				if(thedate < dateAdd("d", -1, now())) {
					variables.fw.redirect(action='admin.index',
							queryString='message=You+can+not+pre+date+a+blog+in+the+past&text='
											& arguments.rc.text & '&title=' & arguments.rc.title);
				} else {
					//create the odbc date stamp.
					arguments.rc.date = createODBCDate(thedate);
				}
			}
			//give the user_id
			arguments.rc.user_id = session.user_id;
		}

		function endCreateblog(rc) {
			//redirect to the newly created blog.
			variables.fw.redirect(action='main.viewblog',
							queryString='id=' & arguments.rc.data);
		}
		
		/**
		* started before the moderate service is called.
		* param the command and the pageCount.
		* if the command is comment, make sure id is specified.
		* @param - rc: (request context)
		*/
		function startModerate(rc) {
			param arguments.rc.pageCount = 0;
			param arguments.rc.command = "blog";

			if(arguments.rc.command == "comment" and not structKeyExists(arguments.rc, "id")) {
				variables.fw.redirect(action='admin.moderate');
			}
		}

		/**
		* called after service.
		* if the command is blog, load the request context with
		* the blog results, else load the request context with
		* comment results.
		* @param - rc: (request context)
		*/
		function endModerate(rc) {
			if(arguments.rc.command == "blog") {
				arguments.rc.blogs = arguments.rc.data;
			} else if(arguments.rc.command == "comment") {
				arguments.rc.comments = arguments.rc.data;
			} else {
				variables.fw.redirect(action='admin.moderate');
			}
		}

		/*
		* all other controllers validate user input
		*	before the service is called.
		*/

		function startDeleteblog(rc) {
			if(not structKeyExists(arguments.rc, "id") and not isNumeric(arguments.rc.id)) {
				variables.fw.redirect(action='admin.moderate',
								queryString='message=Error+while+deleting+blog');
			}
		}

		function endDeleteblog(rc) {
			variables.fw.redirect(action='admin.moderate',
						queryString='message=Blog+deleted');
		}

		function startDeletecomment(rc) {
			if(not session.isAdmin) {
				variables.fw.redirect(action='main.index');
			}

			if(not structKeyExists(arguments.rc, "blogid")) {
				variables.fw.redirect(action='admin.moderate');
			}

			if(not structKeyExists(arguments.rc, "id") or not isNumeric(arguments.rc.id)) {
				variables.fw.redirect(action='admin.moderate',
								queryString='command=comment&id=' & arguments.rc.blogid & '&message=
											Error+while+deleting+comment');
			}
		}

		function endDeletecomment(rc) {
			variables.fw.redirect(action='admin.moderate',
					queryString='command=comment&id=' & arguments.rc.data & '&message=
								Comment+Deleted');
		}
		
		function endManage(rc) {
			rc.users = rc.data;
		}
		
		function startActivate(rc) {
			if(not structKeyExists(arguments.rc, "id")) {
				variables.fw.redirect(action='admin.manage');
			}
			
			
			if(structKeyExists(arguments.rc, "active")) {
				rc.activate = 1;
			} else {
				rc.activate = 0;
			}
		}
		
		function endActivate(rc) {
			variables.fw.redirect(action='admin.manage');
		}
	</cfscript>

	<cffunction name="default">
		<cflocation url="?action=auth.index" />
	</cffunction>

</cfcomponent>
