using System;

//Napisać program wczytujący ciąg n (1<=n<=1000) liczb naturalnych 
//i wypisujący na ekranie wszystkie parzyste liczby w kolejności niemalejącej. 
//Do wypisywania elementów tablicy użyj pętli foreach.
//Wskazówka: Posortuj wczytane liczby, a następnie z tablicy wypisz tylko liczby parzyste.

class Program
{
    static void Main(string[] args)
    {
        int n;

        Console.Write("Podaj liczbę n: ");
        n = int.Parse(Console.ReadLine());

        int[] numbers = new int[n];

        for (int i = 0; i < n; i++)
        {
            Console.Write("Podaj liczbę: ");
            numbers[i] = int.Parse(Console.ReadLine());
        }

        Array.Sort(numbers);
        Console.WriteLine("Liczby parzyste w kolejności niemalejącej:");
        foreach (int number in numbers)
        {
            if (number % 2 == 0)
                Console.WriteLine(number);
        }
    }
}
