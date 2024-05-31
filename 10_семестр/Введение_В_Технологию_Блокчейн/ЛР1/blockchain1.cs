using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Security.Cryptography;
using System.IO;

namespace Blockchain_LR1_files
{
    public partial class Form1 : Form
    {
        string dirPath = "";
        string plainTextFile = "";
        string signedHashFile = "";
        string publicKeyFile = "";

        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }

        // ПОДПИСЬ
        private void button1_Click(object sender, EventArgs e)
        {
            label3.Visible = false;            
            byte[] plainText;
            // чтение открытого текста из файла
            using (FileStream fstream = new FileStream(plainTextFile, FileMode.Open))
            {
                byte[] buffer = new byte[fstream.Length];
                fstream.Read(buffer, 0, buffer.Length);
                plainText = buffer;
            }
            if (plainText.Length == 0) { MessageBox.Show("Файл пуст!"); }
            else
            {
                byte[] signedHash;                  // подписанная хэш-строка
                string publicKey;

                using (SHA256 alg = SHA256.Create())
                {
                    // получение хэша из открытого текста
                    byte[] hash = alg.ComputeHash(plainText);

                    // генерация ЭЦП
                    using (RSA rsa = RSA.Create())
                    {
                        // экспорт открытого ключа
                        publicKey = rsa.ToXmlString(false);

                        // установка параметров для ЭЦП (хэш-функция, ключи)
                        RSAPKCS1SignatureFormatter rsaFormatter = new RSAPKCS1SignatureFormatter(rsa);
                        rsaFormatter.SetHashAlgorithm(nameof(SHA256));

                        // подписанный хэш
                        signedHash = rsaFormatter.CreateSignature(hash);
                    }

                }
                string fnameSigned = dirPath + "/" + textBox1.Text;
                string fnameKey = dirPath + "/" + textBox2.Text;
                // запись подписанного хэша в файл
                using (FileStream fstream = new FileStream(fnameSigned, FileMode.OpenOrCreate))
                {
                    fstream.Write(signedHash, 0, signedHash.Length);
                }
                // запись ключа в файл
                using (StreamWriter writer = new StreamWriter(fnameKey, false))
                {
                    writer.Write(publicKey);
                }

                label3.Text = "Сообщение подписано!";
                label3.Visible = true;
            }
        }

        // ПРОВЕРКА
        private void button2_Click_1(object sender, EventArgs e)
        {
            label3.Visible = false;
            byte[] plainText;

            // чтение открытого текста из файла            
            using (FileStream fstream = new FileStream(plainTextFile, FileMode.Open))
            {
                byte[] buffer = new byte[fstream.Length];
                fstream.Read(buffer, 0, buffer.Length);
                plainText = buffer;
            }
            if (plainText.Length == 0) { MessageBox.Show("Файл пуст!"); }
            else
            {
                byte[] signedHash;               // подписанная хэш-строка
                // чтение подписанной хэш-строки из файла
                using (FileStream fstream = new FileStream(signedHashFile, FileMode.Open))
                {
                    byte[] buffer = new byte[fstream.Length];
                    fstream.Read(buffer, 0, buffer.Length);
                    signedHash = buffer;
                }
                // чтение открытого ключа из файла
                string publicKey;
                using (StreamReader reader = new StreamReader(publicKeyFile))
                {
                    publicKey = reader.ReadToEnd();
                }
                using (SHA256 alg = SHA256.Create())
                {
                    // получение хэша из открытого текста
                    byte[] hash = alg.ComputeHash(plainText);

                    using (RSA rsa = RSA.Create())
                    {
                        // импорт открытого ключа
                        rsa.FromXmlString(publicKey);

                        RSAPKCS1SignatureDeformatter rsaDeformatter = new RSAPKCS1SignatureDeformatter(rsa);
                        rsaDeformatter.SetHashAlgorithm(nameof(SHA256));

                        // проверка ЭЦП
                        if (rsaDeformatter.VerifySignature(hash, signedHash))
                        {
                            label3.Text = "Подлинность подтверждена!";
                            label3.Visible = true;
                        }
                        else
                        {
                            label3.Text = "Ошибка подтверждения!";
                            label3.Visible = true;
                        }
                    }
                }

            }

        }

        private void button2_Click(object sender, EventArgs e)
        {
            
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        // выбор файла с открытым текстом
        private void button3_Click(object sender, EventArgs e)
        {
            using (OpenFileDialog openFileDialog = new OpenFileDialog())
            {
                openFileDialog.InitialDirectory = "c:/Users/Сирин/Desktop/блокчейн/lab1/";
                openFileDialog.Filter = "txt files (*.txt)|*.txt|pub files(*.pub)|*.pub|All files (*.*)|*.*";

                if (openFileDialog.ShowDialog() == DialogResult.OK)
                {
                    plainTextFile = openFileDialog.FileName;

                    label6.Text = plainTextFile;
                    label6.Visible = true;
                }
                else
                {
                    label6.Text = "Файл не выбран";
                    label6.Visible = true;
                }
            }        
        }

        // выбор директории для сохранения
        private void button4_Click(object sender, EventArgs e)
        {
            using (FolderBrowserDialog FBD = new FolderBrowserDialog())
            {
                FBD.ShowNewFolderButton = false;
                if (FBD.ShowDialog() == DialogResult.OK)
                {
                    dirPath = FBD.SelectedPath;
                    label7.Text = dirPath;
                    label7.Visible = true;
                }
                else
                {
                    label7.Text = "Директория не выбрана";
                    label7.Visible = true;
                }
            }            
        }

        // выбор файла с подписанным хэшем
        private void button5_Click(object sender, EventArgs e)
        {
            using (OpenFileDialog openFileDialog = new OpenFileDialog())
            {
                openFileDialog.InitialDirectory = "c:/Users/Сирин/Desktop/блокчейн/lab1/";
                openFileDialog.Filter = "txt files (*.txt)|*.txt|pub files(*.pub)|*.pub|All files (*.*)|*.*";

                if (openFileDialog.ShowDialog() == DialogResult.OK)
                {
                    signedHashFile = openFileDialog.FileName;
                    label8.Text = signedHashFile;
                    label8.Visible = true;
                }
                else
                {
                    label8.Text = "Файл не выбран";
                    label8.Visible = true;
                }
            }
        }

        // выбор файла с ключом
        private void button6_Click(object sender, EventArgs e)
        {
            using (OpenFileDialog openFileDialog = new OpenFileDialog())
            {
                openFileDialog.InitialDirectory = "c:/Users/Сирин/Desktop/блокчейн/lab1/";
                openFileDialog.Filter = "txt files (*.txt)|*.txt|pub files(*.pub)|*.pub|All files (*.*)|*.*";

                if (openFileDialog.ShowDialog() == DialogResult.OK)
                {
                    publicKeyFile = openFileDialog.FileName;

                    label9.Text = publicKeyFile;
                    label9.Visible = true;
                }
                else
                {
                    label9.Text = "Файл не выбран";
                    label9.Visible = true;
                }
            }
        }

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void label11_Click(object sender, EventArgs e)
        {

        }
        
    }
}