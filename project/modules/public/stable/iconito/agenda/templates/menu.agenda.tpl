{if $parent.url && $parent.txt}<a href="{$parent.url}">{$parent.txt}</a> :: {/if}
{if 1}<a href="{copixurl dest="agenda|agenda|vueSemaine"}">{i18n key="agenda.menu.back"}</a> :: {/if}
{if $ableToWrite}<a href="{copixurl dest="agenda|event|create"}">{i18n key="agenda.menu.ajoutEvent"}</a> :: {/if}
{if $ableToModerate}<a href="{copixurl dest="agenda|importexport|prepareImport"}">{i18n key="agenda.menu.import"}</a> :: {/if}
<a href="{copixurl dest="agenda|importexport|prepareExport"}">{i18n key="agenda.menu.export"}</a> ::
{*
{i18n key="agenda.menu.agenda" assign=text}
*}
{assign var="text" value="<span style=\"text-decoration:underline;\">$text</span>"}
{popupinformation displayimg=false displaytext=true text=$text divclass="popupAgenda"}

	<form action="{copixurl dest="agenda|agenda|vueSemaine"}" method="post" name="chooseAgenda">
		{foreach from=$listAgendas item=agenda}
			{assign var="id" value=$agenda->id_agenda}
			{assign var="color" value=$arColorByIdAgenda[$id]}
			<div class="titreAgenda"><div style="margin-left:3px; margin-right:2px; margin-top:3px; float: right; height:14px; width:14px; background-color:#{$color}">&nbsp;</div>{$agenda->title_agenda}<input type="checkbox" name="agendas.{$agenda->id_agenda}" value=1 {if isset($agendasSelectionnes[$id])}checked="checked"{/if}/></div>
		{/foreach}
		<input type="hidden" name="updateAgendaAffiches" value="1" />
		<input type="submit" class="form_button" style="margin-top: 5px;" value="{i18n key="copix:common.buttons.valid"}" />
	</form>
{/popupinformation}