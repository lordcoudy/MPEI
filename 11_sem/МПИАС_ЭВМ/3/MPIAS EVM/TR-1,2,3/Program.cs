using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace TR_1_2_3
{
    internal class Program
    {
        #region Переменные
        private static int N;           // число узлов
        private static int variant;     // ваш вариант

        private static int[,] M;        // ваша матрица расстояний между узлами (для ТР-1,2), она же матрица расстояний между точками b[a] (для ТР-3):
        private static int[,] S;        // матрица конфигурации сети (для ТР-3):

        private static List<int> allNodes = new List<int>(N);   // список номеров узлов

        private static int bandwidth;
        #endregion

        private static void Main(string[] args)
        {
            Console.WriteLine("\n========================================Начальные данные=========================================");
            try
            {
                using (ExcelHelper helperRead = new ExcelHelper())
                {
                    if (helperRead.Open(filePath: Path.Combine(Environment.CurrentDirectory, "Input.xlsx")))
                    {
                        // Считывание данных из excel таблицы:
                        InitVariables(helperRead);
                        PrintStartInfo();

                        helperRead.Dispose();
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }

            Console.WriteLine("\n===============================================TR1===============================================");
            try
            {
                using (ExcelHelper helperWrite = new ExcelHelper())
                {
                    if (helperWrite.Open(filePath: Path.Combine(Environment.CurrentDirectory, "Output_TR_1.xlsx")))
                    {
                        TR1(helperWrite);

                        helperWrite.Save();
                        helperWrite.Dispose();
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }

            Console.WriteLine("\n===============================================TR2===============================================");
            try
            {
                using (ExcelHelper helperWrite = new ExcelHelper())
                {
                    if (helperWrite.Open(filePath: Path.Combine(Environment.CurrentDirectory, "Output_TR_2.xlsx")))
                    {
                        TR2(helperWrite);

                        helperWrite.Save();
                        helperWrite.Dispose();
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }

            Console.WriteLine("\n===============================================TR3===============================================");
            try
            {
                using (ExcelHelper helperWrite = new ExcelHelper())
                {
                    if (helperWrite.Open(filePath: Path.Combine(Environment.CurrentDirectory, "Output_TR_3.xlsx")))
                    {
                        TR3(helperWrite);

                        helperWrite.Save();
                        helperWrite.Dispose();
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }

        #region Инициализация даных варианта
        private static void InitVariables(ExcelHelper helperRead)
        {
            int[] startRowInExcel = new int[] { 3, 4, 6, 16 };                                                  // набор чисел, откуда начинать считывание из excel
            List<string> columnsOfVariables = new List<string> { "B", "D" };                                    // список столбцов для считывания переменных из excel
            List<string> columnsOfMatrix = new List<string> { "G", "H", "I", "J", "K", "L", "M", "N", "O" };    // список столбцов для считывания матриц из excel

            N = ReadValueFromExcel(row: startRowInExcel[0], column: columnsOfVariables[0], helperRead);
            variant = ReadValueFromExcel(row: startRowInExcel[0], column: columnsOfVariables[1], helperRead);
            bandwidth = ReadValueFromExcel(row: startRowInExcel[2], column: columnsOfVariables[0], helperRead);

            M = new int[N, N];
            S = new int[N, N];

            M = ReadMatrixFromExcel(startRow: startRowInExcel[1], countOfRows: M.GetLength(dimension: 0), columns: columnsOfMatrix, helperRead);
            S = ReadMatrixFromExcel(startRow: startRowInExcel[3], countOfRows: S.GetLength(dimension: 0), columns: columnsOfMatrix, helperRead);
            allNodes = ReadListFromExcel(row: startRowInExcel[0], columns: columnsOfMatrix, helperRead);
        }
        #endregion

        #region Типовой расчет 1
        private static void TR1(ExcelHelper helperWrite)
        {
            int Q = 0;          // значение целевой функции
            int min;            // найденный на i-ом шаге минимум
            int rowMin;         // номер строки найденного на i-ом шаге минимума
            int columnMin;      // номер стоолбца найденного на i-ом шаге минимума
            string F;           // строка для вывода фрагмента сети

            List<string> columnsVariablesInExcel = new List<string> { "M" };                                                    // список столбцов для вывода вычисляемых переменных
            List<string> columnsConnectivityMatrixInExcel = new List<string> { "P", "Q", "R", "S", "T", "U", "V", "W", "X" };   // список столбцов для вывода матрицы связности в excel
            List<string> columnsMatrixInExcel = new List<string> { "C", "D", "E", "F", "G", "H", "I", "J", "K" };               // список столбцов для вывода матрицы расстояний в excel
            int[] startRowInExcel = new int[] { 6, 17, 18, 21 };                                                                // набор чисел, откуда начинать заполнение в excel
            int stepRowInExcel = 26;                                                                                            // переменная "где заполнять следующий шаг" в excel

            int[,] matrix = M;                                                      // матрица расстояний на i-ом шаге
            int[,] connectivityMatrix = new int[N, N];                              // матрица связности на i-ом шаге
            List<int> nodesInNetwork = new List<int>(N);                            // номера узлов во фрагменте
            List<int> rowsToFindMin = new List<int> { 0, 1, 2, 3, 4, 5, 6, 7, 8 };  // номера строк, в которых нужно искать минимум
            List<int> numbersOfNodes = new List<int>(allNodes);                     // список номеров узлов

            for (int i = 0; i < N - 1; i++)
            {
                Console.WriteLine($"\nШаг {i + 1}");

                // Запись в excel матрицы расстояний на i-ом шаге:
                WriteListToExcel(row: startRowInExcel[0] + stepRowInExcel * i - 1, columns: columnsMatrixInExcel, data: numbersOfNodes, helperWrite);
                WriteMatrixToExcel(startRow: startRowInExcel[0] + stepRowInExcel * i, columns: columnsMatrixInExcel, data: matrix, helperWrite);

                // Вывод в консоль матрицы расстояний на i-ом шаге:
                PrintMatrix(matrix: matrix, $"M_before_step_{i + 1}");

                // Поиск минимального значения в матрице расстояний на i-ом шаге:
                min = FindMinimumInRows(matrix: matrix, rows: rowsToFindMin, out rowMin, out columnMin);

                // На каждом шаге к фрагменту сети добавляется узел по номеру столбца найденного минимума:
                nodesInNetwork.Add(numbersOfNodes[columnMin]);

                if (i == 0)
                {
                    // На первом шаге к фрагменту сети также добавляется узел по номеру строки найденного минимума:
                    nodesInNetwork.Add(numbersOfNodes[rowMin]);

                    rowsToFindMin.Clear();

                    // На первом шаге из матрицы расстояний удаляется 2 столбца:
                    rowsToFindMin.Add(Math.Max(rowMin, columnMin));
                    matrix = DeleteColumnFromMatrix(matrix: matrix, numberColumnToDelete: rowsToFindMin.Last());
                    rowsToFindMin.Add(Math.Min(rowMin, columnMin));
                    matrix = DeleteColumnFromMatrix(matrix: matrix, numberColumnToDelete: rowsToFindMin.Last());

                    // Изменение матрицы смежности:
                    connectivityMatrix[rowMin, columnMin] = 1;
                    connectivityMatrix[columnMin, rowMin] = 1;

                    numbersOfNodes.Remove(numbersOfNodes[Math.Max(rowMin, columnMin)]);
                    numbersOfNodes.Remove(numbersOfNodes[Math.Min(rowMin, columnMin)]);
                }
                else
                {
                    rowsToFindMin.Add(numbersOfNodes[columnMin] - 1);
                    matrix = DeleteColumnFromMatrix(matrix: matrix, numberColumnToDelete: columnMin);

                    // Изменение матрицы смежности:
                    connectivityMatrix[rowMin, numbersOfNodes[columnMin] - 1] = 1;
                    connectivityMatrix[numbersOfNodes[columnMin] - 1, rowMin] = 1;

                    numbersOfNodes.Remove(numbersOfNodes[columnMin]);
                }

                nodesInNetwork.Sort();
                F = ListToString(list: nodesInNetwork);

                // Запись в excel найденного минимума:
                WriteValueToExcel(row: startRowInExcel[0] + stepRowInExcel * i, column: columnsVariablesInExcel[0], data: min.ToString(), helperWrite);
                // Запись в excel текущего фрагмента сети:
                WriteValueToExcel(row: startRowInExcel[2] + stepRowInExcel * i, column: columnsVariablesInExcel[0], data: $"Ф = {F}", helperWrite);
                // Запись в excel текущего значения целевой функции:
                WriteValueToExcel(row: startRowInExcel[3] + stepRowInExcel * i, column: columnsVariablesInExcel[0], data: $"Q = {Q} + {min} = {Q + min}", helperWrite);
                // Запись в excel матрицы связности после i-го шага:
                WriteMatrixToExcel(startRow: startRowInExcel[2] + stepRowInExcel * i, columns: columnsConnectivityMatrixInExcel, data: connectivityMatrix, helperWrite);

                // Вывод в консоль найденного минимума:
                Console.WriteLine($"\nНайденный минимум = {min}");
                // Вывод в консоль текущего фрагмента сети:
                Console.WriteLine($"\nТекущий фрагмент сети F = {F}");
                // Вывод в консоль текущего значения целевой функции:
                Console.WriteLine($"\nТекущее значение целевой функции Q = {Q} + {min} = {Q + min}");
                // Вывод в консоль матрицы связности после i-го шага:
                PrintMatrix(matrix: connectivityMatrix, $"connectivityMatrix_after_step_{i + 1}");

                // Увеличение целевой функции:
                Q += min;

                // На 1-ом шаге матрица расстояний уменьшается на 2 столбца, а на всех остальных - на 1:
                if (i == 0)
                {
                    columnsMatrixInExcel.Remove(columnsMatrixInExcel.Last());
                }
                columnsMatrixInExcel.Remove(columnsMatrixInExcel.Last());

                // Запись в excel матрицы расстояний после i-го шага (после N-1 шага матрицы уже не будет):
                if (i < N - 2)
                {
                    WriteListToExcel(row: startRowInExcel[2] + stepRowInExcel * i - 1, columns: columnsMatrixInExcel, data: numbersOfNodes, helperWrite);
                    WriteMatrixToExcel(startRow: startRowInExcel[2] + stepRowInExcel * i, columns: columnsMatrixInExcel, data: matrix, helperWrite);

                    // Вывод в консоль матрицы расстояний после i-го шага:
                    PrintMatrix(matrix: matrix, $"M_after_step_{i + 1}");
                }
            }
        }

        private static int FindMinimumInRows(int[,] matrix, List<int> rows, out int rowMin, out int columnMin)
        {
            int numberNodeMin = int.MaxValue;

            int min = int.MaxValue;
            columnMin = 0;
            rowMin = 0;

            int countOfColumns = matrix.GetLength(dimension: 1);

            foreach (int row in rows)
            {
                for (int j = 0; j < countOfColumns; j++)
                {
                    if ((matrix[row, j] < min && matrix[row, j] != 0) || (matrix[row, j] == min && (row < numberNodeMin || j < numberNodeMin)))
                    {
                        numberNodeMin = Math.Min(rowMin, columnMin);
                        min = matrix[row, j];
                        columnMin = j;
                        rowMin = row;
                    }
                }
            }

            return min;
        }

        private static int[,] DeleteRowFromMatrix(int[,] matrix, int numberRowToDelete)
        {
            int countOfRows = matrix.GetLength(dimension: 0) - 1;
            int countOfColumns = matrix.GetLength(dimension: 1);

            int[,] newMatrix = new int[countOfRows, countOfColumns];

            for (int i = 0; i < countOfRows; i++)
            {
                if (i < numberRowToDelete)
                {
                    for (int j = 0; j < countOfColumns; j++)
                    {
                        newMatrix[i, j] = matrix[i, j];
                    }
                }
                else
                {
                    for (int j = 0; j < countOfColumns; j++)
                    {
                        newMatrix[i, j] = matrix[i + 1, j];
                    }
                }
            }

            return newMatrix;
        }

        private static int[,] DeleteColumnFromMatrix(int[,] matrix, int numberColumnToDelete)
        {
            int countOfRows = matrix.GetLength(dimension: 0);
            int countOfColumns = matrix.GetLength(dimension: 1) - 1;

            int[,] newMatrix = new int[countOfRows, countOfColumns];

            for (int i = 0; i < countOfRows; i++)
            {
                for (int j = 0; j < countOfColumns; j++)
                {
                    if (j < numberColumnToDelete)
                    {
                        newMatrix[i, j] = matrix[i, j];
                    }
                    else
                    {
                        newMatrix[i, j] = matrix[i, j + 1];
                    }
                }
            }

            return newMatrix;
        }
        #endregion

        #region Типовой расчет 2
        private static void TR2(ExcelHelper helperWrite)
        {
            int min;            // найденный на i-ом шаге минимум
            int rowMin;         // номер строки найденного на i-ом шаге минимума
            int columnMin;      // номер стоолбца найденного на i-ом шаге минимума

            List<string> columnsVariablesInExcel = new List<string> { "M" };                                            // список столбцов для вывода вычисляемых переменных
            List<string> columnsItterMatrixInExcel = new List<string> { "P", "Q", "R", "S", "T", "U", "V", "W", "X" };  // список столбцов для вывода матриц
            List<string> columnsMatrixInExcel = new List<string> { "C", "D", "E", "F", "G", "H", "I", "J", "K" };       // список столбцов для вывода матриц
            int[] startRowInExcel = new int[] { 6, 9, 12, 18, 30 };                                                     // набор чисел, откуда начинать заполнение в excel
            int stepRowInExcel = 38;                                                                                    // переменная "где заполнять следующий шаг" в excel

            List<int> nodesForDelete = new List<int>();             // список номеров узлов для удаления из исходной матрицы
            List<int> numbersOfNodes = new List<int>(allNodes);     // список номеров узлов
            List<int> rowsToFindMin = new List<int> { 2 };          // номера строк, в которых нужно искать минимум
            List<int> centralNodesOfGroup = new List<int>();        // список с номерами узлов-центров группы
            List<int> nodesInGroup;                                 // список с номерами узлов группы

            int bandwidthGroup = bandwidth;
            int[][] sortedColumns;
            int[,] curentMatrix;                                    // матрица расстояний на i-ом шаге

            for (int i = 0; i < N / 3 + 1; i++)
            {
                if (i < N / 3)
                {
                    curentMatrix = M;

                    foreach (int node in nodesForDelete)
                    {
                        curentMatrix = DeleteColumnFromMatrix(matrix: curentMatrix, numberColumnToDelete: node - 1);
                        curentMatrix = DeleteRowFromMatrix(matrix: curentMatrix, numberRowToDelete: node - 1);
                    }
                }
                else
                {
                    numbersOfNodes = centralNodesOfGroup;
                    numbersOfNodes.Sort();
                    curentMatrix = CreateMatrixOfСenters(matrix: M, rows: numbersOfNodes);
                }

                // Вывод в консоль матрицы расстояний на i-ом шаге:
                PrintMatrix(matrix: curentMatrix, matrixName: "curentMatrix");

                // Запись в excel матрицы расстояний на 1-ом шаге:
                WriteListToExcel(row: startRowInExcel[0] + stepRowInExcel * i - 1, columns: columnsItterMatrixInExcel, data: numbersOfNodes, helperWrite);
                WriteMatrixToExcel(startRow: startRowInExcel[0] + stepRowInExcel * i, columns: columnsItterMatrixInExcel, data: curentMatrix, helperWrite);

                // Формирование упорядоченной матрицы !M на i-ом шаге:
                int[,] sortedMatrix = FindSortedMatrix(matrix: curentMatrix, rows: numbersOfNodes, columns: numbersOfNodes, out sortedColumns);
                // Формирование матрицы номеров MK на i-ом шаге:
                int[,] MatrixOfNumbers;
                MatrixOfNumbers = FindMatrixOfNumbers(matrix: M, sortedColumns: sortedColumns, rows: numbersOfNodes, columns: numbersOfNodes);
                // Формирование сумманой матрицы MС на i-ом шаге:
                int[,] summaryMatrix = FindSummaryMatrix(arrayOfArrays: sortedColumns, rows: numbersOfNodes, columns: numbersOfNodes);
                // Поиск минимума i-ом шаге:
                min = FindMinimumInRows(matrix: summaryMatrix, rows: rowsToFindMin, out rowMin, out columnMin);
                // Поиск узлов группы на i-ом шаге:
                nodesInGroup = FindNodesInGroup(matrixOfNumbers: MatrixOfNumbers, columnMin: columnMin, bandwidth: bandwidthGroup);

                // Добавляем центр группы к списку центров групп:
                centralNodesOfGroup.Add(nodesInGroup.First());

                nodesForDelete.AddRange(nodesInGroup);
                nodesForDelete.Sort();
                nodesForDelete.Reverse();

                // Вывод в консоль упорядоченной матрицы !M на i-ом шаге:
                PrintMatrix(matrix: sortedMatrix, "!M");
                // Вывод в консоль матрицы номеров MK на i-ом шаге:
                PrintMatrix(MatrixOfNumbers, "MK");
                // Вывод в консоль сумманой матрицы MС на i-ом шаге:
                PrintMatrix(summaryMatrix, "MC");
                // Вывод в консоль найденного минимума:
                Console.WriteLine($"\nНайденный минимум = {min}");
                // Вывод в консоль узлов группы на i-ом шаге:
                Console.WriteLine($"\nСписок {{Y[i]}} = {ListToString(list: nodesInGroup)}");

                // Запись в excel упорядоченной матрицы !M на i-ом шаге:
                WriteListToExcel(row: startRowInExcel[0] + stepRowInExcel * i - 1, columns: columnsMatrixInExcel, data: numbersOfNodes, helperWrite);
                WriteMatrixToExcel(startRow: startRowInExcel[0] + stepRowInExcel * i, columns: columnsMatrixInExcel, data: sortedMatrix, helperWrite);
                // Запись в excel матрицы номеров MK на i-ом шаге:
                WriteListToExcel(row: startRowInExcel[3] + stepRowInExcel * i - 1, columns: columnsMatrixInExcel, data: numbersOfNodes, helperWrite);
                WriteMatrixToExcel(startRow: startRowInExcel[3] + stepRowInExcel * i, columns: columnsMatrixInExcel, data: MatrixOfNumbers, helperWrite);
                // Запись в excel сумманой матрицы MС на i-ом шаге:
                WriteListToExcel(row: startRowInExcel[4] + stepRowInExcel * i - 1, columns: columnsMatrixInExcel, data: numbersOfNodes, helperWrite);
                WriteMatrixToExcel(startRow: startRowInExcel[4] + stepRowInExcel * i, columns: columnsMatrixInExcel, data: summaryMatrix, helperWrite);
                // Запись в excel найденного минимума:
                WriteValueToExcel(row: startRowInExcel[0] + stepRowInExcel * i, column: columnsVariablesInExcel[0], data: min.ToString(), helperWrite);
                // Запись в excel группы на i-ом шаге:
                WriteValueToExcel(row: startRowInExcel[1] + stepRowInExcel * i, column: columnsVariablesInExcel[0], data: ListToString(list: nodesInGroup), helperWrite);
                // Запись в excel центра группы на i-ом шаге:
                WriteValueToExcel(row: startRowInExcel[2] + stepRowInExcel * i, column: columnsVariablesInExcel[0], data: nodesInGroup.First().ToString(), helperWrite);

                nodesInGroup.Sort();

                if (i < N / 3 - 1)
                {
                    for (int index = 2; index >= 0; index--)
                    {
                        numbersOfNodes.RemoveAt(numbersOfNodes.IndexOf(nodesInGroup[index]));
                        columnsMatrixInExcel.Remove(columnsMatrixInExcel.Last());
                        columnsItterMatrixInExcel.Remove(columnsItterMatrixInExcel.Last());
                    }
                }

                nodesInGroup.Clear();
            }
        }

        private static int[,] FindSortedMatrix(int[,] matrix, List<int> rows, List<int> columns, out int[][] sortedColumns)
        {
            int countOfRows = rows.Count;
            int countOfColumns = columns.Count;

            sortedColumns = MatrixToArrayOfArrays(matrix: matrix);

            for (int i = 0; i < countOfRows; i++)
            {
                sortedColumns[i] = sortedColumns[i].OrderBy(x => x).ToArray();
            }

            int[,] sortedMatrix = new int[countOfRows, countOfColumns];

            foreach (int row in rows)
            {
                foreach (int column in columns)
                {
                    sortedMatrix[rows.IndexOf(row), columns.IndexOf(column)] = sortedColumns[columns.IndexOf(column)][rows.IndexOf(row)];
                }
            }

            return sortedMatrix;
        }

        private static int[,] FindMatrixOfNumbers(int[,] matrix, int[][] sortedColumns, List<int> rows, List<int> columns)
        {
            int countOfRows = rows.Count;
            int countOfColumns = columns.Count;

            int[][] arrayOfArrays = MatrixToArrayOfArrays(matrix: matrix);

            int[,] matrixOfNumbers = new int[countOfRows, countOfColumns];

            foreach (int row in rows)
            {
                foreach (int column in columns)
                {
                    matrixOfNumbers[rows.IndexOf(row), columns.IndexOf(column)] = Array.IndexOf(arrayOfArrays[row - 1], sortedColumns[rows.IndexOf(row)][columns.IndexOf(column)], 0) + 1;

                    for (int k = 0; k < columns.IndexOf(column); k++)
                    {
                        if (!columns.Contains(matrixOfNumbers[rows.IndexOf(row), columns.IndexOf(column)]) || matrixOfNumbers[rows.IndexOf(row), columns.IndexOf(column)] == matrixOfNumbers[rows.IndexOf(row), k])
                        {
                            matrixOfNumbers[rows.IndexOf(row), columns.IndexOf(column)] = Array.IndexOf(arrayOfArrays[row - 1], sortedColumns[rows.IndexOf(row)][columns.IndexOf(column)], matrixOfNumbers[rows.IndexOf(row), columns.IndexOf(column)] + 1) + 1;
                        }
                    }
                }
            }

            return TransposeMatrix(MatrixsToTranspose: matrixOfNumbers);
        }

        private static int[,] FindSummaryMatrix(int[][] arrayOfArrays, List<int> rows, List<int> columns)
        {
            int countOfRows = rows.Count;
            int countOfColumns = columns.Count;

            int[,] summaryMatrix = new int[countOfRows, countOfColumns];

            foreach (int row in rows)
            {
                foreach (int column in columns)
                {
                    for (int k = 0; k <= rows.IndexOf(row); k++)
                    {
                        summaryMatrix[rows.IndexOf(row), columns.IndexOf(column)] += arrayOfArrays[columns.IndexOf(column)][rows.IndexOf(rows[k])];
                    }
                }
            }

            return summaryMatrix;
        }

        private static List<int> FindNodesInGroup(int[,] matrixOfNumbers, int columnMin, int bandwidth)
        {
            List<int> nodesInGroup = new List<int>(bandwidth);

            for (int i = 0; i < bandwidth; i++)
            {
                nodesInGroup.Add(matrixOfNumbers[i, columnMin]);
            }

            return nodesInGroup;
        }

        private static int[,] CreateMatrixOfСenters(int[,] matrix, List<int> rows)
        {
            int size = rows.Count;

            int[,] matrixOfСenters = new int[size, size];

            for (int i = 0; i < size; i++)
            {
                for (int j = 0; j < size; j++)
                {
                    matrixOfСenters[i, j] = matrix[rows[i] - 1, rows[j] - 1];
                }
            }

            return matrixOfСenters;
        }
        #endregion

        #region Типовой расчет 3
        private static void TR3(ExcelHelper helperWrite)
        {
            int w;              // вариант ω
            List<int> Ystart;   // начальный список распределения узлов {Y[i]}
            List<int> Y;        // список распределения узлов {Y[i]}
            List<int> CO;       // список цен {CO[i]}
            int[,] CP;          // матрица цен ||СП[ij]||
            int[,] Q;           // матрица оценки ||Q[ij]||

            int minQ = int.MinValue;    // минимальное значение в матрице ||Q[ij]||
            int rowMin;                 // номер строки найденного на i-ом шаге минимума
            int columnMin;              // номер стоолбца найденного на i-ом шаге минимума

            int swapsNodeFirst = 5;     // первый из узлов, который нужно поменять по заданию
            int swapsNodeSecond = 8;    // второй из узлов, который нужно поменять по заданию

            List<string> columnsVariablesInExcel = new List<string> { "B", "N", "S", "X" };                                 // список столбцов для вывода вычисляемых переменных
            List<string> columnsMatrixCPInExcel = new List<string> { "C", "D", "E", "F", "G", "H", "I", "J", "K" };         // список столбцов для вывода матрицы C в excel
            List<string> columnsMatrixQInExcel = new List<string> { "N", "O", "P", "Q", "R", "S", "T", "U", "V" };          // список столбцов для вывода матрицы Q в excel
            int[] startRowInExcel = new int[] { 7, 11 };                                                                    // набор чисел, откуда начинать заполнение в excel
            int stepRowInExcel = 17;                                                                                        // переменная "где заполнять следующий шаг" в excel
            int countOfSteps;

            // Подсчет варианта ω:
            w = FindW();
            // Формирование начального списка {Y[i]}:
            Ystart = FindY(w, countOfElements: N);

            // Запись в excel варианта ω:
            WriteValueToExcel(row: startRowInExcel[0], column: columnsVariablesInExcel[0], data: w.ToString(), helperWrite);

            // Вывод в консоль найденного варианта ω:
            Console.WriteLine($"\nНайденный вариант w = {w}");

            for (int i = 0; i < 2; i++)
            {
                Y = new List<int>(Ystart);

                if (i > 0)
                {
                    int buffer = Y[swapsNodeFirst - 1];
                    Y[swapsNodeFirst - 1] = Y[swapsNodeSecond - 1];
                    Y[swapsNodeSecond - 1] = buffer;

                    columnsVariablesInExcel.Clear();
                    columnsMatrixCPInExcel.Clear();
                    columnsMatrixQInExcel.Clear();

                    columnsVariablesInExcel = new List<string> { "B", "AL", "AQ", "AV" };
                    columnsMatrixCPInExcel = new List<string> { "AA", "AB", "AC", "AD", "AE", "AF", "AG", "AH", "AI" };     // список столбцов для вывода матрицы C в excel
                    columnsMatrixQInExcel = new List<string> { "AL", "AM", "AN", "AO", "AP", "AQ", "AR", "AS", "AT" };      // список столбцов для вывода матрицы Q в excel
                }

                countOfSteps = 0;
                while (minQ < 0)
                {
                    // Формирование списка {CO[i]}:
                    CO = FindCO(Y);
                    // Формирование матрицы ||CП[ij]||:
                    CP = FindCP(Y);
                    // Формирование матрицы ||Q[ij]||:
                    Q = FindQ(CO, CP);
                    // Поиск минимума в матрице ||Q[ij]||:
                    minQ = FindMinimumInMatrix(matrix: Q, out rowMin, out columnMin);

                    // Вывод в консоль списка {Y[i]}:
                    Console.WriteLine($"\nСписок {{Y[i]}} = {ListToString(list: Y)}");
                    // Вывод в консоль всех слагаемых CO[i]:
                    PrintAllCOTerms(Y);
                    // Вывод в консоль только не нулевых слагаемых CO[i]:
                    PrintNotZeroCOTerms(Y);
                    // Вывод в консоль списка {CO[i]}:
                    Console.WriteLine($"\nСписок {{CO[i]}} = {ListToString(list: CO)}");
                    // Вывод в консоль всех слагаемых СП[ij]:
                    PrintAllCPTerms(Y);
                    // Вывод в консоль только не нулевых слагаемых CП[ij]:
                    PrintNotZeroCPTerms(Y);
                    // Вывод в консоль матрицы ||CП[ij]||:
                    PrintMatrix(matrix: CP, matrixName: "СП");
                    // Вывод в консоль ||Q[ij]||:
                    PrintMatrix(matrix: Q, matrixName: "Q");
                    // Вывод в консоль найденного минимума в матрице ||Q[ij]||:
                    Console.WriteLine($"\nminQ = {minQ}");

                    // Запись в excel списка {Y[i]}:
                    WriteValueToExcel(row: startRowInExcel[0] + stepRowInExcel * countOfSteps, column: columnsVariablesInExcel[1], data: ListToString(list: Y), helperWrite);
                    // Запись в excel списка {CO[i]}:
                    WriteValueToExcel(row: startRowInExcel[0] + stepRowInExcel * countOfSteps, column: columnsVariablesInExcel[2], data: ListToString(list: CO), helperWrite);
                    // Запись в excel матрицы ||CП[ij]||:
                    WriteMatrixToExcel(startRow: startRowInExcel[1] + stepRowInExcel * countOfSteps, columns: columnsMatrixCPInExcel, data: CP, helperWrite);
                    // Запись в excel матрицы ||Q[ij]||:
                    WriteMatrixToExcel(startRow: startRowInExcel[1] + stepRowInExcel * countOfSteps, columns: columnsMatrixQInExcel, data: Q, helperWrite);
                    // Запись в excel найденного минимума в матрице ||Q[ij]||:
                    WriteValueToExcel(row: startRowInExcel[1] + stepRowInExcel * countOfSteps, column: columnsVariablesInExcel[3], data: minQ.ToString(), helperWrite);

                    if (minQ < 0)
                    {
                        int buffer = Y[rowMin];
                        Y[rowMin] = Y[columnMin];
                        Y[columnMin] = buffer;
                        countOfSteps++;
                    }
                }

                minQ = int.MinValue;
            }
        }

        private static int FindW()
        {
            int w = variant % 9;

            if (w < 2)
            {
                w = 2;
            }

            return w;
        }

        private static List<int> FindY(int w, int countOfElements)
        {
            List<int> Y = new List<int>(countOfElements);

            for (int i = 0; i < countOfElements; i++)
            {
                if (0 <= i && i <= countOfElements - w)
                {
                    Y.Add(i + w);
                }
                else
                {
                    Y.Add(i + w - countOfElements);
                }
            }

            return Y;
        }

        private static List<int> FindCO(List<int> Y)
        {
            int countOfElements = Y.Count;

            List<int> CO = new List<int>(countOfElements);
            int sum = 0;

            for (int i = 0; i < countOfElements; i++)
            {
                for (int k = 0; k < countOfElements; k++)
                {
                    sum += S[i, k] * M[Y[i] - 1, Y[k] - 1] + S[k, i] * M[Y[k] - 1, Y[i] - 1];
                }

                CO.Add(sum);
                sum = 0;
            }

            return CO;
        }

        private static int[,] FindCP(List<int> Y)
        {
            int countOfElements = Y.Count;

            int[,] CP = new int[countOfElements, countOfElements];

            // Вывод только не нулевых слагаемых CП[ij]:
            for (int i = 0; i < countOfElements; i++)
            {
                for (int j = 0; j < countOfElements; j++)
                {
                    for (int k = 0; k < countOfElements; k++)
                    {
                        CP[i, j] += S[i, k] * M[Y[j] - 1, Y[k] - 1] + S[k, i] * M[Y[k] - 1, Y[j] - 1];
                    }

                    CP[i, j] += S[i, j] * M[Y[i] - 1, Y[j] - 1] + S[j, i] * M[Y[j] - 1, Y[i] - 1];
                }
            }

            return CP;
        }

        private static int[,] FindQ(List<int> CO, int[,] CP)
        {
            int countOfRows = CP.GetLength(dimension: 0);
            int countOfColumns = CP.GetLength(dimension: 1);

            int[,] Q = new int[countOfRows, countOfColumns];

            for (int i = 0; i < countOfRows; i++)
            {
                for (int j = 0; j < countOfColumns; j++)
                {
                    Q[i, j] = -CO[i] - CO[j] + CP[i, j] + CP[j, i];
                }
            }

            return Q;
        }

        private static int FindMinimumInMatrix(int[,] matrix, out int rowMin, out int columnMin)
        {
            int min = int.MaxValue;
            columnMin = int.MaxValue;
            rowMin = int.MaxValue;

            int countOfRows = matrix.GetLength(dimension: 0);
            int countOfColumns = matrix.GetLength(dimension: 1);

            for (int i = 0; i < countOfRows; i++)
            {
                for (int j = 0; j < countOfColumns; j++)
                {
                    if (matrix[i, j] < min)
                    {
                        min = matrix[i, j];
                        columnMin = j;
                        rowMin = i;
                    }
                }
            }

            return min;
        }
        #endregion

        #region Методы вывода в консоль
        private static void PrintStartInfo()
        {
            Console.WriteLine("Вариант = " + variant + "\tЧисло узлов = " + N);
            PrintMatrix(matrix: M, matrixName: "M");
            PrintMatrix(matrix: S, matrixName: "S");
        }

        private static void PrintMatrix(int[,] matrix, string matrixName)
        {
            int countOfRows = matrix.GetLength(dimension: 0);
            int countOfColumns = matrix.GetLength(dimension: 1);

            Console.WriteLine();

            for (int i = 0; i < countOfRows; i++)
            {
                if (i == countOfRows / 2)
                {
                    Console.Write($"{matrixName} = |");
                }
                else
                {
                    Console.Write(new string(' ', matrixName.Length + 3) + "|");
                }

                for (int j = 0; j < countOfColumns; j++)
                {
                    if (matrix[i, j] < 0)
                    {
                        Console.Write($"{matrix[i, j],-5}");
                    }
                    else
                    {
                        Console.Write($" {matrix[i, j],-4}");
                    }
                }
                Console.WriteLine("|");
            }
        }

        private static void PrintAllCOTerms(List<int> Y)
        {
            string allTerms = "";

            for (int i = 0; i < N; i++)
            {
                Console.Write($"\nCО[{i + 1}] = ");

                for (int k = 0; k < N; k++)
                {
                    allTerms += $"S[{i + 1}{k + 1}]*m[{Y[i]}{Y[k]}] + S[{k + 1}{i + 1}]*m[{Y[k]}{Y[i]}] + ";
                }

                allTerms = allTerms.Substring(startIndex: 0, length: allTerms.Length - 2);

                Console.WriteLine(allTerms);

                allTerms = "";
            }
        }

        private static void PrintNotZeroCOTerms(List<int> Y)
        {
            string NotZeroTerms = "";

            for (int i = 0; i < N; i++)
            {
                NotZeroTerms = $"\nCО[{i + 1}] = ";

                for (int k = 0; k < N; k++)
                {
                    if (S[i, k] != 0)
                    {
                        NotZeroTerms += $"S[{i + 1}{k + 1}]*m[{Y[i]}{Y[k]}] + S[{k + 1}{i + 1}]*m[{Y[k]}{Y[i]}] + ";
                    }
                }

                NotZeroTerms = NotZeroTerms.Substring(startIndex: 0, length: NotZeroTerms.Length - 2);
                NotZeroTerms += "= ";

                int sum = 0;

                for (int k = 0; k < N; k++)
                {
                    if (S[i, k] != 0)
                    {
                        NotZeroTerms += $"{S[i, k]}*{M[Y[i] - 1, Y[k] - 1]} + {S[k, i]}*{M[Y[k] - 1, Y[i] - 1]} + ";
                        sum += S[i, k] * M[Y[i] - 1, Y[k] - 1] + S[k, i] * M[Y[k] - 1, Y[i] - 1];
                    }
                }

                NotZeroTerms = NotZeroTerms.Substring(startIndex: 0, length: NotZeroTerms.Length - 2);
                NotZeroTerms += $"= {sum}";

                Console.WriteLine(NotZeroTerms);
            }
        }

        private static void PrintAllCPTerms(List<int> Y)
        {
            string allTerms = "";

            for (int i = 0; i < N; i++)
            {
                for (int j = 0; j < N; j++)
                {
                    allTerms += $"\nCП[{i + 1}{j + 1}] = ";

                    for (int k = 1; k < N; k++)
                    {
                        allTerms += $"S[{i + 1}{k + 1}]*m[{Y[j]}{Y[k]}] + S[{k + 1}{i + 1}]*m[{Y[k]}{Y[j]}] + ";
                    }

                    allTerms += $"S[{i + 1}{j + 1}]*m[{Y[i]}{Y[j]}] + S[{j + 1}{i + 1}]*m[{Y[j]}{Y[i]}] + ";

                    allTerms = allTerms.Substring(startIndex: 0, length: allTerms.Length - 2);

                    Console.WriteLine(allTerms);

                    allTerms = "";
                }
            }
        }

        private static void PrintNotZeroCPTerms(List<int> Y)
        {
            string NotZeroTerms = "";

            for (int i = 0; i < N; i++)
            {
                for (int j = 0; j < N; j++)
                {
                    NotZeroTerms = $"\nCП[{i + 1}{j + 1}] = ";

                    for (int k = 1; k < N; k++)
                    {
                        if (S[i, k] != 0 && M[Y[j] - 1, Y[k] - 1] != 0)
                        {
                            NotZeroTerms += $"S[{i + 1}{k + 1}]*m[{Y[j]}{Y[k]}] + S[{k + 1}{i + 1}]*m[{Y[k]}{Y[j]}] + ";
                        }
                    }

                    if (S[i, j] != 0 && M[Y[i] - 1, Y[j] - 1] != 0)
                    {
                        NotZeroTerms += $"S[{i + 1}{j + 1}]*m[{Y[i]}{Y[j]}] + S[{j + 1}{i + 1}]*m[{Y[j]}{Y[i]}] + ";
                    }

                    NotZeroTerms = NotZeroTerms.Substring(startIndex: 0, length: NotZeroTerms.Length - 2);
                    NotZeroTerms += "= ";

                    int sum = 0;

                    for (int k = 0; k < N; k++)
                    {
                        if (S[i, k] != 0 && M[Y[j] - 1, Y[k] - 1] != 0)
                        {
                            NotZeroTerms += $"{S[i, k]}*{M[Y[j] - 1, Y[k] - 1]} + {S[k, i]}*{M[Y[k] - 1, Y[j] - 1]} + ";
                            sum += S[i, k] * M[Y[j] - 1, Y[k] - 1] + S[k, i] * M[Y[k] - 1, Y[j] - 1];
                        }
                    }

                    if (S[i, j] != 0 && M[Y[i] - 1, Y[j] - 1] != 0)
                    {
                        NotZeroTerms += $"{S[i, j]}*{M[Y[i] - 1, Y[j] - 1]} + {S[j, i]}*{M[Y[j] - 1, Y[i] - 1]} + ";
                        sum += S[i, j] * M[Y[i] - 1, Y[j] - 1] + S[j, i] * M[Y[j] - 1, Y[i] - 1];
                    }

                    NotZeroTerms = NotZeroTerms.Substring(startIndex: 0, length: NotZeroTerms.Length - 2);
                    NotZeroTerms += $"= {sum}";

                    Console.WriteLine(NotZeroTerms);
                }
            }
        }
        #endregion

        #region Методы cчитывания из excel
        private static int ReadValueFromExcel(int row, string column, ExcelHelper helperRead)
        {
            return int.Parse(helperRead.ReadCell(row: row, column: column));
        }

        private static int[,] ReadMatrixFromExcel(int startRow, int countOfRows, List<string> columns, ExcelHelper helperRead)
        {
            int[,] matrix = new int[countOfRows, columns.Count];

            for (int i = 0; i < countOfRows; i++)
            {
                foreach (string column in columns)
                {
                    int.TryParse(helperRead.ReadCell(row: startRow, column: column), out matrix[i, columns.IndexOf(column)]);
                }

                startRow++;
            }

            return matrix;
        }

        private static List<int> ReadListFromExcel(int row, List<string> columns, ExcelHelper helperRead)
        {
            List<int> list = new List<int>(columns.Count);

            foreach (string column in columns)
            {
                list.Add(int.Parse(helperRead.ReadCell(row: row, column: column)));
            }

            return list;
        }
        #endregion

        #region Методы записи в excel
        private static void WriteMatrixToExcel(int startRow, List<string> columns, int[,] data, ExcelHelper helperWrite)
        {
            int countOfRows = data.GetLength(dimension: 0);

            for (int i = 0; i < countOfRows; i++)
            {
                foreach (string column in columns)
                {
                    helperWrite.WriteInCell(row: startRow, column: column, data: data[i, columns.IndexOf(column)].ToString());
                }

                startRow++;
            }
        }

        private static void WriteMatrixToExcel(List<int> rows, List<string> columns, int[,] data, ExcelHelper helperWrite)
        {
            foreach (int row in rows)
            {
                foreach (string column in columns)
                {
                    helperWrite.WriteInCell(row: row, column: column, data: data[rows.IndexOf(row), columns.IndexOf(column)].ToString());
                }
            }
        }

        private static void WriteListToExcel(int row, List<string> columns, List<int> data, ExcelHelper helperWrite)
        {
            foreach (string column in columns)
            {
                helperWrite.WriteInCell(row: row, column: column, data: data[columns.IndexOf(column)].ToString());
            }
        }

        private static void WriteValueToExcel(int row, string column, string data, ExcelHelper helperWrite)
        {
            helperWrite.WriteInCell(row: row, column: column, data: data.ToString());
        }
        #endregion

        #region Методы преобразования типов
        private static string ListToString(List<int> list)
        {
            string result = "{";

            foreach (int element in list)
            {
                result += (element).ToString() + ", ";
            }

            result = result.Substring(0, result.Length - 2) + "}";

            return result;
        }

        private static int[][] MatrixToArrayOfArrays(int[,] matrix)
        {
            int countOfRows = matrix.GetLength(dimension: 0);
            int countOfColumns = matrix.GetLength(dimension: 1);

            int[][] arrayOfArrays = new int[countOfRows][];

            for (int i = 0; i < countOfRows; i++)
            {
                arrayOfArrays[i] = new int[countOfColumns];

                for (int j = 0; j < countOfColumns; j++)
                {
                    arrayOfArrays[i][j] = matrix[i, j];
                }
            }

            return arrayOfArrays;
        }

        private static int[,] ArrayOfArraysToMatrix(int[][] arrayOfArrays)
        {
            int countOfRows = arrayOfArrays.Length;

            int[,] matrix = new int[countOfRows, arrayOfArrays[0].Length];

            for (int i = 0; i < countOfRows; i++)
            {
                for (int j = 0; j < arrayOfArrays[i].Length; j++)
                {
                    matrix[i, j] = arrayOfArrays[i][j];
                }
            }

            return matrix;
        }

        private static int[,] TransposeMatrix(int[,] MatrixsToTranspose)
        {
            int countOfRows = MatrixsToTranspose.GetLength(dimension: 0);
            int countOfColumns = MatrixsToTranspose.GetLength(dimension: 1);

            int[,] transposedArrayOfArrays = new int[countOfRows, countOfColumns];

            for (int i = 0; i < countOfRows; i++)
            {
                for (int j = 0; j < countOfColumns; j++)
                {
                    transposedArrayOfArrays[i, j] = MatrixsToTranspose[j, i];
                }
            }

            return transposedArrayOfArrays;
        }
        #endregion
    }
}