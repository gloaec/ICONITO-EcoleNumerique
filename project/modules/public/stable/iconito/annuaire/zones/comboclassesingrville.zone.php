<?php

/**
 * Zone qui affiche la liste d�roulante avec toutes les classes d'un groupe de villes
 * 
 * @package Iconito
 * @subpackage	Annuaire
 */
class ZoneComboClassesInGrville extends CopixZone {

	/**
	 * Affiche la liste d�roulante avec toutes les classes d'un groupe de villes
	 *
	 * @author Christophe Beyer <cbeyer@cap-tic.fr>
	 * @since 2006/01/06
	 * @param integer $grville Id du groupe de villes
	 * @param integer $value Valeur actuelle de la combo
	 * @param string $fieldName Nom du champ de type SELECT qui en r�sulte
	 * @param string $attribs Attributs HTML de la liste (STYLE, ONCHANGE...)
	 * @param array $linesSup Lignes suppl�mentaires � ajouter en haut de la liste au-dessus des dossiers (ex: "Choisissez l'�cole"). Chaque ligne est un tableau, de type array ("value"=>"", "libelle"=>"Choisissez")
	 */
	function _createContent (&$toReturn) {
		
		$annuaireService = & CopixClassesFactory::Create ('annuaire|AnnuaireService');
		
		$grville = isset($this->getParam('grville')) ? $this->getParam('grville') : NULL;
		$value = isset($this->getParam('value')) ? $this->getParam('value') : 0;
		$fieldName = isset($this->getParam('fieldName')) ? $this->getParam('fieldName') : NULL;
		$attribs = isset($this->getParam('attribs')) ? $this->getParam('attribs') : NULL;
		$linesSup = isset($this->getParam('linesSup')) ? $this->getParam('linesSup') : NULL;
		
		$classes = $annuaireService->getClassesInGrville ($grville, array('getNodeInfo_light'=>1));
		
		$tpl = & new CopixTpl ();
		$tpl->assign('items', $classes);
		$tpl->assign('value', $value);
		$tpl->assign('fieldName', $fieldName);
		$tpl->assign('attribs', $attribs);
		$tpl->assign('linesSup', $linesSup);
		
    $toReturn = $tpl->fetch ('comboclasses.tpl');
    return true;
	}

}


?>