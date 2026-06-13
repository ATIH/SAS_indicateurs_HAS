/*==============================================================================*/
/* Indicateur HAS - ETE-ORTHO : identification des poses et multi-poses         */
/* Extrait de ETE_ORTHO/ete_ortho.sas, section III.1                            */
/*                                                                              */
/* Reprend la logique du programme source : selection des actes de pose via les */
/* formats CCAM, denombrement par sejour (PROC MEANS CLASS / OUTPUT SUM) puis    */
/* jointure PROC SQL pour ramener le nombre de poses PTH / PTG sur chaque ligne. */
/*==============================================================================*/

proc format ;
	value $acteh
	"NEKA010","NEKA012","NEKA013","NEKA014","NEKA015",
	"NEKA016","NEKA017","NEKA019","NEKA020","NEKA021" = "1"
	other = ' ' ;
	value $acteg
	"NFKA007","NFKA008","NFKA009" = "1"
	other = ' ';
run;

/* Table d'actes d'exemple (1 ligne par acte). Le programme source lit cette
   table depuis mco&aa.bd.acte ; on en reproduit la structure utile : ident du
   sejour, code acte, indicateur d'activite, nombre de realisations, delai. */
data acte;
	length ident $6 acte $7 acte_activ $1;
	input ident $ acte $ acte_activ $ acte_nbfois acte_delai;
	datalines;
000001 NEKA010 1 1 2
000002 NFKA007 1 1 1
000003 NEKA013 1 1 0
000003 NEKA014 1 1 0
000004 NFKA008 1 2 3
000005 NEKA021 1 1 .
000005 NFKA009 1 1 .
000006 NFKA009 1 1 4
;
run;

/* 1. Identification des poses et multi-poses (sejours avec un deuxieme acte) */
data tt;
	set acte;
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
quit;

proc print data = ttt;
	var ident acte a_h a_g nb nb_pth nb_ptg;
run;

/* Denombrement des sejours multi-pose (au moins deux actes de pose) */
proc sql;
	create table multi as
		select ident, nb, nb_pth, nb_ptg,
			case when nb > 1 then 1 else 0 end as multi_pose
		from ttt
		group by ident, nb, nb_pth, nb_ptg;
quit;

proc print data = multi;
run;
