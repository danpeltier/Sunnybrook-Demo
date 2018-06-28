<cfif IsDefined("form.fname")>
	<cfset encpassword = Hash(reverse(trim(form.emailaddr)) & trim(form.pword & "rxfi"),"sha-1")>
	<cfset uuid = "">
	<cfquery datasource="main" name="getuuid">
		select uuid() as newuuid
	</cfquery>
	<cfoutput query="getuuid">
		<cfset uuid = newuuid>
	</cfoutput>
		
	<cfquery datasource="main">
	insert into users(id,firstname, lastname, emailaddress, username, encpass, accessLevel, registrationdate, verified)
	values('#uuid#','#replace(form.fname,"'","''","all")#',
		'#replace(form.lname,"'","''","all")#',
		'#replace(form.emailaddr,"'","''","all")#',
		'#replace(form.uname,"'","''","all")#',
		'#encpassword#',
		1, now(), 0)
	</cfquery>
	<cfheader statuscode="301" statustext="Redirect">
	<cfheader name="Location" value="login.cfm?success=register">
	<cfabort>
</cfif>
<cfif IsDefined("cookie.username")>
		<cfheader statuscode="301" statustext="Redirect">
		<cfheader name="Location" value="index.cfm">
		<cfabort>
</cfif>
<cfset headertext = "Register - ">
<cfinclude template="header.cfm">
    <div class="container my-3" ng-app="myapp">
		<form method="post" action="register.cfm" ng-controller="signup">
		<table class="table table-striped login-tbl">
			<thead>
				<th class="text-center">Register</th>
			</thead>
			<tbody>
				<tr>
					<td><div class="reqd" data-toggle="tooltip" title="Required Field">*</div>First Name:</td>
				</tr>
				<tr>
					<td><input type="text" name="fname" id="fname" required></td>
				</tr>
				<tr>
					<td><div class="reqd" data-toggle="tooltip" title="Required Field">*</div>Last Name:</td>
				</tr>
				<tr>
					<td><input type="text" name="lname" id="lname" required></td>
				</tr>
				<tr>
					<td><div class="reqd" data-toggle="tooltip" title="Required Field">*</div>Email Address:</td>
				</tr>
				<tr>
					<td><div id="emailaddr-holder" class="check"><div class="progress-bar progress-bar-striped progress-bar-animated bg-success" style="width:100%; height:34px;"></div><div class="check-cover">&nbsp;</div></div><input type="text" ng-model="emailAddress" ng-keyup="checkEmail()" name="emailaddr" id="emailaddr" required>
					<div id="emailaddr-status" ng-class="addClass(emailstatus)" >{{ emailstatus }}&nbsp;</div>
					</td>
				</tr>

				<tr>
					<td><div class="reqd" data-toggle="tooltip" title="Required Field">*</div>Username:</td>
				</tr>
				<tr>
					<td><div id="uname-holder" class="check"><div class="progress-bar progress-bar-striped progress-bar-animated bg-success" style="width:100%; height:34px;"></div><div class="check-cover">&nbsp;</div></div><input type="text" ng-model="userName" ng-keyup="checkUsername()" name="uname" id="uname" required>
					<div id="uname-status" ng-class="addUClass(unamestatus)">{{ unamestatus }}&nbsp;</div></td>
				</tr>
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
			</tbody>
		</table>
		<div class="mt-2 text-center">
			<button id="reg-btn" type="submit" class="btn btn-success" disabled>Register</button>
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

	<script type="text/javascript" src="js/angular-1.2.4.min.js"></script>
	
	<script>
		
	// script for checking form fields (email, username, password, confirm password)
		
var fetch = angular.module('myapp', []);
		
fetch.controller('signup', function ($scope, $http) {
 
 // Check Email Address 
 $scope.checkEmail = function(){
	 
	 $("#emailaddr-status").css({"visibility":"hidden"});
	 if($scope.emailAddress == undefined){
		 showXmark("#emailaddr-holder");
	 }
	 else{
		 showProgress("#emailaddr-holder");
	 }

	 // check if email address
	 var emailRegex = new RegExp("[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
	 if(!emailRegex.test($scope.emailAddress)){
		 $scope.emailstatus = "Not a valid email address";
		 $("#emailaddr-status").css({"visibility":"visible"});
		 showXmark("#emailaddr-holder");
	 }
	 else{
		 $http({
		   method: 'post',
		   url: 'check-field.cfm',
		   data: {checkemail: $scope.emailAddress}
		  }).then(function successCallback(response) {
		   $scope.emailstatus = response.data;
			 $("#emailaddr-status").css({"visibility":"visible"});
			 if(response.data.toString().trim() == "Available" && $scope.emailAddress != ""){
					 showCheckmark("#emailaddr-holder");
			 }
			 if(response.data.toString().trim() == "Not Available" || $scope.emailAddress != ""){
					 showXmark("#emailaddr-holder");
			 }
			 if(response.data.toString().trim() == "Unknown"){
				 hideProgress("#emailaddr-holder");
			 }
		  });
		 }
	 }
	 

 // Set email class
 $scope.addClass = function(emailstatusfull){
	 var emailstatus;
	 if(emailstatusfull) emailstatus = emailstatusfull.toString().trim();
  if(emailstatus == 'Available'){
   return 'exists';
  }else if(emailstatus == 'Not Available' || emailstatus == "Not a valid email address"){
   return 'not-exists';
  }else{
   return 'still-checking';
  }
 }
 
 
 // Check Username 
 $scope.checkUsername = function(){
	 
	 $("#uname-status").css({"visibility":"hidden"});
	 if($scope.userName == undefined){
		 showXmark("#uname-holder");
	 }
	 else{
		 showProgress("#uname-holder");
	 }

 $http({
   method: 'post',
   url: 'check-field.cfm',
   data: {checkuname: $scope.userName}
  }).then(function successCallback(response) {
   $scope.unamestatus = response.data;
	 $("#uname-status").css({"visibility":"visible"});
	 if(response.data.toString().trim() == "Available" && $scope.userName != ""){
		 	 showCheckmark("#uname-holder");
	 }
	 if(response.data.toString().trim() == "Not Available" || $scope.userName != ""){
		 	 showXmark("#uname-holder");
	 }
	 if(response.data.toString().trim() == "Unknown"){
		 hideProgress("#uname-holder");
	 }
  });
 }

 // Set username class
 $scope.addUClass = function(unamestatusfull){
	 var Unamestatus;
	 if(unamestatusfull) Unamestatus = unamestatusfull.toString().trim();
  if(Unamestatus == 'Available'){
   return 'exists';
  }else if(Unamestatus == 'Not Available'){
   return 'not-exists';
  }else{
   return 'still-checking';
  }
 }
 
 
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