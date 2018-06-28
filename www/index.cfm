<cfif IsDefined("url.logout")>
	<cfscript>
		structDelete( cookie, "username" );
		structDelete( cookie, "firstname" );
		structDelete( cookie, "emailaddress" );
	</cfscript>
	<cfheader statuscode="301" statustext="Redirect">
	<cfheader name="Location" value="index.cfm?success=loggedout">
	<cfabort>
</cfif>
<cfset headertext = "">
<cfinclude template="header.cfm">
		<cfif IsDefined("url.success")>
			<cfif url.success eq "loggedout">
				<div class="container">
					<div class="alert alert-success alert-dismissible">
					  <button type="button" class="close" data-dismiss="alert">&times;</button>
					  You have successfully logged out.
					</div>
				</div>
			</cfif>
			<cfif url.success eq "changedpw">
				<div class="container">
					<div class="alert alert-success alert-dismissible">
					  <button type="button" class="close" data-dismiss="alert">&times;</button>
					  You have successfully changed your password.
					</div>
				</div>
			</cfif>
			<cfif url.success eq "lostpw">
				<div class="container">
					<div class="alert alert-success alert-dismissible">
					  <button type="button" class="close" data-dismiss="alert">&times;</button>
					  A password-reset link has been emailed to you
					</div>
				</div>
			</cfif>
		</cfif>
    <div class="container mt-3">
      <div class="row">
        <div class="col-12">
          <div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
            <ol class="carousel-indicators">
              <li data-target="#carouselExampleControls" data-slide-to="0" class="active"></li>
              <li data-target="#carouselExampleControls" data-slide-to="1"></li>
              <li data-target="#carouselExampleControls" data-slide-to="2"></li>
            </ol>
            <div class="carousel-inner">
              <div class="carousel-item active">
                <img class="d-block w-100" src="images/slide1.png" alt="First slide">
                <div class="carousel-caption">
                  <h2>Medicine...</h2>
                </div>
              </div>
              <div class="carousel-item">
                <img class="d-block w-100" src="images/slide2.png" alt="Second slide">
                <div class="carousel-caption">
                  <h2>...Meets...</h2>
                </div>
              </div>
              <div class="carousel-item">
                <img class="d-block w-100" src="images/slide3.png" alt="Third slide">
                <div class="carousel-caption">
                  <h2>...Science&nbsp;Fiction</h2>
                </div>
              </div>
            </div>
            <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
            </a>
          </div>
        </div>
      </div>
      <hr>
    </div>
    <h2 class="text-center">TOPICS</h2>
    <hr>
    <div class="container">
      <div class="row text-center">
        <div class="col-md-4 pb-1 pb-md-0">
          <div class="card">
            <img class="card-img-top" src="images/doctors.png" alt="Card image cap">
            <div class="card-body">
              <h5 class="card-title">ST Doctors</h5>
              <p class="card-text">Who is your favourite Star Trek doctor?</p>
            </div>
          </div>
        </div>
        <div class="col-md-4 pb-1 pb-md-0">
          <div class="card">
            <img class="card-img-top" src="images/borg.png" alt="Card image cap">
            <div class="card-body">
              <h5 class="card-title">The Borg</h5>
              <p class="card-text">Nano Probes and Regeneration - Is it feasible?</p>
            </div>
          </div>
        </div>
        <div class="col-md-4 pb-1 pb-md-0">
          <div class="card">
            <img class="card-img-top" src="images/books.png" alt="Card image cap">
            <div class="card-body">
              <h5 class="card-title">The Future of Medicine</h5>
              <p class="card-text">An interesting blog regarding the future of medicine.</p>
            </div>
          </div>
        </div>
      </div>
    </div>
    <hr>

<cfinclude template="footer.cfm">
	
  </body>
</html>