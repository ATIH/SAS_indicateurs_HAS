/*==============================================================================*/
/* Indicateur HAS - ISO-ORTHO : format $Changement_repose (mapping multi-valeur)*/
/* Extrait de ISO_ORTHO/iso_ortho.sas, section 2_ Formats                       */
/*                                                                              */
/* Le format $Changement_repose classe chaque acte CCAM de reprise / repose /   */
/* changement / ablation en sept categories. Le format numerique ISO_ est       */
/* egalement repris pour libeller l'indicateur d'infection du site operatoire.  */
/*==============================================================================*/

proc format;
	value $Changement_repose
		"NEKA001", "NEKA003", "NEKA006", "NEKA008", "NEKA022" = "1"
		"NELA001", "NELA002" = "2"
		"NFKA001", "NFKA002","NFKA003", "NFKA004","NFKA005"  = "3"
		"NFLA001","NFLA002" = "4"
		"NEGA001","NEGA002","NEGA003","NEGA005","NAGA001"="5"
		"NFGA002","NFGA001"="6"
		"NELA003","NEGA004"="7"
		other = ' '
	;
	value ISO_
		1 = "ISO"
		0 = "Pas d'ISO"
	;
run;

/* Table d'actes d'exemple (1 ligne par acte). Le programme source lit cette
   table depuis Mco&an.bd.acte ; on en reproduit la structure utile. */
data actes;
	length acte $7 acte_activ $1;
	input acte $ acte_activ $;
	datalines;
NEKA001 1
NEKA022 1
NELA001 1
NELA002 1
NFKA003 1
NFLA002 1
NEGA001 1
NAGA001 1
NFGA002 1
NELA003 1
NEGA004 1
ZZZZ000 1
;
run;

data classe;
	set actes;
	if acte_activ = "1";
	type_chgt = put(substr(acte,1,7), $Changement_repose.);
run;

proc freq data = classe;
	tables type_chgt / missing;
run;

proc print data = classe;
	var acte type_chgt;
run;

/* Exemple du format numerique ISO_ : libelle de l'indicateur observe.
   Le format est attache a la variable dans l'etape DATA, comme le programme
   source le fait pour ses rendus. */
data flags;
	input iso_obs;
	format iso_obs ISO_.;
	datalines;
1
0
0
1
;
run;
proc freq data = flags;
	tables iso_obs / missing;
run;
