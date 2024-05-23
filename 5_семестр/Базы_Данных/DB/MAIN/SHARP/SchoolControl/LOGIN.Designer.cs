
namespace SchoolControl
{
    partial class LOGIN
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
            this.tabControl1 = new System.Windows.Forms.TabControl();
            this.StudentPage = new System.Windows.Forms.TabPage();
            this.RegisterButton = new System.Windows.Forms.Button();
            this.loginButton = new System.Windows.Forms.Button();
            this.studentsID = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.TutorPage = new System.Windows.Forms.TabPage();
            this.tutorsID = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.TutorsLogin = new System.Windows.Forms.Button();
            this.AdminPage = new System.Windows.Forms.TabPage();
            this.label3 = new System.Windows.Forms.Label();
            this.AdminLogin = new System.Windows.Forms.Button();
            this.tabControl1.SuspendLayout();
            this.StudentPage.SuspendLayout();
            this.TutorPage.SuspendLayout();
            this.AdminPage.SuspendLayout();
            this.SuspendLayout();
            // 
            // tabControl1
            // 
            this.tabControl1.Controls.Add(this.StudentPage);
            this.tabControl1.Controls.Add(this.TutorPage);
            this.tabControl1.Controls.Add(this.AdminPage);
            this.tabControl1.Location = new System.Drawing.Point(12, 12);
            this.tabControl1.Name = "tabControl1";
            this.tabControl1.SelectedIndex = 0;
            this.tabControl1.Size = new System.Drawing.Size(249, 215);
            this.tabControl1.TabIndex = 0;
            // 
            // StudentPage
            // 
            this.StudentPage.Controls.Add(this.RegisterButton);
            this.StudentPage.Controls.Add(this.loginButton);
            this.StudentPage.Controls.Add(this.studentsID);
            this.StudentPage.Controls.Add(this.label1);
            this.StudentPage.Location = new System.Drawing.Point(4, 24);
            this.StudentPage.Name = "StudentPage";
            this.StudentPage.Padding = new System.Windows.Forms.Padding(3);
            this.StudentPage.Size = new System.Drawing.Size(241, 187);
            this.StudentPage.TabIndex = 0;
            this.StudentPage.Text = "Students";
            this.StudentPage.UseVisualStyleBackColor = true;
            // 
            // RegisterButton
            // 
            this.RegisterButton.Location = new System.Drawing.Point(6, 158);
            this.RegisterButton.Name = "RegisterButton";
            this.RegisterButton.Size = new System.Drawing.Size(229, 23);
            this.RegisterButton.TabIndex = 3;
            this.RegisterButton.Text = "Register";
            this.RegisterButton.UseVisualStyleBackColor = true;
            this.RegisterButton.Click += new System.EventHandler(this.RegisterButton_Click);
            // 
            // loginButton
            // 
            this.loginButton.Location = new System.Drawing.Point(6, 129);
            this.loginButton.Name = "loginButton";
            this.loginButton.Size = new System.Drawing.Size(228, 23);
            this.loginButton.TabIndex = 2;
            this.loginButton.Text = "Login";
            this.loginButton.UseVisualStyleBackColor = true;
            this.loginButton.Click += new System.EventHandler(this.loginButton_Click);
            // 
            // studentsID
            // 
            this.studentsID.Location = new System.Drawing.Point(6, 59);
            this.studentsID.Name = "studentsID";
            this.studentsID.Size = new System.Drawing.Size(228, 23);
            this.studentsID.TabIndex = 1;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(6, 41);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(126, 15);
            this.label1.TabIndex = 0;
            this.label1.Text = "Enter your student\'s ID";
            // 
            // TutorPage
            // 
            this.TutorPage.Controls.Add(this.tutorsID);
            this.TutorPage.Controls.Add(this.label2);
            this.TutorPage.Controls.Add(this.TutorsLogin);
            this.TutorPage.Location = new System.Drawing.Point(4, 24);
            this.TutorPage.Name = "TutorPage";
            this.TutorPage.Padding = new System.Windows.Forms.Padding(3);
            this.TutorPage.Size = new System.Drawing.Size(241, 187);
            this.TutorPage.TabIndex = 1;
            this.TutorPage.Text = "Tutors";
            this.TutorPage.UseVisualStyleBackColor = true;
            // 
            // tutorsID
            // 
            this.tutorsID.Location = new System.Drawing.Point(6, 60);
            this.tutorsID.Name = "tutorsID";
            this.tutorsID.Size = new System.Drawing.Size(228, 23);
            this.tutorsID.TabIndex = 2;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(7, 42);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(112, 15);
            this.label2.TabIndex = 1;
            this.label2.Text = "Enter your tutor\'s ID";
            // 
            // TutorsLogin
            // 
            this.TutorsLogin.Location = new System.Drawing.Point(6, 158);
            this.TutorsLogin.Name = "TutorsLogin";
            this.TutorsLogin.Size = new System.Drawing.Size(228, 23);
            this.TutorsLogin.TabIndex = 0;
            this.TutorsLogin.Text = "Login";
            this.TutorsLogin.UseVisualStyleBackColor = true;
            this.TutorsLogin.Click += new System.EventHandler(this.TutorsLogin_Click);
            // 
            // AdminPage
            // 
            this.AdminPage.Controls.Add(this.label3);
            this.AdminPage.Controls.Add(this.AdminLogin);
            this.AdminPage.Location = new System.Drawing.Point(4, 24);
            this.AdminPage.Name = "AdminPage";
            this.AdminPage.Padding = new System.Windows.Forms.Padding(3);
            this.AdminPage.Size = new System.Drawing.Size(241, 187);
            this.AdminPage.TabIndex = 2;
            this.AdminPage.Text = "Admin";
            this.AdminPage.UseVisualStyleBackColor = true;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(7, 64);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(93, 15);
            this.label3.TabIndex = 1;
            this.label3.Text = "Login as ADMIN";
            // 
            // AdminLogin
            // 
            this.AdminLogin.Location = new System.Drawing.Point(6, 85);
            this.AdminLogin.Name = "AdminLogin";
            this.AdminLogin.Size = new System.Drawing.Size(229, 23);
            this.AdminLogin.TabIndex = 0;
            this.AdminLogin.Text = "Login";
            this.AdminLogin.UseVisualStyleBackColor = true;
            this.AdminLogin.Click += new System.EventHandler(this.AdminLogin_Click);
            // 
            // LOGIN
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(273, 232);
            this.Controls.Add(this.tabControl1);
            this.Name = "LOGIN";
            this.Text = "LOGIN";
            this.Load += new System.EventHandler(this.LOGIN_Load);
            this.tabControl1.ResumeLayout(false);
            this.StudentPage.ResumeLayout(false);
            this.StudentPage.PerformLayout();
            this.TutorPage.ResumeLayout(false);
            this.TutorPage.PerformLayout();
            this.AdminPage.ResumeLayout(false);
            this.AdminPage.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.TabControl tabControl1;
        private System.Windows.Forms.TabPage StudentPage;
        private System.Windows.Forms.Button RegisterButton;
        private System.Windows.Forms.Button loginButton;
        private System.Windows.Forms.TextBox studentsID;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TabPage TutorPage;
        private System.Windows.Forms.TextBox tutorsID;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Button TutorsLogin;
        private System.Windows.Forms.TabPage AdminPage;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Button AdminLogin;
    }
}