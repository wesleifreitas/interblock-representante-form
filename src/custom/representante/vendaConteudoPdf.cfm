<style>

/*
table {
	font-size: 14px;
	table-layout: fixed;
    width: 100%;
}
*/

table td.titulo {
	font-weight: bold;
	white-space: nowrap;
	width: 1%;
	text-align:right;
	vertical-align: top;
	padding-top: 1px;
}

table td.titulo2 {
	/*font-style: italic;*/
	/*white-space: nowrap;
	width: 1%;*/
	font-weight: bold;
	text-align:center;
	vertical-align: top;
	padding-top: 3px;
}

table td.sub-titulo2 {
	font-style: italic;
	text-align: center;
	width: 100%;
}


table td.valor {
	/*white-space: nowrap;*/
	padding-top: 3px;
	vertical-align: top;
}

td.left{
	text-align: left;
}

td.right: {
	text-align: right;
}

td.center: {
	text-align: center;
}

h1 {
	font-size: 30px;
	text-align:center;
}

h3 {
	text-align:center;
	/*text-decoration: underline;*/
}

h4 {
	font-style: italic;
	font-weight: normal;
	text-align:center;
	/*text-decoration: underline;*/
}

hr {
    border: 0;
    height: 0;
    border-top: 1px solid rgba(0, 0, 0, 0.1);    
}

p.descricao {	
    list-style: disc outside none;
    text-align: justify;
    /*background: #ccc;*/
}

/*http://stackoverflow.com/questions/10618917/need-thin-table-borders-in-pdf-generated-by-cfdocument*/
.tbl {
	background-color:#000;
}
.tbl td,th,tr,caption{
	background-color:#fff
}

table
{ 
	font-size: 14px;
	table-layout: fixed;
    margin-left: auto;
    margin-right: auto;	  
}

div.centered 
{
    text-align: center;
}

div.centered table
{
    margin: 0 auto; 
    text-align: left;
}

span.value {
	text-align: center;
	color: #222283;
}

span.value-right {
	text-align: right;
	color: #222283;
}

table td.header2 {
	/*white-space: nowrap;*/
	padding-top: 3px;
	padding-left: 15px;
	vertical-align: top;
	text-align: center;
}

table.header-item {    
    width: 100%;
    text-align: center;
}

td.header-item {
    border: 1px solid black;
}

table.block {    
    width: 100%;
    text-align: left;
    border: 1px solid black;
}

table.loop td {
	/*border-collapse: collapse;
    border: 1px solid black;*/
}

.declara{
	font-size: 15px;
}

div.assinatura-data{
	width: 100%;
	text-align: right;
}

table.assinaturas{
	text-align: center;
	border-spacing: 10px;
	border-collapse: separate;
}
table.assinaturas td{
	padding: 15px;
}


</style>
<cfoutput>	
	<cfset setLocale("Portuguese (Brazilian)")>	

	<cfset data = arguments.data>
	
	<cftry>
		<cfset BORDER = 0>
		<cfset LOGO_PATH = "http://representante.interblock.com.br/img/logo/logo-interblock.gif">

		<cfquery name="qQuery" datasource="#data.dsn#">
			SELECT
				rev_codigo
				,rev_cli_nascimento
				,rev_prop_data_instalacao
				,rev_prop_data_inicio
				,rev_prop_data_fim
				,rev_prop_data_renovacao
			FROM
				dbo.representante_venda
			WHERE
				rev_id = <cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.rev_id#">
		</cfquery>
		
		<table class="header" border="#BORDER#">
			<tr>
				<td class="header2">
					<img src="#LOGO_PATH#">	
					<h3>
						Código de venda <span class="value">#qQuery.rev_codigo#</span>
					</h3>
				</td>

				<td class="header2">	
					<center>			
						<p font-size="6px">INTERBLOCK COMERCIAL LTDA ME</p>
						<p font-size="4px">CNPJ: 02.632.466/0001-35 - I.E.: 626.672.127.112</p>	
						<p font-size="4px">R. Paranapiacaba, 80 - Vila Pires - Sto. André - SP
						<br>Central de Atendimento ao Cliente: 11 4455-7133</p>
						
					</center>									
				</td>
			</tr>
		</table>

		<!--- <cfdump var="#arguments.URL.voLogin#"> --->
		<table class="header-item">
			<tr>
				<td class="header-item">
					<b>Representante</b><br>
					<span class="value">#data.representante.nome#</span>
				</td>
				<!---
				<td class="header-item">
					<b>Unidade</b><br>
					<span class="value"></span>
				</td>
				--->
				<td class="header-item">
					<b>Vendedor</b><br>
					<span class="value">#data.representante.vendedor#</span>
				</td>					
			</tr>
		</table>

		<p>1 - Contratante</p>
		<table width="100%" class="block">
			<tr>	
				<td class="titulo">Nome:</td>
				<td class="valor"><span class="value">#data.cliente.nome#</span></td>
				
				<td class="titulo">Data de Nascimento:</td>
				<td class="valor">
					<span class="value">
						#LSDateFormat(qQuery.rev_cli_nascimento,"DD/MM/YYYY")#
					</span>
				</td>
			</tr>
			
			<tr>	
				<td class="titulo">Endereço:</td>
				<td class="valor" nowrap>
					<span class="value">
						#data.cliente.endereco#, #data.cliente.endereco_numero#
					</span>
				</td>
				
				<td class="titulo">Complemento:</td>
				<td class="valor"><span class="value">#data.cliente.complemento#</span></td>					
			</tr>

			<tr>	
				<td class="titulo">Bairro:</td>
				<td class="valor"><span class="value">#data.cliente.bairro#</span></td>
				
				<td class="titulo">Cidade:</td>
				<td class="valor"><span class="value">#data.cliente.cidade#</span> - <span><span class="value">SP</span></span></td>
			</tr>

			<tr>	
				<td class="titulo">CEP:</td>
				<td class="valor"><span class="value">#data.cliente.cep#</span></td>
				
				<td class="titulo">Tel. Residêncial:</td>
				<td class="valor"><span class="value">#data.cliente.tel1#</span></td>
			</tr>

			<tr>					
				<td class="titulo">Tel. Comercial:</td>
				<td class="valor"><span class="value">#data.cliente.tel2#</span></td>

				<td class="titulo">Celular:</td>
				<td class="valor"><span class="value">#data.cliente.tel3#</span></td>
			</tr>

			<tr>					
				<td class="titulo">CPF / CNPJ:</td>
				<td class="valor">
					<span class="value">
						#data.cliente.cpfCnpj#
					</span>
				</td>

				<td class="titulo">RG / Inscrição estadual:</td>
				<td class="valor">
					<span class="value">
						#data.cliente.rgInscricaoEstadual#
					</span>
				</td>
			</tr>	

			<tr>					
				<td class="titulo">E-mail:</td>
				<td class="valor">
					<span class="value">
						#data.cliente.email#
					</span>
				</td>				
			</tr>		

				
		</table>

		<p>2 - Veículo</p>	
		<table width="100%" class="block">
			<tr>					
				<td class="titulo">Marca/Modelo:</td>
				<td class="valor"><span class="value">#data.veiculo.modelo#</span></td>

				<td class="titulo">Cor:</td>
				<td class="valor"><span class="value">#data.veiculo.cor#</span></td>

				<td class="titulo">Ano:</td>
				<td class="valor"><span class="value">#data.veiculo.ano#</span></td>

				<td class="titulo">Placa:</td>
				<td class="valor"><span class="value">#data.veiculo.placa#</span></td>
			</tr>
		</table>
		
		<p>3 - Equipamentos</p>		
		[EM DESENVOLVIMENTO]
		<!---
		<table width="100%" cellspacing="1" class="tbl">
			<tr>					
				<td class="titulo2">Descrição</td>
				<td class="titulo2">Valor Entrada</td>
				<cfif data.pagamento.locacao_equipamentos EQ 1>
					<td class="titulo2">Locação Mensal</td>
				</cfif>
				<cfif data.pagamento.compra_venda_equipamentos EQ 1>
					<td class="titulo2">Valor Compra</td>
				</cfif>
			</tr>			
			<cfloop query="qQuery">
				<tr>					
					<td class="valor">
						<span class="value">
							#qQuery.PRO_NOME#
						</span>
					</td>
					<td class="valor right">
						<span class="value">
							#LSCurrencyFormat(qQuery.PRO_VALOR_ENTRADA)#
						</span>
					</td>
					<cfif data.pagamento.locacao_equipamentos EQ 1>
						<td class="valor right">
							<span class="value">
								#LSCurrencyFormat(qQuery.PRO_VALOR_MENSAL)#
							</span>
						</td>
					</cfif>
					<cfif data.pagamento.compra_venda_equipamentos EQ 1>
						<td class="valor right">
							<span class="value">
								#LSCurrencyFormat(qQuery.PRO_VALOR_COMPRA)#
							</span>
						</td>	
					</cfif>	
				</tr>
			</cfloop>			
			<tr>					
				<td class="valor">
					<span class="value">
						LOCALIZADOS VIVA VOZ
					</span>
				</td>
				<td class="valor center" colspan="3">
					<span class="value">
						COMODATO
					</span>
				</td>				
			</tr>
			<tr>					
				<td class="valor">
					<span class="value">
						RECEPTOR DE SINAIS (SATÉLITE)
					</span>
				</td>
				<td class="valor center" colspan="3">
					<span class="value">
						COMODATO
					</span>
				</td>				
			</tr>
		</table>
		--->
		<p>4 - Serviços</p>
		[EM DESENVOLVIMENTO]
		<!---
		<table width="100%" cellspacing="1" class="tbl">
			<tr>					
				<td class="titulo2">Descrição</td>
				<td class="titulo2">Valor Entrada</td>
				<td class="titulo2">Locação Mensal</td>
				<td class="titulo2">Valor Compra</td>
			</tr>
			<cfloop query="qQuery">
				<tr>					
					<td class="valor">
						<span class="value">
							#qQuery.SER_NOME#
						</span>
					</td>
					<td class="valor right">
						<span class="value">
							#LSCurrencyFormat(qQuery.SER_VALOR_ENTRADA)#
						</span>
					</td>
					<td class="valor right">
						<span class="value">
							#LSCurrencyFormat(qQuery.SER_VALOR_MENSAL)#
						</span>
					</td>
					<td class="valor right">
						<span class="value">
							#LSCurrencyFormat(qQuery.SER_VALOR_COMPRA)#
						</span>
					</td>		
				</tr>
			</cfloop>
		</table>
		--->

		<p>5 - Condições de Pagamento</p>
		
		<table width="100%" class="block">
			<!--- DINHEIRO --->
			<cfif data.pagamento.tipo EQ "dinheiro">
				<tr>
					<td class="titulo">Entrada:</td>
					<td class="valor">Dinheiro</td>

					<td class="titulo">Valor:</td>
					<td class="valor">#LSCurrencyFormat(data.pagamento.entrada)#</td>
				</tr>
			<cfelse><!--- CHEQUE --->	
				<!---
				<tr>					
					<td class="titulo">Entrada:</td>
					<td class="valor">Cheque</td>

					<td class="titulo">Valor:</td>
					<td class="valor">#LSCurrencyFormat(data.pagamento.entrada)#</td>

					<td class="titulo">Banco:</td>
					<td class="valor">#data.pagamento.cheque_banco#</td>
				</tr>
				<tr>
					<td class="titulo">Cheques:</td>
					<td class="valor">#data.pagamento.cheques#</td>
				
					<td class="titulo">Nº Cheque:</td>
					<td class="valor">#data.pagamento.cheque_entrada_inicio# ao #data.pagamento.cheque_entrada_fim#</td>

					<td class="titulo">1º Vencimento:</td>
					<td class="valor">#LSDateFormat(data.pagamento.cheque_entrada_primeiro_vencimento,"DD/MM/YYYY")#</td>
				</tr>
				--->
			</cfif>				
		</table>

		<p>7- Vigência do contrato</p>

		<table width="100%" class="block">			
			<tr>	
				<td class="titulo">Data da instalação:</td>
				<td class="valor">
					<span class="value">
						#LSDateFormat(qQuery.rev_prop_data_instalacao,"DD/MM/YYYY")#
					</span>
				</td>
				
				<td class="titulo">Início do contrato:</td>
				<td class="valor">
					<span class="value">
						#LSDateFormat(qQuery.rev_prop_data_inicio,"DD/MM/YYYY")#
					</span>
				</td>	
			</tr>
			<tr>	
				<td class="titulo">Término do contrato:</td>
				<td class="valor">
					<span class="value">
						#LSDateFormat(qQuery.rev_prop_data_fim,"DD/MM/YYYY")#
					</span>
				</td>
				
				<td class="titulo">Renovação do contrato:</td>
				<td class="valor">
					<span class="value">
						#LSDateFormat(qQuery.rev_prop_data_renovacao,"DD/MM/YYYY")#
					</span>
				</td>	
			</tr>
		</table>

		<br/>
		<div class="declara">
			<!--- #getDeclaracao(data.pagamento.status)# --->
		</div>

		<br/><br/>

		<div class="assinatura-data">
			_____________________________, ____ de ______________________ de ______	
		</div>

		<br/><br/><br/>

		<table class="assinaturas">
			<tr>
				<td>
					____________________________________________
					<br/>CONTRATANTE
				</td>
				<td>
					____________________________________________
					<br/>CONTRATADA
				</td>
			</tr>
		</table>

		<cfdocumentitem type="footer"> 
		      
		</cfdocumentitem>
									
		<cfcatch>
			<cfdump var="#cfcatch#">
		</cfcatch>
	</cftry>

	<cfscript></cfscript>	

</cfoutput>