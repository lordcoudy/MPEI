
namespace SchoolControl
{
    partial class TUTOR
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.coursesDataGridView = new System.Windows.Forms.DataGridView();
            this.studentsDataGridView = new System.Windows.Forms.DataGridView();
            this.SearchButton = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.courseidTextBox = new System.Windows.Forms.TextBox();
            this.pendingDataGridView = new System.Windows.Forms.DataGridView();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.quitButton = new System.Windows.Forms.Button();
            this.label4 = new System.Windows.Forms.Label();
            this.startcourseButton = new System.Windows.Forms.Button();
            this.activecourseTextBox = new System.Windows.Forms.TextBox();
            this.surnameLabel = new System.Windows.Forms.Label();
            this.nameLabel = new System.Windows.Forms.Label();
            this.middlenameLabel = new System.Windows.Forms.Label();
            this.birthdateLabel = new System.Windows.Forms.Label();
            this.educationLabel = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.studentidTextBox = new System.Windows.Forms.TextBox();
            this.label6 = new System.Windows.Forms.Label();
            this.gradeTextBox = new System.Windows.Forms.TextBox();
            this.setgradeButton = new System.Windows.Forms.Button();
            this.courseTextBox = new System.Windows.Forms.TextBox();
            this.label7 = new System.Windows.Forms.Label();
            this.textBox1 = new System.Windows.Forms.TextBox();
            this.button1 = new System.Windows.Forms.Button();
            this.label8 = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.coursesDataGridView)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.studentsDataGridView)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pendingDataGridView)).BeginInit();
            this.SuspendLayout();
            // 
            // coursesDataGridView
            // 
            this.coursesDataGridView.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.coursesDataGridView.Location = new System.Drawing.Point(12, 62);
            this.coursesDataGridView.Name = "coursesDataGridView";
            this.coursesDataGridView.RowTemplate.Height = 25;
            this.coursesDataGridView.Size = new System.Drawing.Size(594, 282);
            this.coursesDataGridView.TabIndex = 1;
            // 
            // studentsDataGridView
            // 
            this.studentsDataGridView.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.studentsDataGridView.Location = new System.Drawing.Point(12, 379);
            this.studentsDataGridView.Name = "studentsDataGridView";
            this.studentsDataGridView.RowTemplate.Height = 25;
            this.studentsDataGridView.Size = new System.Drawing.Size(919, 269);
            this.studentsDataGridView.TabIndex = 2;
            // 
            // SearchButton
            // 
            this.SearchButton.Location = new System.Drawing.Point(292, 350);
            this.SearchButton.Name = "SearchButton";
            this.SearchButton.Size = new System.Drawing.Size(111, 23);
            this.SearchButton.TabIndex = 3;
            this.SearchButton.Text = "Search";
            this.SearchButton.UseVisualStyleBackColor = true;
            this.SearchButton.Click += new System.EventHandler(this.SearchButton_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(12, 353);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(168, 15);
            this.label1.TabIndex = 4;
            this.label1.Text = "Write course id to see students";
            // 
            // courseidTextBox
            // 
            this.courseidTextBox.Location = new System.Drawing.Point(186, 350);
            this.courseidTextBox.Name = "courseidTextBox";
            this.courseidTextBox.Size = new System.Drawing.Size(100, 23);
            this.courseidTextBox.TabIndex = 5;
            // 
            // pendingDataGridView
            // 
            this.pendingDataGridView.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.pendingDataGridView.Location = new System.Drawing.Point(611, 62);
            this.pendingDataGridView.Name = "pendingDataGridView";
            this.pendingDataGridView.RowTemplate.Height = 25;
            this.pendingDataGridView.Size = new System.Drawing.Size(521, 252);
            this.pendingDataGridView.TabIndex = 6;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(12, 44);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(115, 15);
            this.label2.TabIndex = 7;
            this.label2.Text = "All courses you have";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(611, 44);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(167, 15);
            this.label3.TabIndex = 8;
            this.label3.Text = "Pending for activation courses";
            // 
            // quitButton
            // 
            this.quitButton.Location = new System.Drawing.Point(1057, 625);
            this.quitButton.Name = "quitButton";
            this.quitButton.Size = new System.Drawing.Size(75, 23);
            this.quitButton.TabIndex = 9;
            this.quitButton.Text = "QUIT";
            this.quitButton.UseVisualStyleBackColor = true;
            this.quitButton.Click += new System.EventHandler(this.quitButton_Click);
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(746, 353);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(199, 15);
            this.label4.TabIndex = 10;
            this.label4.Text = "Write pending course id to set active";
            // 
            // startcourseButton
            // 
            this.startcourseButton.Location = new System.Drawing.Point(1057, 346);
            this.startcourseButton.Name = "startcourseButton";
            this.startcourseButton.Size = new System.Drawing.Size(75, 23);
            this.startcourseButton.TabIndex = 11;
            this.startcourseButton.Text = "Start";
            this.startcourseButton.UseVisualStyleBackColor = true;
            this.startcourseButton.Click += new System.EventHandler(this.startcourseButton_Click);
            // 
            // activecourseTextBox
            // 
            this.activecourseTextBox.Location = new System.Drawing.Point(951, 347);
            this.activecourseTextBox.Name = "activecourseTextBox";
            this.activecourseTextBox.Size = new System.Drawing.Size(100, 23);
            this.activecourseTextBox.TabIndex = 12;
            // 
            // surnameLabel
            // 
            this.surnameLabel.AutoSize = true;
            this.surnameLabel.Location = new System.Drawing.Point(13, 13);
            this.surnameLabel.Name = "surnameLabel";
            this.surnameLabel.Size = new System.Drawing.Size(38, 15);
            this.surnameLabel.TabIndex = 13;
            this.surnameLabel.Text = "label5";
            // 
            // nameLabel
            // 
            this.nameLabel.AutoSize = true;
            this.nameLabel.Location = new System.Drawing.Point(186, 13);
            this.nameLabel.Name = "nameLabel";
            this.nameLabel.Size = new System.Drawing.Size(38, 15);
            this.nameLabel.TabIndex = 14;
            this.nameLabel.Text = "label6";
            // 
            // middlenameLabel
            // 
            this.middlenameLabel.AutoSize = true;
            this.middlenameLabel.Location = new System.Drawing.Point(372, 13);
            this.middlenameLabel.Name = "middlenameLabel";
            this.middlenameLabel.Size = new System.Drawing.Size(38, 15);
            this.middlenameLabel.TabIndex = 15;
            this.middlenameLabel.Text = "label7";
            // 
            // birthdateLabel
            // 
            this.birthdateLabel.AutoSize = true;
            this.birthdateLabel.Location = new System.Drawing.Point(543, 13);
            this.birthdateLabel.Name = "birthdateLabel";
            this.birthdateLabel.Size = new System.Drawing.Size(38, 15);
            this.birthdateLabel.TabIndex = 16;
            this.birthdateLabel.Text = "label8";
            // 
            // educationLabel
            // 
            this.educationLabel.AutoSize = true;
            this.educationLabel.Location = new System.Drawing.Point(723, 13);
            this.educationLabel.Name = "educationLabel";
            this.educationLabel.Size = new System.Drawing.Size(38, 15);
            this.educationLabel.TabIndex = 17;
            this.educationLabel.Text = "label9";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(936, 435);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(183, 15);
            this.label5.TabIndex = 18;
            this.label5.Text = "Write student\'s ID to set his grade";
            // 
            // studentidTextBox
            // 
            this.studentidTextBox.Location = new System.Drawing.Point(938, 453);
            this.studentidTextBox.Name = "studentidTextBox";
            this.studentidTextBox.Size = new System.Drawing.Size(182, 23);
            this.studentidTextBox.TabIndex = 19;
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(938, 483);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(119, 15);
            this.label6.TabIndex = 20;
            this.label6.Text = "Write student\'s grade";
            // 
            // gradeTextBox
            // 
            this.gradeTextBox.Location = new System.Drawing.Point(938, 502);
            this.gradeTextBox.Name = "gradeTextBox";
            this.gradeTextBox.Size = new System.Drawing.Size(182, 23);
            this.gradeTextBox.TabIndex = 21;
            // 
            // setgradeButton
            // 
            this.setgradeButton.Location = new System.Drawing.Point(1044, 532);
            this.setgradeButton.Name = "setgradeButton";
            this.setgradeButton.Size = new System.Drawing.Size(75, 23);
            this.setgradeButton.TabIndex = 22;
            this.setgradeButton.Text = "Apply";
            this.setgradeButton.UseVisualStyleBackColor = true;
            this.setgradeButton.Click += new System.EventHandler(this.setgradeButton_Click);
            // 
            // courseTextBox
            // 
            this.courseTextBox.Location = new System.Drawing.Point(940, 397);
            this.courseTextBox.Name = "courseTextBox";
            this.courseTextBox.Size = new System.Drawing.Size(182, 23);
            this.courseTextBox.TabIndex = 24;
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(938, 379);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(185, 15);
            this.label7.TabIndex = 23;
            this.label7.Text = "Write course ID to choose student";
            // 
            // textBox1
            // 
            this.textBox1.Location = new System.Drawing.Point(951, 317);
            this.textBox1.Name = "textBox1";
            this.textBox1.Size = new System.Drawing.Size(100, 23);
            this.textBox1.TabIndex = 27;
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(1057, 317);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(75, 23);
            this.button1.TabIndex = 26;
            this.button1.Text = "Start";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Location = new System.Drawing.Point(738, 320);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(207, 15);
            this.label8.TabIndex = 25;
            this.label8.Text = "Write course id to send to termination";
            // 
            // TUTOR
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1145, 661);
            this.Controls.Add(this.textBox1);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.label8);
            this.Controls.Add(this.courseTextBox);
            this.Controls.Add(this.label7);
            this.Controls.Add(this.setgradeButton);
            this.Controls.Add(this.gradeTextBox);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.studentidTextBox);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.educationLabel);
            this.Controls.Add(this.birthdateLabel);
            this.Controls.Add(this.middlenameLabel);
            this.Controls.Add(this.nameLabel);
            this.Controls.Add(this.surnameLabel);
            this.Controls.Add(this.activecourseTextBox);
            this.Controls.Add(this.startcourseButton);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.quitButton);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.pendingDataGridView);
            this.Controls.Add(this.courseidTextBox);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.SearchButton);
            this.Controls.Add(this.studentsDataGridView);
            this.Controls.Add(this.coursesDataGridView);
            this.Name = "TUTOR";
            this.Text = "TUTOR";
            this.Load += new System.EventHandler(this.TUTOR_Load);
            ((System.ComponentModel.ISupportInitialize)(this.coursesDataGridView)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.studentsDataGridView)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pendingDataGridView)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
        private System.Windows.Forms.DataGridView coursesDataGridView;
        private System.Windows.Forms.DataGridView studentsDataGridView;
        private System.Windows.Forms.Button SearchButton;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox courseidTextBox;
        private System.Windows.Forms.DataGridView pendingDataGridView;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Button quitButton;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Button startcourseButton;
        private System.Windows.Forms.TextBox activecourseTextBox;
        private System.Windows.Forms.Label surnameLabel;
        private System.Windows.Forms.Label nameLabel;
        private System.Windows.Forms.Label middlenameLabel;
        private System.Windows.Forms.Label birthdateLabel;
        private System.Windows.Forms.Label educationLabel;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.TextBox studentidTextBox;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.TextBox gradeTextBox;
        private System.Windows.Forms.Button setgradeButton;
        private System.Windows.Forms.TextBox courseTextBox;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.TextBox textBox1;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Label label8;
    }
}