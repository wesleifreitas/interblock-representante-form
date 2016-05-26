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
		type="any"
		required="false"
		default=""
		hint="">

	<cfargument
		name="cliente"
		type="any"
		required="false"
		default=""
		hint="">

	<cfargument
		name="veiculo"
		type="any"
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
		type="any"
		required="false"
		default=""
		hint="">

	<cfset result = structNew()>

	<cftry>	
		<!--- Verificar permissão --->
		<cfset loginResponse = login(arguments.dsn, SerializeJSON(arguments.representante))>

		<!--- <cfset arguments.representante = decode(arguments.representante)> --->
		<!--- <cfset arguments.cliente = decode(arguments.cliente)> --->
		<!---<cfset arguments.veiculo = decode(arguments.veiculo)> --->
		<cfset arguments.equipamentos = decode(arguments.equipamentos)>
		<cfset arguments.servicos = decode(arguments.servicos)>
		<cfset arguments.pagamento = decode(arguments.pagamento)>
		<!--- <cfset arguments.contrato = decode(arguments.contrato)> --->

		<cfset result["autorizado"] = loginResponse.autorizado>
		<cfif result["autorizado"] EQ false>			
			<cfset result["message"] = loginResponse.message>
			<cfreturn result>
		</cfif>

		<cfset formError = structNew()>
		<cfset formError["error"] = false>
		<cfset formError["fields"] = arrayNew(1)>

		<cfset grupo_id = 2>
		<cfset subgrupo_id = 2>
		<!--- CLIENTE - START --->
		<cfset rev_cli_nome = arguments.cliente.nome>
		<cfset rev_cli_pessoa = arguments.cliente.tipo>
		<cfset rev_cli_cpfCnpj = arguments.cliente.cpfCnpj>
		<cfset rev_cli_rgInscricaoEstadual = arguments.cliente.rgInscricaoEstadual>
		<cfset rev_cli_tel1 = arguments.cliente.tel1>
		<cfset rev_cli_tel2 = arguments.cliente.tel2>
		<cfset rev_cli_tel3 = arguments.cliente.tel3>
		<cfset rev_cli_tel4 = arguments.cliente.tel4>
		<cfset rev_cli_email = arguments.cliente.email>
		<cfset rev_cli_nascimento = arguments.cliente.nascimento>
		<cfset rev_cli_cep = arguments.cliente.cep>
		<cfset rev_cli_endereco = arguments.cliente.endereco>
		<cfset rev_cli_numero = arguments.cliente.endereco_numero>
		<cfset rev_cli_complemento = arguments.cliente.complemento>
		<cfset rev_cli_bairro = arguments.cliente.bairro>
		<cfset rev_cli_cidade = arguments.cliente.cidade>
		<cfset rev_cli_uf = arguments.cliente.uf>
		<cfset cli_cep = arguments.cliente.cep>
		<!--- CLIENTE - END --->
		<!--- VEÍCULO - START --->
		<cfset rev_vei_marca = arguments.veiculo.marca>
		<cfset rev_vei_modelo = arguments.veiculo.modelo>
		<cfset rev_vei_cor = arguments.veiculo.cor>
		<cfset rev_vei_ano = arguments.veiculo.ano>
		<cfset rev_vei_placa = arguments.veiculo.placa>
		<!--- VEÍCULO - END --->
		<!--- CONTRATO - START --->
		<cfset rev_prop_data_instalacao = arguments.contrato.dataInstalacao>
		<cfset rev_prop_data_inicio = arguments.contrato.dataInicio>
		<cfset rev_prop_data_fim = arguments.contrato.dataTermino>
		<cfset rev_prop_data_renovacao = arguments.contrato.dataRenovacao>
		
		<!--- CONTRATO - END --->
		<!--- EQUIPAMENTOS - START --->
		<cfloop array="#arguments.equipamentos#" index="i">
			<cfset i.valorVista.value = replace(REReplace(i.valorVista.value, '[^0-9,]', "", "all"),",",".")>
			<cfset i.pagamentoPrazo.value = REReplace(i.pagamentoPrazo.value, '[^0-9]', "", "all")>
			<cfset i.locacao.value = replace(REReplace(i.locacao.value, '[^0-9,]', "", "all"),",",".")>

			<cfif i.valorVista.value EQ "">
				<cfset i.valorVista.value = 0>
			</cfif>
			<cfif i.pagamentoPrazo.value EQ "">
				<cfset i.valorpagamentoPrazoVista.value = 0>
			</cfif>
			<cfif i.locacao.value EQ "">
				<cfset i.locacao.value = 0>
			</cfif>
		</cfloop>
		<!--- EQUIPAMENTOS - END --->
		<!--- SERVICOS - START --->
		<cfloop array="#arguments.servicos#" index="i">
			<cfset i.valorVista.value = replace(REReplace(i.valorVista.value, '[^0-9,]', "", "all"),",",".")>
			<cfset i.pagamentoPrazo.value = REReplace(i.pagamentoPrazo.value, '[^0-9]', "", "all")>
			<cfset i.locacao.value = replace(REReplace(i.locacao.value, '[^0-9,]', "", "all"),",",".")>

			<cfif i.valorVista.value EQ "">
				<cfset i.valorVista.value = 0>
			</cfif>
			<cfif i.pagamentoPrazo.value EQ "">
				<cfset i.valorpagamentoPrazoVista.value = 0>
			</cfif>
			<cfif i.locacao.value EQ "">
				<cfset i.locacao.value = 0>
			</cfif>
		</cfloop>
		<!--- SERVICOS - END --->
		<!--- PAGAMENTO - START --->
		<cfset rev_pagamento_entrada = replace(REReplace(arguments.pagamento.entrada, '[^0-9,]', "", "all"),",",".")>
		<cfset rev_pagamento_entrada_n_parcelas = replace(REReplace(arguments.pagamento.nParcelasEntrada, '[^0-9]', "", "all"),",",".")>
		<cfset rev_pagamento_entrada_valor_parcela = replace(REReplace(arguments.pagamento.valorParcelaEntrada, '[^0-9,]', "", "all"),",",".")>
		<cfset rev_pagamento_n_parcelas = replace(REReplace(arguments.pagamento.nParcelas, '[^0-9]', "", "all"),",",".")>
		<cfset rev_pagamento_valor_parcela = replace(REReplace(arguments.pagamento.valorParcela, '[^0-9,]', "", "all"),",",".")>

		<cfif rev_pagamento_entrada EQ "">
			<cfset rev_pagamento_entrada = 0>
		</cfif>
		<cfif rev_pagamento_entrada_n_parcelas EQ "">
			<cfset rev_pagamento_entrada_n_parcelas = 0>
		</cfif>
		<cfif rev_pagamento_entrada_valor_parcela EQ "">
			<cfset rev_pagamento_entrada_valor_parcela = 0>
		</cfif>
		<cfif rev_pagamento_n_parcelas EQ "">
			<cfset rev_pagamento_n_parcelas = 0>
		</cfif>
		<cfif rev_pagamento_valor_parcela EQ "">
			<cfset rev_pagamento_valor_parcela = 0>
		</cfif>

		<cfset arguments.pagamento.entrada = rev_pagamento_entrada>
		<cfset arguments.pagamento.nParcelasEntrada = rev_pagamento_entrada_n_parcelas>
		<cfset arguments.pagamento.valorParcelaEntrada = rev_pagamento_entrada_valor_parcela>
		<cfset arguments.pagamento.nParcelas = rev_pagamento_n_parcelas>
		<cfset arguments.pagamento.valorParcela = rev_pagamento_valor_parcela>
		<!--- PAGAMENTO - END --->

		<cfset result["arguments"] = arguments>

		<cfquery datasource="#arguments.dsn#" result="rQuery">
			INSERT INTO 
				dbo.representante_venda
			(
				rev_cli_nome,
				rev_cli_pessoa,
				rev_cli_cpfCnpj,
				rev_cli_rgInscricaoEstadual,
				rev_cli_tel1,
				rev_cli_tel2,
				rev_cli_tel3,
				rev_cli_tel4,
				rev_cli_email,
				rev_cli_nascimento,
				rev_cli_endereco,
				rev_cli_numero,
				rev_cli_complemento,
				rev_cli_bairro,
				rev_cli_cidade,
				rev_cli_uf,
				cli_cep,
				rev_vei_marca,
				rev_vei_modelo,
				rev_vei_cor,
				rev_vei_ano,
				rev_vei_placa,
				rev_prop_data_instalacao,
				rev_prop_data_inicio,
				rev_prop_data_fim,
				rev_prop_data_renovacao,
				rev_pagamento_entrada,
				rev_pagamento_entrada_n_parcelas,
				rev_pagamento_entrada_valor_parcela,
				rev_pagamento_n_parcelas,
				rev_pagamento_valor_parcela,

				<cfloop array="#arguments.equipamentos#" index="i">
					#i.valorVista.field#,
					#i.pagamentoPrazo.field#,
					#i.locacao.field#,
				</cfloop>
				<cfloop array="#arguments.servicos#" index="i">
					#i.valorVista.field#,
					#i.pagamentoPrazo.field#,
					#i.locacao.field#,
				</cfloop>

				rev_data
			) 
			VALUES (
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#rev_cli_nome#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#rev_cli_pessoa#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#rev_cli_cpfCnpj#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#rev_cli_rgInscricaoEstadual#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#rev_cli_tel1#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#rev_cli_tel2#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#rev_cli_tel3#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#rev_cli_tel4#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#rev_cli_email#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#rev_cli_nascimento#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#rev_cli_endereco#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#rev_cli_numero#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#rev_cli_complemento#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#rev_cli_bairro#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#rev_cli_cidade#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#rev_cli_uf#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#rev_cli_cep#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#rev_vei_marca#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#rev_vei_modelo#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#rev_vei_cor#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#rev_vei_ano#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#rev_vei_placa#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#rev_prop_data_instalacao#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#rev_prop_data_inicio#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#rev_prop_data_fim#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#rev_prop_data_renovacao#">,
				<cfqueryparam cfsqltype="cf_sql_float" value="#rev_pagamento_entrada#">,
				<cfqueryparam cfsqltype="cf_sql_interger" value="#rev_pagamento_entrada_n_parcelas#">,
				<cfqueryparam cfsqltype="cf_sql_float" value="#rev_pagamento_entrada_valor_parcela#">,
				<cfqueryparam cfsqltype="cf_sql_interger" value="#rev_pagamento_n_parcelas#">,
				<cfqueryparam cfsqltype="cf_sql_float" value="#rev_pagamento_valor_parcela#">,
				
				<cfloop array="#arguments.equipamentos#" index="i">
					<cfqueryparam cfsqltype="cf_sql_float" value="#i.valorVista.value#">,
					<cfqueryparam cfsqltype="cf_sql_interger" value="#i.pagamentoPrazo.value#">,
					<cfqueryparam cfsqltype="cf_sql_float" value="#i.locacao.value#">,
				</cfloop>
				<cfloop array="#arguments.servicos#" index="i">
					<cfqueryparam cfsqltype="cf_sql_float" value="#i.valorVista.value#">,
					<cfqueryparam cfsqltype="cf_sql_interger" value="#i.pagamentoPrazo.value#">,
					<cfqueryparam cfsqltype="cf_sql_float" value="#i.locacao.value#">,
				</cfloop>
				GETDATE()
			);
		</cfquery>
		
		<!--- <cfset result["rQuery"] = rQuery> --->
		<cfset result["pdf"] = setPdf(arguments, rQuery.IDENTITYCOL)>
		<cfset result["success"] = true>
			
		<cfreturn result>

		<cfcatch>
			<cfset result["success"] = false>
			<cfset result["cfcatch"] = cfcatch>
			<cfreturn result>
		</cfcatch>		
	</cftry>
</cffunction>

<cffunction name="setPdf" access="private" returntype="any">

	<cfargument
		name="data"
		type="struct"
		required="false"
		default=""
		hint="">

	<cfargument
		name="rev_id"
		type="numeric"
		required="false"
		default=""
		hint="IDENTITYCOL">

	<cftry>
		
		<cfset response = structNew()>
		<cfset response["data"] = arguments.data>
		<cfset response["rev_id"] = arguments.rev_id>

		<cfdocument format="PDF" 
				localurl="false"
	 	 		filename="#expandPath('./')#interblock-representante-form/src/_server/files/venda_#arguments.rev_id#.pdf" 
	 	 		overwrite="yes" 	 	 			
	 	 		pagetype="a4"> 
				<cfinclude template="vendaConteudoPdf.cfm">
		</cfdocument>

		<cfreturn response>

		<cfcatch>
			<cfset response["cfcatch"] = cfcatch>
			<cfreturn response>
		</cfcatch>
	</cftry>

</cffunction>