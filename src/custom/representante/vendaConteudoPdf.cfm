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

table td.nome {
	white-space: nowrap;
	padding-top: 3px;
	vertical-align: top;
}

table td.valor {
	/*white-space: nowrap;*/
	padding-top: 3px;
	vertical-align: top;
	width: 100px;
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

.assumindo{
	width: 100%;
	text-align: left;
	font-weight: bold;
	font-size: 14px;
}

.clausulas{
	font-size: 14px;
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
				,rev_pagamento_cheque_data_inicio
				,rev_con_data_instalacao
				,rev_con_data_inicio
				,rev_con_data_fim
				,rev_con_data_renovacao
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
				<td class="valor"><span class="value">#data.cliente.rev_cli_nome#</span></td>
				
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
						#data.cliente.rev_cli_endereco#, #data.cliente.rev_cli_endereco_numero#
					</span>
				</td>
				
				<td class="titulo">Complemento:</td>
				<td class="valor"><span class="value">#data.cliente.rev_cli_complemento#</span></td>					
			</tr>

			<tr>	
				<td class="titulo">Bairro:</td>
				<td class="valor"><span class="value">#data.cliente.rev_cli_bairro#</span></td>
				
				<td class="titulo">Cidade:</td>
				<td class="valor"><span class="value">#data.cliente.rev_cli_cidade#</span> - <span><span class="value">SP</span></span></td>
			</tr>

			<tr>	
				<td class="titulo">CEP:</td>
				<td class="valor"><span class="value">#data.cliente.rev_cli_cep#</span></td>
				
				<td class="titulo">Tel. Residêncial:</td>
				<td class="valor"><span class="value">#data.cliente.rev_cli_tel1#</span></td>
			</tr>

			<tr>					
				<td class="titulo">Tel. Comercial:</td>
				<td class="valor"><span class="value">#data.cliente.rev_cli_tel2#</span></td>

				<td class="titulo">Celular:</td>
				<td class="valor"><span class="value">#data.cliente.rev_cli_tel3#</span></td>
			</tr>

			<tr>					
				<td class="titulo">CPF / CNPJ:</td>
				<td class="valor">
					<span class="value">
						#data.cliente.rev_cli_cpfCnpj#
					</span>
				</td>

				<td class="titulo">RG / Inscrição estadual:</td>
				<td class="valor">
					<span class="value">
						#data.cliente.rev_cli_rgInscricaoEstadual#
					</span>
				</td>
			</tr>	

			<tr>					
				<td class="titulo">E-mail:</td>
				<td class="valor">
					<span class="value">
						#data.cliente.rev_cli_email#
					</span>
				</td>				
			</tr>		

				
		</table>

		<p>2 - Veículo</p>	
		<table width="100%" class="block">
			<tr>					
				<td class="titulo">Marca/Modelo:</td>
				<td class="valor"><span class="value">#data.veiculo.rev_vei_modelo#</span></td>

				<td class="titulo">Cor:</td>
				<td class="valor"><span class="value">#data.veiculo.rev_vei_cor#</span></td>

				<td class="titulo">Ano:</td>
				<td class="valor"><span class="value">#data.veiculo.rev_vei_ano#</span></td>

				<td class="titulo">Placa:</td>
				<td class="valor"><span class="value">#data.veiculo.rev_vei_placa#</span></td>
			</tr>
		</table>
		
		<p>3 - Equipamentos</p>		
		<table width="100%" cellspacing="1" class="tbl">
			<tr>					
				<td class="titulo2">Descrição</td>
				<td class="titulo2">Valor a vista</td>			
				<td class="titulo2">Pag. prazo</td>
				<td class="titulo2">Locação mensal</td>
			</tr>			
			<cfloop array="#data.equipamentos#" index="i">
				<tr>					
					<td class="nome">
						<span class="value">
							#i.nome#
						</span>
					</td>
					<td class="valor right">
						<span class="value">
							#LSCurrencyFormat(i.valorVista.value)#
						</span>
					</td>
					<td class="valor right">
						<span class="value">
							#LSCurrencyFormat(i.pagamentoPrazo.value)#
						</span>
					</td>
					<td class="valor right">
						<span class="value">
							#LSCurrencyFormat(i.locacao.value)#
						</span>
					</td>
				</tr>
			</cfloop>						
		</table>
		<p>4 - Serviços</p>
		<table width="100%" cellspacing="1" class="tbl">
			<tr>					
				<td class="titulo2">Descrição</td>
				<td class="titulo2">Valor a vista</td>			
				<td class="titulo2">Pag. prazo</td>
				<td class="titulo2">Locação mensal</td>
			</tr>			
			<cfloop array="#data.servicos#" index="i">
				<tr>					
					<td class="nome">
						<span class="value">
							#i.nome#
						</span>
					</td>
					<cfif i.comodato EQ true>
						<td colspan="3" class="valor center">
							<span class="value">
								COMODATO
							</span>
						</td>
					<cfelse>
						<td class="valor right">
							<span class="value">
								#LSCurrencyFormat(i.valorVista.value)#
							</span>
						</td>
						<td class="valor right">
							<span class="value">
								#LSCurrencyFormat(i.pagamentoPrazo.value)#
							</span>
						</td>
						<td class="valor right">
							<span class="value">
								#LSCurrencyFormat(i.locacao.value)#
							</span>
						</td>	
					</cfif>					
				</tr>
			</cfloop>						
		</table>

		<p>5 - Condições de Pagamento</p>
		
		<table width="100%" class="block">
			<tr>
				<td class="titulo">Entrada:</td>
				<cfif data.pagamento.rev_pagamento_tipo EQ "D">
					<td class="valor">Dinheiro</td>
				<cfelseif data.pagamento.rev_pagamento_tipo EQ "B">
					<td class="valor">Boleto</td>
				<cfelse>
					<td class="valor">Cheque</td>
				</cfif>

				<td class="titulo">Valor:</td>
				<td class="valor">#LSCurrencyFormat(data.pagamento.rev_pagamento_entrada)#</td>

				<td class="titulo">N° de parcelas:</td>
				<td class="valor">#data.pagamento.rev_pagamento_entrada_n_parcelas#</td>

				<td class="titulo">Valor da parcela:</td>
				<td class="valor">#LSCurrencyFormat(data.pagamento.rev_pagamento_entrada_valor_parcela)#</td>
			</tr>
			<!--- CHEQUE --->
			<cfif data.pagamento.rev_pagamento_tipo EQ "C">								
				<tr>
					<td class="titulo">Banco:</td>
					<td class="valor">#data.pagamento.rev_pagamento_banco#</td>

					<td class="titulo">Cheques:</td>
					<td class="valor">#data.pagamento.rev_pagamento_cheque_numeracao#</td>
				
					<td class="titulo">1º Vencimento:</td>
					<td class="valor">#LSDateFormat(qQuery.rev_pagamento_cheque_data_inicio,"DD/MM/YYYY")#</td>
				</tr>
				
			</cfif>		
			<tr>
				<td colspan="8" class="assumindo">
					Assumindo ainda #data.pagamento.rev_pagamento_n_parcelas# parcelas de #LSCurrencyFormat(data.pagamento.rev_pagamento_valor_parcela)#
				</td>
			</tr>		
		</table>

		<p>7- Vigência do contrato</p>

		<table width="100%" class="block">			
			<tr>	
				<td class="titulo">Data da instalação:</td>
				<td class="valor">
					<span class="value">
						#LSDateFormat(qQuery.rev_con_data_instalacao,"DD/MM/YYYY")#
					</span>
				</td>
				
				<td class="titulo">Início do contrato:</td>
				<td class="valor">
					<span class="value">
						#LSDateFormat(qQuery.rev_con_data_inicio,"DD/MM/YYYY")#
					</span>
				</td>	
			</tr>
			<tr>	
				<td class="titulo">Término do contrato:</td>
				<td class="valor">
					<span class="value">
						#LSDateFormat(qQuery.rev_con_data_fim,"DD/MM/YYYY")#
					</span>
				</td>
				
				<td class="titulo">Renovação do contrato:</td>
				<td class="valor">
					<span class="value">
						#LSDateFormat(qQuery.rev_con_data_renovacao,"DD/MM/YYYY")#
					</span>
				</td>	
			</tr>
		</table>

		<cfdocumentitem type="pagebreak" />

		<br/>

		<div class="declara">
			<table width="100%" class="block clausulas">
				<tr>
					<td><b>PLANO</b></td>
					<cfset clausulas = arrayNew(1)>
					<cfscript>
						arrayAppend(clausulas, "O contratante assina 2 contatros, contrato de locação de equipamentos (com opção de compra) e o contrato de prestação de serviçoes de central.");

						arrayAppend(clausulas, "O prazo de vigencia de ambos os contratos é de 50 meses, sem juros ou correção monetaria do valor das parcelas.");

						arrayAppend(clausulas, "O valor da parcela referente aluguel de equipamentos é revertido para o contratante como valor para aquisição dos equipamentos, portanto quando o valor referente locação de equipamento atigirem o valor dos equipamentos comercializados a vista, o contratante tem como seus os equipamentos passando a pagar somente o valor referente aos serviços.");

						arrayAppend(clausulas, "Os valores referentes à locação de equipamentos poderão ser antecipados, sendo que, serão quitados  no sentido da última parcela para a primeira. Valor este para á aquisição dos equipamentos.");

						arrayAppend(clausulas, "             O cancelamento do plano poderá ser solicitado a qualquer momento, desde que formamente ( carta, fax, email ) a 30 dias antes do efetivo cancelamento. Respeitando sempre as claúsulas referente a este item nos contratos em questão, bem como multa contratual.");

					</cfscript>
				<tr>
				<cfloop array="#clausulas#" index="i">
					<tr>
						<td>
							<ul>
								<li>#i#</li>
							</ul>
						</td>
					</tr>
				</cfloop>

				<tr>
					<td><b>BLOQUEADOR AUTOMÁTICO</b></td>
					<cfscript>
						clausulas = arrayNew(1);
						arrayAppend(clausulas, "SISTEMA DE RECONHECIMENTO : Quando qualquer pessoa não autorizada utilizar seu veiculo, com este sistema, após 2 minutos de ligar o veiculo, o sistema solicita ao usuario sua identificação, não recebendo retorno ( identificação), o veiculo aciona o sistema automatico de bloqueio.");

						arrayAppend(clausulas, "O contratante assina 2 contatros, contrato de locação de equipamentos (com opção de compra) e o contrato de prestação de serviçoes de central.");
					</cfscript>
				<tr>
				<cfloop array="#clausulas#" index="i">
					<tr>
						<td>
							<ul>
								<li>#i#</li>
							</ul>
						</td>
					</tr>
				</cfloop>

				<tr>
					<td><b>RASTREADOR</b></td>
					<cfscript>
						clausulas = arrayNew(1);
						arrayAppend(clausulas, "Rastreia e localiza o seu veiculo 1440  vezes por dia - 24 horas de minuto a minuto.");

						arrayAppend(clausulas, " Monitora em tempo real através de seu computador, tablet ou celular, como as principais informações em tempo real referente:  quilometragem, bateria, foto do local, e microfone aberto.");

						arrayAppend(clausulas, "Gera relatório de até 30 dias do ponto a ponto de onde seu veiculo esteve.");

						arrayAppend(clausulas, "Bloqueio atraves do site,  por celular, telefone fixo ou orelhão.");
					</cfscript>
				<tr>
				<cfloop array="#clausulas#" index="i">
					<tr>
						<td>
							<ul>
								<li>#i#</li>
							</ul>
						</td>
					</tr>
				</cfloop>

				<!---
				<tr>
					<td><b>RECIBO DE VALORES R$</b></td>
				<tr>
				<tr>
					<td>
						A importância de :
					</td>
				</tr>
				<tr>
					<td>
						Ref.:
					</td>
				</tr>
				--->
			</table>
		</div>

		<br/><br/><br/><br/>

		<div class="assinatura-data">
			_____________________________, ____ de ______________________ de ______	
		</div>

		<br/><br/><br/>

		<p>O contratante declara que leu e recebeu todas as informações contidas nesta proposta de adesão.</p>
		<p>O contratante declara que leu e está ciente dos regulamentos dos contratos em que é participanete.</p>
		<p>O contratante declara que recebeu orientação e está ciente do funcionamento e segredos do sistema.</p>

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
</cfoutput>