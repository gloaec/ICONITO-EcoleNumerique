<script language="Javascript1.2" SRC="js/groupe/groupe_admin.js"></script>

{if not $errors eq null}
	<DIV CLASS="message_erreur">
	<UL>
	{foreach from=$errors item=error}
		<LI>{$error}</LI><br/>
	{/foreach}
	</UL>
	</DIV>
{/if}


	{if $list}
	
	<FORM NAME="form" ID="form" ACTION="{copixurl dest="|doUnsubscribe"}" METHOD="POST">
	<INPUT TYPE="hidden" NAME="id" VALUE="{$groupe->id}" ></INPUT>
	<H2>{i18n key="groupe.adminMembers.now"}</H2>
	<table border="0" CLASS="liste" ALIGN="CENTER" CELLSPACING=2 CELLPADDING=2>
		<tr>
			<th CLASS="liste_th">{i18n key="groupe.adminMembers.list.number"}</th>
			<th CLASS="liste_th">{i18n key="groupe.adminMembers.list.login"}</th>
			<th CLASS="liste_th">{i18n key="groupe.adminMembers.list.name"}</th>
			<th CLASS="liste_th">{i18n key="groupe.adminMembers.list.firstname"}</th>
			<th CLASS="liste_th">{i18n key="groupe.adminMembers.list.right"}</th>
			<th CLASS="liste_th">{i18n key="groupe.adminMembers.list.dates"}</th>
			<th CLASS="liste_th">{i18n key="groupe.adminMembers.list.modif"}</th>
			<th CLASS="liste_th">{i18n key="groupe.adminMembers.list.delete"}</th>
		</tr>

		{counter start=1 assign="cpt"}
		{foreach from=$list item=user}
			<tr class="list_line{$cpt%2}">
				<td align="center">{$cpt}</td>
				<td>{user label=$user.login userType=$user.type userId=$user.id login=$user.login dispMail=1}</td>
				<td>{$user.nom}</td>
				<td>{$user.prenom}</td>
				<td>{$user.droitnom}</td>
				<td>
        {if ($user.debut && $user.debut>$today) || ($user.fin && $user.fin<$today)}<div class="members_dates_nok">{/if}
        {if $user.debut && $user.fin} 
        {i18n key="groupe.adminMembers.list.dateDebutFin" debut=$user.debut|datei18n fin=$user.fin|datei18n}
        {elseif $user.debut} 
        {i18n key="groupe.adminMembers.list.dateDebut" debut=$user.debut|datei18n}
        {elseif $user.fin} 
        {i18n key="groupe.adminMembers.list.dateFin" debut=$user.fin|datei18n}
        {else} 
        {i18n key="groupe.adminMembers.list.dateAll"}
        {/if}
        {if ($user.debut && $user.debut>$today) || ($user.fin && $user.fin<$today)}</div>{/if}
        </td>
        <td align="center">{if $user.droit<70}<a href="{copixurl dest="|getHomeAdminMember" id=$groupe->id user_type=$user.type user_id=$user.id}">{i18n key="groupe.adminMembers.list.modif"}</a>{/if}</td>
				<td ALIGN="CENTER">{assign var=lui value=$user.type|cat:"|"|cat:$user.id}{if $his neq $lui}<input type="checkbox" name="membres[]" value="{$user.type}|{$user.id}" class="noBorder">{/if}</td>
				{counter}
			</tr>
		{/foreach}
		<tr CLASS="liste_footer">
			<td colspan="7"></td>
			<TD ALIGN="CENTER"><a href="javascript: deleteMembres();">{i18n key="groupe.btn.unsubscribe"}</a></TD>
		</TR>
		</table>
		</FORM>
		
	{else}
	<i>{i18n key="groupe.noMember"}</i>
	{/if}

	{if $listWaiting}
	
	<FORM NAME="form" ID="form" ACTION="{copixurl dest="|doSubscribeWaiting"}" METHOD="POST">
	<INPUT TYPE="hidden" NAME="id" VALUE="{$groupe->id}" ></INPUT>
	<H2>{i18n key="groupe.adminMembers.waiting"}</H2>
	<table border="0" CLASS="liste" align="CENTER" CELLSPACING=2 CELLPADDING=2>
		<tr>
			<th CLASS="liste_th">{i18n key="groupe.adminMembers.list.number"}</th>
			<th CLASS="liste_th">{i18n key="groupe.adminMembers.list.login"}</th>
			<th CLASS="liste_th">{i18n key="groupe.adminMembers.list.name"}</th>
			<th CLASS="liste_th">{i18n key="groupe.adminMembers.list.firstname"}</th>
			<th CLASS="liste_th">{i18n key="groupe.adminMembers.list.subscribeWait"}</th>
			<th CLASS="liste_th">{i18n key="groupe.adminMembers.list.subscribe1"}</th>
			<th CLASS="liste_th">{i18n key="groupe.adminMembers.list.subscribe0"}</th>
		</tr>

		{counter start=1 assign="cpt"}
		{foreach from=$listWaiting item=user}
      {assign var=tmp value=$user.type|cat:"|"|cat:$user.id}
			<tr CLASS="list_line{$cpt%2}">
				<td ALIGN="CENTER">{$cpt}</td>
				<td>{$user.login}</td>
				<td>{$user.nom}</td>
				<td>{$user.prenom}</td>
				<td ALIGN="CENTER"><input type=radio name="membres[{$user.type}|{$user.id}]" {if $membresW[$tmp] eq "WAIT" || $membresW[$tmp] eq ""}CHECKED{/if} value="WAIT" class="noBorder"></td>
				<td ALIGN="CENTER"><input type=radio name="membres[{$user.type}|{$user.id}]" {if $membresW[$tmp] eq "1"}CHECKED{/if} value="1" class="noBorder"></td>
				<td ALIGN="CENTER"><input type=radio name="membres[{$user.type}|{$user.id}]" {if $membresW[$tmp] eq "0"}CHECKED{/if} value="0" class="noBorder"></td>
				{counter}
			</tr>
		{/foreach}
		<tr CLASS="liste_footer">
			<TD COLSPAN="6">{i18n key="groupe.adminMembers.addDatesW"}
      <br/>
      {i18n key="groupe.adminMembers.addDates.debut"}&nbsp;: {calendar name="debutW" value=$debutW|datei18n} &nbsp; {i18n key="groupe.adminMembers.addDates.fin"}&nbsp;:{calendar name="finW" value=$finW|datei18n}
      
      </TD>
			<TD ALIGN="CENTER"><input style="" class="form_button" type="submit" value="{i18n key="groupe.btn.valid"}" /></TD>
		</TR>
		</table>
		</FORM>
	{/if}

		
	
	
	<H2>{i18n key="groupe.adminMembers.add"}</H2>
	
	<table cellpadding="1" cellspacing="1" border="0" width="500">
<form action="{copixurl dest="|doSubscribe"}" method="post">
<input type="hidden" name="id" value="{$groupe->id}" />
	<TR><td CLASS="form_saisie" COLSPAN=2>
	

<textarea class="form" style="width: 400px; height: 50px;" name="membres" id="membres">{$membres}</textarea>

</TD></TR>
<tr><td CLASS="form_saisie" colspan="2">{i18n key="groupe.adminMembers.addInfo"} {$linkpopup}</TD></TR>

<tr>
<td class="form_saisie"><br/>{i18n key="groupe.adminMembers.addDates"}<br/>
<table>
<tr><td>{i18n key="groupe.adminMembers.addDates.debut"}&nbsp;:</td><td>{calendar name="debut" value=$debut|datei18n}</td></tr>
<tr><td>{i18n key="groupe.adminMembers.addDates.fin"}&nbsp;:</td><td>{calendar name="fin" value=$fin|datei18n}</td>
</table>

</td>
<td CLASS="form_submit">

<input style="" class="form_button" type="submit" value="{i18n key="groupe.btn.subscribe"}" />


</TD>
</tr>







</TABLE>

</form>	
	
	
	