# Ménage dans une mailing list

PHP scripts to extract emails from a list of email or a log.

Use "epuration_email.php" to extract an email list from a mailing error log and "nettoie_liste_email.php" to filter a subscribers list by reoving wrong emails.

(c) Patrick Prémartin / Olf Software 2005

## epuration_email.php

Get a text file and extract all emails from it as an other text file with one email per line.

Used to extract error emails from a mailing list sent log file or a Linux sendmail error log file.

## nettoie_liste_email.php

Remove wrong or blacklisted emails from an email list to obtain a new subscribers emails list.
(I say "emails", but it compares lines in text files so it can be used for other things)

