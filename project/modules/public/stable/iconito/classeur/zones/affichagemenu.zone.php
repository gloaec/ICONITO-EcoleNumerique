<?php
/**
* @package    Iconito
* @subpackage Classeur
* @author     Jérémy FOURNAISE
*/
class ZoneAffichageMenu extends CopixZone {

	function _createContent (& $toReturn) {
	  
	  $ppo = new CopixPPO ();
	  
	  // Récupération des paramètres
	  $ppo->classeurId = $this->getParam('classeurId');
	  $ppo->dossierId  = $this->getParam('dossierId');
	  $ppo->current    = $this->getParam('current');
	  
	  // Gestion des droits
	  $ppo->niveauUtilisateur = Kernel::getLevel('MOD_CLASSEUR', $ppo->classeurId);
	  $ppo->typeUtilisateur   = _currentUser()->getExtra('type');
	  
	  $ppo->vue = !is_null(_sessionGet('classeur|typeVue')) ? _sessionGet('classeur|typeVue') : 'liste';
	  
	  // L'album public est t-il publié ?
	  $ppo->estPublic = false;
	  if (!is_null($ppo->dossierId) && $ppo->dossierId != 0) {
	    
	    $dossierDAO = _ioDAO('classeur|classeurdossier');
	    $dossier = $dossierDAO->get($ppo->dossierId);
	    if ($dossier->public) {
	      
	      $ppo->estPublic = true;
	    }
	  }
	  else {
	    
	    $classeurDAO = _ioDAO('classeur|classeur');
	    $classeur = $classeurDAO->get($ppo->classeurId);
	    if ($classeur->public) {
	      
	      $ppo->estPublic = true;
	    }
	  }
    
	  $toReturn = $this->_usePPO ($ppo, '_affichage_menu.tpl');
  }
}