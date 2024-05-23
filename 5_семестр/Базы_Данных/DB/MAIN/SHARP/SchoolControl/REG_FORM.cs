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
    public partial class REG_FORM : Form
    {
        SqlConnection SqlCon;
        public REG_FORM()
        {
            InitializeComponent();
        }

        private void REG_FORM_Load(object sender, EventArgs e)
        {
            string connectionString = @"Data Source=.; Initial Catalog = School_db; Integrated Security = True;"; 
            SqlCon = new SqlConnection(connectionString); 
        }

        private void regButton_Click(object sender, EventArgs e)
        {
            int id = -1;
            
            if (birthdateTextBox.TextLength == 0)
            {
                MessageBox.Show("Field \"Birthdate\" cannot be empty.");
            }
            else if (surnameTextBox.TextLength == 0)
            {
                MessageBox.Show("Field \"Surname\" cannot be empty.");
            }
            else if (nameTextBox.TextLength == 0)
            {
                MessageBox.Show("Field \"Name\" cannot be empty.");
            }
            else if (middlenameTextBox.TextLength == 0)
            {
                MessageBox.Show("Field \"Middle name\" cannot be empty.");
            }
            else if (socialstatusTextBox.TextLength == 0)
            {
                MessageBox.Show("Field \"Social status\" cannot be empty.");
            }
            else if (wealthTextBox.TextLength == 0)
            {
                MessageBox.Show("Field \"Amount of money\" cannot be empty.");
            }
            else
            {
                    SqlCon.Open();
                    SqlCommand command = new SqlCommand("EXEC add_student @surname, @name, @middlename, @birthdate, @socialstatus, @wealth", SqlCon);
                    command.Parameters.AddWithValue("surname", surnameTextBox.Text);
                command.Parameters.AddWithValue("name", nameTextBox.Text);
                command.Parameters.AddWithValue("middlename", middlenameTextBox.Text);
                command.Parameters.AddWithValue("birthdate", birthdateTextBox.Text);
                command.Parameters.AddWithValue("socialstatus", socialstatusTextBox.Text);
                command.Parameters.AddWithValue("wealth", wealthTextBox.Text);
                command.ExecuteNonQuery();
                    command = new SqlCommand("SELECT TOP(1) * FROM students_table ORDER BY id_student DESC", SqlCon);
                SqlDataReader sqlReader = null; 
                sqlReader = null; 
                    sqlReader = command.ExecuteReader(); 
                    sqlReader.Read();
                    id = Convert.ToInt32(sqlReader[0]);
                    sqlReader.Close();
                    command.ExecuteNonQuery();
                    SqlCon.Close();

                    MessageBox.Show("Registration was successful. Your id is " + id);
                    student_form studentForm = new student_form();

                    studentForm.id = id;
                    studentForm.Show();
                    this.Hide();
                
            }
        }
       
    }
}
