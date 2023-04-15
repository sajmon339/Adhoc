using System;

namespace ConsoleApplication1
{
    class Program
    {
        static void Main(string[] args)
        {
            
            Console.Write("Podaj wysokość: ");
            int height = int.Parse(Console.ReadLine());

            
            for (int i = 1; i <= height; i++)
            {
                for (int j = 1; j <= i; j++)
                {
                    Console.Write(i * j + " ");
                }
                Console.WriteLine();
            }
            Console.ReadKey();
        }
    }
}
