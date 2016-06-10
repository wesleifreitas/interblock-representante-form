<cfcomponent rest="true" restPath="/service">  
	  
    <cffunction 
    	name="representanteForm" 
    	access="remote" 
    	returntype="String"
    	httpMethod="POST" 
    	restPath="/form"
    	hint="">

        <cfargument name="body" type="String">
        
        <!---
        <cfdocument format="PDF" filename="rest-debug.pdf">                	
        	<cfdump var="#DeserializeJSON(arguments.body)#">
        </cfdocument>
        --->
        
        <cftry>
	        <cfset body = DeserializeJSON(arguments.body)>

	        <cfinvoke 
	        	component="representante"
	        	method="saveData"
				dsn="#body.dsn#"
				representante="#body.representante#"
				cliente="#body.cliente#"
				veiculo="#body.veiculo#"
				equipamentos="#body.equipamentos#"
				servicos="#body.servicos#"
				pagamento="#body.pagamento#"
				contrato="#body.contrato#"
	        	returnvariable="response">
	        
	        <cfreturn SerializeJSON(response)>

	    	<cfcatch>
	    		<cfset response = structNew()>
	    		<cfset response["source"] = "rest.cfc">
	    		<cfset response["cfcatch"] = cfcatch>
	    		<cfreturn SerializeJSON(cfcatch)>
	    	</cfcatch>
	    </cftry>

    </cffunction> 
</cfcomponent>
