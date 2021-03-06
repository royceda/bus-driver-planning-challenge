/*********************************************
 * OPL 12.6.0.0 Model
 * Author: Charlie Brown
 * Creation Date: 10 janv. 2016 at 19:14:48
 *********************************************/

 int T = ...;
 int n = ...;
 int m = ...;
 
 int pm [1..n][1..T] = ...;//preference matin
 int pa [1..n][1..T] = ...;//preference aprem
 int pd [1..n][1..T] = ...;//preference day off
 int d[1..n][1..T] = ...; // jour de cong�s matin

int z[1..n][1..m] = ...;// le chauffeur i travail dans la ligne j


 
 dvar int x[1..n][1..T] in (0..1); //le chauffeur i travail le matin de la p�riode j
 dvar int y[1..n][1..T] in (0..1);// le chauffeur i travail l'aprem de la periode j
 
 dvar int b[1..n][1..T][1..m] in (0..1); //le chauffeur i a le bus k a j
 
 
 maximize sum(i in 1..n) ( sum(j in 1..n) ( pm[i][j]*x[i][j] + pa[i][j]*y[i][j] + pd[i][j]*(2 - x[i][j] + y[i][j])));
 //+ sum(i in 1..n)( sum (j in 1..T) sum (k in 1..m) (b[i][j][k]));//min de nb litiges

 
 subject to{
  	forall(i in 1..n, j in 1..T){
  	 	ct1 : x[i][j] + y[i][j] <= 1; //matin, aprem ou cong�s
  	 	ct41: x[i][j] + d[i][j] <= 1; //cong�s matin
   		ct42: y[i][j] + d[i][j] <= 1; //cong�s aprem
   }  	 	
  	 
  	 forall(i in 1..n, j in 1..T-1){
  	 	ct2: y[i][j] + x[i][j+1] <= 1; //aprem puis matin impossible
   }  	

	forall(i in 1..n, j in 1..T-3){
   		ct3: y[i][j] + y[i][j+1] + y[i][j+2] + y[i][j+3] <= 3; // pas plus de 3 nuit de suite
   }



	forall(i in 1..n){
		ct5: sum(j in 1..T) y[i][j] == 4; // 4 nuits pour les 2 semaines	pour chacun
	}
  	 	
  	forall(j in 1..T, i in 1..n, k in 1..m ){
   		ct8: b[i][j][k] <= z[i][k]; // au moins une ligne dans les dispo 
   		//ct81: sum(i in 1..n) b[i][j][k]*z[i][k] <= 1; // 1 lignes par chauffeur et par periode  
   }
  	 	
  	 	
  	 	  
   forall(j in 1..T, i in 1..n){
  	 ct6: sum(k in 1..m) b[i][j][k] == 1; //1 bus par chauffeur et par periode
 	}   
  	 	
  	 	
  	 	
  	//forall(j in 1..T){
		//ct61: sum(i in 1..n) y[i][j] >= 3; // service assur� chaque jour pour les 3 lignes	
		//ct62: sum(i in 1..n) x[i][j] >= 3; // service assur� chaque jour pour les 3 lignes	
	//}
  	 
  	  	 	
   
   
   
   //cas ou faut affecter les skills
   //forall(k in 1..m, i in 1..n){
   	//ct7: sum(j in 1..T) b[i][j][k] == 2; //2 chauffeur par lignes et par periode
   //}
   
   
 
   
   forall(j in 1..T, k in 1..m){
     //ct91: sum(i in 1..n) (x[i][j]*z[i][k]) >= 1; //une affect par ligne et par jour : matin
     ct91: sum(i in 1..n) (x[i][j]*b[i][j][k]) >= 1; //une affect par ligne et par jour : matin
     //ct92: sum(i in 1..n) (y[i][j]*z[i][k]) >= 1;	//une affect par ligne et par jour : aprem
     ct92: sum(i in 1..n) (y[i][j]*b[i][j][k]) >= 1;	//une affect par ligne et par jour : aprem
 	
 	
 	}   
   
 }