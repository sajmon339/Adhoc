using System;

namespace ConsoleApplication1
{
    class Program
    {
        static void Main(string[] args)
        {
            //10. Napisz program drukujący na ekranie kolejne liczby naturalne podzielne przez 7. Ilość liczb wczytaj z klawiatury. Użyj pętli for.
            
            Console.WriteLine("Wpisz maksymalną cyfre:");
            int n = int.Parse(Console.ReadLine());

            for (int i = 1; i <= n; i++)
            {
                if (i % 7 == 0)
                {
                    Console.WriteLine(i);
                    
                }
            }
            Console.ReadKey();
        }
    }
}
