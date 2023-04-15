using System;

//Napisać program wczytujący ciąg n (1<=n<=1000) liczb całkowitych 
//i wypisujący na ekranie informację ile liczb jest dodatnich, ujemnych i równych zero.

class Program
{
    static void Main(string[] args)
    {
        int n;
        int positive = 0;
        int negative = 0;
        int zero = 0;

        Console.Write("Podaj liczbę n: ");
        n = int.Parse(Console.ReadLine());

        for (int i = 0; i < n; i++)
        {
            int num;
            Console.Write("Podaj liczbę: ");
            num = int.Parse(Console.ReadLine());

            if (num > 0)
                positive++;
            else if (num < 0)
                negative++;
            else
                zero++;
        }

        Console.WriteLine("Liczb dodatnich: " + positive);
        Console.WriteLine("Liczb ujemnych: " + negative);
        Console.WriteLine("Liczb równych zero: " + zero);
    }
}
