<cfinclude template="../../system/utils/cf/px-util.cfm">

<cfprocessingDirective pageencoding="utf-8">
<cfset setEncoding("form","utf-8")> 

<cffunction name="login" access="remote" returntype="any" returnformat="JSON" output="true">

	<cfargument
		name="dsn"
		type="string"
		required="false"
		default=""
		hint="Data source name">

	<cfargument
		name="representante"
		type="string"
		required="false"
		default=""
		hint="">

	<cfset result = structNew()>

	<cftry>	
		<cfset arguments.representante = decode(arguments.representante)>
		<cfset result["arguments"] = arguments>

		<cfquery datasource="#arguments.dsn#" name="qLogin">
			SELECT
				CF002_NR_GRUPO
			FROM
				CF002
			WHERE
				CF002_NM_INST = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.representante.nome#"> collate Latin1_General_CI_AI
			AND CF002_SENHA = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.representante.senha#">
		</cfquery>

		<cfif qLogin.recordCount EQ 0>
			<cfset result["message"] = 'Representante não autorizado, por favor entre em contato com a Interblock.'>
			<cfset result["autorizado"] = false>
		<cfelse>
			<cfset result["message"] = ''>
			<cfset result["autorizado"] = true>
		</cfif>
		
		<cfset result["qLogin"] = QueryToArray(qLogin)>
		<cfset result["success"] = true>		
			
		<cfreturn result>

		<cfcatch>
			<cfset result["success"] = false>
			<cfset result["cfcatch"] = cfcatch>
			<cfreturn result>
		</cfcatch>		
	</cftry>
</cffunction>

<cffunction name="getData" access="remote" returntype="any" returnformat="JSON" output="true">

	<cfargument
		name="dsn"
		type="string"
		required="false"
		default=""
		hint="Data source name">

	<cfargument
		name="representante"
		type="string"
		required="false"
		default=""
		hint="">

	<cfset result = structNew()>

	<cftry>	
		<cfset arguments.representante = decode(arguments.representante)>
		<cfset result["arguments"] = arguments>	
		
		<cfset result["success"] = true>				  
			
		<cfreturn result>

		<cfcatch>
			<cfset result["success"] = false>
			<cfset result["cfcatch"] = cfcatch>
			<cfreturn result>
		</cfcatch>		
	</cftry>
</cffunction>

<cffunction name="saveData" access="remote" returntype="any" returnformat="JSON" output="true">

	<cfargument
		name="dsn"
		type="string"
		required="false"
		default=""
		hint="Data source name">

	<cfargument
		name="representante"
		type="string"
		required="false"
		default=""
		hint="">

	<cfargument
		name="cliente"
		type="string"
		required="false"
		default=""
		hint="">

	<cfargument
		name="veiculo"
		type="string"
		required="false"
		default=""
		hint="">

	<cfargument
		name="equipamentos"
		type="string"
		required="false"
		default=""
		hint="">

	<cfargument
		name="servicos"
		type="string"
		required="false"
		default=""
		hint="">

	<cfargument
		name="pagamento"
		type="string"
		required="false"
		default=""
		hint="">

	<cfargument
		name="contrato"
		type="string"
		required="false"
		default=""
		hint="">

	<cfset result = structNew()>

	<cftry>	
		<!--- Verificar permissão --->
		<cfset loginResponse = login(arguments.dsn, arguments.representante)>

		<cfset arguments.representante = decode(arguments.representante)>
		<cfset arguments.cliente = decode(arguments.cliente)>
		<cfset arguments.veiculo = decode(arguments.veiculo)>
		<cfset arguments.equipamentos = decode(arguments.equipamentos)>
		<cfset arguments.servicos = decode(arguments.servicos)>
		<cfset arguments.pagamento = decode(arguments.pagamento)>
		<cfset arguments.contrato = decode(arguments.contrato)>

		<cfset result["autorizado"] = loginResponse.autorizado>
		<cfif result["autorizado"] EQ false>			
			<cfset result["message"] = loginResponse.message>
			<cfreturn result>
		</cfif>

		<cfset result["arguments"] = arguments>

		<cfquery datasource="#arguments.dsn#">
			INSERT INTO 
				dbo.representante_venda
			(
				rev_data,
				rev_cli_nome
			) 
			VALUES (
				GETDATE(),
				'Teste'
			);
		</cfquery>

		<cfset result["success"] = true>				  
			
		<cfreturn result>

		<cfcatch>
			<cfset result["success"] = false>
			<cfset result["cfcatch"] = cfcatch>
			<cfreturn result>
		</cfcatch>		
	</cftry>
</cffunction>