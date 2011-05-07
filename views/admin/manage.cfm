<div>
	<h1>Manage Users</h1>
	<cfoutput>
	<cfloop array="#rc.users#" index="user">
		<div class="blog">
			<fieldset>
				<legend><h1>#user.getUserName()#</h1></legend>
					<p>User ID: #user.getUserID()#</p>
					<p>## of comments: #arrayLen(user.getUserComments())#</p>
					<p>Most Recent Comments:</p>
					<cfloop from="1" to="5" index="i">
						<cfif i le arrayLen(user.getUserComments())>
							<cfset comment = user.getUserComments()[i] />
							<a href="#buildURL(action='main.viewblog?id=' & comment.getBlog().getBlogID())#">
								#left(comment.getText(), 20)#...
							</a><br />
						</cfif>
					</cfloop>
					<form action="#buildURL(action='admin.activate?id=' & user.getUserID())#" method="post">
						Active: 
						<input type="checkbox" <cfif user.isActive()>checked="checked"</cfif> name="active">
						<input type="submit" value="set">
					</form>
			</fieldset>
		</div>
	</cfloop>
	</cfoutput>
</div>