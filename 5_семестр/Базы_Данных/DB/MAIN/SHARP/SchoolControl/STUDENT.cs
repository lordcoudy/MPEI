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
    public partial class student_form : Form
    {
        SqlConnection SqlCon;

        public int id = -2;
        public student_form()
        {
            InitializeComponent();
        }


        private void student_form_Load(object sender, EventArgs e)
        {
            string connectionString = @"Data Source=.; Initial Catalog = School_db; Integrated Security = True;"; 
            SqlCon = new SqlConnection(connectionString); 
            SqlCommand command;
            SqlDataReader sqlReader;

            

            SqlCon.Open(); 
            command = new SqlCommand("EXEC student_by_id @id", SqlCon); 
            command.Parameters.AddWithValue("id", id); 
            sqlReader = null; 
            sqlReader = command.ExecuteReader();
            while (sqlReader.Read())
            { 
                surnameLabel.Text = sqlReader[0].ToString(); 
                nameLabel.Text = sqlReader[1].ToString();
                middlenameLabel.Text = sqlReader[2].ToString();
                birthdateLabel.Text = sqlReader[3].ToString();
                socialstatusLabel.Text = sqlReader[4].ToString();
                wealthLabel.Text = sqlReader[5].ToString();
            }
            sqlReader.Close();
            command.ExecuteNonQuery();
            SqlCon.Close();

            

            SqlDataAdapter sqlDa = new SqlDataAdapter("select * from CourseINFO", SqlCon);
            DataTable dataTable = new DataTable();
            sqlDa.Fill(dataTable);
            coursesDataGridView.DataSource = dataTable;

          
            SqlCon.Open(); 
            command = new SqlCommand("EXEC find_courses_by_student @id", SqlCon); 
            command.Parameters.AddWithValue("id", id);
            sqlReader = null; 
            sqlReader = command.ExecuteReader(); 
            List<string[]> data = new List<string[]>(); 
            
            for (int i = 0; i < 8; i++)
            { 
                studentCoursesDataGridView.Columns.Add(i.ToString(), sqlReader.GetName(i));
            }
            while (sqlReader.Read()) 
            {
                data.Add(new string[8]); 
                data[data.Count - 1][0] = sqlReader[0].ToString(); 
                data[data.Count - 1][1] = sqlReader[1].ToString();
                data[data.Count - 1][2] = sqlReader[2].ToString();
                data[data.Count - 1][3] = sqlReader[3].ToString();
                data[data.Count - 1][4] = sqlReader[4].ToString();
                data[data.Count - 1][5] = sqlReader[5].ToString();
                data[data.Count - 1][6] = sqlReader[6].ToString();
                data[data.Count - 1][7] = sqlReader[7].ToString();
            }
            foreach (string[] s in data) 
                studentCoursesDataGridView.Rows.Add(s);
            sqlReader.Close();
            command.ExecuteNonQuery();



            SqlCon.Close();
            
        }


        private void button1_Click(object sender, EventArgs e)
        {
            if(courseidTextBox.TextLength != 0)
            {

                SqlCon.Open(); 
                SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM course_table WHERE id_course = @id", SqlCon); 
                command.Parameters.AddWithValue("id", Convert.ToInt32(courseidTextBox.Text));
                int IsExists = (Int32)command.ExecuteScalar(); 
                command.ExecuteNonQuery();
                SqlCon.Close(); 
                if (IsExists == 1) 
                {
                    SqlCon.Open(); 
                    command = new SqlCommand("exec course_chosen @student_id, @course_id", SqlCon); 
                    command.Parameters.AddWithValue("student_id", id);
                    command.Parameters.AddWithValue("course_id", Convert.ToInt32(courseidTextBox.Text));
                    command.ExecuteNonQuery();
                    SqlCon.Close();

                    studentCoursesDataGridView.Columns.Clear();
                    SqlCon.Open(); 
                    command = new SqlCommand("EXEC student_by_id @id", SqlCon); 
                    command.Parameters.AddWithValue("id", id); 
                    SqlDataReader sqlReader = null; 
                    sqlReader = command.ExecuteReader();
                    while (sqlReader.Read())
                    { 
                        surnameLabel.Text = sqlReader[0].ToString(); 
                        nameLabel.Text = sqlReader[1].ToString();
                        middlenameLabel.Text = sqlReader[2].ToString();
                        birthdateLabel.Text = sqlReader[3].ToString();
                        socialstatusLabel.Text = sqlReader[4].ToString();
                        wealthLabel.Text = sqlReader[5].ToString();
                    }
                    sqlReader.Close();
                    command.ExecuteNonQuery();
                    SqlCon.Close();

                    SqlCon.Open();
                    command = new SqlCommand("EXEC find_courses_by_student @id", SqlCon); 
                    command.Parameters.AddWithValue("id", id);
                    sqlReader = null; 
                    sqlReader = command.ExecuteReader(); 
                    List<string[]> data = new List<string[]>(); 

                    for (int i = 0; i < 8; i++)
                    { 
                        studentCoursesDataGridView.Columns.Add(i.ToString(), sqlReader.GetName(i));
                    }
                    while (sqlReader.Read()) 
                    {
                        data.Add(new string[8]); 
                        data[data.Count - 1][0] = sqlReader[0].ToString(); 
                        data[data.Count - 1][1] = sqlReader[1].ToString();
                        data[data.Count - 1][2] = sqlReader[2].ToString();
                        data[data.Count - 1][3] = sqlReader[3].ToString();
                        data[data.Count - 1][4] = sqlReader[4].ToString();
                        data[data.Count - 1][5] = sqlReader[5].ToString();
                        data[data.Count - 1][6] = sqlReader[6].ToString();
                        data[data.Count - 1][7] = sqlReader[7].ToString();
                    }
                    foreach (string[] s in data) 
                        studentCoursesDataGridView.Rows.Add(s);
                    sqlReader.Close();
                    command.ExecuteNonQuery();
                    SqlCon.Close(); 
                }
                else
                {
                    MessageBox.Show("Incorrect ID. Can't find course with that code. Try again.");
                }
            }else
        {
            MessageBox.Show("Enter Course ID.");
        }
        } 

        private void button2_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        

    }
}

