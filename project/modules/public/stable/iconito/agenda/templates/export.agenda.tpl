{if $showError}
	<div class="errorMessage">
		<h1>{i18n key=copix:common.messages.error}</h1>
		{foreach from=$arError item=errors key=index}
		{ulli values=$errors}
		{/foreach}
	</div>
{/if}

<form action="{copixurl dest="agenda|importexport|export"}" method="post" class="copixForm" name="importiCal">
	<table border="0" CELLSPACING="1" CELLPADDING="1" class="saisieEvent">
		<tr>
			<td class="form_libelle">{i18n key="agenda.message.agenda"}</td>
			<td class="checkbox_export">
	   				{foreach from=$arTitleAgendasAffiches item=title key=idAgenda}
						<input type="checkbox" value="{$idAgenda}" name="agenda[]" {if is_array($exportParams->agenda) and in_array($idAgenda, $exportParams->agenda) }checked="checked"{/if} />{$title}<br />
					{/foreach}
			</td>
		</tr>
		<tr>
			<td class="form_libelle">{i18n key="agenda.message.periode"}</td>
			<td class="periode"><label for="{i18n key="agenda.message.begin"}">{i18n key="agenda.message.begin"}</label>		
				{assign var=myDate value=$exportParams->datedeb_export|datei18n}
				{calendar name="datedeb_export" value=$myDate} {i18n key="kernel|date.format"}
			</td>
		</tr>
		<tr>
			<td></td>
			<td>
				<label for="{i18n key="agenda.message.end"}">{i18n key="agenda.message.end"}</label>
				{assign var=myDate value=$exportParams->datefin_export|datei18n}
				{calendar name="datefin_export" value=$myDate} {i18n key="kernel|date.format"}
			</td>
		</tr>
    <tr>
    <td colspan="4" CLASS="form_submit"><input type="button" class="form_button" value="{i18n key=copix:common.buttons.cancel}" onclick="javascript:document.location='{copixurl dest="agenda|agenda|vueSemaine"}'" />
		<input type="submit" class="form_button" value="{i18n key="agenda.message.download"}" />
    </td>
    </tr>
	</table>

</form>