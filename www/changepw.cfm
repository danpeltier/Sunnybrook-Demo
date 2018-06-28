<cfif IsDefined("form.pword")>
	<cfset encpassword = Hash(reverse(trim(cookie.emailaddress)) & trim(form.pword & "rxfi"),"sha-1")>
	<cfquery datasource="main">
		update users set encpass = '#encpassword#' where emailaddress = '#replace(cookie.emailaddress,"'","''","all")#'
	</cfquery>
	<cfheader statuscode="301" statustext="Redirect">
	<cfheader name="Location" value="index.cfm?success=changedpw">
	<cfabort>
</cfif>
<cfif !IsDefined("cookie.username")>
		<cfheader statuscode="301" statustext="Redirect">
		<cfheader name="Location" value="index.cfm">
		<cfabort>
</cfif>
<cfset headertext = "Change Password - ">
<cfinclude template="header.cfm">
    <div class="container my-3" ng-app="myapp">
		<form method="post" action="changepw.cfm" ng-controller="signup">
		<table class="table table-striped login-tbl">
			<thead>
				<th class="text-center">Change Password</th>
			</thead>
			<tbody>
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
<!---	
	<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
--->
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