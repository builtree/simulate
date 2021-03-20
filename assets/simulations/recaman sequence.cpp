int recaman(int n)
{
    //Create an array to store terms
    int arr[n];

    //first term of the sequence is always 0= base case
    arr[0]=0;
    printf("%d ",arr[0]);
    //use the recursive formula

    for (int i=1;i<n;i++)
    {
        int curr= arr[i-1]-i;
        int j;
        for (int j=0;j<i;j++)
        {
            int curr=arr[i-1]+i;
            int j;
            for(j=0;j<i;j++)
            {
                if((arr[j]==curr || curr<0))
                {
                    curr=arr[i-1]+i;
                    break;
                }
            }
            arr[i]=curr;
            printf("%d, ",arr[i]);

        }
    }

}