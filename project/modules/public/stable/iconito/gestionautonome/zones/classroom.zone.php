<?php

/**
 * Affichage des classes
 */
class ZoneClassroom extends CopixZone {

	function _createContent (& $toReturn) {
	  
	  $ppo = new CopixPPO ();                               
	  
	  $user = _currentUser ();
	  
	  // Récupération de l'année scolaire
    if (is_null($grade = _sessionGet('grade'))) {
      
      $grade = Kernel::getAnneeScolaireCourante ()->id_as;
    }
	  
	  if (is_null($schoolId = $this->getParam('school_id'))) {
	    
	    $toReturn = '';
	    return;
	  }

	  $classroomDAO = _ioDAO ('kernel|kernel_bu_ecole_classe');
	  $ppo->classrooms = $classroomDAO->findByUserIdAndUserType ($schoolId, $user->getId (), $user->getExtra('type'), $grade);

    $toReturn = $this->_usePPO ($ppo, '_classroom.tpl');
  }
}