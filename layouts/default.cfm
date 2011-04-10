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
		<link rel="stylesheet" type="text/css" href="includes/css/style.cfm?colorChoice=#session.style#">
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
			<!---
				put site content inside the infobox div.
			--->
			<cfoutput>#body#</cfoutput>
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
