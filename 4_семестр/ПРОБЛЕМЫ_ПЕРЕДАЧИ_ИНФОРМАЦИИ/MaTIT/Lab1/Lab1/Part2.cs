using System;
using System.Collections.Generic;

namespace Lab1
{
    public class Part2
    {
        public Part2(string input_line)
        {
            dictionary = new Dictionary<char, string>();
            counter = 0;
            foreach (char element in input_line)
            {
                if (!dictionary.ContainsKey(element))
                {
                    counter++;
                }
            }
            bits = (int) Math.Ceiling(Math.Log(counter) / Math.Log(2));
            value = 0;
            foreach (char element in input_line)
            {
                if (!dictionary.ContainsKey(element))
                {
                    string meaning = Convert.ToString(value, 2);
                    meaning = meaning.PadLeft(bits, '0');
                    dictionary.Add(element, meaning);
                    value++;
                }
            }
            output = null;
            foreach (char symbol in input_line)
            {
                output += dictionary[symbol];
            }
        }

        public int BitsRequired()
        {
            return bits;
        }

        public Dictionary<char, string> ReturnDictionary()
        {
            return dictionary;
        }

        public string ReturnOutput()
        {
            return output;
        }
        private Dictionary<char, string> dictionary;
        private int counter;
        private int bits, value;
        private string output;
    }
}