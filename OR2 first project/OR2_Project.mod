/*********************************************
 * OPL 12.9.0.0 Model
 * Author: sabed
 * Creation Date: Nov 19, 2021 at 4:31:53 PM
 *********************************************/
range I=1..6;
range J=7..9;
range K=1..3;
int Cap[K]=...;
float P[I][J]=...;
int N[I]=...;
int C[I][K]=...;
dvar int+ S[I][J][K];

minimize sum(i in I,k in K) (C[i][k]*sum(j in J)S[i][j][k]);
subject to{
	forall(i in I,j in J)
	  sum(k in K) (S[i][j][k])==P[i][j]*N[i];
	forall(k in K)
	  sum(i in I,j in J) (S[i][j][k]) <= Cap[k];
	forall(j in J,k in K)
	  0.3*(sum(i in I,jj in J) (S[i][jj][k])) <= sum(i in I)(S[i][j][k]);
	forall(j in J,k in K)
	  sum(i in I)(S[i][j][k]) <=0.36*(sum(i in I,jj in J) (S[i][jj][k]));
	forall(j in J)
	   S[2][j][1]==0;
	forall(j in J)
	   S[4][j][3]==0;
	forall(j in J)
	   S[5][j][2]==0;
		};

tuple someTuple{
int a;
int b;
int c;
int value;
};
{someTuple} someSet = {<i,j,k,S[i][j][k]> | i in I, j in J, k in K};