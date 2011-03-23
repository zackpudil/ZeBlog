<div>
	<h1>Latest Blogs</h1>
	<cfset startAt = rc.pageCount*3 />
	<cfset endAt = startAt+3 />
	<cfoutput>
		<cfloop query="rc.blogs" startRow="#startAt+1#" endRow="#endAt#">
			<div class="blog">
				<h2><a href='index.cfm?action=main.viewblog&id=#rc.blogs.BlogID#'>#rc.blogs.Title#</a></h2>
				<hr />
				<p>#DateFormat(rc.blogs.Date, "long")#</p>
				<p>#rc.blogs.text#</p>
				<p class="meta">(#rc.blogs.CommentCount#) comments (#rc.blogs.Views#) views</p>
			</div>
		</cfloop>
		<p align='center' class='nav'>
			<cfif rc.pageCount gte 1>
				<a href='?pageCount=#rc.pageCount-1#&sort=#rc.sort#'>Prev</a>  |
			</cfif>
			<cfif (rc.pageCount*3)+3 lt rc.blogs.recordCount>
				| <a href='?pageCount=#rc.pageCount+1#&sort=#rc.sort#'>Next</a>
			</cfif>
		</p>
	</cfoutput>
</div>
