<cfdump var="#CGI#" label="CGI" expand="false">

<cfhttp 
	url="#CGI.SERVER_NAME#/rest/interblock-representante/test/ola" 
	method="post" 
	port="#CGI.SERVER_PORT#" 
	result="res">
       <cfhttpparam type="body" value="postExample">
</cfhttp>

<cfdump var="#res#">