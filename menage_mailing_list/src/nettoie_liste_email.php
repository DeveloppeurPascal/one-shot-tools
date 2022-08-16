<?php
// nettoie une liste d'adresse à partir d'une liste d'adresses erronées
// (c) pprem 23/01/2005

  function nettoyage ($nom_orig, $nom_dest) {
    $blacklist = file ("PathToEmailErrorLogFileOrEmailBlacklist.txt");
    print ("blacklist: ".count($blacklist)."<br>\n");
    $orig = file ($nom_orig);
    print ("orig: ".count($orig)."<br>\n");
    $dest = array_diff ($orig, $blacklist);
    print ("dest: ".count($dest)."<br>\n");
    if ($f = fopen ($nom_dest, "w")) {
      sort ($dest);
      reset ($dest);
      while (list ($key, $value) = each ($dest)) {
        fwrite ($f, $value);
      }
      fclose ($f);
    }
  }

  nettoyage ("PathToSubscribersEmailList.txt", "PathToFilteredSubscribersEmailList.txt");
?>