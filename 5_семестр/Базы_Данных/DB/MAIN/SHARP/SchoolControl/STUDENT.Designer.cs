
namespace SchoolControl
{
    partial class student_form
    {
        /// <summary>
        ///  Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        ///  Clean up any resources being used.
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
        ///  Required method for Designer support - do not modify
        ///  the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.coursesDataGridView = new System.Windows.Forms.DataGridView();
            this.studentCoursesDataGridView = new System.Windows.Forms.DataGridView();
            this.button1 = new System.Windows.Forms.Button();
            this.button2 = new System.Windows.Forms.Button();
            this.courseidTextBox = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.surnameLabel = new System.Windows.Forms.Label();
            this.nameLabel = new System.Windows.Forms.Label();
            this.middlenameLabel = new System.Windows.Forms.Label();
            this.birthdateLabel = new System.Windows.Forms.Label();
            this.socialstatusLabel = new System.Windows.Forms.Label();
            this.wealthLabel = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.coursesDataGridView)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.studentCoursesDataGridView)).BeginInit();
            this.SuspendLayout();
            // 
            // coursesDataGridView
            // 
            this.coursesDataGridView.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.coursesDataGridView.Location = new System.Drawing.Point(12, 53);
            this.coursesDataGridView.Name = "coursesDataGridView";
            this.coursesDataGridView.RowTemplate.Height = 25;
            this.coursesDataGridView.Size = new System.Drawing.Size(859, 519);
            this.coursesDataGridView.TabIndex = 0;
            // 
            // studentCoursesDataGridView
            // 
            this.studentCoursesDataGridView.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.studentCoursesDataGridView.Location = new System.Drawing.Point(877, 12);
            this.studentCoursesDataGridView.Name = "studentCoursesDataGridView";
            this.studentCoursesDataGridView.RowTemplate.Height = 25;
            this.studentCoursesDataGridView.Size = new System.Drawing.Size(369, 560);
            this.studentCoursesDataGridView.TabIndex = 2;
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(125, 600);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(107, 23);
            this.button1.TabIndex = 4;
            this.button1.Text = "Choose";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // button2
            // 
            this.button2.Location = new System.Drawing.Point(1177, 606);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(69, 23);
            this.button2.TabIndex = 5;
            this.button2.Text = "QUIT";
            this.button2.UseVisualStyleBackColor = true;
            this.button2.Click += new System.EventHandler(this.button2_Click);
            // 
            // courseidTextBox
            // 
            this.courseidTextBox.Location = new System.Drawing.Point(12, 600);
            this.courseidTextBox.Name = "courseidTextBox";
            this.courseidTextBox.Size = new System.Drawing.Size(106, 23);
            this.courseidTextBox.TabIndex = 6;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(13, 582);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(219, 15);
            this.label1.TabIndex = 7;
            this.label1.Text = "Write course ID which you want to go to";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(1177, 582);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(69, 15);
            this.label3.TabIndex = 9;
            this.label3.Text = "Click to exit";
            // 
            // surnameLabel
            // 
            this.surnameLabel.AutoSize = true;
            this.surnameLabel.Location = new System.Drawing.Point(13, 13);
            this.surnameLabel.Name = "surnameLabel";
            this.surnameLabel.Size = new System.Drawing.Size(38, 15);
            this.surnameLabel.TabIndex = 10;
            this.surnameLabel.Text = "label4";
            // 
            // nameLabel
            // 
            this.nameLabel.AutoSize = true;
            this.nameLabel.Location = new System.Drawing.Point(138, 13);
            this.nameLabel.Name = "nameLabel";
            this.nameLabel.Size = new System.Drawing.Size(38, 15);
            this.nameLabel.TabIndex = 11;
            this.nameLabel.Text = "label4";
            // 
            // middlenameLabel
            // 
            this.middlenameLabel.AutoSize = true;
            this.middlenameLabel.Location = new System.Drawing.Point(285, 13);
            this.middlenameLabel.Name = "middlenameLabel";
            this.middlenameLabel.Size = new System.Drawing.Size(38, 15);
            this.middlenameLabel.TabIndex = 12;
            this.middlenameLabel.Text = "label4";
            // 
            // birthdateLabel
            // 
            this.birthdateLabel.AutoSize = true;
            this.birthdateLabel.Location = new System.Drawing.Point(441, 13);
            this.birthdateLabel.Name = "birthdateLabel";
            this.birthdateLabel.Size = new System.Drawing.Size(38, 15);
            this.birthdateLabel.TabIndex = 13;
            this.birthdateLabel.Text = "label4";
            // 
            // socialstatusLabel
            // 
            this.socialstatusLabel.AutoSize = true;
            this.socialstatusLabel.Location = new System.Drawing.Point(578, 13);
            this.socialstatusLabel.Name = "socialstatusLabel";
            this.socialstatusLabel.Size = new System.Drawing.Size(38, 15);
            this.socialstatusLabel.TabIndex = 14;
            this.socialstatusLabel.Text = "label4";
            // 
            // wealthLabel
            // 
            this.wealthLabel.AutoSize = true;
            this.wealthLabel.Location = new System.Drawing.Point(724, 13);
            this.wealthLabel.Name = "wealthLabel";
            this.wealthLabel.Size = new System.Drawing.Size(38, 15);
            this.wealthLabel.TabIndex = 15;
            this.wealthLabel.Text = "label4";
            // 
            // student_form
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1258, 641);
            this.Controls.Add(this.wealthLabel);
            this.Controls.Add(this.socialstatusLabel);
            this.Controls.Add(this.birthdateLabel);
            this.Controls.Add(this.middlenameLabel);
            this.Controls.Add(this.nameLabel);
            this.Controls.Add(this.surnameLabel);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.courseidTextBox);
            this.Controls.Add(this.button2);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.studentCoursesDataGridView);
            this.Controls.Add(this.coursesDataGridView);
            this.Name = "student_form";
            this.Text = "Form1";
            this.Load += new System.EventHandler(this.student_form_Load);
            ((System.ComponentModel.ISupportInitialize)(this.coursesDataGridView)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.studentCoursesDataGridView)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataGridView coursesDataGridView;
        private System.Windows.Forms.DataGridView studentCoursesDataGridView;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Button button2;
        private System.Windows.Forms.TextBox courseidTextBox;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label surnameLabel;
        private System.Windows.Forms.Label nameLabel;
        private System.Windows.Forms.Label middlenameLabel;
        private System.Windows.Forms.Label birthdateLabel;
        private System.Windows.Forms.Label socialstatusLabel;
        private System.Windows.Forms.Label wealthLabel;
    }
}

