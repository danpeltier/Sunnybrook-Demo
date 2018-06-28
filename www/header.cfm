<cfapplication name="rxfi" 
sessionmanagement="Yes" 
sessiontimeout=#CreateTimeSpan(0,0,45,0)#
setclientcookies="true"
setdomaincookies="true">
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><cfoutput>#headertext#</cfoutput>Sunnybrook Demo - Rx Fi - Medicine in Sci-Fi</title>
    <!-- Bootstrap -->
    <link href="https://fonts.googleapis.com/css?family=Aldrich|Amaranth|Audiowide|Exo|Orbitron|Righteous" rel="stylesheet">
    <link href="css/bootstrap-4.0.0.css" rel="stylesheet">
    <link href="css/custom.css" rel="stylesheet">
  </head>
  <body>
	<div class="remote-control" onclick="toggleNav();">
		&nbsp;
	</div>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
	  <div class="nav-logo-spacer">
		<a href="index.cfm" class="border-0"><img class="logo" src="images/logo.jpg" alt="logo"></a>
	  </div>
	  <div class="nav-close-spacer" onclick="toggleNav();">
		  x
	  </div>
      <div class="container">
        <a class="navbar-brand" href="#">&nbsp;</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav mx-auto">
            <li class="nav-item dropdown">
				<cfset loginText = "Login/Register">
				<cfif IsDefined("cookie.username")>
					<cfset loginText = "Welcome, #cookie.firstname#">
				</cfif>
              <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown2" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><cfoutput>#loginText#</cfoutput></a>
              <div class="dropdown-menu" aria-labelledby="navbarDropdown2">
				  <cfif IsDefined("cookie.username")>
					<a class="dropdown-item" href="changepw.cfm">Change Password</a>
					  <a class="dropdown-item" href="index.cfm?logout=<cfoutput>#Now()#</cfoutput>">Logout</a>
				  <cfelse>
						<a class="dropdown-item" href="login.cfm">Login</a>
						<a class="dropdown-item" href="register.cfm">Register</a>
				  </cfif>
              </div>
            </li>
            <li class="nav-item">
              <a id="search-icon" class="border-0" href="#" onclick="toggleSearch();"><img src="images/search-icon.png" alt="search"></a>
			  <form id="search-form" class="form-inline my-2 my-lg-0 pr-4 d-none">
				<input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>&nbsp;<button class="btn btn-secondary" type="button" onclick="toggleSearch();">Cancel</button>
			  </form>
            </li>
          </ul>
        </div>
      </div>
    </nav>
	<div class="logo-spacer">
	    <div class="row">
			<div class="col-sm-1">
				<a href="index.cfm" class="border-0"><img src="images/logo.jpg" alt="logo"></a>
			</div>
			<div class="col-sm-10 text-center">
				<h1 class="rx"><div class="the-x">x</div>R Fi</h1>
				<div class="mt-2">Medicine in Sci-Fi</div>
			</div>
			<div class="col-sm-1">
			&nbsp;
			</div>
		</div>
	</div>
	  