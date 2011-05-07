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
		* @param password - the passwor to hash
		* @param salt - the salt to hash the password with
		* @return - the hashed password.
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
		function login(uname, pword, tries) {
			var ret = structNew();
			ret.username = arguments.uname;
			ret.tries = arguments.tries + 1;
			ret.isLockedOut = false;
			ret.user = [];
			
			var userArray = ormExecuteQuery("from users where userName=?", [arguments.uname]);
			if(arrayLen(userArray)) {
				var user = userArray[1];
				//hash the users password
				var hashpass = getHashPass(pword, user.getSalt());
				if(user.getPassword() eq hashpass) {
					if(user.isActive()) {
						ret.user = [user];
					} else {
						ret.isLockedOut = true;
					}
				} else {
					if(ret.tries >= 3) {
						if(not user.isAdmin()) {
							user.setActive(0);
							entitySave(user);
							ormflush();
						}
					}
				}
			} else {
				ret.user = [];
			}
			
			return ret;
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
				
				ret.saveEntries = {
					firstname = arguments.firstname,
					lastname = arguments.lastname,
					username = arguments.username,
					email = arguments.email
				};
				
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
				user.setActive(1);
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
