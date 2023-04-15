//Napisz program obliczający sumę cyfr dla wczytanej z klawiatury liczby naturalnej.
//Użyj pętli while

using System;

namespace ConsoleApplication1
{
    class Program
    {
        static void Main(string[] args)
        {
            
            Console.Write("Podaj liczbę: ");
            int number = int.Parse(Console.ReadLine());

        
            int sum = 0;
            while (number > 0)
            {
                sum += number % 10;
                number /= 10;
            }

            
            Console.WriteLine($"Suma cyfr wynosi: {sum}");
            Console.ReadKey();
        }
    }
}
