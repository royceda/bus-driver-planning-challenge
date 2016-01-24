#include <ilcplex/ilocplex.h>
#include <vector>

using namespace std;

ILOSTLBEGIN

int main(int argc, char **argv) {
	IloEnv env;
	IloModel model(env);

	IloArray<IloArray <IloNumVar> > x(env); //dvar
	IloArray< IloArray <IloNumVar> > y(env); //dvar
	IloRangeArray c(env); //constraints


	int n = 11;
	int t = 14;
	int m = 3;

	vector<vector<int> > z;
	vector<vector<int> > pm;
	vector<vector<int> > pa;
	vector<vector<int> > pd;
	vector<vector<int> > d;

	//init
	for(int i =0; i<n; i++){
		for(int j=0; j<t; j++){
			x[i][j] =  IloNumVar(env, 0, 1, ILOBOOL);
			y[i][j] =  IloNumVar(env, 0, 1, ILOBOOL);
		}
	}

//les data

	//objective
	IloExpr ob(env);
	for(int i = 0; i<n; i++){
		for(int j=0; j<t; j++){
			ob += pm[i][j]*x[i][j] + pa[i][j]*y[i][j] + pd[i][j]*(2 - x[i][j] - y[i][j]);
		}
	}
	IloObjective obj(env, ob, IloObjective::Maximize, "OBJ" );
	model.add(obj);



	//constraints

	//ct1
	for(int i = 0; i<n; i++){
		IloExpr e1(env);
		for(int j=0; j<t; j++){
			e1 = x[i][j] + y[i][j] + d[i][j];

		}
		c.add(e1 <= 1);
		e1.end();
	}


	//ct2
	for(int i = 0; i<n; i++){
		IloExpr e2(env);
		for(int j=0; j<t; j++){
			e2 = x[i][j] + y[i][j] + d[i][j];

		}
		c.add(e2 <= 1);
		e2.end();
	}



		//ct3
		for(int i = 0; i<n; i++){
			IloExpr e3(env);
			for(int j=0; j<t-3; j++){
				e3 = y[i][j] + y[i][j+1] + y[i][j+2] + y[i][j+3];
			}
			c.add(e3 <= 3);
			e3.end();
		}



		//ct4
		IloExpr e4(env);
		for(int i = 0; i<n; i++){
			for(int j=0; j<t-3; j++){
				e4 += y[i][j];
			}
		}
		c.add(e4 <= 4);
		e4.end();


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
				c.add(e5 >= 1);
				c.add(e51 == m);
				c.add(e6 >= 1);
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
  IloArray<IloNumArray> p(env);
  //cplex.getValues(p, x);


  cout << "Primal = " << p << endl;

	//Duals
	//IloNumArray v(env);
	//cplex.getDuals(v, c);

  //cout << "Duals = " << v << endl;

  env.end();
}
