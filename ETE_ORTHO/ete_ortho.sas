	/*==============================================================================================================================================*/
	/*                 	 						   Indicateur HAS -  ETE-ORTHO 	      	    											   		    */
	/* 			 Mesure des évênements thrombo-emboliques après pose de prothèse totale de genou (PTG) ou de hanche (PTH hors fracture)             */
	/*==============================================================================================================================================*/

/*===========================================================================================================*/
/*           								 I. LIBRAIRIES ET PARAMETRES 							         */
/*===========================================================================================================*/

/* Année de référence */  
%let an_ref = 2021 ;  
%let loca=PTH;

%let anet = %eval(&an_ref+1) ;
%let aa = %substr(&an_ref,3,2) ;          
%let av = %eval(&aa -1) ;
%let v = v&an_ref;

libname mco&&aa.bd meta library="mco&&aa.bd";
libname mco&&av.bd meta library="mco&&av.bd";

	libname finess	"/ref/finess";
	libname drees "/ref/finess/finess_drees/hebdomadaire";
	libname reg   	"/ref/bases/formats_SAS/genbases";
	libname gen  	"/ref/nomenclatures/general";
	libname ref  	"/ref/bases/mco/20&aa/base_diffusee/trace/fmt";
	options fmtsearch=(work finess ref reg) missing=' ';


/*===========================================================================================================*/
/*           							 II. DIFFERENTS FORMATS     								         */
/*===========================================================================================================*/


/* 1. Format pour les codes actes / diags */
/*----------------------------------------*/
proc format ;
	/******* Evénements ETE *******/
	value $tvp 
	/* Codes - HAS */
	"I801"-"I801z",
	"I802"-"I802z", 
	"I803"-"I803z" = "1" 
	/* Codes ajoutés pour l'exclusion uniquement */
	"I808"-"I808z", 
	"I809"-"I809z",
	"I828"-"I828z", 
	"I829"-"I829z" = "2" 
	other = ' ' ;

	/*Comorbidité : antécédents ETE*/
	value $aete
	'Z867'-'Z867z', 
	'Z921'-'Z921z'	= "1"   
	other= ' ' ;

	value $ep
	"I26"-"I269z"= "1"
	other = ' ';

	/******* Actes réalisés : HANCHE ou GENOU *******/
	/* 1. Actes de poses de prothèse */
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

	/*******    Exclusions     *******/
	/* IVC : acte d'interuption de la veine cave */
	value $ivc 
	"DHSF001", "DHSF002",
	"DHSA001", "DHSA002",
	"DHNF006" = "1" 
	other= ' ' ;

	/* Acte d'antécédent prothèse */
	value $atcd 
	"NEKA001"-"NEKA022z",
	"NFKA001"-"NFKA009z", 
	"NELA001"-"NELA003z",
	"NEGA001"-"NEGA005z", 
	"NFGA001","NFGA002" , 
	"NEMA018","NFLA001" ,
	"NFLA002","NAGA001" = "1" 
	other= ' ' ;

	/****** Facteurs d'ajustements *******/
	/*DAS CANCER*/
	value $k
	'C00' -'C26z' ,
	'C30' -'C34z' ,
	'C37' -'C41z' ,
	'C43' -'C43z' ,
	'C45' -'C58z' ,
	'C60' -'C85z' ,
	'C88' -'C88z' ,
	'C900'-'C900z',
	'C902'-'C902z',
	'C96' -'C96z' ,
	'C97' -'C97z' = "1" 
	other = ' ' ;

	/*DAS Insuffisance cardiaque : Congestive Heart Failure*/
	value $chf 
	'I099'-'I099z', 
	'I110'-'I110z',
	'I130'-'I130z',
	'I132'-'I132z',
	'I255'-'I255z', 
	'I420'-'I420z',
	'I425'-'I429z',
	'I43' -'I43z' ,
	'I50' -'I50z' = "1"   
	other= ' ' ;

	/*DAS Bronchopneumopathie chronique*/
	value $cpd 
	'I278'-'I278z',
	'I279'-'I279z', 
	'J40' -'J47z' ,
	'J60' -'J67z' , 
	'J684'-'J684z',
	'J701'-'J701z', 
	'J703'-'J703z'  = "1" 
	other = ' ' ;

	/*DAS Insuffisance rénale*/
	value $ir 
	'I120'-'I120z',
	'I131'-'I131z',
	'N18' -'N18z' ,
	'N19' -'N19z' , 
	'N250'-'N250z',
	'Z490'-'Z492z',
	'Z940'-'Z940z',
	'Z992'-'Z992z' = "1" 
	other = ' '  ;

	/* DAS Paralysie : Paralysis*/
	value $hemi
	'G041'-'G041z',
	'G114'-'G114z',
	'G801'-'G801z',
	'G802'-'G802z',
	'G81' -'G81z' ,
	'G82' -'G82z' ,
	'G830'-'G834z',
	'G839'-'G839z' = "1" 
	other = ' ' ;

	/* DAS Coagulation : Coagulopathy */
	value $coag 
	'D65' -'D68z',
	'D691'-'D691z', 
	'D693'-'D696z' = "1" 
	other = ' ' ;

	/* DAS Maladie cérébro-vasculaire */
	value $mcv 
	'G45' -'G45z' ,
	'G46' -'G46z' ,
	'H340'-'H340z', 
	'I60' -'I69z' = "1"  
	other = ' ' ;

	/* DAS Obésité : Obesity */
	value $obe 
	'E66'-'E66z' = "1"  
	other = ' ' ;

	/*DAS Insuffisance respiratoire chronique*/
	value $irc 
	'J961'-'J961z'   = "1" 
	other = ' ' ;

	/* DP Fracture de Hanche */
	value $dpl1fract 
	'M80' -'M80z',
	'M841' -'M844z', 
	'M907'-'M907z',
	'S32' -'S32z',
	'S72' -'S72z', 
	'S79' -'S79z',
	'M966'-'M966z'
	 = "1" 
	other = ' ';

/* Complications vasculaires consécutives à un acte à visée diagnostique et thérapeutique, 
	non classées ailleurs */
	value $cvc  
	'T817'-'T817z'="1" 
	'T848'-'T848z'	= "2"  
	other = ' ';
run;


/* 2a. Format pour libellés des finessgeo (exemple 690007539)*/
/*----------------------------------------------------------*/

/* CREER une table FIGEOBIS, pour pouvoir ne garder qu'une ligne par finessgeo|annee|finess_pmsi
(parce que par exemple le finessgeo 090001629 a 2 finess_pmsi en 2017 -> on prend le 1er)*/

PROC SQL;
CREATE TABLE FiGeoBis AS
SELECT * 
FROM gen.finessgeo 
WHERE annee="&an_ref" and 
((categ_pmsi in ("CH","CHR/U") and niveau_pmsi="J") 
   or ((categ_pmsi in ("Privé","PSPH/EBNL","CLCC") or rs like "H%PITAL D'INSTRUCTION%") and niveau_pmsi="G")
	or finessgeo in ("750150237","750150260","840019079"))
	 or finessgeo = "560029068" 
	 UNION
SELECT * From nom_gen.finessgeo 
WHERE annee="2019" and finessgeo="310009279" ;
QUIT;
PROC SORT Data=FiGeoBis; by finessgeo; run;
DATA FiGeoBis (rename=(categ_pmsi=categ_figeo)); SET FiGeoBis; by finessgeo; if first.finessgeo; run;
PROC SQL;
CREATE TABLE FiGeoTer AS
SELECT * FROM FiGeoBis
UNION
SELECT * From gen.finessgeo 
WHERE annee="&an_ref" and finessgeo="910000306" and finess_pmsi="910110063";

CREATE TABLE FiGeoBis AS
SELECT FiGeoTer.*, case when finess.categ_detail in ("HIA") then finess.categ_detail else categ_figeo end as categ_pmsi FROM FiGeoTer
LEFT JOIN (select * from gen.finess where annee="&an_ref.") ON finess.finess=FiGeoTer.finess_pmsi;
QUIT;

Data tt (keep = fmtname start label hlo );
	length fmtname $20 start $9 label $77 hlo $1;
	set FiGeoBis (drop=finess_pmsi);

	if mco ="O" then ;
	fmtname = "$libgeo&aa._";
	start = finessgeo;
	label = rs;
	if label ^="";
	output;

	if ^fait then
		do;
			retain fait;
			fait=1;
			start="";
			label="";
			hlo="o";
			output;
		end;
run;
proc sort data= tt nodupkeys;	by  start  hlo;run;
proc format cntlin = tt;run;
data tt (keep = fmtname start label hlo );
	length fmtname $20 start $9 label $77 hlo $1;
	set FiGeoBis ;

	if mco ="O" then ;
	
	fmtname = "$ipe";
	start = finess_pmsi;
	label = ides;
	if label ^="";
	output;

	if ^fait then
		do;
			retain fait;
			fait=1;
			start="";
			label="";
			hlo="o";
			output;
		end;
run;
proc sort data= tt nodupkeys;	by  start  hlo;run;
proc format cntlin = tt;run;

/* 2b. Format pour récupérer finessgeo du RUM qui a fourni le DP du séjour (objectif : détail APs en finessgeo) */
/*-------------------------------------------------------------------------------------------------------------*/
data t (keep = fmtname start label hlo);
	length fmtname $20 start $9 label $30 hlo $1;
	set mco&aa.bd.finessgeo_umdudp (keep = ident finessGeoDP);
	fmtname = "$finessgeodp";
	start = ident;
	label = finessGeoDP;
    if label ^="";
	output;

	if ^fait then
		do;
			retain fait;
			fait=1;
			start="";
			label="";
			hlo="o";
			output;
		end;
run;
proc sort data= t nodupkeys;	by  start  hlo;run;
proc format cntlin = t;run;

/* RS */
data f (keep = fmtname start label hlo);
length fmtname $20 start $9 label $30 hlo $1;
set drees.referentiel_finess;
start=finess;
label=rs;
fmtname="$rsfipmsi";

if ^fait then
		do;
			retain fait;
			fait=1;
			start="";
			label="";
			hlo="o";
			fmtname = "$rsfipmsi";
		end;
run;
proc sort data= f nodupkeys;	by fmtname start label hlo;run;
proc format cntlin = f ;run;


/*===========================================================================================================*/
/*           						 III. IDENTIFICATION DES SEJOURS CONCERNES 				                 */
/*===========================================================================================================*/


/* 1. Identification des poses et multi-poses (séjours avec un deuxième acte)*/
/*---------------------------------------------------------------------------*/

data tt;
	set mco&aa.bd.acte;

	if acte_activ ="1" and (put(substr(acte,1,7), $acteh.) = "1" or put(substr(acte,1,7), $acteg.) = "1" );
		a_h =  put(substr(acte,1,7), $acteh.) = "1";
		a_g =  put(substr(acte,1,7), $acteg.) = "1";
run;

proc means data = tt noprint;
	class ident;
	var a_h  a_g;
	output out = t sum =;
run;

proc sql;
	create table ttt as 
		select a.* , b._freq_ as nb , b.a_h as nb_pth , b.a_g as nb_ptg  
			from tt as a left join t as b 
				on a.ident = b.ident;
run;

proc freq data = ttt  ;
	table acte_delai / missing;
		where missing(acte_delai);
run; 
data aa (keep = fmtname start label hlo );
	length fmtname $20 start $6 label $5 hlo $1;
	set ttt;

	/* Multi-pose_tot */
	if nb >1 or acte_nbfois >1 then
		do;
			fmtname = "$multi_tot&aa._";
			start = ident;
			label = "1";

			if label ^="";
			output;
		end;

	/* Multi-pose pth */
	if (nb_pth >1 or acte_nbfois >1) and nb_ptg =0 then
		do;
			fmtname = "$multi_pth&aa._";
			start = ident;
			label = "1";

			if label ^="";
			output;
		end;

	/* Multi-pose ptg */
	if (nb_ptg >1 or acte_nbfois >1 ) and nb_pth =0 then
		do;
			fmtname = "$multi_ptg&aa._";
			start = ident;
			label = "1";

			if label ^="";
			output;
		end;

	/* Delai de réalisation d'un acte unique */
	if nb=1 and acte_nbfois = 1 then
		do;
			fmtname = "$delai&aa._";
			start = ident;
			label = put(acte_delai, $5.);

			if label ^="";
			output;
		end;

	/* Acte réalisé  */
	if nb=1 and acte_nbfois = 1  then
		do;
			fmtname = "$ActeUniq";
			start = ident;
			label = acte;

			if label ^="";
			output;
		end;


	if ^fait then
		do;
			retain fait;
			fait=1;
			start="";
			label="";
			hlo="o";
			fmtname="$multi_pth&aa._";
			output;
			fmtname="$multi_ptg&aa._";
			output;
			fmtname="$multi_tot&aa._";
			output;
			fmtname ="$delai&aa._";
			output;
			fmtname ="$ActeUniq";
			output;
		end;
run;
proc sort data= aa nodupkeys;	by fmtname start label hlo;run;
proc format cntlin = aa; run;


/* 2. Identification des reposes ou changements, IVC et Echo-doppler , ablation */
/*-------------------------------------------------------------------*/

data tt (keep = fmtname start label hlo );
	length fmtname $10 start $7 label $1 hlo $1;
	set mco&aa.bd.acte;
	if acte_activ ="1" ;  

	/* 1. Remplacements G&H  */
	if put(substr(acte,1,7), $acteh.) = "1" then
		do;
			fmtname = "$pth&aa._";
			start = ident;
			label = "1";

			if label ^="";
			output;
		end;

	if put(substr(acte,1,7), $acteg.) = "1" then
		do;
			fmtname = "$ptg&aa._";
			start = ident;
			label = "1";

			if label ^="";
			output;
		end;

	/* 2. Repose ou changement G&H */
	if put(substr(acte,1,7), $reposeh.) = "1" then
		do;
			fmtname = "$rchh&aa._";
			start = ident;
			label = "1";

			if label ^="";
			output;
		end;

	if put(substr(acte,1,7), $reposeg.) = "1" then
		do;
			fmtname = "$rchg&aa._";
			start = ident;
			label = "1";

			if label ^="";
			output;
		end;

	/* 2. Ablation G&H */
	if put(substr(acte,1,7), $ablah.) = "1" then
		do;
			fmtname = "$ablah&aa._";
			start = ident;
			label = "1";

			if label ^="";
			output;
		end;

	if put(substr(acte,1,7), $ablag.) = "1" then
		do;
			fmtname = "$ablag&aa._";
			start = ident;
			label = "1";

			if label ^="";
			output;
		end;


	/* Interruption de la veine cave */
	if put(substr(acte,1,7), $ivc. ) = "1" then
		do;
			fmtname = "$ivc&aa._";
			start = ident;
			label = "1";

			if label ^="";
			output;
		end;

	/* Acte d'écho-Doppler */
	if put(substr(acte,1,7), $echo. ) = "1" then
		do;
			fmtname = "$echo&aa._";
			start = ident;
			label = "1";

			if label ^="";
			output;
		end;

	if ^fait then
		do;
			retain fait;
			fait=1;
			start="";
			label="";
			hlo="o";
			fmtname="$pth&aa._";
			output;
			fmtname="$rchh&aa._";
			output;
			fmtname="$ptg&aa._";
			output;
			fmtname="$rchg&aa._";
			output;
			fmtname="$ivc&aa._";
			output;
			fmtname="$echo&aa._";
			output;
			fmtname="$ablag&aa._";
			output;
			fmtname="$ablah&aa._";
			output;
		end;
run;
proc sort data= tt nodupkeys;	by fmtname start label hlo;run;
proc format cntlin = tt; run;
 

/*===========================================================================================================*/
/*      	    	 IV. SEJOURS AVEC DP DU 1 ER RUM CORRRESPOND A UN EVENEMENT THROMBOEMBOLIQUE             */
/*===========================================================================================================*/

data tt (keep = fmtname start label hlo );
	length fmtname $15 start $7 label $6 hlo $1;
	set mco&aa.bd.UM;

	if rum = "01" and 
	(put(DPduRUM, $tvp.)="1" /* codes HAS + OCDE */
	or put(DPduRUM, $tvp.)="2" /* codes ajoutés par OCDE */
	or put(DPduRUM, $ep. )="1" ) then
		do;
			fmtname = "$dp1rum&aa._";
			start = ident;
			label = "1";
			output;
		end;

	if rum = "01" and type_RUM_1 in ("07A","07B","01A","01B","02A","02B","03A","03B","18")
		then	do;
			fmtname = "$UHCD_1rum&aa._";
			start = ident;
			label = "1";
			output;
		end;

	if rum = "01"  
		then	do;
			fmtname = "$dprum1_";
			start = ident;
			label = DPduRUM;
			output;
		end;

	if ^fait then
		do;
			retain fait;
			fait=1;
			start="";
			label="";
			hlo="o";
			fmtname = "$dp1rum&aa._";
			output;
			fmtname = "$UHCD_1rum&aa._";
			output;
			fmtname = "$dprum1_";
			output;
		end;
run;

proc sort data= tt nodupkeys;	by fmtname start label hlo;run;
proc format cntlin = tt;run;

/*===========================================================================================================*/
/* 									V. SEJOURS AVEC DAS EP OU TVP (CODES HAS)                                */
/*===========================================================================================================*/

%macro format(an);
data tt  (keep = fmtname start label hlo );
	length fmtname $15 start $6  label hlo  $1;
	merge mco&an.bd.diag (in=a ) mco&an.bd.fixe (in = b keep = ident dp dr );
	by ident;

	if substr(diag, 1,1) = "O" then
		do;
			fmtname = "$o&an._";
			start = ident;
			label = "1";
			output;
		end;

	if substr(diag,1,4) ="Z515" then
		do;
			fmtname = "$sp&an._";
			start = ident;
			label = "1";
			output;
		end;


	if (typ_diag > '2' and diag ^= dp and diag ^= dr ) then 
		do ;  
			/* Fuite */
			if substr(diag,1,4) ="Z532" then
				do;
					fmtname = "$fuit&an._";
					start = ident;
					label = "1";
					output;
				end;
				
			/* Complications vasculaires consécutives  */
			if put(diag, $cvc. ) ="1" then
				do;
					fmtname = "$cvc&an._";
					start = ident;
					label = "1";
					output;
				end;
			if put(diag, $cvc. ) ="2" then
				do;
					fmtname = "$cvcb&an._";
					start = ident;
					label = "1";
					output;
				end;
			if put(diag, $ep.)  ="1" then
				do;
					fmtname = "$co_ep&an._";
					start = ident;
					label = "1";
					output;
				end;

			if put(diag, $tvp.) ="1" then
				do;
					fmtname = "$co_tvp&an._";
					start = ident;
					label = "1";
					output;
				end;
			if put(diag, $tvp.) ="2" then
				do;
					fmtname = "$co_tvp2&an._";
					start = ident;
					label = "1";
					output;
				end;

			if put(diag, $k.) ="1" then
				do;
					fmtname = "$co_k&an._";
					start = ident;
					label = "1";
					output;
				end;

			if put(diag, $chf.) ="1" then
				do;
					fmtname = "$co_chf&an._";
					start = ident;
					label = "1";
					output;
				end;

			if put(diag, $cpd.) ="1" then
				do;
					fmtname = "$co_cpd&an._";
					start = ident;
					label = "1";
					output;
				end;

			if put(diag, $ir.) ="1" then
				do;
					fmtname = "$co_ir&an._";
					start = ident;
					label = "1";
					output;
				end;

			if put(diag, $coag.) ="1" then
				do;
					fmtname = "$co_coag&an._";
					start = ident;
					label = "1";
					output;
				end;

			if put(diag, $hemi.) ="1" then
				do;
					fmtname = "$co_hemi&an._";
					start = ident;
					label = "1";
					output;
				end;

			if put(diag, $mcv.) ="1" then
				do;
					fmtname = "$co_mcv&an._";
					start = ident;
					label = "1";
					output;
				end;

			if put(diag, $obe.) ="1" then
				do;
					fmtname = "$co_obe&an._";
					start = ident;
					label = "1";
					output;
				end;

			if put(diag, $irc.) ="1" then
				do;
					fmtname = "$co_irc&an._";
					start = ident;
					label = "1";
					output;
				end;

		if put(diag,$aete.)="1" then
			do;
				fmtname="$co_aete&an._";
				start=ident;
				label="1";
				output;
			end;

		end;

	if ^fait then
		do;
			retain fait;
			fait=1;
			start="";
			label="";
			hlo="o";
			fmtname = "$fuit&an._";
			output;
			fmtname = "$o&an._";
			output;
			fmtname = "$sp&an._";
			output;
			fmtname = "$cvc&an._";
			output;
			fmtname = "$co_ep&an._";
			output;
			fmtname = "$co_tvp&an._";
			output;
			fmtname = "$co_tvp2&an._";
			output;
			fmtname = "$co_k&an._";
			output;
			fmtname = "$co_chf&an._";
			output;
			fmtname = "$co_cpd&an._";
			output;
			fmtname = "$co_ir&an._";
			output;
			fmtname = "$co_coag&an._";
			output;
			fmtname = "$co_hemi&an._";
			output;
			fmtname = "$co_mcv&an._";
			output;
			fmtname = "$co_obe&an._";
			output;
			fmtname = "$co_irc&an._";
			output;
			fmtname = "$co_aete&an._";
			output;
			fmtname = "$cvcb&an._";
			output;
			fmtname = "$aete&an._"; output;

		end;
run;

proc sort data= tt nodupkeys;
	by fmtname start label hlo;
run;

proc format cntlin = tt;
run;
%mend;

%format (&aa.);
%format (&av.);



/*===========================================================================================================*/
/* 					    VI. LECTURE DE BASE / IDENT. DES RSA REPONDANT A LA REQUETE PSI	  				     */
/*===========================================================================================================*/

%macro psi11(loca);
data psi11_&aa._&loca.;
	merge mco&aa.bd.fixe (in =a keep = finess seqmco anonyme ano_retour ano_date ident 
			nbRum nbda nbActe age sexe modeentree provenance mois annee modesortie destination typ_sej
			duree codegeo dp dr rumdudp supp_rea supp_si ghm2 raac) 
		mco&aa.bd.rgp (in=b keep = ident ghm&v );
	by ident;
	length cmd $ 2 racine $5;
	ghm 	= ghm&v;
	cmd 	= ghm;
	racine	= ghm;
	nb=1;

	/* Définitions des variables  */
	&loca.    		= put(ident, $&loca.&aa._.) ="1";
	rchh   		= put(ident, $rchh&aa._.) ="1" or put(ident, $ablah&aa._.) ="1";
	rchg   		= put(ident, $rchg&aa._.) ="1" or put(ident, $ablag&aa._.) ="1";


	crit_ivc    = put(ident, $ivc&aa._.)  ="1";
	echo   		= put(ident, $echo&aa._.) ="1";
	crit_dp1rum_ete = put(ident, $dp1rum&aa._.)= "1";
	EP     		= put(ident, $co_ep&aa._.)     = "1";
	TVP    		= put(ident, $co_tvp&aa._.)    = "1";
	ep_tvp = 0;
	DP_1RUM=put(ident,$dprum1_.);

	/* Gestion des doublons : priorité au EP, consigne HAS */
	if EP and TVP then
		do;
			EP = 1;
			TVP = 0;
			ep_tvp = 1 ;  /* doublons */
		end;

	/* Evénements thrombo-emboliques */
	ete = 0;
	if ep or tvp then ete = 1;

	/* Délais */
	delai_acte  = input(put(ident, $delai&aa._. ), 5.);

	if delai_acte < duree then
		duree_obs = duree - delai_acte;

	if delai_acte = 1 and duree = 1 then
		duree_obs = 0;

	if (delai_acte ^= duree and duree ^= 1 ) or missing(delai_acte) then
		duree_obs = duree-1;

	/* Critères d'ajustement */
	co_k 		= put(ident , $co_k&aa._. ) = "1" ;    
	co_chf 		= put(ident , $co_chf&aa._. ) = "1" ;
	co_cpd 		= put(ident , $co_cpd&aa._. ) = "1" ;
	co_ir  		= put(ident , $co_ir&aa._.  ) = "1";
	co_coag 	= put(ident , $co_coag&aa._.) = "1" ;
	co_hemi 	= put(ident , $co_hemi&aa._.) = "1" ;
	co_mcv 		= put(ident , $co_mcv&aa._. ) = "1" ;
	co_obe 		= put(ident , $co_obe&aa._. ) = "1" ;
	co_irc 		= put(ident , $co_irc&aa._. ) = "1" ;
	co_antete = put(ident,$aete&aa._.)="1" or put (dr , $aete.) = "1"  ;

	%if &loca=PTH %then %do ;
		crit_fract 	= put(dp , $dpl1fract. ) = "1";
	%end;

	
	/* Informations sur les établissements */
	finessgeo = put(ident, $finessgeodp.);
	
	/* Inclusions/Exclusions  */
 
	exc_age18	= age < 18   ;    
	exc_erreurs  = (cmd in ("14","15","28","90") or translate(ano_retour,"","0")^= ""); /* Séjours mal chainés */
	crit_ambu  = duree = 0;

	crit_obst    	 = put(ident , $o&aa._.) = "1" ;  
            
	crit_multi_autre = rchh or rchg ;            
	crit_modeentree  = modeentree in ("6", "7", "0") ;   

	Crit_urgence=provenance in ("5","U") %if &aa. >=23 %then %do; or passage_urg in ("U","V","5") ; %end; ;
	Crit_uhcd= put(ident,$UHCD_1rum&aa._.)="1";
	Crit_fuite=put(ident,$fuit&aa._.)="1";
	crit_cvc = put(ident , $cvc&aa._. ) = "1" ;    
	crit_cvc_bis = put(ident , $cvcb&aa._. ) = "1" ; 
	crit_sp = put(ident, $sp&aa._.) = "1" ;   
	crit_dc = (modesortie ="9") ;   

	/* Séjours avec au moins un deuxième acte de PTG ou PTH */
	crit_multi_pose  =  put(ident , $multi_tot&aa._.) = "1";

run;



/*===========================================================================================================*/
/* 		 Crit Ajustement. Recherche dans les DAS et DP des séjours de l'année précédent	le séjour de pose 	*/
/*===========================================================================================================*/

	%macro anct(antcd);
		PROC SQL;
		CREATE TABLE Antc_&antcd AS
		SELECT DISTINCT f.ident, anonyme,ano_date,duree
		FROM mco&av.bd.fixe f
		LEFT JOIN mco&av.bd.rgp r on f.ident=r.ident
		WHERE (put(f.ident,$co_&antcd.&av._.)="1" %if "&antcd"="aete" %then %do; or put(dr,$aete.)="1") %end; 
												  %else %do; or put(dp,$&antcd..)="1") %end;
			and substr(ghmv20&aa.,1,2)^="90" and translate(ano_retour,"","0")=""
			and anonyme in (select anonyme from psi11_&aa._&loca. where translate(ano_retour,"","0")="" and &loca.)
			union
		SELECT DISTINCT f.ident, anonyme,ano_date,duree
		FROM mco&aa.bd.fixe f
		LEFT JOIN mco&aa.bd.rgp r on f.ident=r.ident
		WHERE (put(f.ident,$co_&antcd.&aa._.)="1"  %if "&antcd"="aete" %then %do; or put(dr,$aete.)="1") %end; 
												  %else %do; or put(dp,$&antcd..)="1") %end;
			and substr(ghmv20&aa.,1,2)^="90" and translate(ano_retour,"","0")=""
			and anonyme in (select anonyme from psi11_&aa._&loca. where translate(ano_retour,"","0")="" and &loca.);
		QUIT;
	%mend;
	
	%anct(k);
	%anct(chf);
	%anct(cpd);
	%anct(ir);
	%anct(coag);
	%anct(hemi);
	%anct(mcv);
	%anct(obe);
	%anct(irc);
	%anct(tvp);
	%anct(tvp2);
	%anct(ep);
	%anct(aete);


	%macro ant(antcd);
		PROC SQL;
		CREATE TABLE Antc_&antcd AS
		SELECT DISTINCT f.ident, anonyme,ano_date,duree
		FROM mco&av.bd.fixe f
		LEFT JOIN mco&av.bd.rgp r on f.ident=r.ident
		WHERE put(f.ident,$&antcd.&av._.)="1" 
			and substr(ghmv20&aa.,1,2)^="90" and translate(ano_retour,"","0")=""
			and anonyme in (select anonyme from psi11_&aa._&loca. where translate(ano_retour,"","0")="" and &loca.)
			union
		SELECT DISTINCT f.ident, anonyme,ano_date,duree
		FROM mco&aa.bd.fixe f
		LEFT JOIN mco&aa.bd.rgp r on f.ident=r.ident
		WHERE put(f.ident,$&antcd.&aa._.)="1"  
			and substr(ghmv20&aa.,1,2)^="90" and translate(ano_retour,"","0")=""
			and anonyme in (select anonyme from psi11_&aa._&loca. where translate(ano_retour,"","0")="" and &loca.);
		QUIT;
	%mend;

	%ant(sp);


	%macro delai(antcd);
		PROC SQL;
		CREATE TABLE psi12_&antcd._&loca. AS 
		SELECT a.*, b.ident as ident_anct, b.ano_date as ano_date_ant, b.duree as duree_ant, b.ano_date+b.duree as Date_sortie_ant,
			a.ano_date-calculated Date_sortie_ant as delai
		FROM (select ident, anonyme, ano_date from psi11_&aa._&loca. where translate(ano_retour,"","0")="" and &loca.) a
		LEFT JOIN Antc_&antcd. b ON a.anonyme=b.anonyme and (a.ident^=b.ident or a.ano_date^=b.ano_date)
		WHERE b.ano_date<a.ano_date AND b.ano_date+b.duree+365>=a.ano_date;
		QUIT;
		Data f (keep = fmtname start label hlo );
		Set psi12_&antcd._&loca.;
		length fmtname $15 start $6  label hlo  $1;
		fmtname = "$id_&antcd";
		start = ident;
		label = "1";
		if ^fait then
				do;
					retain fait;
					fait=1;
					start="";
					label="";
					hlo="o";
					fmtname = "$id_&antcd";
				end;
		run;
		proc sort data= f nodupkeys;	by fmtname start label hlo;run;
		proc format cntlin = f ;run;
	%mend;
	
	%delai(k);
	%delai(chf);
	%delai(cpd);
	%delai(ir);
	%delai(coag);
	%delai(hemi);
	%delai(mcv);
	%delai(obe);
	%delai(irc);
	%delai(sp);


	PROC SQL;
	CREATE TABLE psi12_aete_&loca. AS
	SELECT  a.*, b.ident as ident_anct, b.ano_date as ano_date_ant, b.duree as duree_ant, b.ano_date+b.duree as Date_sortie_ant,
		a.ano_date-calculated Date_sortie_ant as delai
	FROM (select ident, anonyme, ano_date from psi11_&aa._&loca. where translate(ano_retour,"","0")="" and &loca.) a
	LEFT JOIN Antc_tvp b ON a.anonyme=b.anonyme and (a.ident^=b.ident or a.ano_date^=b.ano_date)
	WHERE b.ano_date<a.ano_date AND b.ano_date+b.duree+365>=a.ano_date
		union
	SELECT  a.*, b.ident as ident_anct, b.ano_date as ano_date_ant, b.duree as duree_ant, b.ano_date+b.duree as Date_sortie_ant,
		a.ano_date-calculated Date_sortie_ant as delai
	FROM (select ident, anonyme, ano_date from psi11_&aa._&loca. where translate(ano_retour,"","0")="" and &loca.) a
	LEFT JOIN Antc_tvp2 b ON a.anonyme=b.anonyme and (a.ident^=b.ident or a.ano_date^=b.ano_date)
	WHERE b.ano_date<a.ano_date AND b.ano_date+b.duree+365>=a.ano_date
		union
	SELECT  a.*, b.ident as ident_anct, b.ano_date as ano_date_ant, b.duree as duree_ant, b.ano_date+b.duree as Date_sortie_ant,
		a.ano_date-calculated Date_sortie_ant as delai
	FROM (select ident, anonyme, ano_date from psi11_&aa._&loca. where translate(ano_retour,"","0")="" and &loca.) a
	LEFT JOIN Antc_ep b ON a.anonyme=b.anonyme and (a.ident^=b.ident or a.ano_date^=b.ano_date)
	WHERE b.ano_date<a.ano_date AND b.ano_date+b.duree+365>=a.ano_date
		union
	SELECT  a.*, b.ident as ident_anct, b.ano_date as ano_date_ant, b.duree as duree_ant, b.ano_date+b.duree as Date_sortie_ant,
		a.ano_date-calculated Date_sortie_ant as delai
	FROM (select ident, anonyme, ano_date from psi11_&aa._&loca. where translate(ano_retour,"","0")="" and &loca.) a
	LEFT JOIN Antc_aete b ON a.anonyme=b.anonyme and (a.ident^=b.ident or a.ano_date^=b.ano_date)
	WHERE b.ano_date<a.ano_date AND b.ano_date+b.duree+365>=a.ano_date;
	QUIT;

	Data f (keep = fmtname start label hlo );
	Set psi12_aete_&loca.;
	length fmtname $15 start $6  label hlo  $1;
	fmtname = "$id_aete";
	start = ident;
	label = "1";
	if ^fait then
			do;
				retain fait;
				fait=1;
				start="";
				label="";
				hlo="o";
				fmtname = "$id_aete";
			end;
	run;
	proc sort data= f nodupkeys;	by fmtname start label hlo;run;
	proc format cntlin = f ;run;
	
/*==========================================================================================================
			Intégration de ces comorbidités dans la base psi11_&an
==========================================================================================================*/

	PROC SQL;
	CREATE TABLE psi12_&aa. AS
	SELECT a.*, put(ident,$id_k.)="1" or co_k  = 1 as com_k,
		put(ident,$id_chf.)="1" or co_chf 	= 1 as com_chf,
		put(ident,$id_cpd.)="1" or co_cpd 	= 1 as com_cpd,
		put(ident,$id_ir.)="1" or co_ir  	= 1 as com_ir,
		put(ident,$id_coag.)="1" or co_coag = 1 as com_coag,
		put(ident,$id_hemi.)="1" or co_hemi = 1 as com_hemi,
		put(ident,$id_mcv.)="1" or co_mcv 	= 1 as com_mcv,
		put(ident,$id_obe.)="1" or co_obe 	= 1 as com_obe,
		put(ident,$id_irc.)="1" or co_irc 	= 1 as com_irc,
		put(ident,$id_aete.)="1" or co_antete = 1 as com_aete,
		put(ident,$id_sp.)="1" or crit_sp = 1 as crit_sp
	FROM psi11_&aa._&loca. a;
	QUIT;

%mend;
%psi11(&loca.);


/*===========================================================================================================*/
/* 	 		VII. CRIT_ATCD : SEJOURS DE PATIENTS AVEC UN PRECEDENT SEJOUR DANS LES 30 JOURS                  */
/*                			COMPORTANT AU MOINS UN ACTE "ANTECEDENT PROTHESE"                                */
/*-----------------------------------------------------------------------------------------------------------*/
/* 			On prend la date d'entrée/sortie des séjours index et antécédents et non pas                     */
/*						la date de réalisation de l'acte, car :                                              */
/*		  1. un séjour peut avoir des multi-poses                                       			         */
/*     	  2. date de réalisation n'est pas obligatoire, donc pas forcement renseignée                        */
/*===========================================================================================================*/

%macro s (an);

	data s (keep = fmtname start label hlo );
		length fmtname $10 start $10 label $1 hlo $1;
		set mco&an.bd.acte;
		fmtname = "$atcd&an._";
		start = cats(ident, &an);

		if put(substr(acte,1,7), $atcd. )= "1" and acte_activ ="1" then
			do;
				label = "1";
				output;
			end;

		if ^fait then
			do;
				retain fait;
				fait=1;
				start="";
				label="";
				hlo="o";
				output;
			end;
	run;

	proc sort data= s nodupkeys;
		by  start label hlo;
	run;

	proc format cntlin = s;
	run;

%mend;
%s(&av);
%s(&aa);


/* L'année précédente  */
data a&av;
	set  mco&av.bd.fixe (in=a keep = ident ano_date ano_retour anonyme duree annee mois);
	by ident;
	atcd = put(cats(ident,&av), $atcd&av._. ) ="1";

	if atcd then
		date_sortie = ano_date + duree;

	if atcd = 1 and translate(ano_retour,"","0")= "" and mois = "12";
run;

/* L'année en cours */
data a&aa;
	set Psi12_&aa (keep = ident ano_date ano_retour anonyme duree annee mois &loca.);
	atcd = put(cats(ident,&aa), $atcd&aa._.) = "1";
	date_sortie = ano_date + duree;
	if atcd =1 and translate(ano_retour,"","0") ="";
run;

data tot&aa;
	set a&av a&aa;
run;

PROC SQL;
Create table cal_anct_&aa. as
select tot&aa..*, b.ano_date as deb_index, b.ident as id_index, 30>= b.ano_date-tot&aa..date_sortie>0 as delai_ok
from tot&aa.
left join (select * from psi12_&aa where &loca.) b on tot&aa..anonyme=b.anonyme ;
QUIT;



/* Format pour les séjours index  */
data s (keep = fmtname start label hlo );
	length fmtname $20start $6 label $1 hlo $1;
	set cal_anct_&aa. (where = (delai_ok = 1 ) );
	fmtname = "$crit_atcd&aa._";
	start = id_index;
	label = "1";
	output;

	if ^fait then
		do;
			retain fait;
			fait=1;
			start="";
			label="";
			hlo="o";
			output;
		end;
run;

proc sort data= s nodupkeys;
	by  start label hlo;
run;

proc format cntlin = s;
run;

/* Complément de la base avec les séjours avec antécédents, les séjours éligibles et les séjours cibles */
/* Base des séjours concernés */

data concerne_&loca._&aa;
	set psi12_&aa;
	crit_atcd  = put(ident , $crit_atcd&aa._. )= "1";
	exclusion  =  not(exc_erreurs or exc_age18 or crit_dp1rum_ete or crit_ivc or crit_obst or crit_ambu  
	or crit_fract or crit_multi_pose or crit_multi_autre or crit_modeentree or crit_atcd or crit_sp
	or Crit_urgence or	Crit_uhcd or crit_fuite); 
	concerne   = &loca. ; 
	eligible   = &loca. and (not exc_erreurs) and (not exc_age18);
	cible      = &loca. and exclusion;
	if concerne = 1 ; 
run;



/*===========================================================================================================*/
/* 	     				RENDUS HAS                              */
/*===========================================================================================================*/

/*************************************/
/* Rendu 1 : Chartflow national */
proc sql;
	create table chartflow1_&aa as 
	select sum(concerne) as nb_concerne, 
        count(distinct case when concerne then finessgeo else "" end) as es_concerne, 
		count (distinct case when cmd in ("14","15","90") or translate(ano_retour,"","0")^="" then ident else "" end) as exc_erreurs, 
		count (distinct case when exc_age18 then ident else "" end) as exc_age18, 
		sum (eligible) as nb_eligible, 
		count (distinct case when eligible then finessgeo else "" end) as es_eligible, 
		sum (cmd not in ("14","15","90") and translate(ano_retour,"","0")="" and exc_age18=0 and ete ) as nb_ete_2,

		count (distinct case when crit_dp1rum_ete then ident else "" end) as crit_dp1rum_ete, 
		count (distinct case when crit_ivc then ident else "" end) as crit_ivc, 
		count (distinct case when crit_obst then ident else "" end) as crit_obst,  
		count (distinct case when crit_ambu  then ident else "" end) as crit_ambu_tot, 
	
	%if &loca.=PTH %then %do;
		count (distinct case when crit_fract then ident else "" end)as crit_fract, 
	%end;
		count(distinct case when (crit_urgence or crit_uhcd) then ident else "" end) as crit_urg, /* Nv 2018 */
		count (distinct case when crit_multi_pose then ident else "" end) as crit_multi_pose, 
		count (distinct case when crit_multi_autre then ident else "" end) as crit_multi_autre, 
		count (distinct case when crit_modeentree then ident else "" end) as crit_modeentree, 
		count (distinct case when crit_atcd then ident else "" end) as crit_atcd, 
		count (distinct case when crit_sp then ident else "" end) as crit_sp, 
		count (distinct case when crit_fuite then ident else "" end) as crit_fuite, 
		count (distinct case when exclusion=0 and eligible=1 then ident else "" end) as nb_exclus, 
		calculated nb_exclus /calculated nb_eligible *100 as pct_exclus, 
		sum(cible) as nb_cible_tot, 
		sum(case when exclusion=1 and eligible=1 then ete else 0 end) as ete ,
		sum(case when exclusion=1 and eligible=1 then ete else 0 end)/sum(cible)*100 as pct_ete  ,

		count (distinct CASE WHEN finessgeo in (select finessgeo FROM (SELECT finessgeo, sum(CIBLE)as NbSejCib FROM concerne_&loca._&aa GROUP BY finessgeo) where NbSejCib>9)
				THEN finessgeo ELSE "" END) as NbESMin10,
		sum (CASE WHEN finessgeo in (select finessgeo FROM (SELECT finessgeo, sum(CIBLE)as NbSejCib FROM concerne_&loca._&aa GROUP BY finessgeo) where NbSejCib>9)
				THEN cible ELSE 0 END) as NbSej_ESMin10,
		sum (CASE WHEN finessgeo in (select finessgeo FROM (SELECT finessgeo, sum(CIBLE)as NbSejCib FROM concerne_&loca._&aa GROUP BY finessgeo) where NbSejCib>9)
				THEN ete and cible ELSE 0 END) as NbETE_ESMin10 ,


		count (distinct CASE WHEN finessgeo in (select finessgeo FROM (SELECT finessgeo, sum(CIBLE)as NbSejCib FROM concerne_&loca._&aa GROUP BY finessgeo) where NbSejCib<10)
				THEN finessgeo ELSE "" END) as NbESMoins10,
		sum (CASE WHEN finessgeo in (select finessgeo FROM (SELECT finessgeo, sum(CIBLE)as NbSejCib FROM concerne_&loca._&aa GROUP BY finessgeo) where NbSejCib<10)
				THEN cible ELSE 0 END) as NbSej_ESMoins10,
		sum (CASE WHEN finessgeo in (select finessgeo FROM (SELECT finessgeo, sum(CIBLE)as NbSejCib FROM concerne_&loca._&aa GROUP BY finessgeo) where NbSejCib<10)
				THEN ete and cible ELSE 0 END) as NbETE_ESMoins10

	from concerne_&loca._&aa   ;
quit;



/*************************************/
/* Rendu 4 : T_part : Dénombrement des exclusions Par finess */

proc sql;
	create table chartflow1_fi_&aa as 
	select distinct ides as ipe, con.finessgeo as finess, con.finess as finess_pmsi,rs as RS_FINESS,put(con.finess,$rsfipmsi.) as RS_FINESS_PMSI,CATEG_PMSI, Secteur_PMSI,	put(put(con.finessgeo, $region.), $reg_lib.) as Region,
		sum(concerne) as nbsej_&loca.,  
		sum(case when cmd in ("14","15","90") or translate(ano_retour,"","0")^="" then concerne else 0 end) as NbSej_erreur_etbt,
		sum(case when cmd="28" then concerne else 0 end) as NbSej_seances_etbt,
		count(distinct case when exc_age18 then ident else "" end) as NbSej_Moins_18ans_etbt, 
		sum(eligible) as nb_eligible, 
		sum(case when eligible then ete else 0 end) as Nb_ETE_Etude,
		count(distinct case when crit_dp1rum_ete then ident else "" end) as NbSej_dp_eptvp_etbt, 
		count(distinct case when crit_ivc then ident else "" end) as Nbsej_veine_cave_etbt, 
		count(distinct case when crit_obst then ident else "" end) as  NbSej_diag_o_etbt,  
		count(distinct case when crit_ambu  then ident else "" end) as  NbSej_ambu_etbt, 
		%if &loca.=PTH %then %do; count(distinct case when crit_fract then ident else "" end) as  NbSej_fract_etbt, %end;
		count(distinct case when (crit_urgence or crit_uhcd) then ident else "" end) as  NbSej_urgence_etbt, /* Nv 2018 *//* Ajout crit_uhcd 2018*/
		count(distinct case when crit_multi_pose then ident else "" end) as Nbsej_multi_pose_etbt, 
		count(distinct case when crit_multi_autre then ident else "" end) as Nbsej_multi_autre_etbt, 
		count(distinct case when crit_modeentree then ident else "" end) as Nbsej_modeentree_etbt, 
		count(distinct case when crit_atcd then ident else "" end) as Nbsej_atcd_etbt, 
		count(distinct case when crit_sp then ident else "" end) as Nbsej_sp_etbt, 
		count(distinct case when crit_fuite then ident else "" end) as Nbsej_Fuite, 
		count(distinct case when exclusion=0 and eligible=1 then ident else "" end) as Nbsej_exclus, 
		calculated Nbsej_exclus /calculated nb_eligible *100 as pctsej_exclus, 
		sum(cible) as ETE_&loca._Cible_etbt 
	from concerne_&loca._&aa.   con
	left join figeobis fg on con.finessgeo=fg.finessgeo
	group by con.finessgeo;
quit;

data T_part_ete_&loca._mco_&aa  ;
set chartflow1_fi_&aa (rename= (nb_eligible=NbSej_Etude));
run;


/*************************************/
/* Rendu 2 : T_indi : base de données des séjours cible */
data population_&aa;
	set concerne_&loca._&aa (where = (cible=1)); 
Acte=put(ident,$acteuniq.); 
run;

/* Calcul de la médiane d'observation sur la population cible */
proc means data = population_&aa nway noprint;
	class finess ;
	var duree_obs;
	output out = mediane_&aa median(duree_obs)= mediane_obs;
	where ete = 0 ; 
run;

/* Transformation de la mediane pour l'integrer au modele d'ajustement  */
data mediane_&aa;
	set mediane_&aa;
	if mediane_obs > 0  then mediane_obs_transforme = 1/(mediane_obs * mediane_obs);
run;

/* Affecter la médiane en fonction de l'ES et de la localisation */
proc sort data = population_&aa;
	by finess ;
run;

data model_&aa (drop = ano_retour ghm2 nbacte nbrum nbda supp_si supp_rea ghm _type_ _freq_ exclusion) ;
	merge population_&aa (in=a) mediane_&aa(in=b);
	by finess ;
run;


PROC SQL;
CREATE TABLE T_indi_ete_&loca._mco_&aa AS
select ident,anonyme,ano_date,duree,finessgeo as finess,finess as finess_pmsi,dp,dr,sexe,age,modeentree,provenance,modesortie,destination,mois,
annee,codegeo,seqmco,ghm&v as ghm2,"&loca." as localisation,dp_1RUM,Acte, cmd in ("14","15","90")  as crit_sej_erreur,cmd="28" as crit_seances, 
exc_age18 as crit_moins_18ans, crit_dp1rum_ETE as crit_dp_eptvp, crit_ivc as crit_veine_cave, crit_obst as crit_diag_o,crit_ambu as crit_sej_ambu_&loca., 
%if &loca.=PTH %then %do; crit_fract, %end;
crit_urgence,crit_multi_pose,crit_multi_autre, crit_modeentree,crit_atcd,crit_sp,crit_fuite,
cible as ete_&loca._cible,ep,tvp,ete,echo,com_k as fr_cancer,com_chf as fr_insufcard, com_cpd as fr_cpd, com_ir as fr_ir, com_coag as fr_coag, 
com_hemi as fr_paralysie, com_mcv as Fr_mcv, com_obe as fr_obe, com_irc as fr_insufrespC,com_aete as FR_Atcd_ETE, crit_cvc ,crit_cvc_bis ,
crit_dc ,delai_acte,duree_obs, mediane_obs,mediane_obs_transforme,raac

FROM model_&aa;
QUIT;

	
/**********************************/
/* Régression logistique */

/* Calcul du taux moyen global observé */
proc sql noprint;
	select (sum(ete)/count(cible)) *100 into: tx_observe_nat_tot_&aa
	from model_&aa ;  
quit;
%put &&tx_observe_nat_tot_&aa;

/* Calcul de la probabilité prédite */
ods html file = "ETE_&loca._&aa..html";
ods trace on;
ods graphics on;
ods output OddsRatios=odds_&aa;
title "";
proc logistic data= model_&aa ;
	class sexe(ref='1') com_k(ref='0') com_chf(ref='0') 
		com_cpd(ref='0') com_ir(ref='0') com_coag(ref='0') com_hemi(ref='0') 
		com_mcv(ref='0') com_obe(ref='0') com_irc(ref='0') com_aete (ref='0')/ param=ref;
	model ete (event='1')= age sexe mediane_obs_transforme com_k com_chf 
com_cpd com_ir com_coag com_hemi com_mcv com_obe com_irc com_aete/ link=logit outroc=troc lackfit;
	output out=prob_&aa. (keep=finessgeo finess ident prob ete raac) prob=prob  ;
run;

ods trace off;
ods html close;


/*****************************************/
/* Funnel plot */
proc sql;
	create table ajuste_fi_&aa as 
		select distinct finessgeo, finess as finess_pmsi,
			sum(ete) as nb_observe_tot, 
			count(*) as nb_cible_tot,
			mean(ete)*100 as tx_observe_tot,
			mean(prob)*100 as tx_attendu, 
			(calculated tx_observe_tot / calculated tx_attendu) as ratio_oe, 
			&&tx_observe_nat_tot_&aa.*(calculated ratio_oe ) as tx_ajuste , 
		    mean(prob)*count(*) as nb_attendu , 
			&&tx_observe_nat_tot_&aa. as tx_observe_nat_tot,
			sum(raac="1") as nb_raac_etbt,
			sum(raac="1")/count(*)*100 as pct_raac_etbt
		from prob_&aa 
		group by finessgeo,finess;
quit;
	
proc iml;
	use ajuste_fi_&aa;
	read all var {nb_attendu};
	close ajuste_fi_&aa;
	p = {0.001 0.025 0.975 0.999};
	limits=j(nrow(nb_attendu),ncol(p));

	/***calcul des bornes */
	do i=1 to ncol(p);
		r=quantile ("poisson", p[i], nb_attendu);
		nb_observe_tot = cdf ("poisson",r,nb_attendu)-p[i];
		nb_cible_tot = cdf ("poisson",r,nb_attendu)-cdf("poisson",r-1,nb_attendu);
		alpha = nb_observe_tot/nb_cible_tot;
		limits[,i] = (r-alpha)/nb_attendu;
	end;

	/**creation de la table des bornes */
	results = nb_attendu || limits;
	labels = {"nb_attendu" "L3sd" "L2sd" "U2sd" "U3sd"};
	create Limits_&aa from results[colname=labels];
	append from results;
	close;
quit;

/* Rassembler les résultats  */
data results_&aa;
	merge ajuste_fi_&aa (drop=nb_attendu) limits_&aa;
run;	
	
	data ResultsB_&aa;
		set Results_&aa;

if round(nb_attendu,0.01)<=0.02 then U3sd=249.9998332;
if round(nb_attendu,0.0001)<=0.0514 then U2sd=10.0021931; 
	
	if nb_cible_tot >= 10 then do;
		if ratio_oe >  U3sd then ETE_&loca._POS_SEUIL_ETBT="C";
		else if ratio_oe <  L3sd then ETE_&loca._POS_SEUIL_ETBT="A";
		else ETE_&loca._POS_SEUIL_ETBT="B";

		if ratio_oe >  U2sd then ETE_&loca._2DS_ETBT="C";
		else if ratio_oe <  L2sd then ETE_&loca._2DS_ETBT="A";
		else ETE_&loca._2DS_ETBT="B";
		
		if ratio_oe >  U3sd then ETE_&loca._2DS_3DS_ETBT = "5";
		if ratio_oe >= U2sd and ratio_oe <= U3sd then ETE_&loca._2DS_3DS_ETBT = "4";
		if ratio_oe >  L2sd and ratio_oe < U2sd then ETE_&loca._2DS_3DS_ETBT = "3";
		if ratio_oe >= L3sd and ratio_oe <= L2sd then ETE_&loca._2DS_3DS_ETBT = "2";
		if ratio_oe < L3sd then ETE_&loca._2DS_3DS_ETBT = "1";
		
		interval_plot = 0;
		if ratio_oe > U3sd or ratio_oe < L3sd then interval_plot = 1;
	end;	

	run;	
	
	proc sql noprint;
		select max(nb_attendu) into : Abscisse_max
		from Resultsb_&aa where nb_cible_tot >= 10;
		select max(ratio_oe) into : Ordonnee_max
		from Resultsb_&aa  where nb_cible_tot >= 10;
	quit;
	%let O_max = %sysevalf(&Ordonnee_max.,ceil);
	%let A_max = %sysevalf(&Abscisse_max.,ceil);

		
proc sort data = resultsb_&aa  ; by nb_attendu interval_plot; run;  
title  "Ratio O/A de TVP ou d'EP après pose de &loca.";
title2 "Données PMSI 20&aa (ES avec au moins 10 séjours cibles)";
proc sgplot data= resultsb_&aa (where = (finessgeo ^="Total") );
	 	styleattrs DataContrastColors = (cx0000FF cxFF0000);
	band x=nb_attendu lower=L3sd upper=U3sd /nofill lineattrs=(pattern = Dash color=black) legendlabel="3DS limits" name="band99";
	refline 1 /axis=y lineattrs=(color=red) legendlabel="Cible" name="cible";
	scatter x=nb_attendu y=ratio_oe / group=interval_plot TRANSPARENCY = 0.4 markerattrs=(symbol=CircleFilled size=5)  ;
	keylegend "band99" "cible" / location=inside down=2 position=topright;
		yaxis grid values = (-1 to &o_max. by 1)label='Ratio observé / attendu';     
		xaxis grid label = 'Nombre de cas attendus' values = (0 to &a_max. by 0.1);         
	where nb_cible_tot >=10;   
run;



/*************************************/
/* Rendu 3 : T_etbt 
	=> données du funnel plot */	

PROC SQL;

select distinct sum(raac="1") into: NB_RAAC_NAT from  model_&aa ;
select distinct (sum(raac="1")/sum(&loca.)) *100 into: PCT_RAAC_NAT from  model_&aa ;

CREATE TABLE T_etbt_ete_ortho_mco_&aa AS
SELECT a.finessgeo as finess,a.finess_pmsi, ides as ipe , rs, categ_pmsi, secteur_pmsi,
		put(put(finess, $region.), $reg_lib.) as region length = 50, 
	nb_cible_tot as ete_&loca._cible_etbt, nb_observe_tot as ete_&loca._obs_etbt, tx_observe_tot as ete_&loca._txobs_etbt, nb_attendu as ete_&loca._att_etbt,
	tx_attendu as ete_&loca._txatt_etbt,ratio_oe as ete_&loca._etbt, tx_ajuste as ete_&loca._txajust_etbt, tx_observe_nat_tot as ete_&loca._txobs_nat,
	 ete_&loca._pos_seuil_etbt,
	 ete_&loca._2DS_etbt,
	 ete_&loca._2DS_3DS_etbt,
	L3sd as Bas_3_ds,
	U3sd as Haut_3_ds,
	nb_raac_etbt, pct_raac_etbt,&nb_raac_nat. as nb_raac_nat, &pct_raac_nat. as pct_raac_nat

FROM resultsB_&aa a
LEFT JOIN figeobis b on a.finessgeo=b.finessgeo
WHERE nb_cible_tot>0;
QUIT;



