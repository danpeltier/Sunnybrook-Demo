<cfif IsDefined("form.uname")>
	<cfset useremail = "">
	<cfquery name="getemail" datasource="main">
		select emailaddress from users where username = '#replace(form.uname,"'","''","all")#'
	</cfquery>
	<cfoutput query="getemail">
		<cfset useremail = emailaddress>
	</cfoutput>
	<cfif useremail eq "">
		<cfheader statuscode="301" statustext="Redirect">
		<cfheader name="Location" value="login.cfm?error=invalid">
		<cfabort>
	</cfif>
	<cfset encpassword = Hash(reverse(trim(useremail)) & trim(form.pword & "rxfi"),"sha-1")>
	<cfquery name="checkpw" datasource="main">
		select * from users where emailaddress = '#replace(useremail,"'","''","all")#' and encpass = '#encpassword#'
	</cfquery>
	<cfset matchfound = 0>
	<cfset userfirstname = "">
	<cfoutput query="checkpw">
		<cfset matchfound = 1>
		<cfset userfirstname = #firstname#>
	</cfoutput>
	<cfif matchfound eq 1>
		
		<cfcookie name="username" value="#form.uname#">
		<cfcookie name="firstname" value="#userfirstname#">
		<cfcookie name="emailaddress" value="#useremail#">
			
		<cfheader statuscode="301" statustext="Redirect">
		<cfheader name="Location" value="index.cfm">
		<cfabort>
	<cfelse>
		<cfheader statuscode="301" statustext="Redirect">
		<cfheader name="Location" value="login.cfm?error=invalid">
		<cfabort>
	</cfif>
</cfif>
<cfif IsDefined("cookie.username")>
	<cfif cookie.username neq "">
		<cfheader statuscode="301" statustext="Redirect">
		<cfheader name="Location" value="index.cfm">
		<cfabort>
	</cfif>
</cfif>
<cfset headertext = "Login - ">
<cfinclude template="header.cfm">

    <div class="container my-3">
		<cfif IsDefined("url.success")>
			<cfif url.success eq "register">
				<div class="alert alert-success alert-dismissible">
				  <button type="button" class="close" data-dismiss="alert">&times;</button>
				  You have successfully registered.
				</div>
			</cfif>
			<cfif url.success eq "changepw">
				<div class="alert alert-success alert-dismissible">
				  <button type="button" class="close" data-dismiss="alert">&times;</button>
				  You have successfully changed your password.
				</div>
			</cfif>
		</cfif>
		<cfif IsDefined("url.error")>
			<cfif url.error eq "invalid">
				<div class="alert alert-danger alert-dismissible">
				  <button type="button" class="close" data-dismiss="alert">&times;</button>
				  Invalid Username and/or Password
				</div>
			</cfif>
		</cfif>
		<form method="post" action="login.cfm">
		<table class="table table-striped login-tbl">
			<thead>
				<th class="text-center">Login</th>
			</thead>
			<tbody>
				<tr>
					<td><div class="reqd" data-toggle="tooltip" title="Required Field">*</div>Username:</td>
				</tr>
				<tr>
					<td><input type="text" name="uname" id="uname" required></td>
				</tr>
				<tr>
					<td><div class="reqd" data-toggle="tooltip" title="Required Field">*</div>Password:</td>
				</tr>
				<tr>
					<td><input type="password" name="pword" id="pword" required></td>
				</tr>
			</tbody>
		</table>
		<div class="mt-2 text-center">
			<button type="submit" class="btn btn-success">Login</button>
		</div>
		<div class="mt-4 text-center">
			<div class="mb-2">
				<a href="lost-pw.cfm">Lost Password?</a>
			</div>
			<div>
				<a href="register.cfm">Not Registered?</a>
			</div>
		</div>
		</form>
    </div>

<cfinclude template="footer.cfm">
	
</body>
</html>