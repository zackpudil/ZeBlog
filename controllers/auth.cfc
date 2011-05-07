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
			param session.tries = 1;
			
			rc.tries = session.tries;
			if(not structKeyExists(arguments.rc, "uname") or not structKeyExists(arguments.rc, "pword")) {
				rc.errors = ['Invalid Username and Password'];
				variables.fw.redirect(action='auth.index', preserve="errors");
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
			var user = arguments.rc.data.user;
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
				if(arguments.rc.data.isLockedOut) {
					rc.errors = ['Account is locked, please contact administrator'];
				} else {
					rc.errors = ['Invalid Username or Passowrd'];
				}	
				rc.username = rc.data.username;
				session.tries = rc.data.tries;
				variables.fw.redirect(action='auth.index', preserve="errors,username,tries");
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
			var errors = [];
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
				arrayAppend(errors, "All fields are required");
				rc.errors = errors;
				
				//redirect to the auth.register action, and preserve the errors in the request context variable.
				variables.fw.redirect(action="auth.register", preserve="errors");
			}

			//if password and confirm do not match.
			if(arguments.rc.password != arguments.rc.confirm) {
				arrayAppend(errors, "Passwords do not match");
			}
			
			//validate username requirments.
			if(reFind("[^A-Za-z09]", arguments.rc.username)) {
				arrayAppend(errors, "Usernames must be alphanumeric (not contain any special characters)");
			}
			
			//validate password requirements.
			if(not reFind("[A-Z]", arguments.rc.password)) {
				arrayAppend(errors, "Passwords must contain at least one uppercase letter");
			}
			
			if(not reFind("[a-z]", arguments.rc.password)) {
				arrayAppend(errors, "Passwords must contain at least one lowercase letter");
			}
			
			if(not reFind("[0-9]", arguments.rc.password)) {
				arrayAppend(errors, "Password must contain at least one number character");
			}
			
			if(not reFind("[^A-Za-z0-9]", arguments.rc.password)) {
				arrayAppend(errors, "Password must contain at least one non-alphanumeric character");
			}
			
			if(len(arguments.rc.password) < 8) {
				arrayAppend(errors, "Passwords must be atleast 8 characters long");
			}
			
			//validate email.
			if(not isValid("email", arguments.rc.email)) {
				arrayAppend(errors, "Please use a valid email address");
			}
			
			if(arrayLen(errors)) {
				rc.errors = errors;
				
				rc.saveEntries = {
					firstname = arguments.rc.firstname,
					lastname = arguments.rc.lastname,
					email = arguments.rc.email,
					username = arguments.rc.username
				};
				
				variables.fw.redirect(action="auth.register", preserve="errors,saveEntries");
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
				rc.errors = ['Now log-in'];
				variables.fw.redirect(action='auth.index', preserve="errors");
			} else {
				//if the username already exists, grab the saved entry from the service and have the user try agaoin.
				rc.errors = ['Username already exists'];
				rc.saveEntries = rc.data.saveEntries;
				variables.fw.redirect(action='auth.register', preserve='errors,saveEntries');
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
			var style = session.style;
			structClear(session);
			session.isAdmin = false;
			session.logged_in = false;
			session.style = style;
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
