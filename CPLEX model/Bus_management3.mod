/*********************************************
 * OPL 12.6.0.0 Model
 * Author: Charlie Brown
 * Creation Date: 22 janv. 2016 at 17:51:39
 *********************************************/

 
 int T = ...;
 int n = ...;
 int m = ...;
 
 {string} team = ...;
 
 {int} pref_m[i in team] = ...;
 {int} pref_a[i in team] = ...;
 {int} pref_d[i in team] = ...;
 {int} tab_z[i in team]  = ...;
 {int} tab_d[i in team]  = ...;
 
 
 
 int pm [i in team][1..T] = ...;//preference matin
 int pa [i in team][1..T] = ...;//preference aprem
 int pd [i in team][1..T] = ...;//preference day off
 int d  [i in team][1..T] = ...; // jour de congés
 int z  [i in team][1..m] = ...;// le chauffeur i connait la ligne j


execute da{

	for(var i in team){
		for(var l in pref_m[i]){
			pm[i][l] = 1;
		}
		
		for(var l in pref_a[i]){
			pa[i][l] = 1;
		}
		
		for(var l in pref_d[i]){
			pd[i][l] = 1;
		}
		
		for(var l in tab_z[i]){
			z[i][l] = 1;
		}
		
		for(var l in tab_d[i]){
			d[i][l] = 1;
		}
	}
}
 
 dvar int x[i in team][1..T] in (0..1); //le chauffeur i travail le matin de la période j
 dvar int y[i in team][1..T] in (0..1);// le chauffeur i travail l'aprem de la periode j
 
 dvar int b1[i in team][1..T][1..m] in (0..1);// le chauffeur i conduit k le matin à j
 dvar int b2[i in team][1..T][1..m] in (0..1);// le chauffeur i conduit k laprem à j
 
 
 maximize sum(i in team, j in 1..T)(pm[i][j]*x[i][j] + pa[i][j]*y[i][j]  + pd[i][j]*(2 - x[i][j] - y[i][j]));

 
 subject to{
  	forall(i in team, j in 1..T){
  	 ct1: x[i][j] + y[i][j] + d[i][j] <= 1; // nuit, jour ou dayoff
   }  	 	
  	 
  	 forall(i in team, j in 1..T-1){ 
  	 	ct2: (y[i][j] + x[i][j+1]) <= 1; //aprem puis matin impossible
   }  	

	forall(i in team, j in 1..T-3){
   		ct3: (y[i][j] + y[i][j+1] + y[i][j+2] + y[i][j+3]) <= 3; // pas plus de 3 nuit de suite
   }

	forall(i in team){ //parfois relaxée
		ct4: sum(j in 1..T) y[i][j] <= 4; // 4 nuits pour les 2 semaines	pour chacun
	}
	
	
	//1 chauffeur par ligne et par jour(matin et aprem)
	forall(k in 1..m, j in 1..T){
		ct51: sum(i in team) x[i][j]*z[i][k] >= 1;
		ct52: sum(i in team) x[i][j] == m;
		ct61: sum(i in team) y[i][j]*z[i][k] >= 1;
		ct62: sum(i in team) y[i][j] == m;
	}		
	
	forall(k in 1..m, j in 1..T){
		sum(i in team)b1[i][j][k] == 1;
		sum(i in team)b2[i][j][k] == 1;
		forall(i in team){
			b1[i][j][k] <= x[i][j]*z[i][k];		
			b2[i][j][k] <= y[i][j]*z[i][k];		
		}	
	}
 }