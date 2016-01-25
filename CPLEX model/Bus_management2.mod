/*********************************************
 * OPL 12.6.0.0 Model
 * Author: Charlie Brown
 * Creation Date: 22 janv. 2016 at 17:51:39
 *********************************************/

 
 int T = ...;
 int n = ...;
 int m = ...;
 
 {int} pref_m[1..n] = ...;
 {int} pref_a[1..n] = ...;
 {int} pref_d[1..n] = ...;
 {int} tab_z[1..n]  = ...;
 {int} tab_d[1..n]  = ...;
 
 
 
 int pm [1..n][1..T] = ...;//preference matin
 int pa [1..n][1..T] = ...;//preference aprem
 int pd [1..n][1..T] = ...;//preference day off
 int d  [1..n][1..T] = ...; // jour de congés
 int z  [1..n][1..m] = ...;// le chauffeur i connait la ligne j


execute da{

	for(var i = 1; i<=2; i++){
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
 
 dvar int x[1..n][1..T] in (0..1); //le chauffeur i travail le matin de la période j
 dvar int y[1..n][1..T] in (0..1);// le chauffeur i travail l'aprem de la periode j
 
 
 maximize sum(i in 1..n, j in 1..T)(pm[i][j]*x[i][j] + pa[i][j]*y[i][j]  + pd[i][j]*(2 - x[i][j] - y[i][j]));

 
 subject to{
  	forall(i in 1..n, j in 1..T){
  	 ct1: x[i][j] + y[i][j] + d[i][j] <= 1; // nuit, jour ou dayoff
   }  	 	
  	 
  	 forall(i in 1..n, j in 1..T-1){ 
  	 	ct2: (y[i][j] + x[i][j+1]) <= 1; //aprem puis matin impossible
   }  	

	forall(i in 1..n, j in 1..T-3){
   		ct3: (y[i][j] + y[i][j+1] + y[i][j+2] + y[i][j+3]) <= 3; // pas plus de 3 nuit de suite
   }

	forall(i in 1..n){ //parfois relaxée
		ct4: sum(j in 1..T) y[i][j] <= 4; // 4 nuits pour les 2 semaines	pour chacun
	}
	
	
	//1 chauffeur par ligne et par jour(matin et aprem)
	forall(k in 1..m, j in 1..T){
		//ct51: sum(i in 1..n) x[i][j]*z[i][k] >= 1;
		ct52: sum(i in 1..n) x[i][j] == m;
		//ct61: sum(i in 1..n) y[i][j]*z[i][k] >= 1;
		ct62: sum(i in 1..n) y[i][j] == m;
	}		
 }