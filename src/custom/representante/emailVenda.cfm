<cfset setLocale("Portuguese (Brazilian)")>
<cfprocessingDirective pageencoding="utf-8">
<cfset setEncoding("form","utf-8")> 

<style>
/*http://stackoverflow.com/questions/10618917/need-thin-table-borders-in-pdf-generated-by-cfdocument*/
.tbl {
	background-color:#000;
}
.tbl td,th,tr,caption{
	background-color:#fff
}
</style>

<cfoutput>	
	<h2>Pré proposta #qPdf.rev_codigo#</h2>

	<table  cellspacing="1" class="tbl">
		<tr>
			<td colspan="2" align="center">
				<b>Dados do representante</b>
			</td>
		</tr>
		<tr>
			<td>
				Código do representante:
			</td>
			<td>
				#qLogin.CF002_NR_INST#
			</td>
		</tr>
		<tr>
			<td>
				Unidade:
			</td>
			<td>
				#qLogin.CF002_NM_ABREV#
			</td>
		</tr>
		<tr>
			<td>
				Usuário:
			</td>
			<td>
				#qLogin.CF002_NM_INST#
			</td>
		</tr>
		<tr>
			<td>
				Vendedor:
			</td>
			<td>
				#arguments.REPRESENTANTE.vendedor#
			</td>
		</tr>
		<tr>
			<td>
				Telefone:
			</td>
			<td>
				[Telefone]
			</td>
		</tr>
		<tr>
			<td>
				Celular:
			</td>
			<td>
				[Celular]
			</td>
		</tr>
	</table>

	<p>
		<i>Endereço:</i>
	</p>

	<p>
		adfasdf asd fasdf asdf
	</p>
</cfoutput>