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
		<cfif structKeyExists(variables.rc, "message")>
			<p class="error" align="center"><cfoutput>#variables.rc.message#</cfoutput></p>
		</cfif>
		<form action="#buildURL(action='auth.signup')#" method="post">
			<fieldset>
				<legend>Personal Information</legend>
				<p>
					<label for="firstname">First Name:</label>
					<input type="text" id="firstname" name="firstname" />
				</p>
				<p>
					<label for="lastname">Last Name:</label>
					<input type="text" id="lastname" name="lastname" />
				</p>
				<p>
					<label for="email">Email: </label>
					<input type="text" id="email" name="email" />
				</p>
			</fieldset>
			<fieldset>
				<legend>Site Information</legend>
				<p>
					<label for="username">Username: </label>
					<input type="text" id="username" name="username" />
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
