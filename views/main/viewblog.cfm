<!---
	ZeBlog
	Author: Zachary Pudil
	File: views\main\index.cfm
		view for the index action
--->
<div>
	<!-- set the startAt and endAt variables for the next/prev blog nav -->
	<cfset startAt = rc.pageCount*3 />
	<cfset endAt = startAt+3 />
	<cfoutput>
		<div class="blog">
			<h1>#variables.rc.blog.getTitle()#</h1>
			<p class="meta">By: #variables.rc.blog.getUser().getUsername()#</p>
			<hr />
			<p>#DateFormat(variables.rc.blog.getBlogPostDate())#</p>
			<p>#variables.rc.blog.getText()#</p>
			<hr />
			<p class="meta">(#variables.rc.blog.getViews()#) Views</p>
			<br />
		</div>
		<h2>Comments</h2>
		<cfif variables.rc.blog.hasBlogComments()>
			<cfloop from="#variables.startAt+1#" to="#variables.endAt#" index="i">
				<cfif i le arrayLen(variables.rc.blog.getBlogComments())>
					<cfset comment = variables.rc.blog.getBlogComments()[i] />
					<div class="comment">
						<h3>#comment.getUser().getUserName()#</h3>
						<p>#comment.getText()#</p>
						<p>#DateFormat(comment.getCommentPostDate())#</p>
					</div>
				</cfif>
			</cfloop>
		</cfif>
		<p align='center' class='nav'>
		<!--- only show links for next and prev if there we are not at the beginning/end
					of the blog.
		--->
			<cfif rc.pageCount gte 1>
				<a href="#buildURL(action='main.viewblog?id='&variables.rc.blog.getBlogID()&'&pageCount='&variables.rc.pageCount-1)#">Prev</a>  |
			</cfif>
			<cfif (rc.pageCount*3)+3 lt arrayLen(variables.rc.blog.getBlogComments())>
				| <a href="#buildURL(action='main.viewblog?id='&variables.rc.blog.getBlogID()&'&pageCount='&variables.rc.pageCount+1)#">Next</a>
			</cfif>
		</p>
		<h2>Post a comment</h2>
		<cfif session.logged_in>
			<div class="form">
				<form action="#buildURL(action='main.commentblog?blogid='& variables.rc.blog.getBlogId())#" method="post">
					<label for="text" style='font-size: 1.4em;'>Comment:</label><br />
					<textarea name="text" id="text" rows="5" cols="45"></textarea><br />
					<input type="submit" value="Post" />
				</form>
			</div>
		<cfelse>
			<!---
				if a user is not logged in,
				save the action and the blogid in the session
				and redirect user to login page.
				When user logs in, the user will be redirected back to the blog page.
			--->
			<cfset session.action = "#variables.rc.action#" />
			<cfset session.arg = "id=#variables.rc.blog.getBlogId()#" />
			<h2><a href="#buildURL(action='auth.index')#">Login to post a comment</a></h2>
		</cfif>
	</cfoutput>
</div>
