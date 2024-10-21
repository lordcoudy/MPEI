using System;
using System.IO;
using Microsoft.Office.Interop.Excel;
using Excel = Microsoft.Office.Interop.Excel;

namespace TR_1_2_3
{
    public class ExcelHelper : IDisposable
    {
        private Application _excel;
        private Workbook _workbook;
        private string _filePath;

        public ExcelHelper()
        {
            _excel = new Excel.Application();
            _workbook = null;
            _filePath = null;
        }

        public bool Open(string filePath)
        {
            try
            {
                if (File.Exists(filePath))
                {
                    _workbook = _excel.Workbooks.Open(filePath);
                }
                else
                {
                    _workbook = _excel.Workbooks.Add();
                    _filePath = filePath;
                }

                return true;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            return false;
        }

        public string ReadCell(int row, string column)
        {
            try
            {
                return Convert.ToString(((Excel.Worksheet)_excel.ActiveSheet).Cells[row, column].Value2);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            return "";
        }

        public bool WriteInCell(int row, string column, object data)
        {
            try
            {
                ((Excel.Worksheet)_excel.ActiveSheet).Cells[row, column] = data;

                return true;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            return false;
        }

        public void Save()
        {
            try
            {
                if (!string.IsNullOrEmpty(_filePath))
                {
                    _workbook.SaveAs(_filePath);
                    _filePath = null;
                }
                else
                {
                    _workbook.Save();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }

        public void Dispose()
        {
            try
            {
                _workbook.Close();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }
    }
}
