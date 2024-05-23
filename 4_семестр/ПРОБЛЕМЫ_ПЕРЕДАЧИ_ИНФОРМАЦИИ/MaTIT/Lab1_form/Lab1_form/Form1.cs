using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Lab1;

namespace Lab1_form
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            // Оьъявляю переменные, отвечающие за длительность каждого сигнала светофора
            int red_duration, yellow_duration, green_duration;
            // Считываю эти переменные
            red_duration = Convert.ToInt32(textBox1.Text);
            yellow_duration = Convert.ToInt32(textBox3.Text);
            green_duration = Convert.ToInt32(textBox4.Text);
            if (red_duration == 0 || yellow_duration == 0 || green_duration == 0)
            {
                label9.Text = "Не требуется нисколько количества информации";
            } else
            {
                Part1 part1 = new Part1(red_duration, yellow_duration, green_duration);
                label9.Text =
                    $"Info value of red is {part1.RedLight()};" +
                    $"\nInfo value of yellow is {part1.YellowLight()};" +
                    $"\nInfo value of green is {part1.GreenLight()};" +
                    $"\nAverage info value is {part1.Average()};\n";
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            // Создаю и считываю строку для закодирования
            string line = textBox2.Text;
            Part2 part2 = new Part2(line);
            List<string> output_list = new List<string>();
            output_list.Add($"Number of bits required: {part2.BitsRequired().ToString()}\nDictionary was created:");
            foreach (var val in part2.ReturnDictionary())
            {
                output_list.Add($"Key - value: {val.Key.ToString()} - {val.Value}\n");
            }
            output_list.Add($"Coded line: {part2.ReturnOutput()}");
            string coded = String.Join("\n", output_list);
            label7.Text = coded;
        }

        private void textBox1_KeyPress(object sender, KeyPressEventArgs e)
        {
            char number = e.KeyChar;

            if (!Char.IsDigit(number) && number != 8)
            {
                e.Handled = true;
            }
        }

        private void textBox3_KeyPress(object sender, KeyPressEventArgs e)
        {
            char number = e.KeyChar;

            if (!Char.IsDigit(number) && number != 8)
            {
                e.Handled = true;
            }
        }

        private void textBox4_KeyPress(object sender, KeyPressEventArgs e)
        {
            char number = e.KeyChar;

            if (!Char.IsDigit(number) && number != 8)
            {
                e.Handled = true;
            }
        }

        private void textBox2_KeyPress(object sender, KeyPressEventArgs e)
        {
            char letter = e.KeyChar;

            if (!Char.IsLetter(letter) && letter != 8)
            {
                e.Handled = true;
            }
        }
    }
}