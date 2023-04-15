//apisać program sumujący kolejne liczby całkowite podawane przez użytkownika, aż do napotkania zera. 
//Wypisz otrzymaną sumę na ekranie. Użyj pętli do-while.

using System;

namespace ConsoleApplication1
{
    class Program
    {
        static void Main(string[] args)
        {
            int sum = 0;
            int number;
            do
            {
                Console.Write("Podaj liczbę: ");
                number = int.Parse(Console.ReadLine());
                sum += number;
            } while (number != 0);
            Console.WriteLine($"Suma wynosi: {sum}");
            Console.ReadKey();


        }
    }
}
