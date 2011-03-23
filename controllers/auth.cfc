<cfcomponent>
	<cfscript>
		/**
		* (see controllers/main.cfc)
		*/
		function init(fw) {
			variables.fw = arguments.fw;
		}

		/**
		* called for the index action of the auth section.
		* index does not have a service, just insure
		* that the user isn't already logged in and
		* let the framework create the index view.
		* @param - rc (request context)
		*/
		function index(rc) {
			if(structKeyExists(session, "user_id") and session.logged_in) {
				variables.fw.redirect(action='main.index');
			}
		}

		/**
		* called before login service is called.
		* validate all user parameters
		* @param - rc (request context)
		*/
		function startLogin(rc) {
			if(not structKeyExists(arguments.rc, "uname")
									or not structKeyExists(arguments.rc, "pword")) {
					variables.fw.redirect(action='main.index',
							queryString='message=Invalid+Username+or+Password');
			}
		}

		/**
		* called when login service is done.
		* just returns a result set based on uname and pword.
		* check that the result set has a user in it,
		* and redirect (either to the main.index page or the
		*			action inside the session scope)
		*/	
		function endLogin(rc) {
			var user = arguments.rc.data;
			if(arrayLen(user)) {
				//if the user has a recordCount, set the
				//session user_id to the user's userID
				//and set application.logged_in to true.
				session.user_id = user[1].getUserID();
				session.logged_in = true;
				//if the userID is equal to one, then
				//the user is an admin.
				if(user[1].getUserID() == 1) {
					session.isAdmin = true;
				} else {
					session.isAdmin = false;
				}

				//redirect if there is an action variable
				//inside the session scope.
				if(structKeyExists(session, "action")) {
					if(structKeyExists(session, "arg")) {
						variables.fw.redirect(action=session.action, queryString=session.arg);
					} else {
						variables.fw.redirect(action=session.action);
					}
				} else {
					variables.fw.redirect(action='main.index');
				}
			} else {
				variables.fw.redirect(action='auth.index', 
									queryString='message=Invalid+Username+Or+Password');
			}
		}

		/**
		* essentially the same as the login page.
		* no service, just check and display view.
		* @param - rc( request context)
		*/
		function register(rc) {
			if(structKeyExists(session, "user_id") and session.logged_in) {
				variables.fw.redirect(action='main.index');
			}
		}

		/**
		* called before the signup service,
		* validate all user provided parameters.
		* @param - rc(request context)
		*/
		function startSignup(rc) {
			if(not structKeyExists(arguments.rc, "username")
							or not structKeyExists(arguments.rc, "password")
							or not structKeyExists(arguments.rc, "confirm")
							or not structKeyExists(arguments.rc, "email")
							or not structKeyExists(arguments.rc, "firstname")
							or not structKeyExists(arguments.rc, "lastname")
							or not len(arguments.rc.username)
							or not len(arguments.rc.password)
							or not len(arguments.rc.confirm)
							or not len(arguments.rc.email)
							or not len(arguments.rc.firstname)
							or not len(arguments.rc.lastname)) {
				variables.fw.redirect(action='auth.register', 
										queryString='message=All+fields+are+required');
				
			}

			//if password and confirm do not match.
			if(arguments.rc.password != arguments.rc.confirm) {
				variables.fw.redirect(action='auth.register',
										queryString='message=Password+confirm+do+not+match');
			}
		}

		/**
		* if the sign up was seccuessfly,
		* redirect user to login page.
		* else redirect back to register page, with the error message.
		* @param -rc (request context)
		*/
		function endSignup(rc) {
			if(arguments.rc.data.success) {
				variables.fw.redirect(action='auth.index',
							queryString='message=' & arguments.rc.data.message);
			} else {
				variables.fw.redirect(action='auth.register',
							queryString='message=' & arguments.rc.data.message);
			}
		}

		/**
		* log user out,
		* clear the session variables,
		* and set respective application variables
		* to false.
		* @param rc - (request context)
		*/
		function logout(rc) {
			structClear(session);
			session.isAdmin = false;
			session.logged_in = false;
			session.style = "greenbase.css";
			variables.fw.redirect(action='main.index');
		}
	</cfscript>

	<!---
		(see controllers/main.cfc)
	--->
	<cffunction name="default">
		<cflocation url="?action=auth.index" />
	</cffunction>
</cfcomponent>
