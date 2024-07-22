# 20240722 - [DeveloppeurPascal](https://github.com/DeveloppeurPascal)

## Modifications sur "gamepad-ui-tests/uJoystickManager.pas"

* ajout de propriétés "tag" sur les classes
* ajout de propriétés "tag" sur les composants
* renommage de la classe TGamepadManagerClass en TGamepadDevicesManager
* application de la modification sur les autres projets du groupe de test
* ajout de valeurs par défaut dans les champs Tag(s)
* ajout de valeurs par défaut dans les Tag(s) publiés sur les composants
* désactivation de la boucle de gestion des gamepad lorsque la directive "IDE" est définie dans le projet (par exemple sur les paquets de construction fournis avec la librarie
* traitement de 2 warning (2 methodes SetXXX privées qui n'étaient plus utilisées)

## Modifications sur "gamepad-ui-tests/GamepadUITestsFMX"

* correction d'une violation d'accès aléatoire en sortie du programme (vue sous Windows)

## Modifications sur "gamepad-ui-tests/GamepadUITestsFMX"

* correction d'une possible violation d'accès aléatoire en sortie (vue sur le projet FMX, pas sur le VCL, mais on ne sait jamais)
* traitement des TODOs restants... (c'est à dire 1, inutile, qui été retiré)

## Modifications sur "gamepad-ui-tests/FMXTestsUI"

* added a constant to choose between a clean form with buttons in cells or a randomly filled form

* supression de la correction idiote de violation d'accès en sortie sur les deux autres exemples : le close était en Queue() ça ne sert à rien de le remettre en Queue() !

* Lors des déplacements on se restreignait aux boutons "proches" (ayant une zone commune en haut, bas, gauche ou droite) ce qui ne permettait pas d'accéder à tout. Désormais on peut aussi choper un autre composant si on n'en a pas trouvé respectant le critère précédent.

## Modifications sur "gamepad-ui-tests/FMXTestUIItemsList"

* synchronisation des focus entre l'interface gérée par Delphi (TAB ou clic) et la librairie UI qui prend en charge les déplacements au clavier et au contrôleur de jeux

## Modifications sur "SVGFromFolderToStringArrayInUnit"

* suppression du dossier suite au transfert de ses codes sources en tant que programme indépendant stocké dans le dépôt de code https://github.com/DeveloppeurPascal/SVGFolder2DelphiUnit
* mise à jour des docs (fr/en) pour refléter ce transfert
