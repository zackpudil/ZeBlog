<!---
	ZeBlog
	Author: Zachary Pudil
	File: layouts/main/index.cfm
		file for the layout of
		the index view.
--->

<cfoutput>
<div class="left">
	<cfif rc.sort eq 'date'>
		<div class="navbox" id="selected">
			<a href="#buildURL(action='main.index?sort=date')#">Latest</a>
		</div>
	<cfelse>
		<div class="navbox">
			<a href="#buildURL(action='main.index?sort=date')#">Latest</a>
		</div>
	</cfif>
	<cfif rc.sort eq 'category'>
		<div class="navbox" id="selected">
			<a style='font-size: 1.6em; margin-top: 3px' href="#buildURL(action='main.index?sort=category')#">Categories</a>
		</div>
	<cfelse>
		<div class="navbox">
			<a style='font-size: 1.6em; margin-top: 3px' href="#buildURL(action='main.index?sort=category')#">Categories</a>
		</div>
	</cfif>
	<cfif rc.sort eq 'viewed'>
		<div class="navbox" id="selected">
			<a style='font-size: 1.4em; margin-top: 6px' href="#buildURL(action='main.index?sort=category')#">Most Viewed</a>
		</div>
	<cfelse>
		<div class="navbox">
			<a style='font-size: 1.4em; margin-top: 6px' href="#buildURL(action='main.index?sort=viewed')#">Most Viewed</a>
		</div>
	</cfif>
	<cfif rc.sort eq 'commented'>
		<div class="navbox" id="selected">
			<a style='font-size: 1.4em; margin-top: 6px' href="#buildURL(action='main.index?sort=commented')#">Most Debated</a>
		</div>
	<cfelse>
		<div class="navbox">
			<a style='font-size: 1.4em; margin-top: 6px' href="#buildURL(action='main.index?sort=commented')#">Most Debated</a>
		</div>
	</cfif>
</div>
<div class="right"><br />
	<div class="infobox">
		<div id="main-index">
			#body#
		</div>
	</div>
</div>
</cfoutput>
