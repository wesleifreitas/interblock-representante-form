<cfcomponent
    output="false"
    hint="I define the application and root-level event handlers.">

    <!--- Define application settings. --->
    <cfset THIS.Name = "interblock-representante" />
    <cfset THIS.ApplicationTimeout = CreateTimeSpan( 0, 8, 0, 0 ) />
    <cfset THIS.SessionManagement = true />
    <cfset THIS.SessionTimeout = CreateTimeSpan( 0, 8, 0, 0 ) />
    <cfset THIS.SetClientCookies = true />
    <cfset THIS.RootDir = getDirectoryFromPath(getCurrentTemplatePath()) />

    <cfset THIS.Mappings = structNew() />
    <cfset THIS.Mappings["/cfc"] = THIS.RootDir />

    <cfparam name="session.loggedIn" default="false" />
   
    <!--- Define the request settings. --->
    <cfsetting
        showdebugoutput="false"
        requesttimeout="10"
        />

    <cffunction
        name="OnApplicationStart"
        access="public"
        returntype="boolean"
        output="false"
        hint="I run when the application boots up. If I return false, the application initialization will hault.">

        <!--- Application root directory--->
        <cfset APPLICATION.RootDir = THIS.RootDir />
        <!---
            Let's create an encryption key that will be used to
            encrypt and decrypt values throughout the system.
        --->
        <cfset APPLICATION.EncryptionKey = "" />

        <cfreturn true />
    </cffunction>


    <cffunction
        name="OnSessionStart"
        access="public"
        returntype="void"
        output="false"
        hint="I run when a session boots up.">
       
        <!--- Return out. --->
        <cfreturn />
    </cffunction>


    <cffunction
        name="OnRequestStart"
        access="public"
        returntype="boolean"
        output="false"
        hint="I perform pre page processing. If I return false, I hault the rest of the page from processing.">

       <!--- Define arguments. --->
        <cfargument
            name="TargetPage"
            type="string"
            required="true"
            />
    
        <!--- Return out. --->
        <cfreturn true />
    </cffunction>


    <cffunction
        name="OnRequest"
        access="public"
        returntype="void"
        output="true"
        hint="I execute the primary template.">

        <!--- Define arguments. --->
        <cfargument
            name="Page"
            type="string"
            required="true"
            hint="The page template requested by the user."
            />

        <!--- REST service 
        <cfset restDirPath = expandPath("./") & "/rest">
        <cfset RestInitApplication(restDirPath, "interblock-representante")> --->

        <!--- If appreset is defined in URL scope then reset the application by calling ApplicationStop --->  
        <cfif structKeyExists(url, "appReset")>
             <cfset ApplicationStop()>
        </cfif>
        
        <cfinclude template="#ARGUMENTS.Page#" />
        
        <!---
        <!---
            Check to see if the user is logged. 
            If they are, then include the requested page; if they are not, 
            then force the login page.
        ---> 
        <cfif SESSION.loggedIn>            
                      
            <!--- User logged in. Allow page request. --->
            <cfinclude template="#ARGUMENTS.Page#" />

        <cfelse>
                      
            <!--- <cfinclude template="" /> --->

        </cfif>
        --->

        <!--- Return out. --->
        <cfreturn />
    </cffunction>

</cfcomponent>