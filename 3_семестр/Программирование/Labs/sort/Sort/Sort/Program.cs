using System;

namespace Sort
{
    class Program
    {
        static void Main(string[] args)
        {
            int[] x = null;
            Random random = new Random();
            for (int i = 0; i < 10000; i++)
            {
                x[i] = random.Next();
            }
            Array.Sort(x);
            
            Console.WriteLine(x[0]);
            Console.WriteLine(x[x.Length-1]);
        }
    }
}