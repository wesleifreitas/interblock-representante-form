<cfcomponent rest="true" restPath="/test">  
	  
    <cffunction 
    	name="test" 
    	access="remote" 
    	returntype="Any"
    	httpMethod="POST" 
    	restPath="/ola"
    	hint="">

        <cfargument name="body" type="String">

        <cftry>
	        <cfreturn arguments.body>

	    	<cfcatch>	    	
	    		<cfreturn cfcatch>
	    	</cfcatch>
	    </cftry>

    </cffunction> 
</cfcomponent>
