/*----------------------------------------------------------------------------------------------------------*/
/*-----------------------------------------------------------------------------------------------------------
					ISO-ORTHO 
=> 2 macro variables à mettre à jour : &annee et &loca
-----------------------------------------------------------------------------------------------------------*/

/* 1_ Bibli et macro variables */
%let annee = 2021;
%let loca=ptg;

%let andet=%eval(&annee+1);
%let an=%eval(%substr(&annee,3,2));
%let an_moins1 = %eval (&an.-1);
%let an_plus1 = %eval (&an.+1);
%let ver=%eval (&annee.+1);

%let locan=%sysfunc(ifc(&loca.=pth,1,2));

%put &locan.;

libname sortie "/partage/psi/&andet./iso_ortho/output";
libname ref_fi "/ref/finess/"  ;
Libname fmtgen "/ref/bases/formats_SAS/genbases";
libname gen  	"/ref/nomenclatures/general";
libname mco&an.bd meta library="mco&an.bd";
libname mco&an_plus1.bd meta library="mco&an_plus1.bd";
libname mco&an_moins1.bd meta library="mco&an_moins1.bd";

libname ssr&an.bd meta library="ssr&an.bd";
libname ssr&an_moins1.bd meta library="ssr&an_moins1.bd";
libname had&an.bd meta library="had&an.bd";
libname had&an_moins1.bd meta library="had&an_moins1.bd";

options fmtsearch = (ref_fi fmtgen);


/* 2_ Formats */
proc format;
	value $PTH
		"NEKA010","NEKA012", "NEKA013",
		"NEKA014", "NEKA015", "NEKA016", "NEKA017",
		"NEKA019", "NEKA020", "NEKA021" 
		= "1"
		other = ' ' 
	;
	value $PTG
	 	"NFKA007", "NFKA008", "NFKA009" 
		= "1"
		other = ' ' 
	;

	value $mois_pose
	 	"01"-"09" = "1"
		other = ' ' 
	;
	
	value $ISO_DIAGINF_ptg /* Annexe 1 */
'A180'-'A180z','A666'-'A666z','B453'-'B453z','B672'-'B672z','M000','M0000','M0006','M0008','M0009','M001','M0010','M0016','M0018','M0019',
'M002',
'M0020','M0026','M0028','M0029','M008','M0080','M0085','M0086','M0088','M0089','M009','M0090','M0096','M0098','M0099',
'M010','M0100','M0106','M0108','M0109','M011','M0110','M0116','M0118','M0119','M012','M0120','M0126','M0128',
'M0129','M013','M0130','M0136','M0138','M0139','M016','M0160','M0166','M0168','M0169','M018','M0180','M0186',
'M0188','M0189','M860','M8600','M8606','M8608','M8609','M861','M8610','M8616','M8618','M8619','M862','M8620',
'M8626','M8628','M8629','M863','M8630','M8636','M8638','M8639','M864','M8640','M8646','M8648','M8649','M865','M8650',
'M8656','M8658','M8659','M866','M8660','M8666','M8668','M8669','M868','M8680','M8686','M8688','M8689','M869',
'M8690','M8696','M8698','M8699','M900','M9000','M9006','M9008','M9009','M901','M9010','M9016','M9018','M9019',
'M902','M9020','M9026','M9028','M9029'
		= "1"
		other = ' ' 
	;
	
	value $ISO_DIAGINF_pth /* Annexe 1 */
'A180'-'A180z','A666'-'A666z','B453'-'B453z','B672'-'B672z','M000','M0000','M0005','M0008','M0009','M001','M0010','M0015','M0018','M0019',
'M002',
'M0020','M0025','M0028','M0029','M008','M0080','M0085','M0088','M0089','M009','M0090','M0095','M0098','M0099',
'M010','M0100','M0105','M0108','M0109','M011','M0110','M0115','M0118','M0119','M012','M0120','M0125','M0128',
'M0129','M013','M0130','M0135','M0138','M0139','M016','M0160','M0165','M0168','M0169','M018','M0180','M0185',
'M0188','M0189','M860','M8600','M8605','M8608','M8609','M861','M8610','M8615','M8618','M8619','M862','M8620','M8625',
'M8628','M8629','M863','M8630','M8635','M8638','M8639','M864','M8640','M8645','M8648','M8649','M865','M8650',
'M8655','M8658','M8659','M866','M8660','M8665','M8668','M8669','M868','M8680','M8685','M8688','M8689','M869',
'M8690','M8695','M8698','M8699','M900','M9000','M9005','M9008','M9009','M901','M9010','M9015','M9018','M9019',
'M902','M9020','M9025','M9028','M9029'
		= "1"
		other = ' ' 
	;
	
	value $ISO_DIAGINF_excl /* Annexe 1 */
'A180'-'A180z','A666'-'A666z','B453'-'B453z','B672'-'B672z','M000','M0000','M0005','M0006','M0008','M0009','M001','M0010','M0015','M0016','M0018','M0019',
'M002',
'M0020','M0025','M0026','M0028','M0029','M008','M0080','M0085','M0086','M0088','M0089','M009','M0090','M0095','M0096','M0098','M0099',
'M010','M0100','M0105','M0106','M0108','M0109','M011','M0110','M0115','M0116','M0118','M0119','M012','M0120','M0125','M0126','M0128',
'M0129','M013','M0130','M0135','M0136','M0138','M0139','M016','M0160','M0165','M0166','M0168','M0169','M018','M0180','M0185','M0186',
'M0188','M0189','M860','M8600','M8605','M8606','M8608','M8609','M861','M8610','M8615','M8616','M8618','M8619','M862','M8620','M8625',
'M8626','M8628','M8629','M863','M8630','M8635','M8636','M8638','M8639','M864','M8640','M8645','M8646','M8648','M8649','M865','M8650',
'M8655','M8656','M8658','M8659','M866','M8660','M8665','M8666','M8668','M8669','M868','M8680','M8685','M8686','M8688','M8689','M869',
'M8690','M8695','M8696','M8698','M8699','M900','M9000','M9005','M9006','M9008','M9009','M901','M9010','M9015','M9016','M9018','M9019',
'M902','M9020','M9025','M9026','M9028','M9029'
		= "1"
		other = ' ' 
	;

	value $IOA /* Annexe 2 */
'A180'-'A180z','A666'-'A666z','B453'-'B453z','B672'-'B672z',	'M000',	'M0000',	'M0001',	'M0002',	'M0003',	'M0004',	'M0005',	'M0006',	'M0007',	'M0008',	'M0009',		
'M001',	'M0010',	'M0011',	'M0012',	'M0013',	'M0014',	'M0015',	'M0016',	'M0017',	'M0018',	'M0019',	'M002',	'M0020',	'M0021',	'M0022',		
'M0023',	'M0024',	'M0025',	'M0026',	'M0027',	'M0028',	'M0029',	'M008',	'M0080',	'M0081',	'M0082',	'M0083',	'M0084',	'M0085',	'M0086',		
'M0087',	'M0088',	'M0089',	'M009',	'M0090',	'M0091',	'M0092',	'M0093',	'M0094',	'M0095',	'M0096',	'M0097',	'M0098',	'M0099',	'M010',		
'M0100',	'M0101',	'M0102',	'M0103',	'M0104',	'M0105',	'M0106',	'M0107',	'M0108',	'M0109',	'M011',	'M0110',	'M0111',	'M0112',	'M0113',		
'M0114',	'M0115',	'M0116',	'M0117',	'M0118',	'M0119',	'M012',	'M0120',	'M0121',	'M0122',	'M0123',	'M0124',	'M0125',	'M0126',	'M0127',		
'M0128',	'M0129',	'M013',	'M0130',	'M0131',	'M0132',	'M0133',	'M0134',	'M0135',	'M0136',	'M0137',	'M0138',	'M0139',	'M016',	'M0160',		
'M0161',	'M0162',	'M0163',	'M0164',	'M0165',	'M0166',	'M0167',	'M0168',	'M0169',	'M018',	'M0180',	'M0181',	'M0182',	'M0183',	'M0184',		
'M0185',	'M0186',	'M0187',	'M0188',	'M0189',	'M461',	'M4618',	'M462',	'M4620',	'M4621',	'M4622',	'M4623',	'M4624',	'M4625',	'M4626',		
'M4627',	'M4628',	'M4629',	'M463',	'M4630',	'M4632',	'M4633',	'M4634',	'M4635',	'M4636',	'M4637',	'M4639',	'M464',	'M4640',	'M4642',		
'M4643',	'M4644',	'M4645',	'M4646',	'M4647',	'M4649',	'M465',	'M4650',	'M4651',	'M4652',	'M4653',	'M4654',	'M4655',	'M4656',	'M4657',		
'M4658',	'M4659',	'M490',	'M4900',	'M4901',	'M4902',	'M4903',	'M4904',	'M4905',	'M4906',	'M4907',	'M4908',	'M4909',	'M491',	'M4910',		
'M4911',	'M4912',	'M4913',	'M4914',	'M4915',	'M4916',	'M4917',	'M4918',	'M4919',	'M492',	'M4920',	'M4921',	'M4922',	'M4923',	'M4924',		
'M4925',	'M4926',	'M4927',	'M4928',	'M4929',	'M493',	'M4930',	'M4931',	'M4932',	'M4933',	'M4934',	'M4935',	'M4936',	'M4937',	'M4938',		
'M4939',	'M680',	'M860',	'M8600',	'M8601',	'M8602',	'M8603',	'M8604',	'M8605',	'M8606',	'M8607',	'M8608',	'M8609',	'M861',	'M8610',		
'M8611',	'M8612',	'M8613',	'M8614',	'M8615',	'M8616',	'M8617',	'M8618',	'M8619',	'M862',	'M8620',	'M8621',	'M8622',	'M8623',	'M8624',		
'M8625',	'M8626',	'M8627',	'M8628',	'M8629',	'M863',	'M8630',	'M8631',	'M8632',	'M8633',	'M8634',	'M8635',	'M8636',	'M8637',	'M8638',		
'M8639',	'M864',	'M8640',	'M8641',	'M8642',	'M8643',	'M8644',	'M8645',	'M8646',	'M8647',	'M8648',	'M8649',	'M865',	'M8650',	'M8651',		
'M8652',	'M8653',	'M8654',	'M8655',	'M8656',	'M8657',	'M8658',	'M8659',	'M866',	'M8660',	'M8661',	'M8662',	'M8663',	'M8664',	'M8665',		
'M8666',	'M8667',	'M8668',	'M8669',	'M868',	'M8680',	'M8681',	'M8682',	'M8683',	'M8684',	'M8685',	'M8686',	'M8687',	'M8688',	'M8689',		
'M869',	'M8690',	'M8691',	'M8692',	'M8693',	'M8694',	'M8695',	'M8696',	'M8697',	'M8698',	'M8699',	'M900',	'M9000',	'M9001',	'M9002',		
'M9003',	'M9004',	'M9005',	'M9006',	'M9007',	'M9008',	'M9009',	'M901',	'M9010',	'M9011',	'M9012',	'M9013',	'M9014',	'M9015',	'M9016',		
'M9017',	'M9018',	'M9019',	'M902',	'M9020',	'M9021',	'M9022',	'M9023',	'M9024',	'M9025',	'M9026',	'M9027',	'M9028',	'M9029',	
'T845'-'T845z',	'T846'-'T846z',	'T847'-'T847z'
="1"
other = ' ';

	value $ATIHS_pth
'NEJA001',	'NEJA002',	'NEJA003','NEJA004','NEJC001','NEJB001','NZJB001'="1"
other="";
	value $ATIHS_ptg
'NFJA001','NFJA002','NFJC001','NFJC002','NZJB001'="1"
other="";

	value $ATS_pth
'NEFC001',	'NEFA003',	'NEFA004'="1" 
other="";
	value $ATS_ptg
'NFFC001',	'NFFC002',	'NFFA002',	'NFFA004',	'NFFA005',	'NFFA006'="1" 
other="";

	value $ATRP_pth
'NEGA001',	'NEGA002',	'NEGA003',	'NEGA004',	'NEKA001',	'NEKA002',	'NEKA003',	'NEKA004',	'NEKA005',
'NEKA006',	'NEKA007',	'NEKA008',	
'NEKA009',	'NELA001',	'NELA002'="1"
other="";

	value $ATRP_ptg
'NFKA001',	'NFKA002',	'NFKA004'="1"
other="";


	value $ADI_pth
'NAHA001',	'NAHA002',	'NAHB001',	'NEHA001',	'NEHA002',	'NZHA001',	'NZHB001',	'NZHB002',	'NZHH001',	
'NZHH002',	'NZHH003',	'NZHH004'="1"
other="";

	value $ADI_ptg
'NZHA001',	'NZHB001',	'NZHB002',	'NZHH001',	'NZHH002',	'NZHH003',	'NZHH004'="1"
other="";


	value $fracture_diag
		"M80"-"M80z", "M841"-"M841z","M842"-"M842z","M843"-"M843z","M844"-"M844z",
		"M907"-"M907z", "S32"-"S32z", "S72"-"S72z",
		"S79"-"S79z", "M966"-"M966z" = "1"
		other = ' ' 
	;
	value $Changement_repose
		"NEKA001", "NEKA003", "NEKA006", "NEKA008",	"NEKA022" = "1"
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

	value $CHIR /* Annexe 3*/
		'NAHA002',	'NAHA001',	'NEHA002',	'NEQC001',	'NFQC001',	'NAEP002',	'NAEP001',	'NACB001',	'NACA001',	'NACA002',	'NACA005',	'NACA003',	'NACA004',	'NAPA004',
'NAPA003',	'NAPA005',	'NAPA001',	'NAPA007',	'NAPA002',	'NAPA008',	'NAPA006',	'NAFA002',	'NAGA003',	'NAGA002',	'NAFA004',	'NAFA006',	'NAFA003',	'NAFA001',
'NAMA002',	'NAGA001',	'NBEP002',	'NBEP001',	'NBEB001',	'NBCA012',	'NBCA005',	'NBCA010',	'NBCA008',	'NBCA004',	'NBCA009',	'NBCA006',	'NBCB001',	'NBCB002',
'NBCB004',	'NBCA007',	'NBCB006',	'NBCA014',	'NBCA015',	'NBCA003',	'NBCA013',	'NFDC001',	'NFDA009',	'NBCB005',	'NBCA011',	'NBPA019',	'NBPA014',	'NBPA020',
'NBPA013',	'NBPA018',	'NBPA006',	'NBFA001',	'NBGA002',	'NBGA006',	'NBGA003',	'NBGA005',	'NBGA004',	'NBGA001',	'NBFA003',	'NBFA004',	'NBFA008',	'NBFA002',
'NBFA006',	'NBFA007',	'NBMA003',	'NBMA001',	'NBDA004',	'NBDA013',	'NBGA015',	'NBGA010',	'NBGA007',	'NBPA016',	'NBPA005',	'NBCB003',	'NBCA002',	'NBCA001',
'NBFA005',	'NBFA009',	'NBMA002',	'NEJB001',	'NEJA002',	'NEJA004',	'NEEP006',	'NEEP007',	'NEEP004',	'NEEP005',	'NEEP002',	'NEEA004',	'NEEA001',	'NEEA003',
'NEEA002',	'NEJC001',	'NEJA001',	'NEDA001',	'NEMA021',	'NEMA003',	'NEMA017',	'NEDA002',	'NEMA020',	'NEMA018',	'NEKA018',	'NEKA011',	'NELA003',	'NEKA020',
'NEKA012',	'NEKA014',	'NEKA010',	'NEKA016',	'NEKA017',	'NEKA021',	'NEKA015',	'NEKA013',	'NEKA019',	'NEGA005',	'NEGA002',	'NEGA003',	'NEGA001',	'NEKA022',
'NEKA004',	'NEKA009',	'NEKA002',	'NEKA007',	'NEKA005',	'NEKA003',	'NEKA008',	'NEKA006',	'NEKA001',	'NELA002',	'NELA001',	'NEFA001',	'NEMA013',	'NEMA011',
'NEPA001',	'NEFC001',	'NEFA004',	'NEFA003'										
='1'
	'NFJC002',	'NFJA002',	'NFEP002',	'NFJC001',	'NFJA001',	'NFDA002',	'NFDA003',	'NFKA009',	'NFKA006',	'NFKA007',	'NFKA008',	'NFGA002',	'NFGA001',
'NFKA004',	'NFKA003',	'NFKA005',	'NFKA001',	'NFKA002',	'NFLA002',	'NFLA001',	'NFMA013',	'NFMA006',	'NFPC002',	'NFPA001',	'NFPA003',	'NFFC002',
'NFFA004',	'NFFA005',	'NFFC001',	'NFFA002',	'NFFA006',	'NFCC002',	'NFCA001',	'NFCA004',	'NFCC001',	'NFCA006',	'NFCA005',	'NFCA003',	'NFMC003',
'NFMA004',	'NFMC002',	'NFMA010',	'NFMC005',	'NFMA008',	'NFMC001',	'NFMA011',	'NFCA002',	'NFMA005',	'NFMA002',	'NFPC001',	'NFPA002',	'NFPA004',
'NFFC004',	'NFFA003',	'NFFC003',	'NFFA001',	'NFEC002',	'NFEA002',	'NFEC001',	'NFEA001'='2'
		other = ' ' 
		;

	value $OBE
		"E6605"-"E6605z", "E6606"-"E6606z", "E6607"-"E6607z", "E6615"-"E6615z", "E6616"-"E6616z", 
		"E6617"-"E6617z", "E6625"-"E6625z", "E6626"-"E6626z", "E6627"-"E6627z", "E6685"-"E6685z", 
		"E6686"-"E6686z", "E6687"-"E6687z", "E6695"-"E6695z", "E6696"-"E6696z", "E6697"-"E6697z"
		= "1"
		other = ' ' 
	;

	/* pour avant 2017 :*/
	value $OBE_pre17_
          "E6601"-"E6601z","E6602"-"E6602z","E6611"-"E6611z","E6612"-"E6612z","E6621"-"E6621z","E6622"-"E6622z",
          "E6681"-"E6681z","E6682"-"E6682z","E6691"-"E6691z","E6692"-"E6692z"
          = "1"
          other = ' ' 
     ;

	value $MALNUTRI
		"E40"-"E44z",
		"E46"-"E46z"
		= "1"
		other = ' ' 
	;
	value $DIABETE
		"E10"-"E10z","E11"-"E11z","E12"-"E12z","E13"-"E13z","E14"-"E14z"/*,
		"Z863"-"Z863z"*/
		= "1"
		other = ' ' 
	;
	value $TUMEUR
		"C00"-"C97z" ,"D37"-"D48z"
		= "1"
		other = ' ' 
	;
	value $POLY_INFLA
		"M05"-"M14z" ,
"M45"-"M460z","M461"-"M461z","M468"-"M469z" = "1"
		other = ' ' 
	;
	value $POLY_INFLA_NON
		"M062"-"M062z","M063"-"M063z","M124"-"M124z","M125"-"M125z"="1"
		other = ' ' 
	;
	value $IMMU_CIRRHOSE
		"B20"-"B24z",
		"D80"-"D84z"
	 	= "1"
		"K700"-"K700z",
		"K703"-"K703z",
		"K717"-"K717z",
		"K74"-"K74z"
		= "2"
		other = ' ' 
	;
	value $IOA_old
		"M00"-"M03z",
		"M86"- "M86z",
		"T826"-"T827z",
		"T845"-"T847z"
		= "1"
		other = ' ' 
	;
	value $DIAG_CHIR
		"Z966"-"Z966z"
		= "1"
		other = ' ' 
	;
	value $IRC
		"N18"-"N18z"
		= "1"
		other = ' ' 
	;
	value $SOCIOECO
		"Z59"-"Z59z"
		= "1"
		other = ' ' 
	;
	value $CONTREAVIS
		"Z532"-"Z532z" = "1"
		other = ' ' 
	;
run;

%macro sej_cible(loca,an);

/* 3_ Base des sejours de pose (code acte + activite "1" pour 'un seul operateur')  */
PROC SQL;
CREATE TABLE Acte_cib 
AS SELECT anonyme,ano_date,a.ident,a.acte,a.acte_nbfois,ano_retour,a.rum, finess as finess_pmsi,finessgeo,fgud.finessgeodp,duree,dp,dr,sexe,age,modeentree,provenance,modesortie,destination,mois,annee,
codegeo,seqmco,"&locan." as localisation,raac
FROM Mco&an.bd.acte a
LEFT JOIN Mco&an.bd.fixe f ON f.ident=a.ident
LEFT JOIN Mco&an.bd.um u ON a.rum=u.rum and a.ident=u.ident
LEFT JOIN Mco&an.bd.Finessgeo_umdudp fgud ON fgud.ident=f.ident

WHERE put(substr(acte,1,7),$&loca..) = "1" and Acte_Activ = "1" and put(mois,$mois_pose.)="1"
ORDER BY anonyme, ano_date,ident,rum;

CREATE TABLE Acte_Nb  AS SELECT ident, count(acte) as NbAct
FROM Acte_cib GROUP BY ident;

CREATE TABLE Multi_Acte AS SELECT distinct ident,ano_date,anonyme FROM Acte_cib 
WHERE ident in (select ident from Acte_Nb where NbAct>1) 
	or ident in (select ident from Acte_cib where acte_nbfois>1) 
	or ident in (select ident from Mco&an.bd.acte 
		where 
			%if &loca.=pth %then %do;  put(substr(acte,1,7),$ptg.) = "1" %end;
			%if &loca.=ptg %then %do;  put(substr(acte,1,7),$pth.) = "1" %end;
		);

QUIT;

/* On garde le premier du patient */
DATA Acte_cib_fst1 ;
SET Acte_cib;
BY anonyme ano_date ident rum;
IF first.anonyme;
RUN;

/* Rechercher les actes de Synovectomie 
	On fait 3 tours de procsort nodupkey car sur 2018 il y avait max 3 actes par séjour (h+g mélangés)
=> à vérifier pour les autres années avant de lancer, voir s'il faut ajouter un 4ème tour  */

PROC SQL;
CREATE TABLE Actsyn&loca. AS
SELECT ident,acte as Synovectomie_&loca.
FROM Mco&an.bd.acte 
WHERE put(substr(acte,1,7),$ATS_&loca..) ="1" and Acte_Activ = "1" ;
QUIT;
PROC SORT data=Actsyn&loca. nodupkey; by _all_; run;
PROC SORT data=Actsyn&loca. nodupkey dupout=Actsyn&loca.2 out=Actsyn&loca.sd; By ident; Run;
PROC SORT data=Actsyn&loca.2 nodupkey dupout=Actsyn&loca.3; By ident; Run;

PROC SQL;
CREATE TABLE Actsyn&loca.4 AS
SELECT Actsyn&loca.sd.ident,Actsyn&loca.sd.Synovectomie_&loca. as Synovectomie_&loca.1 ,Actsyn&loca.2.Synovectomie_&loca. as Synovectomie_&loca.2,Actsyn&loca.3.Synovectomie_&loca. as Synovectomie_&loca.3,
catx(';',Actsyn&loca.sd.Synovectomie_&loca.,Actsyn&loca.2.Synovectomie_&loca.,Actsyn&loca.3.Synovectomie_&loca.) as Synovectomie_&loca.
FROM Actsyn&loca.sd 
LEFT JOIN Actsyn&loca.2 ON Actsyn&loca.sd.ident=Actsyn&loca.2.ident
LEFT JOIN Actsyn&loca.3 ON Actsyn&loca.sd.ident=Actsyn&loca.3.ident;
QUIT;


/* Fusion des tables */
PROC SQL;
CREATE TABLE Acte_cib_fst AS
SELECT a.*,Synovectomie_&loca.
FROM Acte_cib_fst1 a
LEFT JOIN Actsyn&loca.4 b on a.ident=b.ident;
QUIT;



/* 4 Séjours de pose : Iso détectée ? */

PROC SQL;
CREATE TABLE Sej_pose_iso AS 
SELECT f.ident, f.annee, f.mois as mois_iso, f.anonyme, f.ano_date as Ano_date_ISO, f.modesortie as modesortie_iso,f.modeentree as modeentree_iso,f.provenance as provenance_iso,
f.destination as destination_iso,f.duree as duree_iso, f.ano_retour,finessgeo as Finess_iso,f.dp as dp_iso, f.dr as dr_iso,
/* DA ISO */ 
	CASE WHEN f.ident in (SELECT f.ident FROM Mco&an.bd.fixe f LEFT JOIN Mco&an.bd.diag d ON f.ident=d.ident WHERE Typ_Diag > "2" and d.diag ^= f.dp and diag ^= f.dr and put(diag,$ISO_DIAGINF_&loca..)="1") THEN 1 ELSE 0 END as ISO_dac ,
/* DA code T ISO */ 
	CASE WHEN f.ident in (SELECT f.ident FROM Mco&an.bd.fixe f LEFT JOIN Mco&an.bd.diag d ON f.ident=d.ident WHERE Typ_Diag > "2" and d.diag ^= f.dp and diag ^= f.dr and substr(diag,1,4)="T845") THEN 1 ELSE 0 END as ISO_dat,
/* Actes thérap */
	CASE WHEN f.ident in (SELECT ident FROM Mco&an.bd.acte WHERE put(substr(Acte,1,7),$ATIHS_&loca..)="1" and Acte_Activ = "1") THEN 1 ELSE 0 END as ISO_actet,
/* Actes diag */
	CASE WHEN f.ident in (SELECT ident FROM Mco&an.bd.acte WHERE put(substr(Acte,1,7),$ADI_&loca..)="1" and Acte_Activ = "1") THEN 1 ELSE 0 END as ISO_acted,

CASE WHEN (calculated ISO_dac and calculated ISO_dat) THEN "1" ELSE "0" END as A,
CASE WHEN (calculated ISO_dac and calculated ISO_actet) THEN "1" ELSE "0" END as B,
CASE WHEN (calculated ISO_dac and calculated ISO_acted) THEN "1" ELSE "0" END as C,
CASE WHEN (calculated ISO_dat and calculated ISO_actet) THEN "1" ELSE "0" END as D,
CASE WHEN (calculated ISO_dat and calculated ISO_acted) THEN "1" ELSE "0" END as E,
"0" as F,"0" as G,"0" as H,"0" as I, "0" as J,"0" as K, "0" as L, "0" as M, "0" as N, "0" as O,
"0" as P, "0" as Q, "0" as R, "0" as S, "0" as T,
/* ISO */
	CASE WHEN (calculated ISO_dac and calculated ISO_dat) or (calculated ISO_dac and calculated ISO_actet) or (calculated ISO_dac and calculated ISO_acted) 
		or (calculated ISO_dat and calculated ISO_actet) or (calculated ISO_dat and calculated ISO_acted) 
		THEN "1" ELSE "0" END as ISO_&loca._OBS,
	case when calculated ISO_&loca._OBS="1" then 1 else 0 end as sej_pose

FROM Acte_cib_fst b
LEFT JOIN Mco&an.bd.fixe f ON f.ident=b.ident
ORDER BY anonyme, ano_date_ISO;
;
QUIT;

/* 4_bis Séjours de suivi => jusqu'à séjour ISO ou dans les 90 jours */
PROC SQL;
CREATE TABLE Sej_suivi_A_0 AS 
SELECT DISTINCT f.ident ,a.rum, f.annee, f.mois as mois_iso, f.anonyme, f.ano_date as Ano_date_ISO, f.modesortie as modesortie_iso,f.modeentree as modeentree_iso,
f.provenance as provenance_iso,f.destination as destination_iso,f.duree as duree_iso, f.ano_retour,ghmv&ver. as ghm2_iso,
fgud.finessgeodp as Finess_iso,
f.dp as dp_iso, f.dr as dr_iso,
/* DA ISO */ 
	CASE WHEN d.Typ_Diag > "2" and d.diag ^= f.dp and diag ^= f.dr and put(d.diag,$ISO_DIAGINF_&loca..)="1" THEN 1 ELSE 0 END as ISO_dac ,
/* DA code T ISO */ 
	CASE WHEN d.Typ_Diag > "2" and d.diag ^= f.dp and diag ^= f.dr and substr(diag,1,4)="T845" THEN 1 ELSE 0 END as ISO_dat,
/* DP ISO */ 
	CASE WHEN put(f.dp,$ISO_DIAGINF_&loca..)="1" THEN 1 ELSE 0 END as ISO_dpc,
/* DP code T ISO */ 
	CASE WHEN substr(f.dp,1,4)="T845" THEN 1 ELSE 0 END as ISO_dpt,
/* Actes thérapeutiques dont act syn*/
	CASE WHEN  put(substr(a.Acte,1,7),$ATIHS_&loca..)="1" or put(substr(a.Acte,1,7),$ATS_&loca..) in ("1","2") and Acte_Activ = "1" THEN 1 ELSE 0 END as ISO_actets,
/* Actes diagnostics */
	CASE WHEN put(substr(a.Acte,1,7),$ADI_&loca..)="1" and Acte_Activ = "1" THEN 1 ELSE 0 END as ISO_acted,
/* Actes thérapeutiques de reprise */
	CASE WHEN put(substr(a.Acte,1,7),$ATRP_&loca..)="1" and Acte_Activ = "1" THEN 1 ELSE 0 END as ISO_acter,

	/* ISO */
	"0" as A,
	"0" as B,
	"0" as C,
	"0" as D,
	"0" as E,
CASE WHEN (calculated ISO_dpc and calculated ISO_dat) THEN "1" ELSE "0" END as F,
CASE WHEN (calculated ISO_dpc and calculated ISO_actets) THEN "1" ELSE "0" END as G,
CASE WHEN (calculated ISO_dpc and calculated ISO_acted) THEN "1" ELSE "0" END as H,
CASE WHEN (calculated ISO_dac and calculated ISO_dat) THEN "1" ELSE "0" END as I,
CASE WHEN (calculated ISO_actets and calculated ISO_dat) THEN "1" ELSE "0" END as J,
CASE WHEN (calculated ISO_acted and calculated ISO_dat) THEN "1" ELSE "0" END as K,
CASE WHEN (calculated ISO_actets and calculated ISO_dac) THEN "1" ELSE "0" END as L,
CASE WHEN (calculated ISO_dpt and calculated ISO_dac) THEN "1" ELSE "0" END as M,
CASE WHEN (calculated ISO_dpt and calculated ISO_actets) THEN "1" ELSE "0" END as N,
CASE WHEN (calculated ISO_dpt and calculated ISO_acted) THEN "1" ELSE "0" END as O,
CASE WHEN (calculated ISO_acted and calculated ISO_dac) THEN "1" ELSE "0" END as P,
CASE WHEN (calculated ISO_dpt and calculated ISO_acter) THEN "1" ELSE "0" END as Q,
CASE WHEN (calculated ISO_dac and calculated ISO_acter) THEN "1" ELSE "0" END as R,
CASE WHEN (calculated ISO_dpc and calculated ISO_acter) THEN "1" ELSE "0" END as S,
CASE WHEN (calculated ISO_dat and calculated ISO_acter) THEN "1" ELSE "0" END as T,

	CASE WHEN calculated F="1" or calculated G="1" or calculated H="1" or calculated I="1" or calculated J="1" or calculated K="1" or calculated L="1" or 
	calculated M="1" or calculated N="1" or calculated O="1" or calculated P="1" or calculated Q="1" or calculated R="1" or 
	calculated S="1" or calculated T="1" THEN "1" ELSE "0" END as ISO_&loca._OBS,
		0 as sej_pose
FROM Acte_cib_fst b
LEFT JOIN Mco&an.bd.fixe f ON f.anonyme=b.anonyme
LEFT JOIN Mco&an.bd.acte a ON f.ident=a.ident
LEFT JOIN Mco&an.bd.diag d ON f.ident=d.ident and d.rum=a.rum
LEFT JOIN Mco&an.bd.Finessgeo_umdudp fgud ON fgud.ident=f.ident
LEFT JOIN Mco&an.bd.rgp r ON f.ident=r.ident
WHERE translate(f.ano_retour,"","0")="" and translate(b.ano_retour,"","0")="" and f.ano_date <b.ano_date+90 AND f.ano_date >b.ano_date ;
quit;
/* On obtient une ligne par um avec iso => Ne garder qu'une ligne par séjour */

PROC SQL;
CREATE TABLE Sej_suivi_A AS 
SELECT DISTINCT ident,annee,mois_iso,anonyme,ano_date_iso, modesortie_iso,modeentree_iso,provenance_iso,destination_iso,duree_iso,ano_retour, finess_iso, dp_iso,dr_iso,ghm2_iso,
max(a) as a,
max(b) as b,
max(c) as c,
max(d) as d,
max(e) as e,
max(f) as f,
max(g) as g,
max(h) as h,
max(i) as i,
max(j) as j,
max(k) as k,
max(l) as l,
max(m) as m,
max(n) as n,
max(o) as o,
max(p) as p,
max(q) as q,
max(r) as r,
max(s) as s,
max(t) as t,
max(iso_&loca._OBS) as iso_&loca._OBS,
0 as sej_pose
FROM Sej_suivi_A_0
GROUP BY ident,annee,mois_iso,anonyme,ano_date_iso, modesortie_iso,modeentree_iso,provenance_iso,destination_iso,duree_iso,ano_retour, finess_iso, dp_iso,dr_iso,ghm2_iso;
QUIT
;


PROC SQL;
CREATE TABLE Sej_suivi_B_0 AS 
SELECT f.ident ,a.rum, f.annee, f.mois as mois_iso, f.anonyme, f.ano_date as Ano_date_ISO, f.modesortie as modesortie_iso,f.modeentree as modeentree_iso,
f.provenance as provenance_iso,f.destination as destination_iso,f.duree as duree_iso, f.ano_retour,ghmv&ver. as ghm2_iso,
fgud.finessgeodp as Finess_iso,
f.dp as dp_iso, f.dr as dr_iso,
/* DA ISO */ 
	CASE WHEN d.Typ_Diag > "2" and d.diag ^= f.dp and diag ^= f.dr and put(d.diag,$ISO_DIAGINF_&loca..)="1" THEN 1 ELSE 0 END as ISO_dac ,
/* DA code T ISO */ 
	CASE WHEN d.Typ_Diag > "2" and d.diag ^= f.dp and diag ^= f.dr and substr(diag,1,4)="T845" THEN 1 ELSE 0 END as ISO_dat,
/* DP ISO */ 
	CASE WHEN put(f.dp,$ISO_DIAGINF_&loca..)="1" THEN 1 ELSE 0 END as ISO_dpc,
/* DP code T ISO */ 
	CASE WHEN substr(f.dp,1,4)="T845" THEN 1 ELSE 0 END as ISO_dpt,
/* Actes thérapeutiques dont act syn*/
	CASE WHEN  put(substr(a.Acte,1,7),$ATIHS_&loca..)="1" or put(substr(a.Acte,1,7),$ATS_&loca..) in ("1","2") and Acte_Activ = "1" THEN 1 ELSE 0 END as ISO_actets,
/* Actes diagnostics */
	CASE WHEN put(substr(a.Acte,1,7),$ADI_&loca..)="1" and Acte_Activ = "1" THEN 1 ELSE 0 END as ISO_acted,
/* Actes thérapeutiques de reprise */
	CASE WHEN put(substr(a.Acte,1,7),$ATRP_&loca..)="1" and Acte_Activ = "1" THEN 1 ELSE 0 END as ISO_acter,

	"0" as A,
	"0" as B,
	"0" as C,
	"0" as D,
	"0" as E,
CASE WHEN (calculated ISO_dpc and calculated ISO_dat) THEN "1" ELSE "0" END as F,
CASE WHEN (calculated ISO_dpc and calculated ISO_actets) THEN "1" ELSE "0" END as G,
CASE WHEN (calculated ISO_dpc and calculated ISO_acted) THEN "1" ELSE "0" END as H,
CASE WHEN (calculated ISO_dac and calculated ISO_dat) THEN "1" ELSE "0" END as I,
CASE WHEN (calculated ISO_actets and calculated ISO_dat) THEN "1" ELSE "0" END as J,
CASE WHEN (calculated ISO_acted and calculated ISO_dat) THEN "1" ELSE "0" END as K,
CASE WHEN (calculated ISO_actets and calculated ISO_dac) THEN "1" ELSE "0" END as L,
CASE WHEN (calculated ISO_dpt and calculated ISO_dac) THEN "1" ELSE "0" END as M,
CASE WHEN (calculated ISO_dpt and calculated ISO_actets) THEN "1" ELSE "0" END as N,
CASE WHEN (calculated ISO_dpt and calculated ISO_acted) THEN "1" ELSE "0" END as O,
CASE WHEN (calculated ISO_acted and calculated ISO_dac) THEN "1" ELSE "0" END as P,
CASE WHEN (calculated ISO_dpt and calculated ISO_acter) THEN "1" ELSE "0" END as Q,
CASE WHEN (calculated ISO_dac and calculated ISO_acter) THEN "1" ELSE "0" END as R,
CASE WHEN (calculated ISO_dpc and calculated ISO_acter) THEN "1" ELSE "0" END as S,
CASE WHEN (calculated ISO_dat and calculated ISO_acter) THEN "1" ELSE "0" END as T,

	CASE WHEN calculated F="1" or calculated G="1" or calculated H="1" or calculated I="1" or calculated J="1" or calculated K="1" or calculated L="1" or 
	calculated M="1" or calculated N="1" or calculated O="1" or calculated P="1" or calculated Q="1" or calculated R="1" or 
	calculated S="1" or calculated T="1" THEN "1" ELSE "0" END as ISO_&loca._OBS,
	0 as sej_pose
FROM Acte_cib_fst b
LEFT JOIN Mco&an_plus1.bd.fixe f ON f.anonyme=b.anonyme
LEFT JOIN Mco&an_plus1.bd.Finessgeo_umdudp fgud ON fgud.ident=f.ident
LEFT JOIN Mco&an_plus1.bd.acte a ON f.ident=a.ident
LEFT JOIN Mco&an_plus1.bd.diag d ON f.ident=d.ident and d.rum=a.rum
LEFT JOIN Mco&an_plus1.bd.rgp r ON f.ident=r.ident
WHERE translate(f.ano_retour,"","0")="" and translate(b.ano_retour,"","0")="" and f.ano_date <b.ano_date+90 AND f.ano_date >b.ano_date ;
;

CREATE TABLE Sej_suivi_B AS 
SELECT DISTINCT ident,annee,mois_iso,anonyme,ano_date_iso, modesortie_iso,modeentree_iso,provenance_iso,destination_iso,duree_iso,ano_retour, finess_iso, dp_iso,dr_iso,ghm2_iso,
max(a) as a,
max(b) as b,
max(c) as c,
max(d) as d,
max(e) as e,
max(f) as f,
max(g) as g,
max(h) as h,
max(i) as i,
max(j) as j,
max(k) as k,
max(l) as l,
max(m) as m,
max(n) as n,
max(o) as o,
max(p) as p,
max(q) as q,
max(r) as r,
max(s) as s,
max(t) as t,
max(iso_&loca._OBS) as iso_&loca._OBS,
0 as sej_pose
FROM Sej_suivi_B_0
GROUP BY ident,annee,mois_iso,anonyme,ano_date_iso, modesortie_iso,modeentree_iso,provenance_iso,destination_iso,duree_iso,ano_retour, finess_iso, dp_iso,dr_iso,ghm2_iso;

CREATE TABLE Sej_suivi_tot AS 
	SELECT * FROM Sej_suivi_A 
		UNION
	SELECT * FROM Sej_suivi_B
ORDER BY anonyme, ano_date_ISO;
QUIT;

/* Créer ISO_Type */
/* Garder uniquement le premier séjour d'ISO */

DATA Sej_Suivi_ISO_uq ;
SET Sej_pose_iso (where = (ISO_&loca._OBS="1" and translate(ano_retour,"","0")="") )
	Sej_Suivi_tot (where = (ISO_&loca._OBS="1" ));
By anonyme Ano_date_ISO;
IF first.anonyme;
ISO_TYPE=cats(A,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,s,r,t) ;
RUN; 


/* Avoir une base avec le suivi = sej pos + tous les séjours suivant jusqu'à celui de l'iso ou le dernier commencé dans les 90j 
  <-> supprimer les séjours post iso 
Identifier les séjours post iso */

PROC SQL;
CREATE TABLE A_excl  AS
SELECT b.ident,b.annee
FROM Sej_Suivi_ISO_uq a LEFT JOIN Sej_Suivi_tot b ON a.anonyme=b.anonyme
WHERE a.Ano_date_ISO<b.Ano_date_ISO and translate(a.ano_retour,"","0")="" and translate(b.ano_retour,"","0")="";

CREATE TABLE Sej_Sui AS
SELECT ident,annee,mois_iso,anonyme,ano_date_iso,modesortie_iso,modeentree_iso,
duree_iso,ano_retour,finess_iso,dp_iso,dr_iso,iso_&loca._obs,Sej_pose
FROM Sej_suivi_tot WHERE  cats(ident,annee) not in (select cats(ident,annee) from a_excl)
	union
SELECT ident,annee,mois_iso,anonyme,ano_date_iso,modesortie_iso,modeentree_iso,
duree_iso,ano_retour,finess_iso,dp_iso,dr_iso,iso_&loca._obs ,Sej_pose
FROM Sej_pose_iso;
QUIT; 


/* 5_Repérer les séjours de chirurgie (entre la pose et l'iso) */
PROC SQL;
CREATE TABLE Chir AS 
SELECT anonyme, a.ident, annee, ano_date as date_chir , ano_retour
FROM Mco&an.bd.acte a LEFT JOIN Mco&an.bd.fixe f ON f.ident=a.ident WHERE put(substr(acte,1,7),$CHIR.) in ("1","2") and Acte_Activ = "1"
	UNION
SELECT anonyme, a.ident, annee, ano_date as date_chir  , ano_retour
FROM Mco&an_plus1.bd.acte a LEFT JOIN Mco&an_plus1.bd.fixe f ON f.ident=a.ident 
WHERE put(substr(acte,1,7),$CHIR.) in ("1","2") and Acte_Activ = "1";
;

CREATE TABLE Chir_sui AS 
SELECT iso.Anonyme, iso.ident, Ano_date_iso, g.ano_date as Date_pose,date_chir,c.ano_retour
FROM Chir c 
LEFT JOIN Sej_Suivi_iso_uq iso ON iso.anonyme=c.anonyme
LEFT JOIN Acte_cib_fst g ON g.anonyme=iso.anonyme
WHERE c.date_chir <iso.ano_date_iso AND c.date_chir>g.ano_date AND translate(c.ano_retour,"","0")="" AND translate(g.ano_retour,"","0")="" AND translate(iso.ano_retour,"","0")="";

QUIT;


/* 6_ Repérer les séjours de chirurgie précédent de 3 mois la pose */
PROC SQL;
CREATE TABLE Chir_pre AS 
SELECT a.ident, annee, ano_date, anonyme , ano_retour
FROM Mco&an_moins1.bd.acte a LEFT JOIN Mco&an_moins1.bd.fixe f ON f.ident=a.ident WHERE put(substr(acte,1,7),$CHIR.) in ("1","2") and Acte_Activ = "1"
	UNION
SELECT a.ident, annee, ano_date, anonyme , ano_retour
FROM Mco&an.bd.acte a LEFT JOIN Mco&an.bd.fixe f ON f.ident=a.ident WHERE put(substr(acte,1,7),$CHIR.) in ("1","2") and Acte_Activ = "1"
;
CREATE TABLE Chir_pre_pose AS 
SELECT a.anonyme, a.ano_date as Date_chir, a.ano_retour, b.ano_date as Date_pose, a.ident as ident_chir, b.ident as ident_pose, a.annee
FROM Chir_pre a
LEFT JOIN Acte_cib_fst b on b.anonyme=a.anonyme
WHERE b.ano_date>a.ano_date AND b.ano_date<=a.ano_date+90 AND translate(b.ano_retour,"","0")="" AND translate(a.ano_retour,"","0")="";

QUIT;

/* 6_bis Repérer les séjours de chirurgie dans l'année précédent la pose (facteur de risque) */
PROC SQL;
CREATE TABLE Chir_pre_an AS 
SELECT ident, annee, ano_date as Date_chir, anonyme , ano_retour,duree
	FROM Mco&an_moins1.bd.fixe 
WHERE ident in (select ident from Mco&an_moins1.bd.acte where put(substr(acte,1,7),$CHIR.) in ("1","2") and Acte_Activ = "1") 
	
UNION
SELECT ident, annee, ano_date as Date_chir, anonyme , ano_retour,duree
	FROM Mco&an.bd.fixe  
WHERE ident in (select ident from Mco&an.bd.acte where put(substr(acte,1,7),$CHIR.) in ("1","2") and Acte_Activ = "1") 
		
;

CREATE TABLE Chir_pre_pose2 AS 
SELECT a.anonyme, Date_chir, b.ano_date as Date_pose, a.ident as ident_chir, 
b.ident as ident_pose, a.annee
FROM Acte_cib_fst b
LEFT JOIN Chir_pre_an a on b.anonyme=a.anonyme
WHERE b.ano_date>Date_chir AND b.ano_date<=Date_chir+a.duree+365 AND translate (b.ano_retour,"","0")="" AND translate (a.ano_retour,"","0")="" ;

QUIT;

/* 7_ Repérer les séjours avec soins palliatifs */ 

PROC SQL;
CREATE TABLE SP AS 
SELECT a.ident, annee, ano_date , ano_retour
FROM Mco&an.bd.diag a LEFT JOIN Mco&an.bd.fixe f ON f.ident=a.ident WHERE diag="Z515" 
	UNION
SELECT a.ident, annee, ano_date  , ano_retour
FROM Mco&an_plus1.bd.diag a LEFT JOIN Mco&an_plus1.bd.fixe f ON f.ident=a.ident WHERE diag="Z515" ;

CREATE TABLE SP_sui AS 
SELECT Anonyme, ident, Ano_date_iso , ano_retour
FROM Sej_Sui WHERE cats(ident,annee) in (select cats(ident,annee) from SP);
QUIT;

/* 7_bis_ Repérer les séjours avec sp dans l'année précédent le séj de pose */
PROC SQL;
CREATE TABLE sp_pre AS 
SELECT ident, annee, ano_date as Date_sp, anonyme , ano_retour,duree
	FROM Mco&an_moins1.bd.fixe 
WHERE ident in (select ident from  Mco&an_moins1.bd.diag where diag="Z515")
		UNION
SELECT ident, annee, ano_date as Date_sp, anonyme , ano_retour,duree
	FROM Mco&an.bd.fixe  
	WHERE ident in (select ident from  Mco&an.bd.diag where diag="Z515")
;

CREATE TABLE sp_pre2 AS 
SELECT a.anonyme, Date_sp, b.ano_date as Date_pose, a.ident as ident_sp, 
b.ident as ident_pose, a.annee, a.ano_retour
FROM Acte_cib_fst b
LEFT JOIN sp_pre a on b.anonyme=a.anonyme
WHERE b.ano_date>Date_sp AND b.ano_date<=a.Date_sp+a.duree+365 AND translate (b.ano_retour,"","0")="" AND translate (a.ano_retour,"","0")="" ;

QUIT;

/* 8_Repérer les séjours avec act d'infection ostéo-articulaire 
		complexe codée en DAS durant l'année prcdt le séjour de pose  */
PROC SQL;
CREATE TABLE ioa_pre AS 
SELECT ident, annee, ano_date as Date_ioa, anonyme , ano_retour,duree
	FROM Mco&an_moins1.bd.fixe 
WHERE ident in (select ident from  Mco&an_moins1.bd.diag where diag="Z76800" and typ_diag="5")
		UNION
SELECT ident, annee, ano_date as Date_ioa, anonyme , ano_retour,duree
	FROM Mco&an.bd.fixe  
	WHERE ident in (select ident from  Mco&an.bd.diag where diag="Z76800"  and typ_diag="5")
;

CREATE TABLE ioa_pre2 AS /* 112 */
SELECT a.anonyme, Date_ioa, b.ano_date as Date_pose, a.ident as ident_ioa, 
b.ident as ident_pose, a.annee,  a.ano_retour
FROM Acte_cib_fst b
LEFT JOIN ioa_pre a on b.anonyme=a.anonyme
WHERE b.ano_date>Date_ioa AND b.ano_date<=a.Date_ioa+a.duree+365 AND translate (b.ano_retour,"","0")="" AND translate (a.ano_retour,"","0")="" ;
QUIT;


/* 9_ Repérer les patients avec au moins un séjour de transplantation rénale dans l'année N-1 (GHM 27C06)*/
* Disparu en 2020 ;


/* 10_ Repérer les séjours avec diag obésité */
PROC SQL;
CREATE TABLE OBE AS 
SELECT a.ident, annee, ano_date, anonyme , ano_retour,duree
FROM Mco&an.bd.diag a LEFT JOIN Mco&an.bd.fixe f ON f.ident=a.ident 
WHERE (put(Diag,$OBE.) = "1" and annee>="2017") OR (put(Diag,$OBE_pre17_.)="1" and annee<"2017")
	UNION
SELECT a.ident, annee, ano_date, anonyme  , ano_retour,duree
FROM Mco&an_moins1.bd.diag a LEFT JOIN Mco&an_moins1.bd.fixe f ON f.ident=a.ident 
WHERE (put(Diag,$OBE.) = "1" and annee>="2017") OR (put(Diag,$OBE_pre17_.)="1" and annee<"2017");

CREATE TABLE OBE_pose AS /* 11216 */
SELECT g.anonyme,g.ident FROM Acte_cib_fst g LEFT JOIN OBE on obe.anonyme=g.anonyme 
	WHERE obe.ano_date+365+obe.duree>=g.ano_date and obe.ano_date<g.ano_date AND translate (g.ano_retour,"","0")="" AND translate (obe.ano_retour,"","0")=""
		UNION
SELECT g.anonyme,g.ident FROM Acte_cib_fst g LEFT JOIN Mco&an.bd.diag d on g.ident=d.ident 
	WHERE Typ_Diag > "2" and diag ^= g.dp and diag ^= g.dr and (put(Diag,$OBE.) = "1" and g.annee>="2017") OR (put(Diag,$OBE_pre17_.)="1" and g.annee<"2017");
QUIT;

/* 11_ Repérer les séjours avec malnutrition */

PROC SQL;
CREATE TABLE Maln AS
SELECT a.ident, annee, ano_date, anonyme, ano_retour,duree FROM Mco&an.bd.diag a LEFT JOIN Mco&an.bd.fixe f ON f.ident=a.ident WHERE put(Diag,$MALNUTRI.) = "1"
UNION
SELECT a.ident, annee, ano_date, anonyme, ano_retour,duree FROM Mco&an_moins1.bd.diag a LEFT JOIN Mco&an_moins1.bd.fixe f ON f.ident=a.ident WHERE put(Diag,$MALNUTRI.) = "1";

CREATE TABLE Maln_pose AS /* 5 577 */
SELECT g.anonyme,g.ident  FROM Acte_cib_fst g LEFT JOIN Maln on Maln.anonyme=g.anonyme 
	WHERE Maln.ano_date+Maln.duree+365>=g.ano_date and Maln.ano_date<g.ano_date AND translate (g.ano_retour,"","0")="" AND translate (maln.ano_retour,"","0")=""
		UNION
SELECT g.anonyme,g.ident  FROM Acte_cib_fst g /*LEFT JOIN Mco&an.bd.fixe f on g.ident=f.ident*/ LEFT JOIN Mco&an.bd.diag d on g.ident=d.ident 
	WHERE Typ_Diag > "2" and diag ^= dp and diag ^= dr and put(Diag,$MALNUTRI.) ="1" ;
QUIT;

/* 12_ Repérer les séjours avec diabète */

PROC SQL;
CREATE TABLE Diab AS 
SELECT a.ident, annee, ano_date, anonyme, ano_retour,duree 
FROM Mco&an.bd.diag a LEFT JOIN Mco&an.bd.fixe f ON f.ident=a.ident WHERE put(Diag,$DIABETE.) = "1"
	UNION
SELECT a.ident, annee, ano_date, anonyme, ano_retour,duree  
FROM Mco&an_moins1.bd.diag a LEFT JOIN Mco&an_moins1.bd.fixe f ON f.ident=a.ident WHERE put(Diag,$DIABETE.) = "1";

CREATE TABLE Diab_pose AS 
SELECT g.anonyme,g.ident  FROM Acte_cib_fst g LEFT JOIN Diab on Diab.anonyme=g.anonyme 
WHERE Diab.ano_date+Diab.duree+365>=g.ano_date and Diab.ano_date<g.ano_date and translate (g.ano_retour,"","0")="" AND translate (diab.ano_retour,"","0")=""
		UNION
SELECT g.anonyme,g.ident  FROM Acte_cib_fst g LEFT JOIN Mco&an.bd.diag d on g.ident=d.ident 
WHERE Typ_Diag > "2" and diag ^= dp and diag ^= dr and put(Diag,$DIABETE.) ="1" ;
QUIT;

/* 13_ Repérer les séjours avec tumeur */
PROC SQL;
	CREATE TABLE Tum AS 
SELECT g.anonyme FROM Acte_cib_fst g LEFT JOIN Mco&an.bd.diag d on g.ident=d.ident 
WHERE Typ_Diag > "2" and diag ^= dp and diag ^= dr and put(Diag,$TUMEUR.) ="1" and translate (g.ano_retour,"","0")="" 
	UNION
SELECT anonyme FROM (select * FROM Sej_Sui WHERE annee="&annee." and sej_pose=0 and translate (ano_retour,"","0")="" ) ss1 LEFT JOIN Mco&an.bd.diag d on ss1.ident=d.ident
WHERE put(Diag,$TUMEUR.) ="1"
	UNION
SELECT anonyme FROM (select * FROM Sej_Sui WHERE annee=cats("20","&an_plus1.") and sej_pose=0 and translate (ano_retour,"","0")="" ) ss2 LEFT JOIN Mco&an_plus1.bd.diag d on ss2.ident=d.ident
WHERE put(Diag,$TUMEUR.) ="1";
QUIT; 

/* 13bis_ Tumeur (z511) dans l'année précédent le séjour de pose ou dans le suivi */
PROC SQL;
CREATE TABLE Tum2_a AS 
SELECT ident, annee, ano_date, anonyme, ano_retour,duree FROM Mco&an.bd.fixe f WHERE substr(dp,1,4) = "Z511"
	UNION
SELECT ident, annee, ano_date, anonyme, ano_retour,duree FROM Mco&an_moins1.bd.fixe f WHERE substr(dp,1,4) = "Z511";

CREATE TABLE Tum2 AS
SELECT g.anonyme,g.ident  FROM Acte_cib_fst g LEFT JOIN Tum2_a on Tum2_a.anonyme=g.anonyme 
WHERE Tum2_a.ano_date+Tum2_a.duree+365>=g.ano_date and Tum2_a.ano_date<g.ano_date and translate (g.ano_retour,"","0")="" AND translate (Tum2_a.ano_retour,"","0")=""
	UNION
SELECT g.anonyme,g.ident  FROM Sej_Sui g WHERE  substr(dp_iso,1,4) = "Z511" ;
QUIT;


/* 14_ Repérer les séjours avec polyarthrite */
PROC SQL;
CREATE TABLE PolyArt AS 
SELECT a.ident, annee, ano_date, anonyme, ano_retour,duree FROM Mco&an.bd.diag a LEFT JOIN Mco&an.bd.fixe f ON f.ident=a.ident WHERE put(Diag,$POLY_INFLA.) = "1" and put(Diag,$POLY_INFLA_NON.) ne "1"
UNION
SELECT a.ident, annee, ano_date, anonyme, ano_retour,duree  FROM Mco&an_moins1.bd.diag a LEFT JOIN Mco&an_moins1.bd.fixe f ON f.ident=a.ident WHERE put(Diag,$POLY_INFLA.) = "1" and put(Diag,$POLY_INFLA_NON.) ne "1";

CREATE TABLE PolyArt_pose AS 
SELECT g.anonyme,g.ident  FROM Acte_cib_fst g LEFT JOIN PolyArt fact on fact.anonyme=g.anonyme 
WHERE fact.ano_date+fact.duree+365>=g.ano_date and fact.ano_date<g.ano_date AND translate (g.ano_retour,"","0")="" AND translate (fact.ano_retour,"","0")=""
	UNION
SELECT g.anonyme,g.ident  FROM Acte_cib_fst g  LEFT JOIN Mco&an.bd.diag d on g.ident=d.ident 
WHERE Typ_Diag > "2" and diag ^= dp and diag ^= dr and put(Diag,$POLY_INFLA.) = "1" and put(Diag,$POLY_INFLA_NON.) ne "1";
QUIT;


/* 15_ Repérer les séjours avec deficit immunitaire et/ou cirrhose */
PROC SQL;
CREATE TABLE DefImuCir AS 
SELECT a.ident, annee, ano_date, anonyme, ano_retour,duree FROM Mco&an.bd.diag a LEFT JOIN Mco&an.bd.fixe f ON f.ident=a.ident WHERE put(Diag,$IMMU_CIRRHOSE.) in ("1" ,"2")
	UNION
SELECT a.ident, annee, ano_date, anonyme, ano_retour ,duree  FROM Mco&an_moins1.bd.diag a LEFT JOIN Mco&an_moins1.bd.fixe f ON f.ident=a.ident 
	WHERE put(Diag,$IMMU_CIRRHOSE.) in ("1" ,"2");

CREATE TABLE DefImuCir_pose AS 
SELECT g.anonyme,g.ident  FROM Acte_cib_fst g LEFT JOIN DefImuCir fact on fact.anonyme=g.anonyme 
WHERE fact.ano_date+fact.duree+365>=g.ano_date and fact.ano_date<g.ano_date AND translate (g.ano_retour,"","0")="" AND translate (fact.ano_retour,"","0")=""
	UNION
SELECT g.anonyme,g.ident  FROM Acte_cib_fst g   LEFT JOIN Mco&an.bd.diag d on g.ident=d.ident 
WHERE Typ_Diag > "2" and diag ^= dp and diag ^= dr and put(Diag,$IMMU_CIRRHOSE.) in ("1","2");
QUIT;


/* 16_ Repérer les séjours avec infection des os et articulations */
PROC SQL;
CREATE TABLE IOA AS 
SELECT a.ident, annee, ano_date, anonyme,ano_retour,duree FROM Mco&an.bd.fixe f LEFT JOIN Mco&an.bd.diag a ON f.ident=a.ident WHERE put(Diag,$IOA.)="1"
	UNION
SELECT a.ident, annee, ano_date, anonyme,ano_retour,duree FROM Mco&an_moins1.bd.fixe f LEFT JOIN Mco&an_moins1.bd.diag a ON f.ident=a.ident 
	WHERE put(Diag,$IOA.) ="1";

CREATE TABLE IOA_pose AS 
SELECT g.anonyme,g.ident  FROM Acte_cib_fst g LEFT JOIN IOA  fact on fact.anonyme=g.anonyme 
WHERE fact.ano_date+fact.duree+365>=g.ano_date and fact.ano_date<g.ano_date AND translate (g.ano_retour,"","0")="" AND translate (fact.ano_retour,"","0")=""
 ;
QUIT;


/* 17_ Repérer les séjours avec insuffisance rénale chronique */
PROC SQL;
CREATE TABLE IRC AS 
SELECT a.ident, annee, ano_date, anonyme,ano_retour , duree
FROM Mco&an.bd.diag a LEFT JOIN Mco&an.bd.fixe f ON f.ident=a.ident 
LEFT JOIN Mco&an.bd.rgp r ON r.ident=f.ident 
WHERE put(diag,$IRC.)="1" or substr(ghmv20&an.,1,5)="11K02"
	UNION
SELECT a.ident, annee, ano_date, anonyme,ano_retour , duree
FROM Mco&an_moins1.bd.diag a LEFT JOIN Mco&an_moins1.bd.fixe f ON f.ident=a.ident 
LEFT JOIN Mco&an.bd.rgp r ON r.ident=f.ident 
WHERE put(diag,$IRC.)="1" or substr(ghmv20&an.,1,5)="11K02";

CREATE TABLE IRC_pose AS 
SELECT g.anonyme,g.ident  FROM Acte_cib_fst g LEFT JOIN IRC  fact on fact.anonyme=g.anonyme WHERE fact.ano_date+fact.duree+365>=g.ano_date and fact.ano_date<g.ano_date AND translate (g.ano_retour,"","0")="" AND translate (fact.ano_retour,"","0")=""
	UNION
SELECT g.anonyme,g.ident  FROM Acte_cib_fst g /*LEFT JOIN Mco&an.bd.fixe f on g.ident=f.ident*/ LEFT JOIN Mco&an.bd.diag d on g.ident=d.ident WHERE Typ_Diag > "2" and diag ^= dp and diag ^= dr and put(diag,$IRC.)="1";
QUIT;


/* 18_ Repérer les séjours longue durée */
PROC SQL; 
CREATE TABLE SejLD AS
SELECT anonyme,ano_date,ano_retour,duree  FROM Mco&an.bd.fixe WHERE duree>=4
	UNION
SELECT anonyme,ano_date,ano_retour,duree  FROM SSR&an.bd.fixe_sej
	UNION
SELECT anonyme,ano_date,ano_retour,duree FROM HAD&an.bd.fixe_sej
	UNION
SELECT anonyme,ano_date,ano_retour,duree  FROM Mco&an_moins1.bd.fixe WHERE duree>=4
	UNION
SELECT anonyme,ano_date,ano_retour,duree  FROM SSR&an_moins1.bd.fixe_sej
	UNION
SELECT anonyme,ano_date,ano_retour,duree FROM HAD&an_moins1.bd.fixe_sej;

CREATE TABLE SejLD_pose AS 
SELECT * FROM Acte_cib_fst g LEFT JOIN SejLD  fact on fact.anonyme=g.anonyme 
WHERE fact.ano_date+fact.duree+365>=g.ano_date and fact.ano_date<g.ano_date AND translate (g.ano_retour,"","0")="" AND translate (fact.ano_retour,"","0")="";
QUIT;


/* 19_ Repérer les séjours avec facteur socioéco - On ne veut que les DA, pas les DP */
PROC SQL;
CREATE TABLE FEC AS 
SELECT a.ident, annee, ano_date, anonyme,ano_retour,duree FROM Mco&an.bd.diag a LEFT JOIN Mco&an.bd.fixe f ON f.ident=a.ident WHERE put(diag,$SOCIOECO.)="1" and put(dp,$SOCIOECO.)^="1"
	UNION
SELECT a.ident, annee, ano_date, anonyme,ano_retour,duree FROM Mco&an_moins1.bd.diag a LEFT JOIN Mco&an_moins1.bd.fixe f ON f.ident=a.ident WHERE put(diag,$SOCIOECO.)="1" and put(dp,$SOCIOECO.)^="1";

CREATE TABLE FEC_pose AS 
SELECT g.anonyme,g.ident  FROM Acte_cib_fst g LEFT JOIN FEC  fact on fact.anonyme=g.anonyme WHERE fact.ano_date+fact.duree+365>=g.ano_date and fact.ano_date<g.ano_date AND translate (g.ano_retour,"","0")="" AND translate (fact.ano_retour,"","0")=""
	UNION
SELECT g.anonyme,g.ident  FROM Acte_cib_fst g LEFT JOIN Mco&an.bd.diag d on g.ident=d.ident WHERE Typ_Diag > "2" and diag ^= dp and diag ^= dr and put(diag,$SOCIOECO.)="1" ;
QUIT;

/* 20_ Base séjours cibles */
PROC SQL;
CREATE TABLE Sej_cible_1 AS SELECT 
cats(f.Ident,&an.) as IdentA,
f.Anonyme,
f.Ano_date,
f.Duree,
f.finessgeodp as Finess,
CASE WHEN  f.Finess_PMSI in ("750712184","690781810","130786049") THEN f.finessgeodp ELSE f.Finess_PMSI END as Finess_PMSI,
f.Dp,
f.Dr,
f.Sexe,
f.Age,
f.ModeEntree,
f.Provenance,
f.ModeSortie,
f.Destination,
f.Mois,
f.Annee,
f.CodeGeo,
f.SeqMCO,
r.ghmv&ver. as GHM2,
"&locan." as localisation,
u.DPduRUM as Dp_1RUM,
f.Acte,
f.Synovectomie_&loca.,

CASE WHEN f.modesortie="9" or f.anonyme in 
	(select anonyme from Sej_Sui where modesortie_iso="9" except select anonyme from Sej_Suivi_ISO_uq where modesortie_iso^="9") 
	THEN 1 ELSE 0 END as Suivi_DC,
CASE WHEN f.modesortie="9" THEN f.Ano_date+f.duree ELSE sd.Ano_date_iso+sd.duree END as Suivi_Date_DC,
CASE WHEN substr(r.ghmv&ver.,1,2)="90" THEN 1 ELSE 0 END as Crit_CMD90,
CASE WHEN translate(f.ano_retour,"","0")^="" THEN 1 ELSE 0 END as Crit_chainage,
CASE WHEN substr(r.ghmv&ver.,1,2)="28" THEN 1 ELSE 0 END as Crit_seances,
CASE WHEN substr(r.ghmv&ver.,1,2)="14" THEN 1 ELSE 0 END as Crit_CMD_14,
CASE WHEN substr(r.ghmv&ver.,1,2)="15" THEN 1 ELSE 0 END as Crit_CMD_15,
CASE WHEN f.age<18 THEN 1 ELSE 0 END as Crit_Moins_18ans,
CASE WHEN put(u.DPduRUM,$ISO_DIAGINF_excl.)="1" or put(f.DP,$ISO_DIAGINF_excl.)="1"  THEN 1 ELSE 0 END as Crit_Dp_ISO,
CASE WHEN f.ident in (select ident from Mco&an.bd.diag where substr(diag,1,4) in ("T846","T847") and typ_diag>"2") THEN 1 ELSE 0 END  as Crit_T846_7,
CASE WHEN f.ident in (select ident from Mco&an.bd.diag where substr(diag,1,4) in ("T840","T841") and typ_diag^="2") THEN 1 ELSE 0 END  as Crit_T840_1,
%if &loca=PTH %then %do ;
	CASE WHEN calculated localisation="1" and put(f.dp,$fracture_diag.)="1" THEN 1 ELSE 0 END  as Crit_fract,
%end;
CASE WHEN f.provenance="5" or u.type_rum_1 in ("07A","07B","01A","01B","02A","02B","03A","03B","18") THEN 1 ELSE 0 END  as Crit_urgence,
CASE WHEN f.ident in (select ident from Multi_Acte) THEN 1 ELSE 0 END  as  Crit_multi_pose,
CASE WHEN f.ident in (select ident from Mco&an.bd.acte where put(substr(acte,1,7),$changement_repose.) in ("1","2","3","4","5","6","7") 
																and Acte_Activ = "1") 
						and f.ident not in (select ident from Mco&an.bd.diag where put(diag,$ISO_DIAGINF_excl.)="1" and typ_diag='5') 
																							THEN 1 ELSE 0 END  as Crit_multi_autre,
CASE WHEN f.ModeEntree in ("6","7","0") THEN 1 ELSE 0 END  as Crit_modeentree,
CASE WHEN f.anonyme in (select anonyme from chir_sui) and translate (f.ano_retour,"","0")="" THEN 1 ELSE 0 END  as Crit_chir_suivi,
CASE WHEN f.anonyme in (select anonyme from chir_pre_pose) and translate (f.ano_retour,"","0")=""  THEN 1 ELSE 0 END  as Crit_atcd,
CASE WHEN f.anonyme in (select anonyme from SP_sui  where translate (ano_retour,"","0")="" union select anonyme from sp_pre2) and translate (f.ano_retour,"","0")=""   THEN 1 ELSE 0 END  as Crit_SP,
CASE WHEN f.anonyme in (select anonyme from ioa_pre2) and translate (f.ano_retour,"","0")=""  THEN 1 ELSE 0 END	as Crit_infec_complexe,
CASE WHEN substr(f.CodeGeo,1,2) = "99" and f.CodeGeo ^= "99100" THEN 1 ELSE 0 END  as Crit_etranger,
CASE WHEN f.modesortie="9" and f.anonyme not in (select anonyme from Sej_Suivi_ISO_uq) THEN 1 ELSE 0 END  as Crit_deces,
CASE WHEN f.duree>90 THEN 1 ELSE 0 END  as Crit_90j,
CASE WHEN f.ident in (select ident from Mco&an.bd.diag where diag="Z532") THEN 1 ELSE 0 END  as Crit_fuite,

CASE WHEN calculated Crit_fuite+calculated Crit_90j+calculated Crit_deces+calculated Crit_etranger+calculated Crit_SP+calculated Crit_atcd
	+calculated Crit_chir_suivi+calculated Crit_modeentree+calculated Crit_multi_autre+calculated Crit_multi_pose+calculated Crit_urgence
	%if &loca.=pth %then %do ; +calculated Crit_fract %end; +calculated Crit_Dp_ISO+calculated Crit_Moins_18ans+calculated Crit_CMD_15+calculated Crit_CMD_14
	+calculated Crit_seances+calculated Crit_CMD90 + calculated Crit_chainage + calculated Crit_T846_7 + calculated Crit_T840_1 
+calculated Crit_infec_complexe =0 
	THEN 1 ELSE 0 END as ISO_ORTHO_CIBLE,

CASE WHEN f.anonyme in (select anonyme from Sej_Suivi_ISO_uq where translate (ano_retour,"","0")="") and translate (f.ano_retour,"","0")=""  THEN 1 ELSE 0 END as ISO_ORTHO_OBS,
iu.ISO_TYPE,
CASE WHEN iu.ident=f.ident and iu.annee="&annee." THEN 1 ELSE CASE WHEN iu.ident^="" THEN 2 ELSE . END END as ISO_RH,
iu.Finess_ISO = f.finessgeodp as ISO_M_ES,
iu.ano_date_iso-f.ano_date as Delai_ISO,
cats (iu.ident,iu.annee) as IdentA_ISO,
iu.Ano_date_ISO,
iu.Duree_ISO,
iu.Finess_ISO,
iu.Dp_ISO,
iu.Dr_ISO,
iu.ModeEntree_ISO,
iu.Provenance_ISO,
iu.ModeSortie_ISO,
iu.Destination_ISO,
iu.Mois_ISO,
iu.sej_pose,
riu.GHM2_ISO,
CASE WHEN f.anonyme in (select anonyme from obe_pose ) and translate (f.ano_retour,"","0")=""  THEN "1" ELSE "0" END as FR_OBE,
CASE WHEN f.anonyme in (select anonyme from maln_pose ) and translate (f.ano_retour,"","0")="" THEN "1" ELSE "0" END as FR_MALNUTRI,
CASE WHEN f.anonyme in (select anonyme from diab_pose ) and translate (f.ano_retour,"","0")="" THEN "1" ELSE "0" END as FR_DIABETE,
CASE WHEN f.anonyme in (select anonyme from tum ) and translate (f.ano_retour,"","0")="" THEN "1" ELSE "0" END as FR_TUMEUR_v2,
CASE WHEN f.anonyme in (select anonyme from PolyArt_pose ) and translate (f.ano_retour,"","0")=""  THEN "1" ELSE "0" END as FR_POLYARTRITE,
CASE WHEN f.anonyme in (select anonyme from DefImuCir_pose ) and translate (f.ano_retour,"","0")="" THEN "1" ELSE "0" END as FR_IMMU_CIRRHOSE,
CASE WHEN f.anonyme in (select anonyme from IOA_pose ) and translate (f.ano_retour,"","0")="" THEN "1" ELSE "0" END as FR_IOA_v2,
CASE WHEN f.anonyme in (select anonyme from Chir_pre_pose2 ) and translate (f.ano_retour,"","0")=""  THEN "1" ELSE "0" END as FR_CHIR_HG_v2,
CASE WHEN f.anonyme in (select anonyme from IRC_pose ) and translate (f.ano_retour,"","0")="" THEN "1" ELSE "0" END as FR_IRC,
CASE WHEN f.anonyme in (select anonyme from SejLD_pose ) and translate (f.ano_retour,"","0")="" THEN "1" ELSE "0" END as  FR_SEJ_PROL,
CASE WHEN f.anonyme in (select anonyme from FEC_pose ) and translate (f.ano_retour,"","0")="" THEN "1" ELSE "0" END as  FR_SOCIOECO,
raac

FROM Acte_cib_fst f
LEFT JOIN Mco&an.bd.rgp r ON f.ident=r.ident
LEFT JOIN (select ident,DPduRUM,type_RUM_1 from Mco&an.bd.um where rum="01") u ON u.ident=f.ident
LEFT JOIN (select anonyme,ano_date_iso,duree_iso as duree FROM Sej_suivi_tot 
	WHERE modesortie_iso="9" AND anonyme not in (select anonyme from Sej_Suivi_ISO_uq where modesortie_iso^="9")) sd ON sd.anonyme=f.anonyme
LEFT JOIN Sej_Suivi_ISO_uq iu on iu.anonyme=f.anonyme
LEFT JOIN (select fi.ident, annee, ghmv&ver. as GHM2_ISO 
	from Mco&an.bd.fixe fi 
	left join Mco&an.bd.rgp ri ON fi.ident=ri.ident 
		UNION select fi2.ident, annee, ghmv&ver. as GHM2_ISO  
	from Mco&an_plus1.bd.fixe fi2 
	left join Mco&an_plus1.bd.rgp ri2 ON fi2.ident=ri2.ident) riu 	ON iu.annee=riu.annee and iu.ident=riu.ident
LEFT JOIN Mco&an.bd.Finessgeo_umdudp fgud ON fgud.ident=f.ident

ORDER BY f.Anonyme, f.Ano_date;

QUIT;
%mend;


%sej_cible(&loca.,&an.);


/* Trier et ne garder que le premier séjour de pose par patient et UNIQUEMENT LES SEJOURS CIBLES */
/* (on veut d'abord prendre le premier séjour du patient, puis, ne le garder que s'il est séjour cible...) */

Data ISO_ORTHO_FR_0; 
Set Sej_cible_1_&loca.&an. ;
By Anonyme Ano_date;
If first.anonyme;
run;
data iso_ortho_fr; 
set iso_ortho_fr_0;
where ISO_ORTHO_CIBLE=1;
run;


/* 21_ Diagramme de flux */
PROC SQL;
CREATE TABLE Diag_Flux_Nat AS
SELECT distinct count(anonyme) as NbPat,
count (distinct finess) as NbES1,
count (CASE WHEN (Crit_CMD90 or Crit_chainage or Crit_seances or Crit_CMD_14 or Crit_CMD_15) THEN identA ELSE "" END) as NbExclu1,
CASE WHEN (Crit_CMD90 or Crit_chainage or Crit_seances or Crit_CMD_14 or Crit_CMD_15) THEN 1 ELSE 0  END as EstExcl1,
sum   (Crit_Moins_18ans) as Crit_Moins_18ans,
count (CASE WHEN calculated EstExcl1=0 and Crit_Moins_18ans=0 THEN identA ELSE "" END) as NbSej2,
count (distinct CASE WHEN calculated EstExcl1=0 and Crit_Moins_18ans=0 THEN finess ELSE "" END) as NbES2,
sum (CASE WHEN calculated EstExcl1=0 and Crit_Moins_18ans=0 THEN ISO_ORTHO_OBS ELSE 0 END) as Nb_iso_2,

sum (CASE WHEN calculated EstExcl1=0 and Crit_Moins_18ans=0 THEN Crit_Dp_ISO ELSE 0 END) as Crit_Dp_ISO,
sum (CASE WHEN calculated EstExcl1=0 and Crit_Moins_18ans=0 THEN Crit_T846_7 ELSE 0 END) as Crit_T846_7,
sum (CASE WHEN calculated EstExcl1=0 and Crit_Moins_18ans=0 THEN Crit_T840_1 ELSE 0 END) as Crit_T840_1,
%if &loca.=pth %then %do ; sum (CASE WHEN calculated EstExcl1=0 and Crit_Moins_18ans=0 THEN Crit_fract ELSE 0 END) as Crit_fract,%end;
sum (CASE WHEN calculated EstExcl1=0 and Crit_Moins_18ans=0 THEN Crit_urgence ELSE 0 END) as Crit_urgence,
sum (CASE WHEN calculated EstExcl1=0 and Crit_Moins_18ans=0 THEN Crit_multi_pose ELSE 0 END) as Crit_multi_pose,
sum (CASE WHEN calculated EstExcl1=0 and Crit_Moins_18ans=0 THEN Crit_multi_autre ELSE 0 END) as Crit_multi_autre,
sum (CASE WHEN calculated EstExcl1=0 and Crit_Moins_18ans=0 THEN Crit_modeentree ELSE 0 END) as Crit_modeentree,
sum (CASE WHEN calculated EstExcl1=0 and Crit_Moins_18ans=0 THEN Crit_chir_suivi ELSE 0 END) as Crit_chir_suivi,
sum (CASE WHEN calculated EstExcl1=0 and Crit_Moins_18ans=0 THEN Crit_atcd ELSE 0 END) as Crit_atcd,
sum (CASE WHEN calculated EstExcl1=0 and Crit_Moins_18ans=0 THEN Crit_SP ELSE 0 END) as Crit_SP,
sum (CASE WHEN calculated EstExcl1=0 and Crit_Moins_18ans=0 THEN Crit_infec_complexe ELSE 0 END) as Crit_infec_complexe,
sum (CASE WHEN calculated EstExcl1=0 and Crit_Moins_18ans=0 THEN Crit_etranger ELSE 0 END) as Crit_etranger,
sum (CASE WHEN calculated EstExcl1=0 and Crit_Moins_18ans=0 THEN Crit_deces ELSE 0 END) as Crit_deces,
sum (CASE WHEN calculated EstExcl1=0 and Crit_Moins_18ans=0 THEN Crit_90j ELSE 0 END) as Crit_90j,
sum (CASE WHEN calculated EstExcl1=0 and Crit_Moins_18ans=0 THEN Crit_Fuite ELSE 0 END) as Crit_Fuite,

count(CASE WHEN calculated EstExcl1=0 and Crit_Moins_18ans=0 and (Crit_Dp_ISO=1 %if &loca.=pth %then %do ; or Crit_fract=1 %end; or  Crit_urgence=1 or  Crit_multi_pose=1 or 
Crit_multi_autre=1 or Crit_modeentree=1 or Crit_chir_suivi=1 or Crit_atcd=1 or Crit_SP=1 or Crit_etranger=1 or Crit_deces=1 or Crit_90j=1 or 
Crit_Fuite=1) THEN identA ELSE "" END) as NbExcl2,
round(calculated NbExcl2*100/calculated NbSej2,1) as SejExcl_pct,
sum(ISO_ORTHO_CIBLE) as SejCible,
count (distinct CASE WHEN finess in (select finess FROM (SELECT finess, sum(ISO_ORTHO_CIBLE)as NbSejCib FROM ISO_ORTHO_FR_0 GROUP BY finess)where NbSejCib>0)
				THEN finess ELSE "" END) as NbESsejCib,

sum(case when ISO_ORTHO_CIBLE then ISO_ORTHO_OBS else 0 end) as NbIso,
calculated NbIso / calculated SejCible as Pctiso_cible,
sum(sej_pose=0 and ISO_ORTHO_CIBLE and ISO_ORTHO_OBS ) / calculated NbIso as PctIsoHSPos,

count (distinct CASE WHEN finess in (select finess FROM (SELECT finess, sum(ISO_ORTHO_CIBLE)as NbSejCib FROM ISO_ORTHO_FR_0 GROUP BY finess)where NbSejCib>9)
				THEN finess ELSE "" END) as NbESMin10,
count (distinct CASE WHEN finess in (select finess FROM (SELECT finess, sum(ISO_ORTHO_CIBLE)as NbSejCib FROM ISO_ORTHO_FR_0 GROUP BY finess)where NbSejCib<10 and NbSejCib>0)
				THEN finess ELSE "" END) as NbESMoins10 ,
sum (CASE WHEN finess in (select finess FROM (SELECT finess, sum(ISO_ORTHO_CIBLE)as NbSejCib FROM ISO_ORTHO_FR_0 GROUP BY finess)where NbSejCib<10 and NbSejCib>0)
				THEN ISO_ORTHO_CIBLE ELSE 0 END) as NbSej_ESMoins10,
sum (CASE WHEN finess in (select finess FROM (SELECT finess, sum(ISO_ORTHO_CIBLE)as NbSejCib FROM ISO_ORTHO_FR_0 GROUP BY finess)where NbSejCib<10 and NbSejCib>0)
				THEN ISO_ORTHO_CIBLE and ISO_ORTHO_OBS ELSE 0 END) as NbISO_ESMoins10,

sum (CASE WHEN finess in (select finess FROM (SELECT finess, sum(ISO_ORTHO_CIBLE)as NbSejCib FROM ISO_ORTHO_FR_0 GROUP BY finess)where NbSejCib>9)
				THEN ISO_ORTHO_CIBLE ELSE 0 END) as NbSej_ESMin10,
sum (CASE WHEN finess in (select finess FROM (SELECT finess, sum(ISO_ORTHO_CIBLE)as NbSejCib FROM ISO_ORTHO_FR_0 GROUP BY finess)where NbSejCib>9)
				THEN ISO_ORTHO_CIBLE and ISO_ORTHO_OBS ELSE 0 END) as NbIso_ESMin10,
sum (CASE WHEN finess in (select finess FROM (SELECT finess, sum(ISO_ORTHO_CIBLE)as NbSejCib FROM ISO_ORTHO_FR_0 GROUP BY finess)where NbSejCib>9)
				and sej_pose=0 THEN ISO_ORTHO_CIBLE and ISO_ORTHO_OBS ELSE 0 END) as NbIsoHSP_ESMin10,
calculated NbIsoHSP_ESMin10 / calculated  NbIso_ESMin10 as PctIsoHSPos_ESMin10,
sum (CASE WHEN finess in (select finess FROM (SELECT finess, sum(ISO_ORTHO_CIBLE)as NbSejCib FROM ISO_ORTHO_FR_0 GROUP BY finess)where NbSejCib>9)
				and ISO_M_ES=1 THEN ISO_ORTHO_CIBLE and ISO_ORTHO_OBS ELSE 0 END) as NbIsoME_ESMin10,
calculated NbIsoME_ESMin10/ calculated NbIso_ESMin10 as PctIsoME_ESMin10


FROM ISO_ORTHO_FR_0
;
QUIT;

PROC SORT data=diag_flux_Nat (drop=estexcl1) nodupkey;by _all_; run;


/* 22_ Standardisation (regression linéaire pour récupérer les coefficients) */
Data model;
set ISO_ORTHO_FR;
ISO= put(ISO_ORTHO_OBS,1.0);
run;

ods graphics on;
ods output OddsRatios=odds_&an.; /* Pour récupérer les oddsratio et leur intervalle de confiance */
proc logistic data= model plots(maxpoints=none);
	class Sexe(ref='2') FR_OBE (ref='0') FR_MALNUTRI (ref='0') FR_DIABETE (ref='0') 
		FR_TUMEUR_v2 (ref='0') FR_POLYARTRITE (ref='0') FR_IMMU_CIRRHOSE (ref='0') 
		FR_IOA_v2 (ref='0') FR_CHIR_HG_v2 (ref='0') FR_IRC (ref='0') 
		FR_SEJ_PROL (ref='0') FR_SOCIOECO (ref='0') / param=ref;
	model ISO (event='1') = Sexe  FR_OBE FR_MALNUTRI FR_DIABETE 
		FR_TUMEUR_v2 FR_POLYARTRITE FR_IMMU_CIRRHOSE 
		FR_IOA_v2 FR_CHIR_HG_v2 FR_IRC FR_SEJ_PROL FR_SOCIOECO / link=logit outroc=troc lackfit ;
	output out = prob (keep=Finess Finess_pmsi IdentA prob ISO_ORTHO_OBS ISO_ORTHO_CIBLE sej_pose iso_m_es) prob=prob;
run;


/* 23_ Base de données par établissement */
/* Table puis format pour récupérer l'IPE */

/* CREER une table FIGEOBIS, pour pouvoir ne garder qu'une ligne par finessgeo|annee|finess_pmsi
(parce que par exemple le finessgeo 090001629 a 2 finess_pmsi en 2017 -> on va prendre le 1er)*/
PROC SQL;
CREATE TABLE FiGeoBis AS
SELECT * 
FROM nom_gen.finessgeo 
WHERE annee="&annee" and 
		((categ_pmsi in ("CH","CHR/U") and niveau_pmsi="J") 
   or   ((categ_pmsi in ("Privé","PSPH/EBNL","CLCC") or rs like "HÔPITAL D'INSTRUCTION%") and niveau_pmsi="G")
   or finessgeo in ("750150237","750150260","840019079"))
   or finessgeo = "560029068" ;
QUIT;
PROC SORT Data=FiGeoBis; by finessgeo; run;
DATA FiGeoBis ; SET FiGeoBis; by finessgeo; if first.finessgeo; run;
PROC SQL;
CREATE TABLE FiGeoBis AS
SELECT * FROM FiGeoBis
UNION
SELECT * From nom_gen.finessgeo 
WHERE annee="&annee" and ((finessgeo="910000306" and finess_pmsi="910110063") or (finessgeo="360000160" and finess_pmsi="360000079"))
UNION
SELECT * From nom_gen.finessgeo 
WHERE annee="2019" and finessgeo="310009279" 
;
QUIT; /* sinon on perd le finess_pmsi  "910110063" car en 2017 le finessgeo "910000306" est aussi rattaché à "910110055" 
		et c'est uniquement cette ligne qui ressort */

data tt (keep = fmtname start label hlo );
	length fmtname $20 start $9 label $77 hlo $1;
	set FiGeoBis ;

	if mco ="O" then ;
	
	fmtname = "$ipe";
	start = finessgeo;
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

/***************************************************************************/
* Calculs au niveau national => enregistrés dans des macros variables ;
proc sql noprint;
	select distinct (sum(ISO_ORTHO_OBS)/sum(ISO_ORTHO_CIBLE)) *100 into: ISO_ORTHO_TXOBS_NAT from ISO_ORTHO_FR;
	select distinct sum (ISO_ORTHO_CIBLE)  into: ISO_ORTHO_&loca._NAT from ISO_ORTHO_FR;
	select distinct sum(ISO_ORTHO_CIBLE) into:ISO_ORTHO_CIBLE_NAT  from ISO_ORTHO_FR;
	select distinct sum(ISO_ORTHO_OBS) into: ISO_ORTHO_OBS_NAT  from ISO_ORTHO_FR;
	select distinct sum(raac="1") into: NB_RAAC_NAT from ISO_ORTHO_FR;
	select distinct (sum(raac="1")/sum(ISO_ORTHO_CIBLE)) *100 into: PCT_RAAC_NAT from ISO_ORTHO_FR;
quit;

/* Macro-table pour les calculs sur les FR */
%Macro MV_FR(fr);
	proc sql ;
	create table NatFR1_&an. as
		select "&fr" as FACTEUR_RISQUE length=18,sum(CASE WHEN &fr="1" THEN iso_ortho_cible ELSE 0 END)  as NB_SEJ_NAT ,
		calculated NB_SEJ_NAT/sum(iso_ortho_cible)*100 as TX_SEJ_NAT

from ISO_ORTHO_FR;
	quit;

	Proc append base=NatFr_&an. data=NatFR1_&an.;quit;
%Mend;
%MV_FR(sexe);
%MV_FR(FR_OBE);
%MV_FR(FR_MALNUTRI);
%MV_FR(FR_DIABETE);
%MV_FR(FR_TUMEUR_v2);
%MV_FR(FR_POLYARTRITE);
%MV_FR(FR_IMMU_CIRRHOSE);
%MV_FR(FR_IOA_v2);
%MV_FR(FR_CHIR_HG_v2);
%MV_FR(FR_IRC);
%MV_FR(FR_SEJ_PROL);
%MV_FR(FR_SOCIOECO);

%Macro ES_FR(fr);
	proc sql ;
	create table ESFR1_&an. as
		select finess, "&fr" as FACTEUR_RISQUE length=18,
		sum(CASE WHEN &fr="1" THEN iso_ortho_cible ELSE 0 END)  as NB_SEJ_ETBT,
		calculated NB_SEJ_ETBT/sum(iso_ortho_cible)*100 as	TX_SEJ_ETBT
	from ISO_ORTHO_FR
		group by finess;
	quit;

	Proc append base=esFr_&an. data=esFR1_&an.;quit;
%Mend;
%ES_FR(sexe);
%ES_FR(FR_OBE);
%ES_FR(FR_MALNUTRI);
%ES_FR(FR_DIABETE);
%ES_FR(FR_TUMEUR_v2);
%ES_FR(FR_POLYARTRITE);
%ES_FR(FR_IMMU_CIRRHOSE);
%ES_FR(FR_IOA_v2);
%ES_FR(FR_CHIR_HG_v2);
%ES_FR(FR_IRC);
%ES_FR(FR_SEJ_PROL);
%ES_FR(FR_SOCIOECO);


* Calcul par ES;
proc sql;
	create table ISO_ORTHO_ETBT_0 as select distinct 
		CASE WHEN p.Finess in (select finessgeo from figeobis where finess_pmsi in ("750712184","690781810","130786049")) 
			THEN f.finess ELSE put(p.finess, $ipe.) END as IPE,
		p.Finess, 
		p.finess_pmsi,
		fg.rs as RS_Finess, 
		put(cats(p.finess_pmsi,&annee.),$finess_rs.) as RS_Finess_pmsi, 
		case when put(cats(p.finess_pmsi,&annee.),$finess_categ.)="CHR/U" then "CHU" else 
				put(cats(p.finess_pmsi,&annee.),$finess_categ.) end  as categ_pmsi,
		put(cats(p.finess_pmsi,&annee.),$finess_secteur.)  as secteur_pmsi,
		put(put(p.finess,$region.),$reg_lib.) as region,
		put(p.finess,$region.) as code_reg,
		sum(ISO_ORTHO_CIBLE) as ISO_ORTHO_CIBLE_ETBT,
		sum(ISO_ORTHO_OBS) as ISO_ORTHO_OBS_ETBT,  
		mean(ISO_ORTHO_OBS)*100 as ISO_ORTHO_TXOBS_ETBT,
		sum(ISO_M_ES) as NB_ISO_MES_ETBT,
		sum(sej_pose) as NB_ISO_SEJ_POSE_ETBT,
		sum(prob) as ISO_ORTHO_ATT_ETBT,
		mean(prob)*100 as ISO_ORTHO_TXATT_ETBT, 
		(calculated ISO_ORTHO_OBS_ETBT / calculated ISO_ORTHO_ATT_ETBT) as ISO_ORTHO_ETBT, 
		(calculated ISO_ORTHO_ETBT)*&ISO_ORTHO_TXOBS_NAT.  as ISO_ORTHO_TXAJUST_ETBT,
		&ISO_ORTHO_CIBLE_NAT. as ISO_ORTHO_CIBLE_NAT,
		&ISO_ORTHO_OBS_NAT. as ISO_ORTHO_OBS_NAT,
		&ISO_ORTHO_TXOBS_NAT. as ISO_ORTHO_TXOBS_NAT,
			
		sum(raac="1") as NB_RAAC_ETBT,
		mean(raac="1")*100 as PCT_RAAC_ETBT,
		&NB_RAAC_NAT. as NB_RAAC_NAT,
		&PCT_RAAC_NAT. as PCT_RAAC_NAT

	FROM prob p
	LEFT JOIN Mco&an.bd.fixe f ON f.ident=substr(p.identA,1,6)
	LEFT JOIN figeobis fg ON fg.finessgeo=p.finess

	group by p.finess;
quit;


/* 24_ Funnel plot */

%macro Funnel_plot (Table, loi, DS, titre);

	/********** Calcul des taux **********/

	/* Calcul des limites sur le nb_attendus par ES*/

	proc iml;
		use &Table.; /* Ouverture de la table SAS */
		read all var {ISO_ORTHO_ATT_ETBT}; /* Lecture */
		close &Table.; /* Fermeture de la table SAS */

		p = {0.001 0.025 0.975 0.999};
		limits = j(nrow(ISO_ORTHO_ATT_ETBT),ncol(p)); /* J contient le nbre d'ES et le nombre de p possibles*/

		/* calcul des bornes */
		do i = 1 to ncol(p);
			r = quantile ("&loi.", p[i], ISO_ORTHO_ATT_ETBT); /* Quantiles de la loi de Poisson */
			nb_observe_tot = cdf ("&loi.",r,ISO_ORTHO_ATT_ETBT) - p[i]; /* CDF : Fonction de distribution */
			nb_cible_tot = cdf ("&loi.",r,ISO_ORTHO_ATT_ETBT) - cdf("&loi.",r-1,ISO_ORTHO_ATT_ETBT);
			alpha = nb_observe_tot/nb_cible_tot;
			limits[,i] = (r-alpha)/ISO_ORTHO_ATT_ETBT;
		end;

		/* creation de la table des bornes */
		results = ISO_ORTHO_ATT_ETBT || limits;
		labels = {"Nb_attendu" "L3sd" "L2sd" "U2sd" "U3sd"};
		create Limits from results[colname=labels];
		append from results;
		close;
	quit;
	
	/* CALCUL DES LIMITES REGULIERES */
	proc iml;
		use &Table.;
		read all var {ISO_ORTHO_ATT_ETBT};
		close &Table.;
		minN = 0.1;
		maxN = max(ISO_ORTHO_ATT_ETBT);
		x = t(do(minN, maxN, 0.1));
		p = {0.001 0.025 0.975 0.999};
		limits=j(nrow(x),ncol(p));

		
		do i=1 to ncol(p);
			r = quantile ("&loi.",p[i],x);
			cdfr = cdf ("&loi.",r,x);
			cdfr1 = cdf("&loi.",r-1,x);
			nb_observe_tot = cdfr-p[i];
			nb_cible_tot = cdfr - cdfr1;
			alpha = nb_observe_tot/nb_cible_tot;
			limits[,i] = (r-alpha)/x;
		end;
		
		results = x ||limits;
		labels = {"x" "L3sdx" "L2sdx" "U2sdx" "U3sdx"};
		create Limits_regul from results[colname=labels];
		append from results;
		close;
	quit;


	data Results;
		merge &Table. Limits Limits_regul;
	run;


	* Définition des ES en Alerte;
	data Results;
		set Results;

if round(ISO_ORTHO_ATT_ETBT,0.01)<=0.02 then U3sd=249.9998332;
if round(ISO_ORTHO_ATT_ETBT,0.0001)<=0.0514 then U2sd=10.0021931; 

		if ISO_ORTHO_ETBT >  U3sd then interval = "1";
		if ISO_ORTHO_ETBT >= U2sd and ISO_ORTHO_ETBT <= U3sd then interval = "2";
		if ISO_ORTHO_ETBT >  L2sd and ISO_ORTHO_ETBT < U2sd then interval = "3";
		if ISO_ORTHO_ETBT >= L3sd and ISO_ORTHO_ETBT <= L2sd then interval = "4";
		if ISO_ORTHO_ETBT < L3sd then interval = "5";
		interval_plot = 0;
		if ISO_ORTHO_ETBT > U&DS.sd or ISO_ORTHO_ETBT < L&DS.sd then interval_plot = 1;
		ISO_ORTHO_POS_SEUIL_ETBT = "(=)";
		if interval in ("1","2") and interval_plot = 1 then ISO_ORTHO_POS_SEUIL_ETBT = "(+)";
		if interval in ("5","4") and interval_plot = 1 then ISO_ORTHO_POS_SEUIL_ETBT = "(-)";
		if ISO_ORTHO_CIBLE_ETBT < 10 then ISO_ORTHO_POS_SEUIL_ETBT = "";* Les ES avec 0 < nb_cible < 9 ne sont pas mis en alerte;
	run;


	/********** Funnel Plots **********/
	/* Connaitres les bornes inf et sup pour tracer le funnel plot */
	proc sql noprint;
		select max(ISO_ORTHO_ATT_ETBT) into : Abscisse_max
		from Results;
		select max(ISO_ORTHO_ETBT) into : Ordonnee_max
		from Results;
	quit;
	%let O_max = %sysevalf(&Ordonnee_max.,ceil);
	%let A_max = %sysevalf(&Abscisse_max.,ceil);

	title  "Ratio O/A des &titre.";
	title2 "Données PMSI &annee. (ES avec au moins 10 séjours cibles)";
	proc sgplot data = Results;
	 	styleattrs DataContrastColors = (cx0000FF cxFF0000);
		band x = x lower = L&DS.sdx upper = U&DS.sdx / nofill lineattrs = (pattern = Dash color=black) legendlabel = "&DS.DS limits" name = "band99";
		refline 1 / axis=y lineattrs=(color=red) legendlabel="Cible" name="cible";
		scatter x = ISO_ORTHO_ATT_ETBT y = ISO_ORTHO_ETBT / group = interval_plot TRANSPARENCY = 0.4 markerattrs=(symbol=CircleFilled size=5);
		keylegend "band99" "cible" / location = inside down = 2 position = topright;
		yaxis grid values = (-1 to &o_max. by 1)label='Ratio observé / attendu';     
		xaxis grid label = 'Nombre de cas attendus' values = (0 to &a_max. by 0.1);      
		where ISO_ORTHO_CIBLE_ETBT >= 10;   
	run;

%mend Funnel_plot;

%Funnel_plot (ISO_ORTHO_ETBT_0, poisson, 3, ISO après pose de &loca.);


/* 25_ Compléter la table établissement avec les données du funnel plot */

PROC SQL;
CREATE TABLE ISO_ORTHO_ETBT AS
SELECT a.*,
	CASE WHEN a.ISO_ORTHO_CIBLE_ETBT < 10 then "" ELSE
		CASE WHEN res.ISO_ORTHO_ETBT<L3sd THEN "A" ELSE (CASE WHEN res.ISO_ORTHO_ETBT>U3sd THEN "C" ELSE 
					(CASE WHEN res.ISO_ORTHO_ETBT ^=. THEN "B" ELSE "" END) END) END END AS ISO_ORTHO_POS_SEUIL_ETBT,
	CASE WHEN a.ISO_ORTHO_CIBLE_ETBT < 10 then "" ELSE
		CASE WHEN res.ISO_ORTHO_ETBT<L2sd THEN "A" ELSE (CASE WHEN res.ISO_ORTHO_ETBT>U2sd THEN "C" ELSE 
					(CASE WHEN res.ISO_ORTHO_ETBT ^=. THEN "B" ELSE "" END) END) END END AS ISO_ORTHO_2DS_ETBT,
	CASE WHEN a.ISO_ORTHO_CIBLE_ETBT < 10 then "" ELSE
		CASE WHEN res.ISO_ORTHO_ETBT<L3sd THEN "1" ELSE 
			CASE WHEN res.ISO_ORTHO_ETBT<L2sd THEN "2" ELSE 
				CASE WHEN res.ISO_ORTHO_ETBT<U2sd THEN "3" ELSE 
					CASE WHEN res.ISO_ORTHO_ETBT<U3sd THEN "4" ELSE 
						CASE WHEN res.ISO_ORTHO_ETBT>U3sd THEN "5" ELSE "" END END END END END END AS ISO_ORTHO_2DS_3DS_ETBT,
L3sd as Limite_Basse,
U3sd as Limite_Haute

FROM ISO_ORTHO_ETBT_0 a LEFT JOIN Results res on res.finess=a.finess;
QUIT;


/* 26_ Table FR_QUALHAS  */

/*26_a_ Mettre en forme Odds */
Data Odds_&an.;
Set Odds_&an. ;
var=scan(Effect,1);
run;

/*26_b_ Compiler les 3 tables nécessaires */
PROC SQL;
CREATE TABLE FR_QUALHAS AS
SELECT put(a.finess,$ipe.) as IPE, a.finess, ioe.finess_pmsi,ioe.rs_finess,ioe.rs_finess_pmsi,
ioe.categ_pmsi,ioe.region,ioe.code_reg,
esfr_&an..facteur_risque, OddsRatioEst as OR, UpperCL as IC_haut, LowerCl as IC_bas,
tx_sej_nat,nb_sej_nat, nb_sej_etbt,tx_sej_etbt
from esfr_&an. a
left join Odds_&an. o on o.var=esfr_&an..facteur_risque
left join natfr_&an. on natfr_&an..facteur_risque=esfr_&an..facteur_risque
left join iso_ortho_etbt ioe on ioe.finess=esfr_&an..finess
order by finess; 
QUIT;


/* 27_  Diag flux par etab */

proc sql;
     create table ISO_ORTHO_Part_&an. as select distinct 
		CASE WHEN a.Finess in (select finessgeo from figeobis where finess_pmsi in ("750712184","690781810","130786049")) 
			THEN f.finess ELSE put(a.finess, $ipe.) END as IPE,
		a.Finess, 
		a.finess_pmsi,
		fg.rs as RS_Finess, 
		put(cats(a.finess_pmsi,&annee.),$finess_rs.) as RS_Finess_pmsi, 
		case when put(cats(a.finess_pmsi,&annee.),$finess_categ.)="CHR/U" then "CHU" else 
				put(cats(a.finess_pmsi,&annee.),$finess_categ.) end  as categ_pmsi,
		put(cats(a.finess_pmsi,&annee.),$finess_secteur.)  as secteur_pmsi,
		put(put(a.finess,$region.),$reg_lib.) as region,
		put(a.finess,$region.) as code_reg,

		count(*) as NbSej_&loca.,
        count (case when (Crit_CMD90 = 1 or Crit_chainage = 1 or Crit_Seances = 1 or Crit_CMD_14 = 1 or Crit_CMD_15 = 1) 
                then identA else "" end) as NbSej_Erreur,
        sum(Crit_Moins_18ans) as NbSej_Moins_18ans, 
        count (case when (Crit_CMD90 ^= 1 and Crit_chainage ^= 1 and Crit_Seances ^= 1 and Crit_CMD_14 ^= 1 and Crit_CMD_15 ^= 1 and Crit_Moins_18ans ^= 1) 
                then identA else "" end) as NbSej_Etude,
        sum(case when (Crit_CMD90 ^= 1 and Crit_chainage ^= 1 and Crit_Seances ^= 1 and Crit_CMD_14 ^= 1 and Crit_CMD_15 ^= 1 and Crit_Moins_18ans ^= 1  ) 
                then iso_ortho_obs else 0 end) as Nb_ISO_Etude,
        sum(Crit_DP_ISO) as NbSej_DP_ISO_v2, 
		sum(Crit_T846_7) as NbSej_T846_7,
		sum(Crit_T840_1) as NbSej_T840_1,
%if &loca.=pth %then %do ; sum(Crit_fract) as NbSej_fract_v2,%end; sum(Crit_urgence) as NbSej_urgence_v2,
        sum(Crit_multi_pose) as NbSej_multi_pose, sum(Crit_Multi_autre) as NbSej_Multi_autre_v2, sum(Crit_ModeEntree) as NbSej_ModeEntree,
        sum(Crit_chir_Suivi) as NbSej_CHIR_Suivi_v2, sum(Crit_ATCD) as NbSej_ATCD_v2, sum(Crit_SP) as NbSej_SP, 
		sum(Crit_infec_complexe) as NbSej_infec_complexe,
		sum(Crit_etranger) as NbSej_etranger,
        sum(Crit_deces) as NbSej_deces, sum(Crit_90j) as NbSej_90j, sum(Crit_fuite) as NbSej_fuite,

        count(case when (Crit_CMD90 ^= 1 and Crit_chainage ^= 1 and Crit_Seances ^= 1 and Crit_CMD_14 ^= 1 and Crit_CMD_15 ^= 1 and Crit_Moins_18ans ^= 1)
                and (Crit_DP_ISO = 1 %if &loca.=pth %then %do ; or Crit_fract = 1 %end; or Crit_urgence = 1 or Crit_multi_pose = 1 or Crit_Multi_autre = 1 
                or Crit_ModeEntree = 1 or Crit_chir_Suivi = 1 or Crit_ATCD = 1 or Crit_SP = 1 or Crit_etranger = 1 or Crit_deces = 1 
                or Crit_90j = 1 or Crit_fuite = 1) 
                then identA else "" end) as NbSej_Exclus,
          (calculated NbSej_Exclus) / (calculated NbSej_Etude)*100 as PctSej_Exclus,
          count (case when (Crit_CMD90 ^= 1 and Crit_chainage ^= 1 and Crit_Seances ^= 1 and Crit_CMD_14 ^= 1 and Crit_CMD_15 ^= 1 and Crit_Moins_18ans ^= 1
                and Crit_DP_ISO ^= 1 %if &loca.=pth %then %do ; and Crit_fract ^= 1 %end; and Crit_urgence ^= 1 and  Crit_multi_pose ^= 1 and Crit_Multi_autre ^= 1 
                and Crit_ModeEntree ^= 1 and Crit_chir_Suivi ^= 1 and Crit_ATCD ^= 1 
                and Crit_SP ^= 1 and Crit_etranger ^= 1 and Crit_deces ^= 1 and Crit_90j ^= 1 and Crit_fuite ^= 1 and Crit_T846_7^= 1 and Crit_T840_1^= 1 
				and Crit_infec_complexe^=1) 
                then identA else "" end) as ISO_&loca._CIBLE_ETBT
       
     from ISO_ORTHO_fr_0 a
     left join mco&an.bd.fixe f on f.ident=substr(a.identa,1,6)
     left join figeobis fg ON fg.finessgeo=a.finess 
	
group by a.finess;
quit;

/* 28_ Sortie (sauvegarde) des tables */


/* Rendu 1 : diag flux */
Data sortie.Diag_flux_&loca.&an.;
Set diag_flux_nat; run;

/* Rendu 2 : Iso_ortho (sej cibles) */
%let let=%sysfunc(substr(&loca.,3,1));
Data sortie.T_INDI_ISO_&loca._MCO_&an. 
(rename = (ISO_ORTHO_CIBLE=ISO_&loca._CIBLE ISO_ORTHO_OBS=ISO_&loca._OBS 
	Synovectomie_&loca. = Synovectomie_&let. ));
Set ISO_ORTHO_FR ;
drop sej_pose;
run;

/* Rendu 3 : iso_ortho_etbt (base étab) */
Data sortie.T_ETBT_ISO_&loca._MCO_&an. (rename = (
	ISO_ORTHO_CIBLE_ETBT=ISO_&loca._CIBLE_ETBT
	ISO_ORTHO_OBS_ETBT=ISO_&loca._OBS_ETBT
	ISO_ORTHO_TXOBS_ETBT=ISO_&loca._TXOBS_ETBT
	ISO_ORTHO_ATT_ETBT=ISO_&loca._ATT_ETBT
	ISO_ORTHO_TXATT_ETBT=ISO_&loca._TXATT_ETBT
	ISO_ORTHO_ETBT=ISO_&loca._ETBT
	ISO_ORTHO_TXAJUST_ETBT=ISO_&loca._TXAJUST_ETBT
	ISO_ORTHO_CIBLE_NAT=ISO_&loca._CIBLE_NAT
	ISO_ORTHO_OBS_NAT=ISO_&loca._OBS_NAT
	ISO_ORTHO_TXOBS_NAT=ISO_&loca._TXOBS_NAT
	ISO_ORTHO_POS_SEUIL_ETBT=ISO_&loca._POS_SEUIL_ETBT
	ISO_ORTHO_2DS_ETBT=ISO_&loca._2DS_ETBT
	ISO_ORTHO_2DS_3DS_ETBT=ISO_&loca._2DS_3DS_ETBT
));
Set ISO_ORTHO_ETBT;
IF NB_ISO_SEJ_POSE_ETBT=. then NB_ISO_SEJ_POSE_ETBT=0;
IF NB_ISO_MES_ETBT=. then NB_ISO_MES_ETBT=0;
run;
