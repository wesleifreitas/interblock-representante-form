<!---
<style>
	/*http://stackoverflow.com/questions/10618917/need-thin-table-borders-in-pdf-generated-by-cfdocument*/
	.tbl {
		background-color:#000;
	}
	.tbl td,th,tr,caption{
		background-color:#fff
	}
	.tbl tr td:first-child {
		font-weight: bold;
		color: red;
	}
</style>
--->
<cfoutput>	
	<cfset setLocale("Portuguese (Brazilian)")>	
	
	<h2>Pré proposta #qPdf.rev_codigo#</h2>
	<h3>DADOS DO REPRESENTANTE</h3>

	<table cellspacing="1" class="tbl">
		<tr>
			<td>
				<b>Representante:</b>
			</td>
			<td>
				#qLogin.CF002_NR_INST#
			</td>
		</tr>
		<tr>
			<td>
				<b>Unidade:</b>
			</td>
			<td>
				#qLogin.CF002_NM_ABREV#
			</td>
		</tr>
		<tr>
			<td>
				<b>Usuário:</b>
			</td>
			<td>
				#qLogin.CF002_NM_INST#
			</td>
		</tr>
		<tr>
			<td>
				<b>Vendedor:</b>
			</td>
			<td>
				#arguments.REPRESENTANTE.vendedor#
			</td>
		</tr>
		<cfif len(qLogin.CF002_NR_TEL) EQ 10>
			<tr>
				<td>
					<b>Telefone:</b>
				</td>
				<td>
					#mid(qLogin.CF002_NR_TEL, 1, 2)#-#mid(qLogin.CF002_NR_TEL, 3, 4)#-#mid(qLogin.CF002_NR_TEL, 7, 4)#
				</td>
			</tr>
		</cfif> 
		<cfif len(qLogin.CF002_NR_TEL2) GTE 10>
			<tr>
				<td>
					<b>Celular:</b>
				</td>
				<td>
					#mid(qLogin.CF002_NR_TEL2, 1, 2)#-#mid(qLogin.CF002_NR_TEL2, 3, 5)#-#mid(qLogin.CF002_NR_TEL2, 8, 4)#
				</td>
			</tr>
		</cfif>
	</table>

	<h3>ENDEREÇO</h3>

	<cfset endereco = qLogin.CF002_NM_END & ", n° " & qLogin.CF002_NR_END>
	<cfif qLogin.CF002_NM_COMPL NEQ "">
		<cfset endereco = endereco & " " & qLogin.CF002_NM_COMPL>
	</cfif>	
	<p>
		#endereco#
		<cfset endereco = qLogin.CF002_NM_BAIRRO & " - " & qLogin.CF002_NM_CIDADE & ", " & qLogin.CF002_NM_ESTADO & " - " & mid(qLogin.CF002_NR_CEP, 1, 5) & "-" & mid(qLogin.CF002_NR_CEP, 6, 3)>
		<br>#endereco#
	</p>
</cfoutput>