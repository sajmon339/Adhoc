using System;

//Napisać program wczytujący ciąg n (1<=n<=1000) liczb całkowitych 
//i wypisujący na ekranie sumę kwadratów wczytanych liczb.

class Program
{
    static void Main(string[] args)
    {
        int n;
        int sum = 0;

        Console.Write("Podaj liczbę n: ");
        n = int.Parse(Console.ReadLine());

        for (int i = 0; i < n; i++)
        {
            int num;
            Console.Write("Podaj liczbę: ");
            num = int.Parse(Console.ReadLine());
            sum += num * num;
        }

        Console.WriteLine("Suma kwadratów liczb: " + sum);
    }
}
