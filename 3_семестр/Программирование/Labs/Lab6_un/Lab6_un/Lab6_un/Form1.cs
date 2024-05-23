using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Lab6_un
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }
        

        private bool CheckWord(string word)
        {
            int count = 0;
            foreach (char ch in word.ToUpper())
            {
                foreach (char second_ch in word.ToUpper())
                {
                    if (ch == second_ch)
                    {
                        count++;
                    }
                }

                if (count > 1)
                {
                    return true;
                }
                count = 0;
            }

            return false;
        }
        private void button1_Click(object sender, EventArgs e)
        {
            String input = textBox1.Text;
            string[] words = input.Split();
            string output_words = null;
            foreach (string word in words)
            {
                if ((word.ToUpper() != words[words.Length - 1].ToUpper()) && !CheckWord(word) && word!= "" && word != " ")
                {
                    // if (word[word.Length - 1] == '.' || word[word.Length - 1] == ',' || word[word.Length - 1] == ':')
                    //     word.Remove(word.Length - 1, 1);
                    output_words += word + " ";
                }
            }

            if (output_words == null)
            {
                label4.Text = "Нет подходящих слов";
            }
            else
            {
                label4.Text = output_words;
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            if (openFileDialog1.ShowDialog() == DialogResult.OK)
            {
                StreamReader file = new StreamReader(openFileDialog1.FileName);
                string charachters = file.ReadLine();
                label6.Text = charachters;
                string[] massive = charachters.Split();
                string numbers = null;
                foreach (string part in massive)
                {
                    bool check = (part.Length == 2 && (Char.IsDigit(part[0]) && part[0] != '0') && Char.IsDigit(part[1]))
                                 || (part.Length == 3 && (part[0] == '-' || part[0] == '+' || part[0] == '0') && (Char.IsDigit(part[1]) && part[1] != '0') && Char.IsDigit(part[2]));
                    if (check)
                    {
                        numbers += part + "   ";
                    }
                }
                if (numbers == null)
                {
                    label7.Text = "Нет подходящих чисел";
                }
                else
                {
                    label7.Text = numbers;
                }
            }
            else
            {
                label6.Text = "Ошибка при открытии файла";
            }
        }
        
        private void textBox1_KeyPress(object sender, KeyPressEventArgs e)
        {
            char symbol = e.KeyChar;
            if (!Char.IsLetter(symbol) && symbol != 8 && symbol != 32) 
            {
                e.Handled = true;
            }
        }
    }
}