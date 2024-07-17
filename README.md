# One shot tools

[Cette page en français.](LISEZMOI.md)

Those programs are simple utilities I created to solve a problem or simplify a task I had.

They probably won't be useful for you, but you can check their source file to see how to do some tasks and adapt them to your needs.

It's Pascal programming language in Delphi, JavaScript or PHP depending on what I wanted to do.

Except if you have issues or questions to share with me, the projects in this repository won't be maintained.

If you are looking for code examples to learn Delphi or basic manipulations look instead at [this repository of examples of all kinds](https://github.com/DeveloppeurPascal/Delphi-samples).

This code repository contains projects developed in Object Pascal language under Delphi. You don't know what Delphi is and where to download it ? You'll learn more [on this web site](https://delphi-resources.developpeur-pascal.fr/).

## Source code installation

To download this code repository, we recommend using "git", but you can also download a ZIP file directly from [its GitHub repository](https://github.com/DeveloppeurPascal/one-shot-tools).

This project uses dependencies in the form of sub-modules. They will be absent from the ZIP file. You'll have to download them by hand.

* [DeveloppeurPascal/Delphi-Game-Engine](https://github.com/DeveloppeurPascal/Delphi-Game-Engine) must be installed in the ./lib-externes/Delphi-Game-Engine subfolder.
* [DeveloppeurPascal/librairies](https://github.com/DeveloppeurPascal/librairies) must be installed in the ./lib-externes/librairies subfolder.

## License to use this code repository and its contents

This source code is distributed under the [AGPL 3.0 or later license](https://choosealicense.com/licenses/agpl-3.0/).

You are generally free to use the contents of this code repository anywhere, provided that:
* you mention it in your projects
* distribute the modifications made to the files supplied in this project under the AGPL license (leaving the original copyright notices (author, link to this repository, license) which must be supplemented by your own)
* to distribute the source code of your creations under the AGPL license.

If this license doesn't suit your needs, you can purchase the right to use this project under the [Apache License 2.0](https://choosealicense.com/licenses/apache-2.0/) or a dedicated commercial license ([contact the author](https://developpeur-pascal.fr/nous-contacter.php) to explain your needs).

These source codes are provided as is, without warranty of any kind.

Certain elements included in this repository may be subject to third-party usage rights (images, sounds, etc.). They are not reusable in your projects unless otherwise stated.

## How to ask a new feature, report a bug or a security issue ?

If you want an answer from the project owner the best way to ask for a new feature or report a bug is to go to [the GitHub repository](https://github.com/DeveloppeurPascal/one-shot-tools) and [open a new issue](https://github.com/DeveloppeurPascal/one-shot-tools/issues).

If you found a security issue please don't report it publicly before a patch is available. Explain the case by [sending a private message to the author](https://developpeur-pascal.fr/nous-contacter.php).

You also can fork the repository and contribute by submitting pull requests if you want to help. Please read the [CONTRIBUTING.md](CONTRIBUTING.md) file.

## Support the project and its author

If you think this project is useful and want to support it, please make a donation to [its author](https://github.com/DeveloppeurPascal). It will help to maintain the code and binaries.

You can use one of those services :

* [GitHub Sponsors](https://github.com/sponsors/DeveloppeurPascal)
* [Liberapay](https://liberapay.com/PatrickPremartin)
* [Patreon](https://www.patreon.com/patrickpremartin)
* [Paypal](https://www.paypal.com/paypalme/patrickpremartin)

or if you speack french you can [subscribe to Zone Abo](https://zone-abo.fr/nos-abonnements.php) on a monthly or yearly basis and get a lot of resources as videos and articles.

## List of projects

### DisplayDPROJContent

Displays the content of Delphi project options file.

### gamepad-ui-tests

Some VCL and FMX tests project to use the user interface with a keyboard, mouse and gamepads.

### generation-serie-mots-de-passe

Creates a randomly generated password list for a user list.

### genpassword

Generates a list of passwords with only letters and numbers.

### import-CSV-from-MSSQLServer-To-MySQL

Generate SQL commands to create a database structure from a MS SQL Server dump as CSV files.

### menage_mailing_list

Scripts to extract emails from a list of email or a log.

### mesiim471222_ovh_vps

Program created in 2022 to generate user accounts and detailed texts for accessing a hosting account with FTP/MySQL/PostgreSQL and of course a (sub)domain name to configure on a web server under Debian with VirtualMin (but work for all sort of hosting).

### mesimf371818_ovh

A program created in 2018 to add users, virtual domains web hosting and MySQL Databases on a Debian 9 OVH virtual private server.

Give users names on first memo field, click the button and copy/paste the users/passwords list, the Apache <VirtualHost> source, the MySQL create databases SQL script and bash commands to create users and folders.

Of course change the domaine name "mesimf371818.ovh" hard coded in the source before doing anything with this program.

### RedirectionPasDPK

Change all PAS files in a folder with a deprecated comment and an include to the new file path (for compatibility reasons). (useful when changing the tree structure of an open source library or related enterprise project)

### rename-all-files-in-a-folder

A simple code to rename files in a folder and use a local counter for that.

### show-images-fullscreen

Show all images (JPG, PNG) from a folder in full screen. Use arrow keys to change the picture (next / previous) and ESC/RETURN to exit.

### SVGFromFolderToStringArrayInUnit

List all SVG files from a folder and create a unit where they are stored as strings in an array, with the filename as a constant used as array index.

### TDirectory_CreateDirectory_Check

Test methods TDirectory.CreateDirectory(), TDirectory.Delete() and the TPath.GetXXXPath() for Delphi programs on all available platforms.

### tirages_au_sort

To attribute gains in a lotery depending on the number of participants and gifts.

### webhosting-send-ftp-config-email

Send the "FTP config mail" for a web hosting service from a list of user/passwords.

### webhosting-send-mysql-config-email

Send the "database config mail" for a web hosting service from a list of user/passwords.
