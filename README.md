# One shot tools

[Cette page en français.](LISEZMOI.md)

Those programs are simple utilities I created to solve a problem or simplify a task I had.

They probably won't be useful for you, but you can check their source file to see how to do some tasks and adapt them to your needs.

It's Pascal programming language in Delphi, JavaScript or PHP depending on what I wanted to do.

Except if you have issues or questions to share with me, the projects in this repository won't be maintained.

If you are looking for code examples to learn Delphi or basic manipulations look instead at [this repository of examples of all kinds](https://github.com/DeveloppeurPascal/Delphi-samples).

This code repository contains projects developed in Object Pascal language under Delphi. You don't know what Delphi is and where to download it ? You'll learn more [on this web site](https://delphi-resources.developpeur-pascal.fr/).

## Talks and conferences

### Twitch

Follow my development streams of software, video games, mobile applications and websites on [my Twitch channel](https://www.twitch.tv/patrickpremartin) or as replays on [Serial Streameur](https://serialstreameur.fr) mostly in French.

## Source code installation

To download this code repository, we recommend using "git", but you can also download a ZIP file directly from [its GitHub repository](https://github.com/DeveloppeurPascal/one-shot-tools).

This project uses dependencies in the form of sub-modules. They will be absent from the ZIP file. You'll have to download them by hand.

* [DeveloppeurPascal/Delphi-Game-Engine](https://github.com/DeveloppeurPascal/Delphi-Game-Engine) must be installed in the ./lib-externes/Delphi-Game-Engine subfolder.
* [DeveloppeurPascal/librairies](https://github.com/DeveloppeurPascal/librairies) must be installed in the ./lib-externes/librairies subfolder.

# Documentation and support

The project's technical documentation, generated with [DocInsight](https://devjetsoftware.com/products/documentation-insight/), is available in the ./docs folder and on [GitHub Pages](https://developpeurpascal.github.io/one-shot-tools). Further information and related links are available on [the project website](https://oneshottools.developpeur-pascal.fr).

If you need explanations or help in using this project in your own, please [contact me](https://developpeur-pascal.fr/nous-contacter.php). I can either direct you to an online resource, or offer you assistance on a fee-for-service basis. You can also contact me at a conference or an online presentation.

## Compatibility

As an [Embarcadero MVP](https://www.embarcadero.com/resources/partners/mvp-directory), I benefit from the latest versions of [Delphi](https://www.embarcadero.com/products/delphi) and [C++ Builder](https://www.embarcadero.com/products/cbuilder) in [RAD Studio](https://www.embarcadero.com/products/rad-studio) as soon as they are released. I therefore work with these versions.

Normally, my libraries and components should also run on at least the current version of [Delphi Community Edition](https://www.embarcadero.com/products/delphi/starter).

There's no guarantee of compatibility with earlier versions, even though I try to keep my code clean and avoid using too many of the new ways of writing in it (type inference, inline var and multiline strings).

If you detect any anomalies on earlier versions, please don't hesitate to [report them](https://github.com/DeveloppeurPascal/one-shot-tools/issues) so that I can test and try to correct or provide a workaround.

## License to use this code repository and its contents

This source code is distributed under the [AGPL 3.0 or later](https://choosealicense.com/licenses/agpl-3.0/) license.

You are free to use the contents of this code repository anywhere provided :
* you mention it in your projects
* distribute the modifications made to the files provided in this AGPL-licensed project (leaving the original copyright notices (author, link to this repository, license) must be supplemented by your own)
* to distribute the source code of your creations under the AGPL license.

If this license doesn't suit your needs (especially for a commercial project) I also offer [classic licenses for developers and companies](https://oneshottools.developpeur-pascal.fr).

Some elements included in this repository may depend on third-party usage rights (images, sounds, etc.). They are not reusable in your projects unless otherwise stated.

The source codes of this code repository as well as any compiled version are provided “as is” without warranty of any kind.

## How to ask a new feature, report a bug or a security issue ?

If you want an answer from the project owner the best way to ask for a new feature or report a bug is to go to [the GitHub repository](https://github.com/DeveloppeurPascal/one-shot-tools) and [open a new issue](https://github.com/DeveloppeurPascal/one-shot-tools/issues).

If you found a security issue please don't report it publicly before a patch is available. Explain the case by [sending a private message to the author](https://developpeur-pascal.fr/nous-contacter.php).

You also can fork the repository and contribute by submitting pull requests if you want to help. Please read the [CONTRIBUTING.md](CONTRIBUTING.md) file.

## Support the project and its author

If you think this project is useful and want to support it, please make a donation to [its author](https://github.com/DeveloppeurPascal). It will help to maintain the code and binaries.

You can use one of those services :

* [GitHub Sponsors](https://github.com/sponsors/DeveloppeurPascal)
* Ko-fi [in French](https://ko-fi.com/patrick_premartin_fr) or [in English](https://ko-fi.com/patrick_premartin_en)
* [Patreon](https://www.patreon.com/patrickpremartin)
* [Liberapay](https://liberapay.com/PatrickPremartin)
* [Paypal](https://www.paypal.com/paypalme/patrickpremartin)

You can buy [my softwares](https://lic.olfsoftware.fr/products.php?lng=en), [my video games](https://lic.gamolf.fr/products.php?lng=en) or [a developer license for my libraries](https://lic.developpeur-pascal.fr/products.php?lng=en) if you use them in your projects.

If you speak French [subscribe to Zone Abo](https://zone-abo.fr/nos-abonnements.php) to access my complete online archive (articles, videos, training videos, ebooks).

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

This one shot program is now a real project available [from this repository](https://github.com/DeveloppeurPascal/SVGFolder2DelphiUnit).

### TDirectory_CreateDirectory_Check

Test methods TDirectory.CreateDirectory(), TDirectory.Delete() and the TPath.GetXXXPath() for Delphi programs on all available platforms.

### tirages_au_sort

To attribute gains in a lotery depending on the number of participants and gifts.

### webhosting-send-ftp-config-email

Send the "FTP config mail" for a web hosting service from a list of user/passwords.

### webhosting-send-mysql-config-email

Send the "database config mail" for a web hosting service from a list of user/passwords.
