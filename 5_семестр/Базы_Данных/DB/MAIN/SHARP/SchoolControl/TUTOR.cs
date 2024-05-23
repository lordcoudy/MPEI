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

   
    public partial class TUTOR : Form
    {
        SqlConnection SqlCon;

        public int id = -2;
        public TUTOR()
        {
            InitializeComponent();
        }

        private void TUTOR_Load(object sender, EventArgs e)
        {
            string connectionString = @"Data Source=.; Initial Catalog = School_db; Integrated Security = True;"; 
            SqlCon = new SqlConnection(connectionString);
            SqlCommand command;
            SqlDataReader sqlReader;

            SqlCon.Open(); 
            command = new SqlCommand("EXEC tutor_by_id @id", SqlCon); 
            command.Parameters.AddWithValue("id", id); 
            sqlReader = null;
            sqlReader = command.ExecuteReader();
            while (sqlReader.Read())
            {
                surnameLabel.Text = sqlReader[0].ToString();
                nameLabel.Text = sqlReader[1].ToString();
                middlenameLabel.Text = sqlReader[2].ToString();
                birthdateLabel.Text = sqlReader[3].ToString();
                educationLabel.Text = sqlReader[4].ToString();
            }
            sqlReader.Close();
            command.ExecuteNonQuery();
            SqlCon.Close();

            SqlCon.Open(); 
            command = new SqlCommand("EXEC courses_by_tutor @id", SqlCon);
            command.Parameters.AddWithValue("id", id);
            sqlReader = null; 
            sqlReader = command.ExecuteReader(); 
            List<string[]> data = new List<string[]>(); 

            for (int i = 0; i < 9; i++)
            { 
                coursesDataGridView.Columns.Add(i.ToString(), sqlReader.GetName(i));
            }
            while (sqlReader.Read()) 
            {
                data.Add(new string[10]); 
                data[data.Count - 1][0] = sqlReader[0].ToString(); 
                data[data.Count - 1][1] = sqlReader[1].ToString();
                data[data.Count - 1][2] = sqlReader[2].ToString();
                data[data.Count - 1][3] = sqlReader[3].ToString();
                data[data.Count - 1][4] = sqlReader[4].ToString();
                data[data.Count - 1][5] = sqlReader[5].ToString();
                data[data.Count - 1][6] = sqlReader[6].ToString();
                data[data.Count - 1][7] = sqlReader[7].ToString();
                data[data.Count - 1][8] = sqlReader[8].ToString();
                data[data.Count - 1][9] = sqlReader[9].ToString();
            }
            foreach (string[] s in data) 
                coursesDataGridView.Rows.Add(s);
            sqlReader.Close();
            command.ExecuteNonQuery();
            SqlCon.Close();

            SqlCon.Open();
            command = new SqlCommand("EXEC find_pending_courses @id", SqlCon);
            command.Parameters.AddWithValue("id", id);
            sqlReader = null; 
            sqlReader = command.ExecuteReader(); 
            data = new List<string[]>(); 

            for (int i = 0; i < 9; i++)
            { 
                pendingDataGridView.Columns.Add(i.ToString(), sqlReader.GetName(i));
            }
            while (sqlReader.Read()) 
            {
                data.Add(new string[10]); 
                data[data.Count - 1][0] = sqlReader[0].ToString(); 
                data[data.Count - 1][1] = sqlReader[1].ToString();
                data[data.Count - 1][2] = sqlReader[2].ToString();
                data[data.Count - 1][3] = sqlReader[3].ToString();
                data[data.Count - 1][4] = sqlReader[4].ToString();
                data[data.Count - 1][5] = sqlReader[5].ToString();
                data[data.Count - 1][6] = sqlReader[6].ToString();
                data[data.Count - 1][7] = sqlReader[7].ToString();
                data[data.Count - 1][8] = sqlReader[8].ToString();
                data[data.Count - 1][9] = sqlReader[9].ToString();
            }
            foreach (string[] s in data) 
                pendingDataGridView.Rows.Add(s);
            sqlReader.Close();
            command.ExecuteNonQuery();
            SqlCon.Close();

        }

        private void SearchButton_Click(object sender, EventArgs e)
        {
            if (courseidTextBox.TextLength != 0)
            {
                SqlCon.Open(); 
                SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM course_table WHERE tutor = @id", SqlCon); 
                command.Parameters.AddWithValue("id", id);
                int IsExists = (Int32)command.ExecuteScalar(); 
                command.ExecuteNonQuery();
                SqlCon.Close(); 
                if (IsExists > 0)
                {
                    studentsDataGridView.Columns.Clear();
                    SqlCon.Open(); 
                    command = new SqlCommand("exec find_students_by_course @id", SqlCon);
                    command.Parameters.AddWithValue("id", Convert.ToInt32(courseidTextBox.Text));
                    command.ExecuteNonQuery();
                    SqlDataReader sqlReader = null;
                    sqlReader = command.ExecuteReader();
                    List<string[]> data = new List<string[]>();

                    for (int i = 0; i <4; i++)
                    { 
                        studentsDataGridView.Columns.Add(i.ToString(), sqlReader.GetName(i));
                    }
                    while (sqlReader.Read()) 
                    {
                        data.Add(new string[5]);
                        data[data.Count - 1][0] = sqlReader[0].ToString(); 
                        data[data.Count - 1][1] = sqlReader[1].ToString();
                        data[data.Count - 1][2] = sqlReader[2].ToString();
                        data[data.Count - 1][3] = sqlReader[3].ToString();
                        data[data.Count - 1][4] = sqlReader[4].ToString();
                    }
                    foreach (string[] s in data) 
                        studentsDataGridView.Rows.Add(s);
                    sqlReader.Close();
                    command.ExecuteNonQuery();
                    SqlCon.Close(); 
                }
                else
                {
                    MessageBox.Show("Incorrect ID. Can't find course with that code. Try again.");
                }
            }
            else
            {
                MessageBox.Show("Enter Course ID.");
            }
        }

        private void quitButton_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void startcourseButton_Click(object sender, EventArgs e)
        {
            if (activecourseTextBox.TextLength != 0)
            {
                SqlCon.Open();
                SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM course_table where tutor = @id and course_status='waiting for tutor'", SqlCon);
                command.Parameters.AddWithValue("id", id);
                int IsExists = (Int32)command.ExecuteScalar(); 
                command.ExecuteNonQuery();
                SqlCon.Close(); 
                if (IsExists >0) 
                {

                    SqlCon.Open(); 
                    command = new SqlCommand("exec start_course @id", SqlCon); 
                    command.Parameters.AddWithValue("id", Convert.ToInt32(activecourseTextBox.Text));
                    command.ExecuteNonQuery();
                    SqlCon.Close();

                    coursesDataGridView.Columns.Clear();
                    pendingDataGridView.Columns.Clear();
                    SqlCon.Open(); 
                    command = new SqlCommand("EXEC courses_by_tutor @id", SqlCon);
                    command.Parameters.AddWithValue("id", id);
                    SqlDataReader sqlReader = null;
                    sqlReader = command.ExecuteReader(); 
                    List<string[]> data = new List<string[]>();

                    for (int i = 0; i < 9; i++)
                    {
                        coursesDataGridView.Columns.Add(i.ToString(), sqlReader.GetName(i));
                    }
                    while (sqlReader.Read())
                    {
                        data.Add(new string[10]);
                        data[data.Count - 1][0] = sqlReader[0].ToString();
                        data[data.Count - 1][1] = sqlReader[1].ToString();
                        data[data.Count - 1][2] = sqlReader[2].ToString();
                        data[data.Count - 1][3] = sqlReader[3].ToString();
                        data[data.Count - 1][4] = sqlReader[4].ToString();
                        data[data.Count - 1][5] = sqlReader[5].ToString();
                        data[data.Count - 1][6] = sqlReader[6].ToString();
                        data[data.Count - 1][7] = sqlReader[7].ToString();
                        data[data.Count - 1][8] = sqlReader[8].ToString();
                        data[data.Count - 1][9] = sqlReader[9].ToString();
                    }
                    foreach (string[] s in data)
                        coursesDataGridView.Rows.Add(s);
                    sqlReader.Close();
                    command.ExecuteNonQuery();
                    SqlCon.Close();

                    SqlCon.Open(); 
                    command = new SqlCommand("EXEC find_pending_courses @id", SqlCon); 
                    command.Parameters.AddWithValue("id", id);
                    sqlReader = null; 
                    sqlReader = command.ExecuteReader();
                    data = new List<string[]>();

                    for (int i = 0; i < 9; i++)
                    {
                        pendingDataGridView.Columns.Add(i.ToString(), sqlReader.GetName(i));
                    }
                    while (sqlReader.Read())
                    {
                        data.Add(new string[10]);
                        data[data.Count - 1][0] = sqlReader[0].ToString();
                        data[data.Count - 1][1] = sqlReader[1].ToString();
                        data[data.Count - 1][2] = sqlReader[2].ToString();
                        data[data.Count - 1][3] = sqlReader[3].ToString();
                        data[data.Count - 1][4] = sqlReader[4].ToString();
                        data[data.Count - 1][5] = sqlReader[5].ToString();
                        data[data.Count - 1][6] = sqlReader[6].ToString();
                        data[data.Count - 1][7] = sqlReader[7].ToString();
                        data[data.Count - 1][8] = sqlReader[8].ToString();
                        data[data.Count - 1][9] = sqlReader[9].ToString();
                    }
                    foreach (string[] s in data)
                        pendingDataGridView.Rows.Add(s);
                    sqlReader.Close();
                    command.ExecuteNonQuery();
                    SqlCon.Close();
                } else
                {
                    MessageBox.Show("No such waiting course. Try again.");
                }
            }
            else
            {
                MessageBox.Show("Enter Course ID.");
            }
        }

        private void setgradeButton_Click(object sender, EventArgs e)
        {
            if (courseTextBox.TextLength == 0)
            {
                MessageBox.Show("Field \"Course\" cannot be empty.");
            }
            else if (studentidTextBox.TextLength == 0)
            {
                MessageBox.Show("Field \"Student's id\" cannot be empty.");
            }
            else if (gradeTextBox.TextLength == 0)
            {
                MessageBox.Show("Field \"Grade\" cannot be empty.");
            } else
            {
                SqlCon.Open();
                SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM temp_table where student = @student_id and course = @course_id", SqlCon); 
                command.Parameters.AddWithValue("student_id", Convert.ToInt32(studentidTextBox.Text));
                command.Parameters.AddWithValue("course_id", Convert.ToInt32(courseidTextBox.Text));
                int IsExists = (Int32)command.ExecuteScalar(); 
                command.ExecuteNonQuery();
                SqlCon.Close();
                if (IsExists > 0) 
                {
                    SqlCon.Open();
                    command = new SqlCommand("exec grade_student @student_id, @course_id, @grade", SqlCon);
                    command.Parameters.AddWithValue("student_id", Convert.ToInt32(courseTextBox.Text));
                    command.Parameters.AddWithValue("course_id", Convert.ToInt32(studentidTextBox.Text));
                    command.Parameters.AddWithValue("grade", Convert.ToInt32(gradeTextBox.Text));
                    command.ExecuteNonQuery();
                    SqlCon.Close();
                }
                else
                {
                    MessageBox.Show("No such waiting course. Try again.");
                }
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (textBox1.TextLength != 0)
            {
                SqlCon.Open(); 
                SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM course_table where tutor = @id and course_status='active'", SqlCon);
                command.Parameters.AddWithValue("id", id);
                int IsExists = (Int32)command.ExecuteScalar(); 
                command.ExecuteNonQuery();
                SqlCon.Close(); 
                if (IsExists == 1)
                {

                    SqlCon.Open();
                    command = new SqlCommand("exec set_to_terminate @id", SqlCon);
                    command.Parameters.AddWithValue("id", Convert.ToInt32(textBox1.Text));
                    command.ExecuteNonQuery();
                    SqlCon.Close();

                    coursesDataGridView.Columns.Clear();
                    pendingDataGridView.Columns.Clear();
                    SqlCon.Open(); 
                    command = new SqlCommand("EXEC courses_by_tutor @id", SqlCon);
                    command.Parameters.AddWithValue("id", id);
                    SqlDataReader sqlReader = null;
                    sqlReader = command.ExecuteReader();
                    List<string[]> data = new List<string[]>(); 

                    for (int i = 0; i < 9; i++)
                    { 
                        coursesDataGridView.Columns.Add(i.ToString(), sqlReader.GetName(i));
                    }
                    while (sqlReader.Read()) 
                    {
                        data.Add(new string[10]);
                        data[data.Count - 1][0] = sqlReader[0].ToString(); 
                        data[data.Count - 1][1] = sqlReader[1].ToString();
                        data[data.Count - 1][2] = sqlReader[2].ToString();
                        data[data.Count - 1][3] = sqlReader[3].ToString();
                        data[data.Count - 1][4] = sqlReader[4].ToString();
                        data[data.Count - 1][5] = sqlReader[5].ToString();
                        data[data.Count - 1][6] = sqlReader[6].ToString();
                        data[data.Count - 1][7] = sqlReader[7].ToString();
                        data[data.Count - 1][8] = sqlReader[8].ToString();
                        data[data.Count - 1][9] = sqlReader[9].ToString();
                    }
                    foreach (string[] s in data) 
                        coursesDataGridView.Rows.Add(s);
                    sqlReader.Close();
                    command.ExecuteNonQuery();
                    SqlCon.Close();

                    SqlCon.Open();
                    command = new SqlCommand("EXEC find_pending_courses @id", SqlCon);
                    command.Parameters.AddWithValue("id", id);
                    sqlReader = null;
                    sqlReader = command.ExecuteReader();
                    data = new List<string[]>();

                    for (int i = 0; i < 9; i++)
                    { 
                        pendingDataGridView.Columns.Add(i.ToString(), sqlReader.GetName(i));
                    }
                    while (sqlReader.Read()) 
                    {
                        data.Add(new string[10]); 
                        data[data.Count - 1][0] = sqlReader[0].ToString();
                        data[data.Count - 1][1] = sqlReader[1].ToString();
                        data[data.Count - 1][2] = sqlReader[2].ToString();
                        data[data.Count - 1][3] = sqlReader[3].ToString();
                        data[data.Count - 1][4] = sqlReader[4].ToString();
                        data[data.Count - 1][5] = sqlReader[5].ToString();
                        data[data.Count - 1][6] = sqlReader[6].ToString();
                        data[data.Count - 1][7] = sqlReader[7].ToString();
                        data[data.Count - 1][8] = sqlReader[8].ToString();
                        data[data.Count - 1][9] = sqlReader[9].ToString();
                    }
                    foreach (string[] s in data)
                        pendingDataGridView.Rows.Add(s);
                    sqlReader.Close();
                    command.ExecuteNonQuery();
                    SqlCon.Close();
                }
                else
                {
                    MessageBox.Show("No such active course. Try again.");
                }
            }
            else
            {
                MessageBox.Show("Enter Course ID.");
            }
        }
    }
}
