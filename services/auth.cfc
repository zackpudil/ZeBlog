<!---
	ZeBlog
	Author: Zachary Pudil
	File: services/auth.cfc
		the services for all
		actions in the auth section
--->
<cfcomponent>
	<cfscript>
		/**
		* service for the login action.
		* return a query result from the users
		* table where username=uname and password=pword
		* @param uname - passed in username of the user
		* @param pword - passed in password of the user
		* @return - queryObject
		*/
		function login(uname, pword) {
			//return an array of user objects with username and password
			//equal to uname and pword
			return ormExecuteQuery("from users where userName=? and password=?",
					[arguments.uname, arguments.pword]);
		}

		/**
		* service for the signup action.
		* takes in the data for the user,
		* ensures that the username is not already in use.
		* inserts the user into the db.
		* @param - username (wanted username)
		* @param - password ( wanted password)
		* @param - confirm (only passed because it is in rc when service is called)
		* @param - email (email of user)
		* @param - firstnaem, lastname - name of the user
		* @return - struct(
		*					success boolean,
		*					message String
		*	)
		*/
		function signup(username, password, confirm, email, firstname, lastname) {
			//first query the user for a user with
			//username 'username'
			var checkUser = ormExecuteQuery("from users where userName=?", [arguments.username]);
			if(arrayLen(checkUser)) {
				var ret = StructNew();
				ret.success = false;
				ret.message = 'Username already exists';
				return ret;
			} else {
				//else insert the user into the database
				var user = entityNew("users");
				user.setFirstname(arguments.firstname);
				user.setLastname(arguments.lastname);
				user.setEmail(arguments.email);
				user.setUsername(arguments.username);
				user.setPassword(arguments.password);
				entitySave(user);
				ormflush();
				//return
				ret = StructNew();
				ret.success = true;
				ret.message = "Now login";
				return ret;
			}
		}
	</cfscript>
</cfcomponent>
