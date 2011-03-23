<div>
	<h1>New Blog</h1>
	<div class="form">
		<form action="index.cfm?action=admin.createblog" method="post">
			<p>
				<label for="title">Title</label>
				<input type="text" id="title" name="title" />
			</p>
			<p>
				<label for="text">Body</label>
				<textarea id="text" name="text" rows="5" cols="45"></textarea>
			</p>
			<p align="center"><input type="submit" value="Post" /></p>
		</form>
		<cfif structKeyExists(variables.rc, "message")>
			<p class="error" align="center"><cfoutput>#variables.rc.message#</cfoutput></p>
		</cfif>
	</div>
</div>
