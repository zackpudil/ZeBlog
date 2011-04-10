<!---
	ZeBlog
	Author: Zachary Pudil
	File: layouts/main/viewblog.cfm
		file for the layout of
		the viewblog view.
--->

<cfoutput>
<div class="left">
	<div class="navbox">
		<a href="#buildURL(action='main.index?sort=date')#">Latest</a>
	</div>
	<div class="navbox">
		<a style='font-size: 1.6em; margin-top: 3px' href="#buildURL(action='main.index?sort=category')#">Categories</a>
	</div>
	<div class="navbox">
		<a style='font-size: 1.4em; margin-top: 6px' href="#buildURL(action='main.index?sort=category')#">Most Viewed</a>
	</div>
	<div class="navbox">
		<a style='font-size: 1.4em; margin-top: 6px' href="#buildURL(action='main.index?sort=commented')#">Most Debated</a>
	</div>
</div>
<div class="right"><br />
	<div class="infobox">
		<div id="viewblog">
			#body#
		</div>
	</div>
</div>
</cfoutput>
