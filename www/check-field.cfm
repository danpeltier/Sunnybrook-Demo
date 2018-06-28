<cfcontent type="text/plain">
<cfscript>
	requesterror = "";
    try {
        requestBody =  deserializeJSON(getHttpRequestData().content);
    } catch ( any error ) {
        // throw( type = "BadRequest" );
		requesterror = "unknown";
    }
	
</cfscript>
	
<cfif requesterror eq "unknown">
	Unknown
<cfelse>
	<cfif IsDefined("requestBody.checkemail")>
	  	  <cfquery name="checkUsers" datasource="main">
		  select * from users where emailaddress = '#replace(requestBody.checkemail,"'","''","all")#'
		  </cfquery>
			  
		  <cfset emailFound = 0>
		  <cfoutput query="checkUsers">
			  <cfset emailFound = 1>
		  </cfoutput>
		
		<cfif emailFound eq 1>
			Not Available
		<cfelse>
			Available
		</cfif>
	</cfif>
		
	<cfif IsDefined("requestBody.checkuname")>
	  	  <cfquery name="checkUsers" datasource="main">
		  select * from users where username = '#replace(requestBody.checkuname,"'","''","all")#'
		  </cfquery>
			  
		  <cfset unameFound = 0>
		  <cfoutput query="checkUsers">
			  <cfset unameFound = 1>
		  </cfoutput>
		
		<cfif unameFound eq 1>
			Not Available
		<cfelse>
			Available
		</cfif>
	</cfif>
		
</cfif>