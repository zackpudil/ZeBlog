<!---
	ZeBlog
	Author: Zachary Pudil
	File: layouts/auth/register.cfm
		View for the register action
--->
<div class="form">
	<!---
		registration form for the user
	--->
	<cfoutput>
		<h1>Register</h1>
		<cfif structKeyExists(variables.rc, "errors")>
			<cfloop array="#variables.rc.errors#" index="errorMessageIndex">
				<p class="error">#errorMessageIndex#</p>
			</cfloop>
		</cfif>
		<cfset variables.saved = structKeyExists(variables.rc, "saveEntries") />
		<form action="#buildURL(action='auth.signup')#" method="post">
			<fieldset>
				<legend>Personal Information</legend>
				<p>
					<label for="firstname">First Name:</label>
					<input type="text" id="firstname" name="firstname" <cfif variables.saved> value="#variables.rc.saveEntries.firstname#"</cfif> />
				</p>
				<p>
					<label for="lastname">Last Name:</label>
					<input type="text" id="lastname" name="lastname" <cfif variables.saved> value="#variables.rc.saveEntries.lastname#"</cfif> />
				</p>
				<p>
					<label for="email">Email: </label>
					<input type="text" id="email" name="email" <cfif variables.saved> value="#variables.rc.saveEntries.email#"</cfif> />
				</p>
			</fieldset>
			<fieldset>
				<legend>Site Information</legend>
				<p>
					<label for="username">Username: </label>
					<input type="text" id="username" name="username" <cfif variables.saved> value="#variables.rc.saveEntries.username#"</cfif> />
				</p>
				<p>
					<label for="password">Password: </label>
					<input type="password" id="password" name="password" />
				</p>
				<p>
					<label for="confirm">Confirm: </label>
					<input type="password" id="confirm" name="confirm" />
				</p>
			</fieldset>
			<p align="center"><input type="submit" value="Sign Up" /></p>
		</form>
	</cfoutput>
</div>
