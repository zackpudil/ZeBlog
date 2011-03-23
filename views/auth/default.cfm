<div>
	<h1>Login</h1>
	<div class="form">
		<form action="index.cfm?action=auth.login" method="post">
			<p>
				<label for="uname">Username </label>
				<input type="text" id="uname" name="uname" />
			</p>
			<p>
				<label for="pword">Password </label>
				<input type="password" id="pword" name="pword" /><br /><br />
			</p>
			<p id="log"><input type="submit" value="Login" /> or <a href="index.cfm?action=auth.register">Register</a></p>
		</form>
		<cfif structKeyExists(rc, "message")>
			<p class="error"><cfoutput>#rc.message#</cfoutput></p>
		</cfif>
	</div>
</div>
