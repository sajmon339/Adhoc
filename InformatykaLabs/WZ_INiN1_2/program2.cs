using System;

namespace ConsoleApplication1
{
    class Program
    {
        static void Main(string[] args)
        {

            //11. Napisz program obliczający sumę n początkowych liczb 
            //nieparzystych. Liczbę n należy pobrać od użytkownika. Do obliczenia wartości sumy użyj pętli for.
            Console.Write("Podaj liczbę n: ");
            int n = int.Parse(Console.ReadLine());


            int sum = 0;


            for (int i = 1; i < n * 2; i += 2)
            {
                sum += i;
            }


            Console.WriteLine("Suma n początkowych liczb nieparzystych to " + sum);
            Console.ReadKey();
        }
    }
}
