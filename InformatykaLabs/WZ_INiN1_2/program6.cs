// 7. Napisz program obliczający wartość n! (n silnia, n!=1*2*...*n) 
//dla wczytanej z klawiatury liczby naturalnej n. Użyj pętli while. Np.: dla n=5 wypisz wynik 5!=120.

using System;

namespace ConsoleApplication1
{
    class Program
    {
        static void Main(string[] args)
        {
            
            Console.Write("Podaj liczbę n: ");
            int n = int.Parse(Console.ReadLine());

            
            int result = 1;
            int i = 1;
            while (i <= n)
            {
                result *= i;
                i++;
            }

            
            Console.WriteLine($"{n}! = {result}");
            Console.ReadKey();
        }
    }
}
