<!---
	ZeBlog
	Author: Zachary Pudil
	File: views\main\viewblog.cfm
		view for the viewblog action.
--->
<div>
	<h1>Blogs</h1>
	<!--- page nav --->
	<cfset startAt = rc.pageCount*3 />
	<cfset endAt = startAt+3 />
	<cfoutput>
		<!---
			show the list of recent blogs,
			ordered by either most viewed, most debated, or most recent
		--->	
		<cfloop from="#variables.startAt+1#" to="#variables.endAt#" index="i"> 
			<cfif i le arrayLen(variables.rc.blogs)>
				<cfset blog = variables.rc.blogs[i] />
				<div class="blog">
					<h2><a href="#buildURL(action='main.viewblog?id=' & blog.getBlogId())#">#blog.getTitle()#</a></h2>
					<p class="nav"> By: #blog.getUser().getUsername()#</p>
					<hr />
					<p>#DateFormat(blog.getBlogPostDate(), "long")#</p>
					<p>#blog.getText()#</p>
					<p class="meta">(#arrayLen(blog.getBlogComments())#) comments (#blog.getViews()#) views</p>
				</div>
			</cfif>
		</cfloop>
		<p align='center' class='nav'>
			<cfif variables.rc.pageCount gte 1>
				<a href='#buildURL(action='main.index?pageCount='&variables.rc.pageCount-1&'&sort='&variables.rc.sort)#'>Prev</a>  |
			</cfif>
			<cfif (variables.rc.pageCount*3)+3 lt ArrayLen(variables.rc.blogs)>
				| <a href="#buildURL(action='main.index?pageCount='&variables.rc.pageCount+1&'&sort='&variables.rc.sort)#">Next</a>
			</cfif>
		</p>
	</cfoutput>
</div>
