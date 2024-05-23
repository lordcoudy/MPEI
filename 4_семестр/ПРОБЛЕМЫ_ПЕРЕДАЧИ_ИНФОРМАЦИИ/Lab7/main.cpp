#include "cstdio"
#include <iostream>
#include <vector>
#include <bitset>

using namespace std;

int main()
{
	int n, m;
	cout << "Enter n\n";
	cin >> n;
	cout << "Enter m\n";
	cin >> m;

	vector< vector<int> > matrix(n,vector<int>(m));

	cout << "Enter matrix\n";
	for (int i=0; i<n; i++)
	{
		for(int j=0; j<m; j++)
		{
			if(j<n)
			{
				if (i==j) matrix[i][j]=1;
				else matrix[i][j]=0;
			}
			else cin >> matrix[i][j];
		}
	}

	for (int i=0; i<n; i++)
	{
		for(int j=0; j<m; j++)
		{
			cout << matrix[i][j] << " ";
		}
		cout << endl;
	}

	return 0;
}