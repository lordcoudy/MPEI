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

namespace Lab7_un
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Random random = new Random();
            int limit = (int)numericUpDown1.Value;
            if (limit < 1)
            {
                label2.Text = "Нельзя сгенерировать текст с нулевым или меньше количеством элементов!";
            }
            else
            {


                string[] numbers = new string[limit];
                double[] vec = new double[limit];
                for (int i = 0; i < limit; i++)
                {
                    vec[i] = random.NextDouble();
                    numbers[i] = vec[i] + "   ";
                }

                string text = null;
                foreach (string number in numbers)
                {
                    text = String.Concat(text, number);
                }

                SaveFileDialog saveFileDialog1 = new SaveFileDialog();

                saveFileDialog1.Filter = "txt files (*.txt)|*.txt|All files (*.*)|*.*";
                saveFileDialog1.FilterIndex = 2;
                saveFileDialog1.RestoreDirectory = true;
                Stream myStream;
                if (saveFileDialog1.ShowDialog() == DialogResult.OK)
                {
                    if ((myStream = saveFileDialog1.OpenFile()) != null)
                    {
                        StreamWriter output = new StreamWriter(myStream);
                        output.WriteLine(text);
                        output.Close();
                        myStream.Close();
                    }
                }

                label2.Text = text;

                double sum = 0;
                int count = 0;
                foreach (double number in vec)
                {
                    if (number > 0.5)
                    {
                        sum += number;
                        count++;
                    }
                }

                if (count == 0)
                {
                    label4.Text = "Нет чисел больше 0,5";
                }
                else
                {
                    label4.Text = sum.ToString();
                }
            }
        }

        
        bool Check(string word)
        {
            for (int i = 0; i < word.Length-1; i++)
            {
                if (!Char.IsLetter(word[i]))
                {
                    return false;
                }
            }

            if (word[word.Length - 1] != '.' &&
                word[word.Length - 1] != ',' && 
                word[word.Length - 1] != ':' &&
                !Char.IsLetter(word[word.Length - 1]))
                return false;
            return true;
        }
        private void button2_Click(object sender, EventArgs e)
        {
            if (openFileDialog1.ShowDialog() == DialogResult.OK)
            {
                StreamReader file = new StreamReader(openFileDialog1.FileName);
                string charachters = file.ReadToEnd();
                label9.Text = charachters;
                string[] massive = charachters.Split();
                int counter = 0;
                foreach (string word in massive)
                {
                    if (!String.IsNullOrWhiteSpace(word) && Check(word))
                    {
                        counter++;
                    }
                        
                }

                label1.Text = counter.ToString();
            }
        }
    }
}