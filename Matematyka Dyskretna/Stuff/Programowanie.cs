// See https://aka.ms/new-console-template for more information
using System;

//Cwiczenie 1
//Console.WriteLine("Hello World !");
//Console.ReadKey();

//Cwiczenia 2
//string imie;
//Console.Write("Podaj swoje imie: ");
//imie = Console.ReadLine();
//Console.WriteLine("Witaj {0}", imie);
//Console.ReadKey();

//Cwiczenie 3
//int a;
//Console.Write("Podaj a=");
//a = Convert.ToInt32(Console.ReadLine());
//Console.WriteLine("a^3={0}", a * a * a);
//Console.ReadKey();


//Cwiczenie 4
//double a, b;
//Console.Write("Podaj a=");
//a = Convert.ToDouble(Console.ReadLine());
//Console.Write("Podaj b=");
//b = Convert.ToDouble(Console.ReadLine());
//Console.WriteLine("Pole ={0}", a * b);
//Console.WriteLine("Obwod ={0}", 2*a + 2*b);
//Console.ReadKey();

//Cwiczenie 5
//double r, h, l, V, Pc;
//Console.Write("Podaj r=");
//r = Convert.ToDouble(Console.ReadLine());
//Console.Write("Podaj h=");
//h = Convert.ToDouble(Console.ReadLine());
//l = Math.Sqrt(h * r + h * h);
//V = 1.0 / 3 * Math.PI * r * r * h;
//Pc = Math.PI * r * r + Math.PI * r * l;
//Console.WriteLine("V={0}", V);
//Console.WriteLine("Pc={0}", Pc);
//Console.ReadKey();

//Cwiczenie 6
//double a, b, suma, iloczyn, iloraz, roznica;
//Console.Write("Podaj a= ");
//a = Convert.ToDouble(Console.ReadLine());
//Console.Write("Podaj b= ");
//b = Convert.ToDouble(Console.ReadLine());
//suma = a + b;
//iloczyn = a * b;
//iloraz = a / b;
//roznica = a - b;

//Console.WriteLine("Suma {0} i {1} to {2} ", a, b, suma);
//Console.WriteLine("Iloczyn {0} i {1} to {2} ", a, b, iloczyn);
//Console.WriteLine("Iloraz {0} i {1} to {2} ", a, b, iloraz);
//Console.WriteLine("Roznica {0} i {1} to {2} ", a, b, roznica);
//Console.ReadKey();

//Cwiczenie 7
//int a, b;
//Console.Write("Podaj a= ");
//a = Convert.ToInt32(Console.ReadLine());
//Console.Write("Podaj b= ");
//b = Convert.ToInt32(Console.ReadLine());
//Console.WriteLine("{0}/{1}={2}r{3}", a, b, a / b, a % b);
//Console.ReadKey();

//Cwiczenie 8
//double a, b, c;
//string odpowiedz= "Z podanych wartosci nie mozna zbudowac trójkąta";
//Console.Write("Podaj wartosc odcknka a= ");
//a = Convert.ToDouble(Console.ReadLine());

//Console.Write("Podaj wartosc odcknka b= ");
//b = Convert.ToDouble(Console.ReadLine());

//Console.Write("Podaj wartosc odcknka c= ");
//c = Convert.ToDouble(Console.ReadLine());

//if (a + b > c && a + c >b && b + c > a)
//{
//    odpowiedz = "Z podanych odcinkow mozna zbudowac trójkąt";
//}
//Console.WriteLine(odpowiedz);
//Console.ReadKey();

//Cwiczenie 9

//double a, b, c, delta, x1, x2, x3;
//Console.Write("Podaj wartosc a=");
//a = Convert.ToDouble(Console.ReadLine());

//Console.Write("Podaj wartosc b=");
//b = Convert.ToDouble(Console.ReadLine());


//Console.Write("Podaj wartosc c=");
//c = Convert.ToDouble(Console.ReadLine());

//delta = (b * b) - 4 * a * c;
//if (delta < 0)
//{
//    Console.WriteLine("Delta jest mniejsza od 0. Wartosc delty: {0}", delta);
//    Console.ReadKey();
//}
//else if (delta == 0)
//{
//    x3 = -b / 2 * a;
//    Console.WriteLine("Rownanie kwadratowe ma jedno rozwiazanie gdzie x={0}", x3);
//    Console.ReadKey();
//}
//else if (delta > 0)
//{
//    x1 = (-b - Math.Sqrt(delta) / 2 * a);
//    x2 = (-b + Math.Sqrt(delta) / 2 * a);

//    Console.WriteLine("Miejscami zerowymi funkcji sa: x1={0} i x2={1}", x1, x2);
//    Console.ReadKey();
//}

//Cwiczenie 10

//int a;
//Console.Write("Wprowadz liczbe calkowita pomiedzy 1 a 1 000 000: ");
//a = Convert.ToInt32(Console.ReadLine());
//int aLen = a.ToString().Length;
//Console.WriteLine(aLen);
//Console.ReadKey();

//public static string getBaseNumber(int input)
//{
//    string a;

//    return a;
//};



//static void Main(string[] args)
//{
//    try
//    {
//        Console.WriteLine("Enter a Number to convert to words");
//        string number = Console.ReadLine();
//        number = NumberToWords.ConvertAmount(double.Parse(number));
//        Console.WriteLine("Number in words is \n{0}", number);
//        Console.ReadKey();
//    }
//    catch (Exception ex)
//    {
//        Console.WriteLine(ex.Message);
//        Console.ReadKey();
//    }
//}

//Console.WriteLine("Wpisz Cyfre");
//string number = Console.ReadLine();
//number = NumberToWords.ConvertAmount(double.Parse(number));
//Console.WriteLine("Zapis cyfry jest \n{0}", number);
//Console.ReadKey();


//class NumberToWords
//{
//    private static String[] units = { "Zero", "Jeden", "Dwa", "Trzy",
//    "Cztery", "Pięć", "Sześć", "Siedem", "Osiem", "Dziewięć", "Dziesięć", "Jedenaście",
//    "Dwanaście", "Trzynaście", "Czternaście", "Piętnaście", "Szesnaście",
//    "Siedemnaście", "Osiemnaście", "Dziewietnaście" };
//    private static String[] tens = { "", "", "Dwadzieścia", "Trzydzieści", "Czterdzieści",
//    "Pięćdziesiąt", "Sześćdziesiąt", "Siedemdziesiąt", "osiemdziesiąt", "Dziewiędziesiąt" };

//    public static String ConvertAmount(double amount)
//    {
//        try
//        {
//            Int64 amount_int = (Int64)amount;
//            Int64 amount_dec = (Int64)Math.Round((amount - (double)(amount_int)) * 100);
//            if (amount_dec == 0)
//            {
//                return Convert(amount_int) + "";
//            }
//            else
//            {
//                return Convert(amount_int) + " Przecinek " + Convert(amount_dec) + "";
//            }
//        }
//        catch (Exception e)
//        {
//            // TODO: handle exception  
//        }
//        return "";
//    }

//    public static String Convert(Int64 i)
//    {
//        if (i < 20)
//        {
//            return units[i];
//        }
//        if (i < 100)
//        {
//            return tens[i / 10] + ((i % 10 > 0) ? " " + Convert(i % 10) : "");
//        }
//        if (i < 1000)
//        {
//            return units[i / 100] + " Sto"
//                    + ((i % 100 > 0) ? " " + Convert(i % 100) : "");
//        }
//        if (i < 100000)
//        {
//            return Convert(i / 1000) + " Tysiąc "
//                    + ((i % 1000 > 0) ? " " + Convert(i % 1000) : "");
//        }
//        if (i < 10000000)
//        {
//            return Convert(i / 100000) + " Lakh "
//                    + ((i % 100000 > 0) ? " " + Convert(i % 100000) : "");
//        }
//        if (i < 1000000000)
//        {
//            return Convert(i / 10000000) + " Crore "
//                    + ((i % 10000000 > 0) ? " " + Convert(i % 10000000) : "");
//        }
//        return Convert(i / 1000000000) + " Arab "
//                + ((i % 1000000000 > 0) ? " " + Convert(i % 1000000000) : "");
//    }


//}

