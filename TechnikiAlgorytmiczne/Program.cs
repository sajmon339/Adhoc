using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text.Json;
using System.Threading.Tasks;

namespace TechnikiAlgorytmiczne
{
    class Program
    {
        static void Main(string[] args)
        {
            var sizes = Enumerable.Range(10000, 5).Select(x => x * 10000).ToList();
            var results = new Dictionary<string, Dictionary<int, double>>();

            var sequences = new Dictionary<string, Func<int, int[]>>()
            {
                { "O(n^2)", GenerateSequenceN2 },
                { "O(n^(3/4))", GenerateSequenceN34 },
                { "O(n^(3/2))", GenerateSequenceN32 },
                { "Custom 1", GenerateCustomSequence1 },
                { "Custom 2", GenerateCustomSequence2 },
                { "Custom 3", GenerateCustomSequence3 }
            };

            Parallel.ForEach(sequences, sequence =>
            {
                var sequenceResults = new Dictionary<int, double>();
                Parallel.ForEach(sizes, size =>
                {
                    var stopwatch = Stopwatch.StartNew();
                    ShellSort(sequence.Value(size));
                    stopwatch.Stop();
                    lock (sequenceResults)
                    {
                        sequenceResults.Add(size, stopwatch.Elapsed.TotalMilliseconds);
                    }
                });
                lock (results)
                {
                    results.Add(sequence.Key, sequenceResults);
                }
            });

            SaveResultsToJson(results, "results.json");

            Console.WriteLine("Experiment completed. Results saved to results.json");
        }

        static void ShellSort(int[] arr)
        {
            int n = arr.Length;
            for (int gap = n / 2; gap > 0; gap /= 2)
            {
                for (int i = gap; i < n; i += 1)
                {
                    int temp = arr[i];
                    int j;
                    for (j = i; j >= gap && arr[j - gap] > temp; j -= gap)
                    {
                        arr[j] = arr[j - gap];
                    }
                    arr[j] = temp;
                }
            }
        }

        static int[] GenerateSequenceN2(int size)
        {
            return Enumerable.Range(1, size).ToArray();
        }

        static int[] GenerateSequenceN34(int size)
        {
            return Enumerable.Range(1, (int)Math.Pow(size, 3.0 / 4.0)).ToArray();
        }

        static int[] GenerateSequenceN32(int size)
        {
            return Enumerable.Range(1, (int)Math.Pow(size, 3.0 / 2.0)).ToArray();
        }

        static int[] GenerateCustomSequence1(int size)
        {
            // Define your custom sequence generation logic here (Example: Even numbers sequence)
            var sequence = new int[size];
            for (int i = 0; i < size; i++)
            {
                sequence[i] = i * 2;
            }
            return sequence;
        }

        static int[] GenerateCustomSequence2(int size)
        {
            // Generowanie ciągu malejących liczb od size do 1
            var sequence = new int[size];
            for (int i = 0; i < size; i++)
            {
                sequence[i] = size - i;
            }
            return sequence;
        }

        static int[] GenerateCustomSequence3(int size)
        {
            // Generowanie losowego ciągu liczb
            var random = new Random();
            var sequence = new int[size];
            for (int i = 0; i < size; i++)
            {
                sequence[i] = random.Next(1, 1000); // Losowanie liczby całkowitej z zakresu 1-1000
            }
            return sequence;
        }

        static void SaveResultsToJson(Dictionary<string, Dictionary<int, double>> results, string filename)
        {
            string jsonString = JsonSerializer.Serialize(results, new JsonSerializerOptions() { WriteIndented = true });
            File.WriteAllText(filename, jsonString);
        }
    }
}
