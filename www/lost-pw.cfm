<cfif IsDefined("form.pword")>
	<cfquery name="updatelostlink" datasource="main">
		update lostlinks set emailaddress = '*#form.lostlinkemail#' where emailaddress = '#form.lostlinkemail#'
	</cfquery>
	<cfset encpassword = Hash(reverse(trim(form.lostlinkemail)) & trim(form.pword & "rxfi"),"sha-1")>
	<cfquery name="updatepw" datasource="main">
		update users set encpass = '#encpassword#' where emailaddress = '#replace(form.lostlinkemail,"'","''","all")#'
	</cfquery>
	<cfheader statuscode="301" statustext="Redirect">
	<cfheader name="Location" value="login.cfm?success=changepw">
	<cfabort>
</cfif>
<cfif IsDefined("url.l")>
	<cfset chklink = "">
	<cfquery name="checklink" datasource="main">
		select * from lostlinks where id = '#replace(url.l,"'","''","all")#' and now() < expirationdate
	</cfquery>
	<cfoutput query="checklink">
		<cfset chklink = emailaddress>
	</cfoutput>
</cfif>
<cfif IsDefined("form.emailaddr")>
	<cfset useremail = "">
	<cfquery name="getemail" datasource="main">
		select emailaddress from users where emailaddress = '#replace(form.emailaddr,"'","''","all")#'
	</cfquery>
	<cfoutput query="getemail">
		<cfset useremail = emailaddress>
	</cfoutput>
	<cfif useremail eq "">
		<cfheader statuscode="301" statustext="Redirect">
		<cfheader name="Location" value="lost-pw.cfm?error=invalid">
		<cfabort>
	</cfif>
	<cfset uuid = "">
	<cfquery name="getuuid" datasource="main">
		select uuid() as newuuid
	</cfquery>
	<cfoutput query="getuuid">
		<cfset uuid = newuuid>
	</cfoutput>
	<cfquery name="createlostlink" datasource="main">
		insert into lostlinks(id,emailaddress,expirationdate)
		values('#uuid#','#replace(form.emailaddr,"'","''","all")#',date_add(now(), INTERVAL 7 DAY))
	</cfquery>
	<cfmail to="#useremail#"
		from="dan@cyberspaciousness.com"
		subject="Password Reset"
		type="html">
		<h1>Lost Password Request</h1>

		<img src="http://cyberspaciousness.com/sunnybrook/images/logo.jpg" alt="space" style="border-radius:5px; background-color:white; border:3px double black; float:left; margin-right:10px; margin-botto:10px;">
		<p>
		You are receiving this because a request was made to change your password.
		</p>
		<p>
		If you did not request a password change, please ignore this email.
		</p>
		<p>
		You may use the following link within the next 7 days to change your password
		</p>
		<p>
			<a href="http://cyberspaciousness.com/sunnybrook/lost-pw.cfm?l=<cfoutput>#uuid#</cfoutput>" target="_blank">http://cyberspaciousness.com/sunnybrook/lost-pw.cfm?l=<cfoutput>#uuid#</cfoutput></a>
		</p>

		Dan @ Cyberspaciousness.com

	</cfmail>
	<cfheader statuscode="301" statustext="Redirect">
	<cfheader name="Location" value="index.cfm?success=lostpw&t=#Now()#">
	<cfabort>
</cfif>
<cfif IsDefined("cookie.username")>
	<cfif cookie.username neq "">
		<cfheader statuscode="301" statustext="Redirect">
		<cfheader name="Location" value="index.cfm">
		<cfabort>
	</cfif>
</cfif>
<cfset headertext = "Lost Password - ">
<cfinclude template="header.cfm">

		<cfif IsDefined("url.error")>
			<cfif url.error eq "invalid">
				<div class="alert alert-danger alert-dismissible">
				  <button type="button" class="close" data-dismiss="alert">&times;</button>
				  Invalid Email Address
				</div>
			</cfif>
		</cfif>
    <div class="container my-3" ng-app="myapp">
		<form method="post" action="lost-pw.cfm" ng-controller="signup">
		<table class="table table-striped login-tbl">
			<thead>
				<th class="text-center">Lost Password</th>
			</thead>
			<tbody>
				<tr>
					<td><div class="reqd" data-toggle="tooltip" title="Required Field">*</div>Email Address:</td>
				</tr>
				<tr>
					<cfif IsDefined("chklink")>
						<td><cfoutput>#chklink#</cfoutput></td>
					<cfelse>
						<td><input type="email" name="emailaddr" id="emailaddr" required></td>
					</cfif>
				</tr>
				<cfif IsDefined("chklink")>
					<input type="hidden" name="lostlinkemail" value="<cfoutput>#chklink#</cfoutput>">
					<tr>
						<td><div class="reqd" data-toggle="tooltip" title="Required Field">*</div>Password:</td>
					</tr>
					<tr>
						<td><div id="pword-holder" class="check"><div class="progress-bar progress-bar-striped progress-bar-animated bg-success" style="width:100%; height:34px;"></div><div class="check-cover">&nbsp;</div></div><input type="password" ng-model="passWord" ng-keyup="checkPassword()" name="pword" id="pword" required>
						<div id="pword-status">{{ pwordstatus }}&nbsp;</div></td>
					</tr>
					<tr>
						<td><div class="reqd" data-toggle="tooltip" title="Required Field">*</div>Confirm Password:</td>
					</tr>
					<tr>
						<td><div id="cpword-holder" class="check"><div class="progress-bar progress-bar-striped progress-bar-animated bg-success" style="width:100%; height:34px;"></div><div class="check-cover">&nbsp;</div></div><input type="password" ng-model="cpassWord" ng-keyup="checkCPassword()" name="cpword" id="cpword" required>
						<div id="cpword-status">{{ cpwordstatus }}&nbsp;</div></td>
					</tr>
				</cfif>
			</tbody>
		</table>
		<div class="mt-2 text-center">
			<button id="reg-btn" type="submit" class="btn btn-success">Submit</button>
		</div>
		</form>
    </div>

<cfinclude template="footer.cfm">

	<script type="text/javascript" src="js/angular-1.2.4.min.js"></script>
	
	<script>
		
	// script for checking form fields (email, username, password, confirm password)
		
var fetch = angular.module('myapp', []);
		
fetch.controller('signup', function ($scope, $http) {
 
 // check password:
 
 	var strongRegex = new RegExp("^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,})");

	var mediumRegex = new RegExp("^(((?=.*[a-z])(?=.*[A-Z]))|((?=.*[a-z])(?=.*[0-9]))|((?=.*[A-Z])(?=.*[0-9])))(?=.{6,})");

	$scope.checkPassword = function(){
		
		 if($scope.passWord == undefined){
			 showXmark("#pword-holder");
		 }
		 else{
			 showProgress("#pword-holder");
		 }
		
		
		if(strongRegex.test($scope.passWord)){
			$scope.pwordstatus = "Strong";
			$("#pword-status").css({"color":"green"});
			showCheckmark("#pword-holder");
		}
		else{
			if(mediumRegex.test($scope.passWord)){
				$scope.pwordstatus = "Medium";
				$("#pword-status").css({"color":"green"});
				showCheckmark("#pword-holder");
			}
			else{
				$scope.pwordstatus = "Weak";
				$("#pword-status").css({"color":"red"});
				showXmark("#pword-holder");
			}
		}
	}


	
	$scope.checkCPassword = function(){
		
		if($("#pword").val() != ""){
			 if($scope.cpassWord == undefined){
				 showXmark("#cpword-holder");
			 }
			 else{
				 showProgress("#cpword-holder");
			 }


			if($("#pword").val() == $scope.cpassWord){
				$scope.cpwordstatus = "Passwords Match";
				$("#cpword-status").css({"color":"green"});
				showCheckmark("#cpword-holder");
			}
			else{
				$scope.cpwordstatus = "Passwords DO NOT Match";
				$("#cpword-status").css({"color":"red"});
				showXmark("#cpword-holder");
			}
		}
		else{
				$scope.cpwordstatus = "Password not entered";
				$("#cpword-status").css({"color":"red"});
				showXmark("#cpword-holder");
		}
	}
	
	
	
});		
		
	</script>
	
	
</body>
</html>