<!---
	ZeBlog
	Author: Zachary Pudil
	File: views/auth/index.cfm
		view for the index action
--->
<div>
	<!---
		login form for user
	--->
	<h1>Login</h1>
	<div class="form">
		<cfoutput>
			<form action="#buildURL(action='auth.login')#" method="post">
				<p>
					<label for="uname">Username </label>
					<input type="text" id="uname" name="uname" <cfif structKeyExists(variables.rc, "username")>value="#variables.rc.username#"</cfif> />
				</p>
				<p>
					<label for="pword">Password </label>
					<input type="password" id="pword" name="pword" /><br /><br />
				</p>
				<p id="log"><input type="submit" value="Login" /> or <a href="#buildURL(action='auth.register')#">Register</a></p>
			</form>
			<cfif structKeyExists(variables.rc, "errors")>
				<cfloop array="#variables.rc.errors#" index="errorsIndex">
					<p class="error">#errorsIndex#</p>
				</cfloop>
			</cfif>
		</cfoutput>
	</div>
</div>
