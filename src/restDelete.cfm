<!--- http://blogs.coldfusion.com/post.cfm/registering-a-rest-application-in-coldfusion10 --->
<cfabort>
<!--- code starts --->
<cftry>
	<cfset restDeleteApplication(getDirectoryFromPath(getCurrentTemplatePath()) & 'rest')>
	<cfcatch type="any">
	    <cfdump var="#cfcatch#">
	</cfcatch>
</cftry>
successfull!
<!--- code ends --->