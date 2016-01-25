#include <ilcplex/ilocplex.h>
#include <vector>
#include <string>
#include <sstream>


using namespace std;

ILOSTLBEGIN

int main(int argc, char **argv) {
  IloEnv env;
  IloModel model(env);

  int n = 11;
  int t = 14;
  int m = 3;


  IloArray <IloNumVarArray> x(env,n); //dvar
  IloArray <IloNumVarArray> y(env,n); //dvar
  IloRangeArray c(env); //constraints


  vector<vector<int> > z(n);
  vector<vector<int> > pm(n);
  vector<vector<int> > pa(n);
  vector<vector<int> > pd(n);
  vector<vector<int> > d(n);




  //init
  for(int i =0; i<n; i++){
    x[i] = IloNumVarArray(env, t);
    y[i] = IloNumVarArray(env, t);
    for(int j=0; j<t; j++){
      x[i][j] =  IloNumVar(env, 0, 1, ILOBOOL);
      y[i][j] =  IloNumVar(env, 0, 1, ILOBOOL);
    }
  }


  for(int i = 0; i<n; i++){
    z.push_back(vector <int>());

    for(int k=0; k<m; k++){
      z[i].push_back(0);
    }

    pm.push_back(vector <int>());
    for(int j=0; j<t; j++){
      pm[i].push_back(0);
      pa[i].push_back(0);
      pd[i].push_back(0);
      d[i].push_back(0);
    }
  }

  //les data
  vector<string> stpm(n);
  vector<string> stpa(n);
  vector<string> stpd(n);
  vector<string> std(n);
  vector<string> stz(n);

  for(int i = 0; i<n; i++){
    stpa.push_back("");
    std.push_back("");
    stpm.push_back("");
    stpd.push_back("");
    stz.push_back("");
  }
  
  stpd[0] = "8,14";
  stpd[1] = "7,9";
  stpd[2] = "1,10";
  stpd[3] = "3,4,11";
  stpd[4] = "10,11";
  stpd[5] = "6,12";
  stpd[6] = "5,6,14";
  stpd[7] = "1,6,7";
  stpd[8] = "14";
  stpd[9] = "1,8,9";
  stpd[10] = "3,9";

  stpm[0] = "9,12,13";
  stpm[1] = "6";
  stpm[2] = "8";
  stpm[3] = "8,10,";
  stpm[4] = "12,13";
  stpm[5] = "5";
  stpm[6] = "1,7,";
  stpm[7] = "2,9";
  stpm[8] = "";
  stpm[9] = "11";
  stpm[10] = "8";

  stpa[0] = "7";
  stpa[1] = "6,9";
  stpa[2] = "14";
  stpa[3] = "2";
  stpa[4] = "";
  stpa[5] = "3,14";
  stpa[6] = "";
  stpa[7] = "";
  stpa[8] = "6,8";
  stpa[9] = "2,3";
  stpa[10] = "";
  
  std[0] = "3,4,10,11";
  std[1] = "4,5,11,12";
  std[2] = "5,6,12,13";
  std[3] = "6,7,13,14";
  std[4] = "7,8,14,1";
  std[5] = "1,2,8,9";
  std[6] = "2,3,9,10";
  std[7] = "3,4,10,11";
  std[8] = "4,5,11,12";
  std[9] = "5,6,12,13";
  std[10] = "6,7,13,14";
  
  stz[0] = "2,";
  stz[1] = "1";
  stz[2] = "1";
  stz[3] = "2,3";
  stz[4] = "1,2";
  stz[5] = "2";
  stz[6] = "2";
  stz[7] = "2";
  stz[8] = "2";
  stz[9] = "2";
  stz[10] = "2";

  char split_char = ',';
  for(int i = 0; i<n; i++){
    
    istringstream split_z(stz[i]);
    istringstream split_d(std[i]);
    istringstream split_pd(stpd[i]);
    istringstream split_pm(stpm[i]);
    istringstream split_pa(stpa[i]);

    vector<string> tokens_z;
    vector<string> tokens_pd;
    vector<string> tokens_pm;
    vector<string> tokens_pa;
    vector<string> tokens_d;

    
    for(string each; getline(split_pm, each, split_char); tokens_pm.push_back(each));    
    for(unsigned int j = 0; j<tokens_pm.size(); j++){
      /// cout << stoi(tokens_pm[j]) << "\t";
      int index = stoi(tokens_pm[j]) - 1; 
      pm[i][index] = 1;
    }
    //cout << "ok" <<endl;
    
    for(string each; getline(split_pa, each, split_char); tokens_pa.push_back(each));
    for(unsigned int j = 0; j<tokens_pa.size(); j++){
     
      int index = stoi(tokens_pa[j])-1; 
      pa[i][index] = 1;
    }
    
    for(string each; getline(split_pd, each, split_char); tokens_pd.push_back(each));
    for(unsigned int j = 0; j<tokens_pd.size(); j++){
      int index = stoi(tokens_pd[j])-1; 
      pd[i][index] = 1;
    }

    
    for(string each; getline(split_z, each, split_char); tokens_z.push_back(each));
    for(unsigned int j = 0; j<tokens_z.size(); j++){
      int index = stoi(tokens_z[j])-1; 
      z[i][index] = 1;
    }

    
    for(string each; getline(split_d, each, split_char); tokens_d.push_back(each));    
    for(unsigned int j = 0; j<tokens_d.size(); j++){
      int index = stoi(tokens_d[j])-1; 
      d[i][index] = 1;
    }
    
  }
  cout << "parse: OK" << endl;



  /*objective*/
  IloExpr ob(env);
  for(int i = 0; i<n; i++){
    for(int j=0; j<t; j++){
      ob += pm[i][j]*x[i][j] + pa[i][j]*y[i][j] + pd[i][j]*(2 - x[i][j] - y[i][j]);
    }
  }
  IloObjective obj(env, ob, IloObjective::Maximize, "OBJ" );
  model.add(obj);



  /*constraints*/

  //ct1
  for(int i = 0; i<n; i++){  
    for(int j=0; j<t; j++){
      IloExpr e1(env);
      e1 = x[i][j] + y[i][j] + d[i][j];
      c.add(e1 <= 1);
      e1.end();
    } 
  }


  //ct2
  for(int i = 0; i<n; i++){
    for(int j=0; j<t-1; j++){
      IloExpr e2(env);
      e2 = x[i][j] + y[i][j+1];
      c.add(e2 <= 1);
      e2.end();
    }
  }



  //ct3
  for(int i = 0; i<n; i++){
    for(int j=0; j<t-3; j++){
      IloExpr e3(env);
      e3 = y[i][j] + y[i][j+1] + y[i][j+2] + y[i][j+3];
      c.add(e3 <= 3);
      e3.end();
    }
  }



  //ct4
 
  for(int i = 0; i<n; i++){
    IloExpr e4(env); 
    for(int j=0; j<t; j++){
      e4 += y[i][j];
    }
    c.add(e4 <= 4);
    e4.end();
  }
 

  
  //ct5
  for(int k = 0; k<m; k++){
    for(int j=0; j<t; j++){
      IloExpr e5(env);
      IloExpr e51(env);
      IloExpr e6(env);
      IloExpr e61(env);

      for(int i =0 ; i<n; i++){
	e5  += x[i][j]*z[i][k];
	e51 += x[i][j];
	e6  += y[i][j]*z[i][k];
	e61 += x[i][j];
      }
      //c.add(e5 >= 1);
      c.add(e51 == m);
      //c.add(e6 >= 1);
      c.add(e61 == m);
      e5.end();
      e51.end();
      e6.end();
      e61.end();
    }
  }
  
  
  model.add(c);




  //Solving
  IloCplex cplex(model);
  cplex.solve();
  cout << "max= " << cplex.getObjValue() << endl;

  //primal
  cout << "Le matin" << endl; 
  for(int i=0; i<n; i++){
    IloNumArray  p(env);
    cplex.getValues(p, x[i]);
    cout <<  i << " = " << p << endl;
    p.end();
  }

  cout << "Le soir" << endl; 
  for(int i=0; i<n; i++){
    IloNumArray  p(env);
    cplex.getValues(p, y[i]);
    cout << i << " = " << p << endl;
    p.end();
  }

  //Duals
  //IloNumArray v(env);
  //cplex.getDuals(v, c);

  //cout << "Duals = " << v << endl;

  env.end();
}
