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
		* util function to get a hash of the given password and salt.
		*/
		function getHashPass(password, salt) {
			var hashpass = hash(password & "" & salt, "SHA-512");
			
			//hash a thousand times.	
			for(var i = 0; i <= 1000; i++) {
				hashpass = hash(hashpass & "" & salt, "SHA-512");
			}
			
			return hashpass;
		}
		
		/**
		* service for the login action.
		* return a query result from the users
		* table where username=uname and password=pword
		* @param uname - passed in username of the user
		* @param pword - passed in password of the user
		* @return - queryObject
		*/
		function login(uname, pword) {
			var userArray = ormExecuteQuery("from users where userName=?", [arguments.uname]);
			if(arrayLen(userArray)) {
				var user = userArray[1];
				//hash the users password
				var hashpass = getHashPass(pword, user.getSalt());
				return ormExecuteQuery("from users where userName=? and password=?",
						[arguments.uname, hashpass]);
			} else {
				return [];
			}
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
				user.setUsername(lcase(arguments.username));
				user.setSalt(createUUid());
				
				//hash the password this time, instead of storing it in plain text.
				var hashpass = getHashPass(password, user.getSalt());
				
				user.setPassword(hashpass);
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
