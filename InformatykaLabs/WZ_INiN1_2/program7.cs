//Napisz program stwierdzający, czy zadana liczba n jest pierwsza. Użyj pętli while.

using System;

namespace ConsoleApplication1
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.Write("Podaj liczbę n: ");
            int n = int.Parse(Console.ReadLine());

            
            bool isPrime = true;
            int i = 2;
            while (i < n)
            {
                if (n % i == 0)
                {
                    isPrime = false;
                    break;
                }
                i++;
            }

            
            if (isPrime)
            {
                Console.WriteLine($"{n} jest liczbą pierwszą");
            }
            else
            {
                Console.WriteLine($"{n} nie jest liczbą pierwszą");
            }
            Console.ReadKey();
        }
    }
}
