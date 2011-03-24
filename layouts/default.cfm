<!---
	ZeBlog
	Author: Zachary Pudil
	File: layouts/default.cfm
		the base template for all pages
		in the web app.
--->
<!DOCTYPE html>
<cfsetting showDebugOutput="No" />
<cfoutput>
<html>
	<head>
		<meta name="description" content="Advanced CSS showcase">
		<meta name="keywords" content="css, html, javascript, other stuff">
		<title>ZeBLOG</title>
		<link rel="stylesheet" type="text/css" href="includes/css/color.css">
		<link rel="stylesheet" type="text/css" href="includes/css/#session.style#">
		<script type="text/javascript">
			function showOrHidePicker() {
				picker = document.getElementById("picker");
				clicker = document.getElementById("clicker");
				if(picker.style.display == 'none') {
					picker.style.display = 'block';
					clicker.setAttribute('class', 'click');
				} else {
					picker.style.display = 'none';
					clicker.setAttribute('class', 'unclick');
				}
			}

			function changeColor(color) {
				var req = window.XMLHttpRequest ? new XMLHttpRequest() : new ActiveXObject("Microsoft.XMLHTTP");
				req.open("GET", "index.cfm?action=main.color&color="+color, true);
				req.send(null);
				req.onreadystatechange = function() {
					window.location.reload();
				};
			}
		</script>
	</head>

	<body>
		<div class="colorchooser">
			<p onclick="showOrHidePicker()" id="clicker" class="unclick">Color</p>
			<div id="picker" style="display: none;">
				<ul>
					<li id="green" onclick='changeColor(this.id)'>Green</li>
					<li id="blue" onclick='changeColor(this.id)'>Blue</li>
					<li id="brown" onclick='changeColor(this.id)'>Brown</li>
				</ul>
			</div>	
		</div>
		<div class="preheader">
		<!---
			use application.logged_in to determine
			the content of the preheader
		--->
			<cfif not session.logged_in>
				<p><a href="#buildURL(action='auth.index')#">Login</a> | <a href="#buildURL(action='auth.register')#">Sign Up</a></p>
			<cfelse>
				<p><a href="#buildURL(action='auth.logout')#">Logout</a></p>
			</cfif>
		</div>
		<div class="header">
			<h1>ZeBLOG</h1>
		</div>
		<div class="navmenu">
			<!---
				 set the width of the nav div
					based on whether we have an administrator or not.
			--->
			<cfif not session.isAdmin>
				<div class="navcontent" style="width: 700px; margin: auto; margin-left: 180px;">
			<cfelse>
				<div class="navcontent" style="width: 900px; margin: auto; margin-left: 80px;">
			</cfif>
				<!---
					make a li element of class selected based on the rc.action
				--->
				<ul>
					<cfif rc.action.startsWith("main") or rc.action.startsWith("auth")>
						<li class="selected"><a href="index.cfm">Home</a></li>
					<cfelse>
						<li class><a href="index.cfm">Home</a></li>
					</cfif>
					<li><a href="">Archive</a></li>
					<li><a href="">People</a></li>
					<li><a href="">Guestbook</a></li>
					<cfif session.isAdmin>
						<cfif rc.action.startsWith("admin")>
							<li class="selected"><a href="#buildURL(action='admin.index')#">Admin</a></li>
						<cfelse>
							<li><a href="#buildURL(action='admin.index')#">Admin</a></li>
						</cfif>
					</cfif>
				</ul>
			</div>
		</div>
		<div class="content">
			<!--- set the content of the side nav
						based on the rc.action variable.
			--->
			<cfif rc.action eq "main.index">
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
			<cfelseif rc.action eq "main.viewblog">
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
			<cfelseif rc.action eq "auth.index" or rc.action eq "auth.register">
				<div class="left">
					<cfif rc.action eq "auth.index">
						<div class="navbox" id="selected"><a href="#buildURL(action='auth.index')#">Login</a></div>
						<div class="navbox"><a href="#buildURL(action='auth.register')#">Register</a></div>
					<cfelse>
						<div class="navbox"><a href="#buildURL(action='auth.index')#">Login</a></div>
						<div class="navbox" id="selected"><a href="#buildURL(action='auth.register')#">Register</a></div>
					</cfif>
				</div>
			<cfelseif rc.action eq "admin.index" 
				or rc.action eq "admin.moderate" 
				or rc.action eq "admin.moderate_search"
				or rc.action eq "admin.manage">
				<div class="left">
					<cfif rc.action eq "admin.index">
						<div class="navbox" id="selected"><a href="#buildURL(action='admin.index')#">Create</a></div>
					<cfelse>
						<div class="navbox"><a href="#buildURL(action='admin.index')#">Create</a></div>
					</cfif>
					<cfif rc.action eq "admin.moderate" or rc.action eq "admin.moderate_search">
						<div class="navbox" id="selected"><a href="#buildURl(action='admin.moderate')#">Moderate</a></div>
					<cfelse>
						<div class="navbox"><a href="#buildURL(action='admin.moderate')#">Moderate</a></div>
					</cfif>
					<cfif rc.action eq "admin.manage">
						<div class="navbox" id="selected"><a href="#buildURL(action='admin.manage')#">Manage</a></div>
					<cfelse>
						<div class="navbox"><a href="#buildURL(action='admin.manage')#">Manage</a></div>
					</cfif>
				</div>
			</cfif>
			<div class="right">
				<br />
				<div class="infobox">
						<!---
							put site content inside the infobox div.
						--->
						<cfoutput>#body#</cfoutput>
				</div>
			</div>
		</div>
		<div class="footer">
			<p>
				<a href="">About</a> | 
				<a href="">Terms</a> |
				<a href="">Privacy</a> |
				<a href="">Contact</a>
			</p>
			<p>Copyright &copy; 2010 Zack Pudil</p>
		</div>
	</body>
</html>
</cfoutput>
