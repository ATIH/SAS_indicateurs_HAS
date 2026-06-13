/*==============================================================================*/
/* Indicateur HAS - ETE-ORTHO : formats CIM-10 evenements & comorbidites        */
/* Extrait des definitions PROC FORMAT de ETE_ORTHO/ete_ortho.sas (section II.1) */
/*                                                                              */
/* Les plages de codes CIM-10 sont reprises a l'identique du programme source : */
/* evenements thrombo-emboliques (TVP / EP) et facteurs d'ajustement            */
/* (cancer, insuffisance cardiaque, insuffisance renale, obesite).              */
/*==============================================================================*/

proc format ;
	/******* Evenements ETE *******/
	value $tvp
	/* Codes - HAS */
	"I801"-"I801z",
	"I802"-"I802z",
	"I803"-"I803z" = "1"
	/* Codes ajoutes pour l'exclusion uniquement */
	"I808"-"I808z",
	"I809"-"I809z",
	"I828"-"I828z",
	"I829"-"I829z" = "2"
	other = ' ' ;

	value $ep
	"I26"-"I269z"= "1"
	other = ' ';

	/****** Facteurs d'ajustements *******/
	/*DAS CANCER*/
	value $k
	'C00' -'C26z' ,
	'C30' -'C34z' ,
	'C37' -'C41z' ,
	'C43' -'C43z' ,
	'C45' -'C58z' = "1"
	other = ' ' ;

	/*DAS Insuffisance cardiaque : Congestive Heart Failure*/
	value $chf
	'I099'-'I099z',
	'I110'-'I110z',
	'I50' -'I50z' = "1"
	other= ' ' ;

	/*DAS Insuffisance renale*/
	value $ir
	'N18' -'N18z' ,
	'N19' -'N19z' = "1"
	other = ' '  ;

	/* DAS Obesite : Obesity */
	value $obe
	'E66'-'E66z' = "1"
	other = ' ' ;
run;

/* Table de diagnostics d'exemple (codes CIM-10). Le programme source lit ces
   codes depuis mco&aa.bd.diag ; on en reproduit la structure (un code par ligne). */
data diag;
	length diag $7;
	input diag $;
	datalines;
I8010
I8021
I8081
I269
C509
C189
I500
N189
E660
J459
Z867
;
run;

/* Classement des diagnostics, comme dans la section V (recherche des DAS) */
data comorb;
	set diag;
	ete_tvp = put(diag, $tvp.);
	ete_ep  = put(diag, $ep.);
	co_k    = put(diag, $k.)   = "1";
	co_chf  = put(diag, $chf.) = "1";
	co_ir   = put(diag, $ir.)  = "1";
	co_obe  = put(diag, $obe.) = "1";
run;

proc print data = comorb;
	var diag ete_tvp ete_ep co_k co_chf co_ir co_obe;
run;

proc freq data = comorb;
	tables ete_tvp co_k co_chf co_ir co_obe / missing;
run;
