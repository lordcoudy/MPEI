using System;
using System.Collections.Generic;

namespace Lab1
{
    class Program
    {
        public static void part1_func()
        {
            // Оьъявляю переменные, отвечающие за длительность каждого сигнала светофора
            int red_duration, yellow_duration, green_duration;
            // Считываю эти переменные
            Console.WriteLine("Enter duration of red light: ");
            red_duration = Convert.ToInt32(Console.ReadLine());
            Console.WriteLine("Enter duration of yellow light: ");
            yellow_duration = Convert.ToInt32(Console.ReadLine());
            Console.WriteLine("Enter duration of green light: ");
            green_duration = Convert.ToInt32(Console.ReadLine());
            Part1 part1 = new Part1(red_duration, yellow_duration, green_duration);

            Console.WriteLine("Info value of red is " + part1.RedLight() +
                              ";\nInfo value of yellow is " + part1.YellowLight() +
                              ";\nInfo value of green is " + part1.GreenLight() + ";\n");
            Console.WriteLine("Average info value is " + part1.Average() + ";\n");
        }
        
        public static void part2_func()
        {
            Console.WriteLine("--------------------------------------\nEnter line:\n");
            // Создаю и считываю строку для закодирования
            string line = Console.ReadLine();
            Part2 part2 = new Part2(line);
            Console.WriteLine("Number of bits required: " + part2.BitsRequired());
            Console.WriteLine("Dictionary was created:\n");
            foreach (var val in part2.ReturnDictionary())
            {
                Console.WriteLine("Key - value: " + val.Key + " - " + val.Value);
            }
            Console.WriteLine("Coded line:\t" + part2.ReturnOutput());
        }
    
        static void Main()
        {
            bool end = false;
            while (!end)
            {
                Console.WriteLine("Choose what part of lab you want to do:" +
                                  "\n1 - first part" +
                                  "\n2 - second part" +
                                  "\n0 - exit\n");
                int key = Convert.ToInt32(Console.ReadLine());
                switch (key)
                {
                    case 1: 
                        part1_func();
                        break;
                    case 2:
                        part2_func();
                        break;
                    case 0:
                        end = true;
                        break;
                    default:
                        Console.WriteLine("Unknown symol, please, try again\n");
                        break;
                }
            }
        }
    }
}
