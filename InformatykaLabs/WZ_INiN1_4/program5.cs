using System;

//Wczytaj liczbę naturalną n i wypisz na ekranie tą liczbę w systemie ósemkowym.

class Program
{
    static void Main(string[] args)
    {
        int n;

        Console.Write("Podaj liczbę n: ");
        n = int.Parse(Console.ReadLine());

        string octal = Convert.ToString(n, 8);
        Console.WriteLine("Liczba " + n + " w systemie ósemkowym to: " + octal);
    }
}
