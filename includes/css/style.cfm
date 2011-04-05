<cfcontent type="text/css" />
<cfparam name="url.colorChoice" default="green" />

<cfset colorIndex = 1>
<cfset colors = arrayNew(2)>

<cfset colors[1][1] = "##C4FFCB" />
<cfset colors[1][2] = "green" />
<cfset colors[1][3] = "##00D419" />
<cfset colors[1][4] = "##D2FAD7" />
<cfset colors[1][5] = "##D9FCC7" />
<cfset colors[1][6] = "##D9FCAF" />
<cfset colors[1][7] = "##00FF00" />
<cfset colors[1][8] = "##D9FCA7" />
<cfset colors[1][9] = "##080" />

<cfset colors[2][1] = "##B3CAFC" />
<cfset colors[2][2] = "blue" />
<cfset colors[2][3] = "##5374E0" />
<cfset colors[2][4] = "##BFCBF2" />
<cfset colors[2][5] = "##567AF0" />
<cfset colors[2][6] = "##88AFF2" />
<cfset colors[2][7] = "##000099" />
<cfset colors[2][8] = "##88AFF2" />
<cfset colors[2][9] = "##008" />

<cfset colors[3][1] = "##9C7B59" />
<cfset colors[3][2] = "##663300" />
<cfset colors[3][3] = "##8C6F50" />
<cfset colors[3][4] = "##A37547" />
<cfset colors[3][5] = "##BF9E7E" />
<cfset colors[3][6] = "##997E65" />
<cfset colors[3][7] = "##754719" />
<cfset colors[3][8] = "##997E57" />
<cfset colors[3][9] = "##663300" />

<cfswitch expression="#url.colorChoice#">
	<cfcase value="green">
		<cfset colorIndex = 1 />
	</cfcase>
	
	<cfcase value="blue">
		<cfset colorIndex = 2 />
	</cfcase>
	
	<cfcase value="brown">
		<cfset colorIndex = 3 />
	</cfcase>
</cfswitch>


<cfoutput>
body {
	font-family: arial, sans-serif;
	background-color: #colors[colorIndex][1]#;
}

.preheader {
	margin: 0px;
	margin-bottom: 10px;
	padding: 0px;
}

.preheader p {
	text-align: right;
	margin: 0px;
	padding: 0px;
}

.preheader a {
	text-decoration: none;
	color: #colors[colorIndex][2]#;
	font-size: 1.4em;
}

.header {
	width: 997px;
	height: 100px;
	margin: auto;
	margin-top: 0px;
	padding: 0px;
	color: #colors[colorIndex][2]#;
	background-color: #colors[colorIndex][3]#;

	border-top-left-radius: 50px;
	border-top-right-radius: 50px;

	-moz-border-radius-topleft: 50px;
	-moz-border-radius-topright: 50px;

	border: 2px solid #colors[colorIndex][2]#;
	border-bottom: 0px;

	-webkit-box-shadow: 0px -2px 4px #colors[colorIndex][2]#;
	-moz-box-shadow: 0px -2px 4px #colors[colorIndex][2]#;
}

.header h1 {
	margin: 0px;
	margin-top: 7px;
	text-align: center;
	font-size: 5em;
}

.navmenu {
	width: 997px;
	height: 40px;
	
	margin: auto;
	margin-top: 0px;
	padding: 0px;

	background-color: #colors[colorIndex][3]#;

	border: 2px solid #colors[colorIndex][2]#;
	border-bottom: 2px solid #colors[colorIndex][2]#;
	border-top: 0px;
}

.navmenu ul {
	margin: 0px;
	padding: 0px;
	display: inline;
}

.navmenu ul li {
	list-style: none;
	text-align: center;
	float: left;
	width: 160px;
	margin: 5px 1px 5px 1px;
	color: #colors[colorIndex][2]#;

	border-top-right-radius: 10px;
	border-top-left-radius: 10px;

	-moz-border-radius-topright: 10px;
	-moz-border-radius-topleft: 10px;

	-webkit-box-shadow: 0px 0px 5px #colors[colorIndex][2]#;
	-moz-box-shadow: 0px 0px 5px #colors[colorIndex][2]#;
}

.navmenu ul li:hover, .navmenu ul li.selected {
	padding: 0px 5px 0px 5px;
	-webkit-box-shadow: 0px -3px 10px #colors[colorIndex][2]#;
	-moz-box-shadow: 0px -3px 10px #colors[colorIndex][2]#;
}

.navmenu ul li a {
	text-decoration: none;
	font-size: 1.8em;
	color: #colors[colorIndex][2]#;

	padding: 0px 5px 0px 5px;
}

.content {
	background-color: #colors[colorIndex][4]#;

	width: 997px;
	margin: auto;

	border-right: 2px solid #colors[colorIndex][2]#;
	border-left: 2px solid #colors[colorIndex][2]#;

}

.content .left {
	clear: both;
	width: 150px;

	float: left;
	margin: 0px;
	margin-top: 20px;
	margin-left: 7px;
	padding: 0px;
}

.content .right {
	width: 641px;
	margin: 0px;
	padding: 0px;

	margin-left: 156px;
}

.navbox {
	width: 73px;
	height: 40px;
	margin-top: 10px;
	margin-left: 74px;

	background-color: #colors[colorIndex][3]#;

	border: 2px solid #colors[colorIndex][2]#;

	border-radius: 20px;
	border-top-right-radius: 0px;
	border-bottom-right-radius: 0px;

	-moz-border-radius: 20px;
	-moz-border-radius-topright: 0px;
	-moz-border-radius-bottomright: 0px;

	-webkit-box-shadow: 0px 0px 10px #colors[colorIndex][2]#;
	-moz-box-shadow: 0px 0px 10px #colors[colorIndex][2]#;

	text-align: center;
}

.navbox:hover, .navbox##selected {
	margin: auto;
	margin-top: 10px;
	margin-left: 2px;
	width: 145px;
}

.navbox:hover a, .navbox##selected a {
	display: block;
}

.navbox p {
	color: #colors[colorIndex][2]#;
	font-size: 2em;
}

.navbox a {
	color: #colors[colorIndex][2]#;
	text-decoration: none;
	font-size: 2em;
	display:none;
}

.infobox {
	width: 800px;

	background-color: #colors[colorIndex][5]#;
	margin: auto;
	margin-top: -5px;
	margin-bottom: 8px;

	padding: 0px 0px 15px 0px;

	border: 3px solid #colors[colorIndex][2]#;
	
	-webkit-box-shadow: -4px -3px 4px gray;
	-moz-box-shadow: -4px -3px 4px gray;
}

.infobox div {
	margin-left: 10px;
	padding-right: 10px;
	margin-bottom: 10px;
}

.infobx hr {
	height: 1px;
	border: 1px solid #colors[colorIndex][2]#;
}

.infobox  label {
	font-size: 1.8em;
	text-align: center;
	color: #colors[colorIndex][2]#;
	font-weight: bold;
}

.infobox div h1 {
	color: #colors[colorIndex][2]#;
	text-align: center;
}

.infobox div h1 a {
	color: #colors[colorIndex][2]#;
	text-decoration: none;
}

.infobox div h1 a:hover {
	text-decoration: underline;
}

.infobox div h2 {
	color: #colors[colorIndex][2]#;
}

.infobox p.nav {
	color: #colors[colorIndex][2]#;
	font-size: 2.0em;
}

.infobox p.nav a {
	color: #colors[colorIndex][2]#;
	text-decoration: none;
}

.infobox .error {
	color: red;
}

.infobox .blog {
	color: #colors[colorIndex][2]#;
	margin-top: 5px;
	border: 2px solid #colors[colorIndex][2]#;
	border-radius: 10px;
	-moz-border-radius: 10px;
	margin-bottom: 50px;
	padding: 10px;
	font-weight: bold;
	background-color: #colors[colorIndex][6]#;
	-webkit-box-shadow: 10px 10px 5px #colors[colorIndex][9]#;
	-moz-box-shadow: 10px 10px 5px #colors[colorIndex][9]#;
}

.infobox .blog p {
	font-size: 1.3em;
}

.infobox .blog p.meta {
	font-weight: normal;
	font-style: italic;
}

.infobox .blog h2 {
	margin: 0px;
}

.infobox .blog h2 a {
	text-decoration: none;
	color: #colors[colorIndex][2]#;
}

.infobox .blog h2 a:hover {
	text-decoration: underline;
}

.infobox .blog p.meta {
	font-weight: normal;
	font-style: italic;
}

.infobox .mod {
	font-size: 1.4em;
	font-weight: bold;
	color: #colors[colorIndex][2]#;
}

.infobox .mod a {
	color: #colors[colorIndex][2]#;
}

.infobox .blog p {
	font-size: 1.3em;
}

.infobox .form {
	color: #colors[colorIndex][2]#;
	width: 700px;
	margin: auto;
	margin-top: 15px;
	padding-left: 20px;
	padding-right: 20px;
	margin-bottom: 15px;
	border: 2px solid #colors[colorIndex][2]#;
	border-radius: 20px;
	-moz-border-radius: 20px;
}

.infobox .form input[type="submit"] {
	background-color: #colors[colorIndex][7]#;
	width: 190px;
	color: #colors[colorIndex][2]#;
	font-size: 2.0em;
	border-radius: 30px;
}

.infobox .form input[type="text"], 
.infobox	.form input[type="password"], 
.infobox .form textarea {
	background-color: #colors[colorIndex][8]#;
	color: #colors[colorIndex][2]#;
	font-size: 1.3em;
	border-radius: 10px;
	-moz-border-radius: 10px;
}

.infobox .form fieldset {
	border: 2px solid #colors[colorIndex][2]#;
}

.infobox .form fieldset legend {
	font-size: 1.3em;
}

.infobox .form select {
	font-size: 1.5em;
	color: #colors[colorIndex][2]#;
	background-color: #colors[colorIndex][8]#;
}

.infobox .form option {
	color: #colors[colorIndex][2]#;
	background-color: #colors[colorIndex][8]#;
}

.infobox .form ##date_label {
	font-size: 1.9em;
	font-weight: bold;
	margin-bottom: 3px;
}
.infobox .form ##title {
	margin-left: 13px;
}

.infobox .comment {
	padding: 0px;
	padding-left: 10px;
	border: 3px solid #colors[colorIndex][2]#;	
}

.infobox .comment h3 {
	text-align: center;
	color: #colors[colorIndex][2]#;
}

.infobox .comment p {
	font-size: 1.3em;
	color: #colors[colorIndex][2]#;
	font-weight: bold;
}

.infobox ##auth-index p {
	text-align: center;
}

.infobox ##auth-index p a {
	text-decoration: none;
	font-size: 2em;
	color: #colors[colorIndex][2]#;
}
.footer {
	background-color: #colors[colorIndex][3]#;
	width: 997px;
	height: 75px;
	margin: auto;

	border: 2px solid #colors[colorIndex][2]#;

	border-bottom-right-radius: 50px;
	border-bottom-left-radius: 50px;
	-moz-border-radius-bottomright: 50px;
	-moz-border-radius-bottomleft: 50px;

	-webkit-box-shadow: 0px 2px 2px #colors[colorIndex][2]#;
	-moz-box-shadow: 0px 2px 2px #colors[colorIndex][2]#;
}

.footer p {
	color: #colors[colorIndex][2]#;
	text-align: center;
}

.footer p a {
	color: #colors[colorIndex][2]#;
	text-decoration: none;
}

</cfoutput>