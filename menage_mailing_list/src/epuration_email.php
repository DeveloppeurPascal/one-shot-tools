<?php
// permet de récupérer une liste d'adresses email à partir d'un fichier origine
// pratique pour extraire les emails en erreur suite à un emailing
// (c) pprem 18/02/2005

  print ("Etape 0: début du programme<br>");
  
  set_time_limit (0);

  function traiter_fichier ($nom_f_orig, $f_dest) {
    $origine = file_get_contents ($nom_f_orig);
    if (false === $origine) {
      print ("<p>Fichier d'origine non ouvert : ".$nom_f_orig."</p>");
    } else {
      print ("<p>Fichier d'origine ouvert : ".$nom_f_orig."</p>");
//      print ("<p>contenu : ".htmlentities ($origine)."</p>");
    }
    print ("<p>Longueur du fichier d'origine : ".strlen ($origine)."</p>");
//    $origine = strip_tags ($origine);
//    print ("<p>Longueur du fichier d'origine après retrait des tags HTML : ".strlen ($origine)."</p>");
//    print ("<p>contenu : ".htmlentities ($origine)."</p>");
    $old_value = "";
    while (ereg ("To: ([a-zA-Z0-9\._-]+@[a-zA-Z0-9\._-]+\.[a-zA-Z0-9\._-]{2,10})", $origine, $ch)) {
      $value = strtolower ($ch[1]);
      print ($ch[1]."<br>");
      $n = strpos ($origine, $value);
      $origine = substr ($origine, $n+strlen ($value), strlen ($origine));
      if (($value != $old_value) && (false === strpos ($value, "@DomainToIgnore1.com")) && (false === strpos ($value, "@DomainToIgnore2.com")) && (false === strpos ($value, "@SenderDomain.com")) && (false === strpos ($value, "mailer-daemon")) && (false === strpos ($value, "abuse")) && (false === strpos ($value, "postmaster"))) {
        $old_value = $value;
        fwrite ($f_dest, $value."\n");
      }
    }
  }

  print ("Etape 1: ouverture de la destination<br>");
  $f_dest = fopen ("liste_email_".date("YmdHis").".txt", "w");
  print ("Etape 2: parcourt de la source<br>");
  traiter_fichier ("PathToLogFileFromWichWeWantToExtractEmail.txt", $f_dest);
  print ("Etape 3: fermeture de la destination<br>");
  fclose ($f_dest);
  print ("Etape 4: fin du programme<br>");
?>