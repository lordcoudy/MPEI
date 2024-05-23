using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace SchoolControl
{
    public partial class LOGIN : Form
    {

        SqlConnection SqlCon;
        public LOGIN()
        {
            InitializeComponent();
        }

        

        private void LOGIN_Load(object sender, EventArgs e) 
        {
            string connectionString = @"Data Source=.; Initial Catalog = School_db; Integrated Security = True;"; 
            SqlCon = new SqlConnection(connectionString); 
        }

        private void RegisterButton_Click(object sender, EventArgs e)
        {
            REG_FORM regForm = new REG_FORM(); 
            regForm.Show();
            this.Hide();
        }

        private void loginButton_Click(object sender, EventArgs e)
        { 
            int IsExists = -1; 

            if (studentsID.TextLength != 0) 
            {
                SqlCon.Open(); 
                SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM students_table WHERE id_student = @id", SqlCon); 
                command.Parameters.AddWithValue("id", Convert.ToInt32(studentsID.Text));
                IsExists = (Int32)command.ExecuteScalar(); 
                command.ExecuteNonQuery();
                SqlCon.Close(); 

                if (IsExists == 1) 
                {
                    student_form studentForm = new student_form(); 
                    studentForm.id = Convert.ToInt32(studentsID.Text); 
                    studentForm.Show();
                    this.Hide();
                }
                else 
                {
                    MessageBox.Show("Incorrect ID. Can't find student with that code. Try again or register.");
                }
            }
            else 
            {
                MessageBox.Show("Enter ID.");
            }
        }

        private void TutorsLogin_Click(object sender, EventArgs e)
        {
            int IsExists = -1; 

            if (tutorsID.TextLength == 0) 
            {
                MessageBox.Show("Enter ID");
            }
            else 
            {
                SqlCon.Open(); 
                SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM tutors_table WHERE id_tutor = @id", SqlCon); 
                command.Parameters.AddWithValue("id", Convert.ToInt32(tutorsID.Text));
                IsExists = (Int32)command.ExecuteScalar(); 
                command.ExecuteNonQuery();
                SqlCon.Close(); 

                if (IsExists == 1) 
                { 
                        TUTOR tutorForm = new TUTOR(); 
                        tutorForm.id = Convert.ToInt32(tutorsID.Text); 
                        tutorForm.Show();
                        this.Hide();
                
                }
                else 
                {
                    MessageBox.Show("Incorrect ID. Can't find tutor with that code. Try again.");
                }
            }
        }
        private void AdminLogin_Click(object sender, EventArgs e)
        {
                ADMIN adminForm = new ADMIN(); 
                adminForm.Show();
                this.Hide();
        }
        private void button1_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }


    }

}

