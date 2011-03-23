<!---
	ZeBlog
	Author: Zachary Pudil
	File: views/admin/index.cfm
		View for the index action.
			provide a from for the admin to crate a blog.
--->
<div>
	<h1>New Blog</h1>
	<div class="form">
		<cfoutput>
			<form action="#buildURL(action='admin.createblog')#" method="post">
		</cfoutput>
			<p>
				<label for="title">Title</label>
				<input type="text" id="title" name="title" 
						<cfif structKeyExists(variables.rc, "title")>
							<cfoutput>value="#variables.rc.title#"</cfoutput>
						</cfif> />
			</p>
			<p>
				<label for="text">Body</label>
				<textarea id="text" name="text" rows="5" cols="45"></textarea>
			</p>
			<p>
				<p id="date_label">Date To Post</p>
				<hr />
				<label for="month">Month: </label>
				<!---
					use the date add to only give options from now to six months
					from now.
				--->
				<select id="month" name="month" onchange="setDaysInMonth(this.value-1)">
					<cfloop index="i" from="0" to="6" step="1">
						<cfoutput>
							<option value="#Month(dateAdd("m", +i, now()))#">
								#DateFormat(dateAdd("m", +i, now()), "mmmmmmmm")#
							</option>
						</cfoutput>
					</cfloop>
				</select>

				<label for="day">Day: </label>
				<!---
					the day select item is populated in the script tag at the
					end of the form.
				--->
				<select id="day" name="day">
				</select>

				<label for="year">Year: </label>
				<!---
					loop through the dateAdd("m", +i) variable again.
					if the year is different for one of them, then
					display the year.  This is in case that six months
					from now it will be a different year.
				--->
				<select id="year" name="year">
					<cfloop index="i" from="0" to="6" step="1">
						<cfoutput>
							<cfif i eq 0>
								<option value="#Year(dateAdd('m', +i, now()))#">
									#DateFormat(dateAdd('m', +i, now()), 'yyyy')#
								</option>
							</cfif>
							<cfif Year(dateAdd('m', +i, now())) neq Year(dateAdd('m', +(i-1), now()))>
								<option value="#Year(dateAdd('m', +i, now()))#">
									#DateFormat(dateAdd('m', +i, now()), 'yyyy')#
								</option>
							</cfif>
						</cfoutput>
					</cfloop>
				</select>
				<cfoutput>
					<script type="text/javascript">
						/**
						* function to populate the day select DOM object.
						* to get the number of days in the month, you overflow the
						* the day variable which will return the date of the month after
						* it, the you subtract 32 by that, and you have the number of
						* days in that month.  It even counts leap years.
						* @param - month: the month in zero based integer format.
						*/
						function setDaysInMonth(month) {
							var year = document.getElementById("year").value;
							var days = 32-new Date(year, month, 32).getDate();
							var dayObj = document.getElementById("day");
							dayObj.innerHTML = "";
							for(var i = 1; i <= days; i++) {
								dayObj.innerHTML += "<option value='"+i+"'>"+i+"</option>";
							}
						}

						//the onchange event handler is not fired at page
						//load up.
						setDaysInMonth(new Date().getMonth());
						//set the date for today.
						document.getElementById('month').value = #Month(now())#;
						document.getElementById('day').value = #Day(now())#;
						document.getElementById('year').value = #Year(now())#;

						<cfif structKeyExists(variables.rc, "text")>
							document.getElementById('text').value = "#variables.rc.text#";
						</cfif>

					</script>
				</cfoutput>
			</p>
			<p align="center"><input type="submit" value="Post" /></p>
		</form>
		<!---
			if there is a error message, display it.
		--->
		<cfif structKeyExists(variables.rc, "message")>
			<p class="error" align="center"><cfoutput>#variables.rc.message#</cfoutput></p>
		</cfif>
	</div>
</div>
