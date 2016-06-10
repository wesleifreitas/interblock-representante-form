<!--- code starts --->
<cftry>
<cfset restInitApplication(getDirectoryFromPath(getCurrentTemplatePath()) & "custom/representante","interblock-representante")>
<cfcatch type="any">
    <cfdump var="#cfcatch#">
</cfcatch>
</cftry>
successfull!
<!--- code ends --->