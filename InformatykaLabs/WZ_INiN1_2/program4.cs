using System;

namespace ConsoleApplication1
{
    class Program
    {
        static void Main(string[] args)
        {
            
            //Wczytaj liczbę naturalną n (n>4). 
            //Narysuj na ekranie ze znaków X kontur trójkąta prostokątnego jak na poniższym przykładzie. Użyj pętli for.
            
            
            Console.Write("Podaj liczbę n: ");
            int n = int.Parse(Console.ReadLine());

            
            for (int i = 1; i < n; i++)
            {
                for (int j = 1; j < n - i; j++)
                {
                    Console.Write(" ");
                }
                for (int j = 1; j <= i; j++)
                {
                    Console.Write("X");
                }
                Console.WriteLine();
            }

            for (int i = 1; i <= n; i++)
            {
                Console.Write("X");
            }
            Console.WriteLine();
            Console.ReadKey();
        }
       
    }
}
