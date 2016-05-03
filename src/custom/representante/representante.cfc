<cfinclude template="../../system/utils/cf/px-util.cfm">

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
		<cfset arguments.representante = decode(arguments.representante)>
		<cfset arguments.cliente = decode(arguments.cliente)>
		<cfset arguments.veiculo = decode(arguments.veiculo)>
		<cfset arguments.equipamentos = decode(arguments.equipamentos)>
		<cfset arguments.servicos = decode(arguments.servicos)>
		<cfset arguments.pagamento = decode(arguments.pagamento)>
		<cfset arguments.contrato = decode(arguments.contrato)>

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