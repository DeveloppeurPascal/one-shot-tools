# Programmes à usage unique

[This page in English.](README.md)

Ces programmes sont de simples utilitaires que j'ai créés pour résoudre un problème ou simplifier une tâche que j'avais.

Ils ne vous seront probablement pas utiles, mais vous pouvez consulter leur fichier source pour voir comment effectuer certaines tâches et les adapter à vos besoins.

Il s'agit du langage de programmation Pascal dans Delphi, JavaScript ou PHP en fonction de ce que je voulais faire.

Sauf si vous avez des problèmes ou des questions à partager avec moi, les projets de ce dépôt ne seront pas maintenus.

Si vous cherchez des exemples de code pour apprendre Delphi ou des manipulations de base regardez plutôt [ce dépôt d'exemples de toutes sortes](https://github.com/DeveloppeurPascal/Delphi-samples).

Ce dépôt de code contient des projets développés en langage Pascal Objet sous Delphi. Vous ne savez pas ce qu'est Dephi ni où le télécharger ? Vous en saurez plus [sur ce site web](https://delphi-resources.developpeur-pascal.fr/).

## Présentations et conférences

### Twitch

Suivez mes streams de développement de logiciels, jeux vidéo, applications mobiles et sites web sur [ma chaîne Twitch](https://www.twitch.tv/patrickpremartin) ou en rediffusion sur [Serial Streameur](https://serialstreameur.fr) la plupart du temps en français.

## Installation des codes sources

Pour télécharger ce dépôt de code il est recommandé de passer par "git" mais vous pouvez aussi télécharger un ZIP directement depuis [son dépôt GitHub](https://github.com/DeveloppeurPascal/one-shot-tools).

Ce projet utilise des dépendances sous forme de sous modules. Ils seront absents du fichier ZIP. Vous devrez les télécharger à la main.

* [DeveloppeurPascal/Delphi-Game-Engine](https://github.com/DeveloppeurPascal/Delphi-Game-Engine) doit être installé dans le sous dossier ./lib-externes/Delphi-Game-Engine
* [DeveloppeurPascal/librairies](https://github.com/DeveloppeurPascal/librairies) doit être installé dans le sous dossier ./lib-externes/librairies
* [DeveloppeurPascal/SVG-cards](https://github.com/DeveloppeurPascal/SVG-cards) doit être installé dans le sous dossier ./lib-externes/SVG-cards

## Documentation et assistance

Je passe par des commentaires au format [XMLDOC](https://docwiki.embarcadero.com/RADStudio/fr/Commentaires_de_documentation_XML) dans Delphi pour documenter mes projets. Ils sont reconnus par Help Insight qui propose de l'aide à la saisie en temps réel dans l'éditeur de code.

J'utilise régulièrement l'outil [DocInsight](https://devjetsoftware.com/products/documentation-insight/) pour les saisir et contrôler leur formatage.

L'export de la documentation est fait en HTML par [DocInsight](https://devjetsoftware.com/products/documentation-insight/) ou [PasDoc](https://pasdoc.github.io) vers le dossier /docs du dépôt. Vous y avez aussi [accès en ligne](https://developpeurpascal.github.io/one-shot-tools) grâce à l'hébergement offert par GitHub Pages.

D'autres informations (tutoriels, articles, vidéos, FAQ, présentations et liens) sont disponibles sur [le site web du projet](https://oneshottools.developpeur-pascal.fr) ou [le devlog du projet](https://developpeur-pascal.fr/les-one-shot.html).

Si vous avez besoin d'explications ou d'aide pour comprendre ou utiliser certaines parties de ce projet dans le vôtre, n'hésitez pas à [me contacter](https://developpeur-pascal.fr/nous-contacter.php). Je pourrai soit vous orienter vers une ressource en ligne, soit vous proposer une assistance sous forme de prestation payante ou gratuite selon les cas. Vous pouvez aussi me faire signe à l'occasion d'une conférence ou pendant une présentation en ligne.

## Compatibilité

En tant que [MVP Embarcadero](https://www.embarcadero.com/resources/partners/mvp-directory) je bénéficie dès qu'elles sortent des dernières versions de [Delphi](https://www.embarcadero.com/products/delphi) et [C++ Builder](https://www.embarcadero.com/products/cbuilder) dans [RAD Studio](https://www.embarcadero.com/products/rad-studio). C'est donc dans ces versions que je travaille.

Normalement mes librairies et composants doivent aussi fonctionner au moins sur la version en cours de [Delphi Community Edition](https://www.embarcadero.com/products/delphi/starter).

Aucune garantie de compatibilité avec des versions antérieures n'est fournie même si je m'efforce de faire du code propre et ne pas trop utiliser les nouvelles façons d'écrire dedans (type inference, inline var et multilines strings).

Si vous détectez des anomalies sur des versions antérieures n'hésitez pas à [les rapporter](https://github.com/DeveloppeurPascal/one-shot-tools/issues) pour que je teste et tente de corriger ou fournir un contournement.

## Licence d'utilisation de ce dépôt de code et de son contenu

Ces codes sources sont distribués sous licence [AGPL 3.0 ou ultérieure](https://choosealicense.com/licenses/agpl-3.0/).

Vous êtes libre d'utiliser le contenu de ce dépôt de code n'importe où à condition :
* d'en faire mention dans vos projets
* de diffuser les modifications apportées aux fichiers fournis dans ce projet sous licence AGPL (en y laissant les mentions de copyright d'origine (auteur, lien vers ce dépôt, licence) obligatoirement complétées par les vôtres)
* de diffuser les codes sources de vos créations sous licence AGPL

Si cette licence ne convient pas à vos besoins (notamment pour un projet commercial) je propose aussi [des licences classiques pour les développeurs et les entreprises](https://oneshottools.developpeur-pascal.fr).

Certains éléments inclus dans ce dépôt peuvent dépendre de droits d'utilisation de tiers (images, sons, ...). Ils ne sont pas réutilisables dans vos projets sauf mention contraire.

Les codes sources de ce dépôt de code comme leur éventuelle version compilée sont fournis en l'état sans garantie d'aucune sorte.

## Comment demander une nouvelle fonctionnalité, signaler un bogue ou une faille de sécurité ?

Si vous voulez une réponse du propriétaire de ce dépôt la meilleure façon de procéder pour demander une nouvelle fonctionnalité ou signaler une anomalie est d'aller sur [le dépôt de code sur GitHub](https://github.com/DeveloppeurPascal/one-shot-tools) et [d'ouvrir un ticket](https://github.com/DeveloppeurPascal/one-shot-tools/issues).

Si vous avez trouvé une faille de sécurité n'en parlez pas en public avant qu'un correctif n'ait été déployé ou soit disponible. [Contactez l'auteur du dépôt en privé](https://developpeur-pascal.fr/nous-contacter.php) pour expliquer votre trouvaille.

Vous pouvez aussi cloner ce dépôt de code et participer à ses évolutions en soumettant vos modifications si vous le désirez. Lisez les explications dans le fichier [CONTRIBUTING.md](CONTRIBUTING.md).

## Supportez ce projet et son auteur

Si vous trouvez ce dépôt de code utile et voulez le montrer, merci de faire une donation [à son auteur](https://github.com/DeveloppeurPascal). Ca aidera à maintenir le projet (codes sources et binaires).

Vous pouvez utiliser l'un de ces services :

* [GitHub Sponsors](https://github.com/sponsors/DeveloppeurPascal)
* Ko-fi [en français](https://ko-fi.com/patrick_premartin_fr) ou [en anglais](https://ko-fi.com/patrick_premartin_en)
* [Patreon](https://www.patreon.com/patrickpremartin)
* [Liberapay](https://liberapay.com/PatrickPremartin)
* [Paypal](https://www.paypal.com/paypalme/patrickpremartin)

Vous pouvez acheter [mes logiciels](https://lic.olfsoftware.fr/products.php?lng=fr), [mes jeux vidéo](https://lic.gamolf.fr/products.php?lng=fr) ou [une licence de développement pour mes bibliothèques](https://lic.developpeur-pascal.fr/products.php?lng=fr) si vous les utilisez dans vos projets.

Si vous parlez français [abonnez-vous à Zone Abo](https://zone-abo.fr/nos-abonnements.php) pour accéder à l'intégralité de mes archives en ligne (articles, vidéos, vidéos de formation, ebooks).

## Liste des projets

### DisplayDPROJContent

Affichage d'informations contenues dans un fichier d'options de projet de Delphi.

### gamepad-ui-tests

Des tests en VCL et FireMonkey pour manipuler une interface utilisateur avec clavier, souris et contrôleur de jeux.

### generation-serie-mots-de-passe

Crée une liste de mots de passe générés de façon aléatoire pour une liste d'utilisateurs.

### genpassword

Génère une liste de mots de passe contenant uniquement des lettres et des chiffres.

### import-CSV-from-MSSQLServer-To-MySQL

Générer des commandes SQL pour créer une structure de base de données à partir d'un dump MS SQL Server sous forme de fichiers CSV.

### LinkWebsiteServerSampleDBGenerator

Générateur de base de données de test (sous forme de fichiers JSON) pour le projet de moteur d'affichage de sites web multilingues disponible sur https://github.com/DeveloppeurPascal/Link-Website-Server

### menage_mailing_list

Scripts pour extraire les emails d'une liste d'emails ou d'un journal.

### mesiim471222_ovh_vps

Programme créé en 2022 pour générer des comptes utilisateurs et des textes détaillés pour accéder à un compte d'hébergement avec FTP/MySQL/PostgreSQL et bien sûr un nom de (sous-)domaine à configurer sur un serveur web sous Debian avec VirtualMin (mais fonctionne pour tout type d'hébergement).

### mesimf371818_ovh

Un programme créé en 2018 pour ajouter des utilisateurs, des domaines virtuels d'hébergement web et des bases de données MySQL sur un serveur privé virtuel Debian 9 OVH.

Donnez des noms d'utilisateurs sur le premier champ mémo, cliquez sur le bouton et copiez/collez la liste des utilisateurs/mots de passe, la source Apache <VirtualHost>, le script SQL MySQL create databases et les commandes bash pour créer les utilisateurs et les dossiers.

Bien sûr, changez le nom de domaine "mesimf371818.ovh" codé en dur dans la source avant de faire quoi que ce soit avec ce programme.

### RedirectionPasDPK

Modifie les fichiers PAS d'un dossier en ajoutant un commentaire indiquant qu'ils sont dépréciés et enfaisant un lien vers la nouvelle position du fichier déplacé pour des raisons de compatibilité ascendante. (utile en cas de changement d'arborescence d'une librairie open source ou d'un projet lié en entreprise)

### rename-all-files-in-a-folder

Un code simple pour renommer des fichiers dans un dossier et utiliser un compteur local pour cela.

### show-images-fullscreen

Affiche toutes les images (JPG, PNB) d'un dossier en plein écran une par une. Changez avec les flèches pour passer de l'une à l'autre et sortez avec ESC ou ENTREE.

### SVGCardSocialPreviewImageGenerator

Utilise les images vectorielles de SVG Cards pour générer une image utilisée en prévisualisation sur les réseaux sociaux lors du partage de son dépôt GitHub.

### TDirectory_CreateDirectory_Check

Test des méthodes TDirectory.CreateDirectory(), TDirectory.Delete() et TPath.GetXXXPath() pour les programmes Delphi sur toutes les plateformes disponibles.

### tirages_au_sort

Pour attribuer des gains dans une loterie en fonction du nombre de participants et de cadeaux.

### webhosting-send-ftp-config-email

Envoyer le "FTP config mail" pour un service d'hébergement web à partir d'une liste d'utilisateurs/mots de passe.

### webhosting-send-mysql-config-email

Envoyer le "mail de configuration de la base de données" pour un service d'hébergement web à partir d'une liste d'utilisateurs/mots de passe.

## Liste des projets supprimés

Ces programmes ne sont plus disponibles ici. Ils ont été transformés en logiciels indépendants ou ont été supprimés pour d'autres raisons.

### CreateGroupProjFromPath

Crée un groupe de projet pour Delphi à partir des projets trouvés dans une arborescence donnée.

Il est devenu [GroupProj Updater](https://groupprojupdater.olfsoftware.fr). Ses codes sources sont disponibles [sur ce dépôt de code](https://github.com/DeveloppeurPascal/GroupProjUpdater).

### SVGFromFolderToStringArrayInUnit

Liste tous les fichiers SVG d'un dossier et crée une unité dans laquelle ils sont stockés sous forme d'un tableau de chaines avec comme index le nom du fichier défini comme constante.

Il est devenu [SVG Folder To Delphi Unit](http://svgfolder2delphiunit.olfsoftware.fr). Ses codes sources sont disponibles [sur ce dépôt de code](https://github.com/DeveloppeurPascal/SVGFolder2DelphiUnit).
