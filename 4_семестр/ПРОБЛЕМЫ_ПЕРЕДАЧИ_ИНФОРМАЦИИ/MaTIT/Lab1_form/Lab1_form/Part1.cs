using System;
using System.Threading;

namespace Lab1
{
    public class Part1
    {
        public Part1(int red_duration, int yellow_duration, int green_duration)
        {
            red = red_duration;
            yellow = yellow_duration;
            green = green_duration;
            // Создаю переменную, отвечающую за общее время цикла светофора
            sum = red + yellow + green;
            // Создаю переменные, отвечающие за вероятности происшествия каждого сигнала светофора
            pRed = red / sum;
            pYellow = yellow / sum;
            pGreen = green / sum;
            // Создаю переменные, отвечающие за количество информации, которую несет каждый сигнал
            // int iRed = (int) Math.Ceiling(((Math.Log(1 / pRed) / Math.Log(2))));
            iRed = (int) Math.Ceiling(Math.Log2(1 / pRed));
            // int iYellow = (int) Math.Ceiling(((Math.Log(1 / pYellow) / Math.Log(2))));
            iYellow = (int) Math.Ceiling(Math.Log2(1 / pYellow));
            // int iGreen = (int) Math.Ceiling(((Math.Log(1 / pGreen) / Math.Log(2))));
            iGreen = (int) Math.Ceiling(Math.Log2(1 / pGreen));
            // Создаю переменную, отвечающую за среднее значение информации, которую несут сигналы светофора
            avg = Math.Ceiling(pRed * iRed + pYellow * iYellow + pGreen * iGreen);
        }
        public int RedLight()
        {
            return iRed;
        }
        public int YellowLight()
        {
            return iYellow;
        }
        public int GreenLight()
        {
            return iGreen;
        }

        public double Average()
        {
            return avg;
        }
        private int red, yellow, green, iRed, iYellow, iGreen;
        private double sum, pRed, pYellow, pGreen, avg;
    }
}