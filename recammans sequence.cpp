#include <iostream>
using namespace std;
int main()
{
	// Code to find nth term of a  Recamán's Sequence //
	int n,x=0;
	cout<<" Please enter the number of terms you wish to see in the  Recamán's Sequence : ";
	cin>>n;
	cout<<endl<<endl;
	cout<<" The first n terms of the  Recamán's Sequence are as follows:"<<endl;
	cout<<x<<" ";
	for(int i=1; i<n;i++)
	{
		if(x-i>0)
		x=x-i;
		else
		x=x+i;
		cout<<x<<" ";
	}
	fflush(stdin);
	getchar();
	return 0;
}



