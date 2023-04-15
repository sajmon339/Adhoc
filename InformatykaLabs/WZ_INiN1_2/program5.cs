using System;

namespace ConsoleApplication1
{
    class Program
    {
        static void Main(string[] args)
        {
            
            //14. Napisz program znajdujący wszystkie trójki liczb pitagorejskich z zadanego przedziału.
            Console.Write("Podaj początek przedziału: ");
            int start = int.Parse(Console.ReadLine());
            Console.Write("Podaj koniec przedziału: ");
            int end = int.Parse(Console.ReadLine());

            
            for (int a = start; a <= end; a++)
            {
                for (int b = start; b <= end; b++)
                {
                    for (int c = start; c <= end; c++)
                    {
                        if (a * a + b * b == c * c)
                        {
                            Console.WriteLine($"{a}, {b}, {c}");
                        }
                    }
                }
            }
            Console.ReadKey();
        }
    }
}
