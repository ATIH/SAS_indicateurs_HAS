/*==============================================================================*/
/* Indicateur HAS - ETE-ORTHO : formats CCAM de pose / repose / ablation / echo */
/* Extrait des definitions PROC FORMAT de ETE_ORTHO/ete_ortho.sas (section II.1) */
/*                                                                              */
/* Les plages de codes CCAM sont reprises a l'identique du programme source.    */
/* Une petite table d'actes d'exemple permet de verifier le classement realise  */
/* par les formats (hanche / genou, pose / repose / ablation / echo-doppler).   */
/*==============================================================================*/

proc format ;
	/******* Actes realises : HANCHE ou GENOU *******/
	/* 1. Actes de poses de prothese */
	value $acteh
	/* hanche */
	"NEKA010", /*"NEKA011",*/
	"NEKA012", "NEKA013",
	"NEKA014", "NEKA015",
	"NEKA016", "NEKA017",
	"NEKA019", "NEKA020",
	"NEKA021" = "1"
	other = ' ' ;

	/* genou  */
	value $acteg
	"NFKA007", "NFKA008",
	"NFKA009" = "1"
	other = ' ';

	/* 2. Actes Repose/changement*/
	value $reposeh
	/* hanche */
	"NELA001", "NELA002", "NELA003",
	"NEKA001", "NEKA003",
	"NEKA006", "NEKA008",
	"NEKA022", "NEGA004" = "1"
	other = ' ' ;

	/* genou */
	value $reposeg
	"NFLA001","NFLA002",
	"NFKA001","NFKA002",
	"NFKA005","NFKA004","NFKA003" ="1"
	other = ' ';

	/* 3. Actes d'ablation */
	/* hanche*/
	value $ablah
	"NEGA001", "NEGA002", "NEGA003", "NEGA005", "NAGA001",
	"NELA003", "NEGA004"="1"
	other=" ";

	/*genou*/
	value $ablag
	"NFGA002", "NFGA001"="1"
	other=" ";

	/* Actes Echo-Doppler */
	value $echo
	"EJQM001", "EJQM003",
	"EJQM004" = "1"
	other = ' ' ;
run;

/* Table d'actes d'exemple (1 ligne par acte realise). Le programme source lit
   cette table depuis mco&aa.bd.acte ; on en reproduit ici la structure
   (acte CCAM + indicateur d'activite). */
data acte;
	length acte $7 acte_activ $1;
	input acte $ acte_activ $;
	datalines;
NEKA010 1
NEKA013 1
NFKA007 1
NFKA009 1
NELA001 1
NFKA001 1
NEGA001 1
NFGA002 1
EJQM001 1
EJQM004 1
ZZZZ999 1
NEKA021 1
NFKA008 1
NEKA022 1
NEGA005 1
;
run;

/* Application des formats, comme dans la section III du programme source */
data classe;
	set acte;
	if acte_activ = "1";
	pose_h   = put(substr(acte,1,7), $acteh.)   = "1";
	pose_g   = put(substr(acte,1,7), $acteg.)   = "1";
	repose_h = put(substr(acte,1,7), $reposeh.) = "1";
	repose_g = put(substr(acte,1,7), $reposeg.) = "1";
	abla_h   = put(substr(acte,1,7), $ablah.)   = "1";
	abla_g   = put(substr(acte,1,7), $ablag.)   = "1";
	echo     = put(substr(acte,1,7), $echo.)    = "1";
run;

proc freq data = classe;
	tables pose_h pose_g repose_h repose_g abla_h abla_g echo / missing;
run;

proc print data = classe;
	var acte pose_h pose_g repose_h repose_g abla_h abla_g echo;
run;
