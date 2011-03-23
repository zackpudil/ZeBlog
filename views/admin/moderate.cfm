<!---
	ZeBlog	
	Author: Zachary Pudil
	File: views/admin/moderate.cfm
		View for the moderate action.
			is essentially two diffrent views because of the command parameter.
--->
<div>
	<h1>Moderate Blogs</h1>
	<cfif structKeyExists(variables.rc, "message")>
		<p class="error"><cfoutput>#variables.rc.message#</cfoutput></p>
	</cfif>
	<cfset startAt = variables.rc.pageCount*3 />
	<cfset endAt = variables.startAt+3 />
	<cfparam name="maxrow" default="0" />
	<!---
		if the command is to show the blogs
	--->
	<cfif variables.rc.command eq "blog">
		<cfset maxrow = arrayLen(variables.rc.blogs)/>
		<cfoutput>
			<cfloop from="#startAt+1#" to="#endAt#" index="i">
				<cfif i le arrayLen(variables.rc.blogs)>
					<cfset blog = variables.rc.blogs[i] />
					<div class="blog">
						<h2><a href="#buildURL(action='main.viewblog?id=' & blog.getBlogID())#">#blog.getTitle()#</a></h2> <hr />
						<p>#DateFormat(blog.getBlogPostDate())#</p>
						<p class="meta">(#arrayLen(blog.getBlogComments())#) Comments</p>
						<a style="margin-right: 8px;" class="mod" href="#buildURL(action='admin.moderate?command=comment&id='&blog.getBlogID())#">Moderate</a>
						<a class="mod" href="#buildURL(action='admin.deleteblog?id='&blog.getBlogID())#">Delete Blog</a>
					</div>
				</cfif>
			</cfloop>
		</cfoutput>
	<!---
		else show the comments for a specific blog.
	--->
	<cfelseif variables.rc.command eq "comment">
		<cfif arrayLen(variables.rc.comments)>
		<cfset maxrow = arrayLen(variables.rc.comments) />
		<cfoutput>
			<h1><a href="#buildURL(action='main.viewblog?id='&variables.rc.comments[1].getBlog().getBlogID())#">#variables.rc.comments[1].getBlog().getTitle()#</a></h1>
			<p class="mod">#DateFormat(variables.rc.comments[1].getBlog().getBlogPostDate())#</p>
			<hr />
			<cfif arrayLen(variables.rc.comments) gt 0>
				<cfloop from="#startAt+1#" to="#endAt#" index="i">
					<cfif i le arrayLen(variables.rc.comments)>
						<div class="comment">
							<cfset comment = variables.rc.comments[i] />
							<h3>#comment.getUser().getUserName()#</h3>
							<p>#comment.getText()#</p>
							<p class="meta">#DateFormat(comment.getCommentPostDate())#</p>
							<p class="mod">
								<a href="#buildURL(action='admin.deletecomment?id='& comment.getCommentID()&'&blogID='&comment.getBlog().getBlogID())#">Delete Comment</a>
							</p>
						</div>
					</cfif>
				</cfloop>
			</cfif>
			<p class="mod"><a href="#buildURL(action='admin.moderate')#">Back</a></p>
		</cfoutput>
		<cfelse>
			<div>
				<h1 style="padding: 30px;">There are no comments to moderate</h1>
			</div>
		</cfif>
	<cfelse>
		<p class="error">Error</p>
	</cfif>
	<cfoutput>
		<!---
			always show the navigation links
		--->
		<p class="nav">
				<cfif variables.rc.pageCount gte 1>
					<cfif variables.rc.command eq "comment">
						<a href="#buildURL(action='admin.moderate?command=comment&pageCount='&variables.rc.pageCount-1&'&id='&rc.comments[1].getBlog().getBlogID())#">Prev</a>  |
					<cfelse>
						<a href="#buildURL(action='admin.moderate?pageCount='&variables.rc.pageCount-1)#">Prev</a>  |
					</cfif>
				</cfif>
				<cfif (variables.rc.pageCount*3)+3 lt variables.maxrow>
					<cfif variables.rc.command eq "comment">
						|  <a href="#buildURL(action='admin.moderate?command=comment&pageCount='&variables.rc.pageCount+1&'&id='&rc.comments[1].getBlog().getBlogID())#">Next</a>
					<cfelse>
						|  <a href="#buildURL(action='admin.moderate?pageCount='&variables.rc.pageCount+1)#">Next</a>
					</cfif>
				</cfif>
			</p>
	</cfoutput>
</div>
