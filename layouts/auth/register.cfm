<!---
	ZeBlog	
	Author: Zachary Pudil
	File: layouts/auth/register.cfm
		layout for the registrationpage
--->

<cfoutput>
<div class="left">
	<div class="navbox"><a href="#buildURL(action='auth.index')#">Login</a></div>
	<div class="navbox" id="selected"><a href="#buildURL(action='auth.register')#">Register</a></div>
</div>
<div class="right"><br />
	<div class="infobox">
		<div id="auth-register">
			#body#
		</div>
	</div>
</div>
</cfoutput>
