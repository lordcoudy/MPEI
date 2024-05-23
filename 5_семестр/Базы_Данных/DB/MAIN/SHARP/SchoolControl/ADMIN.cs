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
    public partial class ADMIN : Form
    {

        SqlConnection SqlCon;
        public ADMIN()
        {
            InitializeComponent();
        }



        private void exitButton_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void ADMIN_Load(object sender, EventArgs e)
        {
            string connectionString = @"Data Source=.; Initial Catalog = School_db; Integrated Security = True;"; 
            SqlCon = new SqlConnection(connectionString); 

            SqlDataAdapter sqlDa = new SqlDataAdapter("select * from courseINFO", SqlCon);
            DataTable dataTable = new DataTable();
            sqlDa.Fill(dataTable);
            coursesDataGridView.DataSource = dataTable;

            SqlDataAdapter sqlDa2 = new SqlDataAdapter("select * from tutors_table", SqlCon);
            DataTable dataTable2 = new DataTable();
            sqlDa2.Fill(dataTable2);
            tutorsDataGridView.DataSource = dataTable2;

            SqlDataAdapter sqlDa3 = new SqlDataAdapter("select * from students_table", SqlCon);
            DataTable dataTable3 = new DataTable();
            sqlDa3.Fill(dataTable3);
            studentsDataGridView.DataSource = dataTable3;

        }

        private void fireButton_Click(object sender, EventArgs e)
        {
            if (fireTextBox.TextLength != 0)
            {
                SqlCon.Open(); 
                SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM tutors_table where id_tutor = @id", SqlCon); 
                command.Parameters.AddWithValue("id", Convert.ToInt32(fireTextBox.Text));
                int IsExists = (Int32)command.ExecuteScalar(); 
                command.ExecuteNonQuery();
                SqlCon.Close(); 
                if (IsExists == 1) 
                {
                    SqlCon.Open(); 
                    command = new SqlCommand("exec fire_tutor @id", SqlCon);
                    command.Parameters.AddWithValue("id", Convert.ToInt32(fireTextBox.Text));
                    command.ExecuteNonQuery();
                    SqlCon.Close();
                    SqlDataAdapter sqlDa = new SqlDataAdapter("select * from courseINFO", SqlCon);
                    DataTable dataTable = new DataTable();
                    sqlDa.Fill(dataTable);
                    coursesDataGridView.DataSource = dataTable;

                    SqlDataAdapter sqlDa2 = new SqlDataAdapter("select * from tutors_table", SqlCon);
                    DataTable dataTable2 = new DataTable();
                    sqlDa2.Fill(dataTable2);
                    tutorsDataGridView.DataSource = dataTable2;

                    SqlDataAdapter sqlDa3 = new SqlDataAdapter("select * from students_table", SqlCon);
                    DataTable dataTable3 = new DataTable();
                    sqlDa3.Fill(dataTable3);
                    studentsDataGridView.DataSource = dataTable3;
                }
                else
                {
                    MessageBox.Show("Can't find tutor with such code. Try again.");
                }
            } else
            {
                MessageBox.Show("Enter Tutor's ID.");
            }
        }

        private void closeButton_Click(object sender, EventArgs e)
        {
            if (coursetodeleteTextBox.TextLength != 0)
            {
                SqlCon.Open(); 
                SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM course_table where id_course = @id", SqlCon); 
                command.Parameters.AddWithValue("id", Convert.ToInt32(coursetodeleteTextBox.Text));
                int IsExists = (Int32)command.ExecuteScalar(); 
                command.ExecuteNonQuery();
                SqlCon.Close(); 
                if (IsExists == 1) 
                {
                    SqlCon.Open(); 
                command = new SqlCommand("exec end_course @course_id", SqlCon);
                command.Parameters.AddWithValue("course_id", Convert.ToInt32(coursetodeleteTextBox.Text));
                command.ExecuteNonQuery();
                SqlCon.Close();
                SqlDataAdapter sqlDa = new SqlDataAdapter("select * from courseINFO", SqlCon);
                DataTable dataTable = new DataTable();
                sqlDa.Fill(dataTable);
                coursesDataGridView.DataSource = dataTable;

                SqlDataAdapter sqlDa2 = new SqlDataAdapter("select * from tutors_table", SqlCon);
                DataTable dataTable2 = new DataTable();
                sqlDa2.Fill(dataTable2);
                tutorsDataGridView.DataSource = dataTable2;

                SqlDataAdapter sqlDa3 = new SqlDataAdapter("select * from students_table", SqlCon);
                DataTable dataTable3 = new DataTable();
                sqlDa3.Fill(dataTable3);
                studentsDataGridView.DataSource = dataTable3;
                }
                else
                {
                    MessageBox.Show("Can't find course with such code. Try again.");
                }
            }
            else
            {
                MessageBox.Show("Enter Tutor's ID.");
            }
        }

        private void updateButton_Click(object sender, EventArgs e)
        {
            if (studentidTextBox.TextLength != 0 && studentwealthTextBox.TextLength != 0)
            {
                SqlCon.Open(); 
                SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM students_table where id_student = @id", SqlCon); 
                command.Parameters.AddWithValue("id", Convert.ToInt32(studentidTextBox.Text));
                int IsExists = (Int32)command.ExecuteScalar(); 
                command.ExecuteNonQuery();
                SqlCon.Close(); 
                if (IsExists == 1) 
                {
                    SqlCon.Open(); 
                command = new SqlCommand("exec update_wealth @id, @wealth", SqlCon);
                command.Parameters.AddWithValue("id", Convert.ToInt32(studentidTextBox.Text));
                command.Parameters.AddWithValue("wealth", Convert.ToInt32(studentwealthTextBox.Text));
                command.ExecuteNonQuery();
                SqlCon.Close();
                SqlDataAdapter sqlDa = new SqlDataAdapter("select * from courseINFO", SqlCon);
                DataTable dataTable = new DataTable();
                sqlDa.Fill(dataTable);
                coursesDataGridView.DataSource = dataTable;

                SqlDataAdapter sqlDa2 = new SqlDataAdapter("select * from tutors_table", SqlCon);
                DataTable dataTable2 = new DataTable();
                sqlDa2.Fill(dataTable2);
                tutorsDataGridView.DataSource = dataTable2;

                SqlDataAdapter sqlDa3 = new SqlDataAdapter("select * from students_table", SqlCon);
                DataTable dataTable3 = new DataTable();
                sqlDa3.Fill(dataTable3);
                studentsDataGridView.DataSource = dataTable3;
                }
                else
                {
                    MessageBox.Show("Can't find student with such code. Try again.");
                }
            }
            else
            {
                MessageBox.Show("Enter Student's ID and wealth.");
            }
        }

        private void updateButton2_Click(object sender, EventArgs e)
        {
            if (studentidTextBox2.TextLength != 0 && studentgradeTextBox.TextLength != 0)
            {
                SqlCon.Open(); 
                SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM temp_table where student = @id and course = @id_course", SqlCon); 
                command.Parameters.AddWithValue("id", Convert.ToInt32(studentidTextBox2.Text));
                command.Parameters.AddWithValue("id_course", Convert.ToInt32(courseTextBox2.Text));
                int IsExists = (Int32)command.ExecuteScalar(); 
                command.ExecuteNonQuery();
                SqlCon.Close(); 
                if (IsExists == 1) 
                {
                    SqlCon.Open(); 
                command = new SqlCommand("exec update_grade @id, @grade, @id_course", SqlCon);
                command.Parameters.AddWithValue("id", Convert.ToInt32(studentidTextBox2.Text));
                command.Parameters.AddWithValue("grade", Convert.ToInt32(studentgradeTextBox.Text));
                command.Parameters.AddWithValue("id_course", Convert.ToInt32(courseTextBox2.Text));
                command.ExecuteNonQuery();
                SqlCon.Close();

                SqlDataAdapter sqlDa = new SqlDataAdapter("select * from courseINFO", SqlCon);
                DataTable dataTable = new DataTable();
                sqlDa.Fill(dataTable);
                coursesDataGridView.DataSource = dataTable;

                SqlDataAdapter sqlDa2 = new SqlDataAdapter("select * from tutors_table", SqlCon);
                DataTable dataTable2 = new DataTable();
                sqlDa2.Fill(dataTable2);
                tutorsDataGridView.DataSource = dataTable2;

                SqlDataAdapter sqlDa3 = new SqlDataAdapter("select * from students_table", SqlCon);
                DataTable dataTable3 = new DataTable();
                sqlDa3.Fill(dataTable3);
                studentsDataGridView.DataSource = dataTable3;
                }
                else
                {
                    MessageBox.Show("Can't find student with such code. Try again.");
                }
            }
            else
            {
                MessageBox.Show("Enter Student's ID and wealth.");
            }
        }

        private void createcourseButton_Click(object sender, EventArgs e)
        {
            if (createnameTextBox.TextLength == 0)
            {
                MessageBox.Show("Field \"Birthdate\" cannot be empty.");
            }
            else if (createdisciplineTextBox.TextLength == 0)
            {
                MessageBox.Show("Field \"Surname\" cannot be empty.");
            }
            else if (createtutorTextBox.TextLength == 0)
            {
                MessageBox.Show("Field \"Name\" cannot be empty.");
            }
            else if (createpriceTextbox.TextLength == 0)
            {
                MessageBox.Show("Field \"Middle name\" cannot be empty.");
            }
            else if (createlengthTextBox.TextLength == 0)
            {
                MessageBox.Show("Field \"Social status\" cannot be empty.");
            }
            else
            {
                SqlCon.Open(); 
                SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM tutors_table where id_tutor = @id", SqlCon); 
                command.Parameters.AddWithValue("id", Convert.ToInt32(createtutorTextBox.Text));
                int IsExists = (Int32)command.ExecuteScalar(); 
                command.ExecuteNonQuery();
                SqlCon.Close(); 
                if (IsExists == 1) 
                {
                    SqlCon.Open();
                command = new SqlCommand("EXEC create_course @name, @discipline, @tutor_id, @price, @course_length", SqlCon);
                command.Parameters.AddWithValue("name", createnameTextBox.Text);
                command.Parameters.AddWithValue("discipline", createdisciplineTextBox.Text);
                command.Parameters.AddWithValue("tutor_id", createtutorTextBox.Text);
                command.Parameters.AddWithValue("price", createpriceTextbox.Text);
                command.Parameters.AddWithValue("course_length", createlengthTextBox.Text);
                command.ExecuteNonQuery();
                command = new SqlCommand("SELECT TOP(1) * FROM course_table ORDER BY id_course DESC", SqlCon);
                SqlDataReader sqlReader = null; 
                sqlReader = null; 
                sqlReader = command.ExecuteReader(); 
                sqlReader.Read();
                int id_course = Convert.ToInt32(sqlReader[0]);
                sqlReader.Close();
                command.ExecuteNonQuery();
                SqlCon.Close();

                MessageBox.Show("Creation was successful. Course id is " + id_course);

                SqlDataAdapter sqlDa = new SqlDataAdapter("select * from courseINFO", SqlCon);
                DataTable dataTable = new DataTable();
                sqlDa.Fill(dataTable);
                coursesDataGridView.DataSource = dataTable;

                SqlDataAdapter sqlDa2 = new SqlDataAdapter("select * from tutors_table", SqlCon);
                DataTable dataTable2 = new DataTable();
                sqlDa2.Fill(dataTable2);
                tutorsDataGridView.DataSource = dataTable2;

                SqlDataAdapter sqlDa3 = new SqlDataAdapter("select * from students_table", SqlCon);
                DataTable dataTable3 = new DataTable();
                sqlDa3.Fill(dataTable3);
                studentsDataGridView.DataSource = dataTable3;
                }
                else
                {
                    MessageBox.Show("Can't find tutor with such code. Try again.");
                }
            }
        }

    }
}
