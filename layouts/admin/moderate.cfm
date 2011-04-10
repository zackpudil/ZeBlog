<!---
	ZeBlog
	Author: Zachary Pudil
	File: layouts/admin/moderate.cfm
		layout for moderate view.
--->

<cfoutput>
<div class="left">
	<div class="navbox"><a href="#buildURL(action='admin.index')#">Create</a></div>
	<div class="navbox" id="selected"><a href="#buildURl(action='admin.moderate')#">Moderate</a></div>
	<div class="navbox"><a href="#buildURL(action='admin.manage')#">Manage</a></div>
</div>
<div class="right"><br />
	<div class="infobox">
		<div id="admin-moderate">
				#body#
		</div>
	</div>
</div>
</cfoutput>
