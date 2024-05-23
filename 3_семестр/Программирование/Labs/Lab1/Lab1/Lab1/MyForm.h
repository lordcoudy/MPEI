#pragma once
#include <string>
#include <msclr/marshal_cppstd.h>
#include <iostream>
#include <sstream>
#include <exception>
#include <stdlib.h>

namespace Lab1 {

	using namespace System;
	using namespace System::ComponentModel;
	using namespace System::Collections;
	using namespace System::Windows::Forms;
	using namespace System::Data;
	using namespace System::Drawing;

	/// <summary>
	/// Summary for MyForm
	/// </summary>
	public ref class MyForm : public System::Windows::Forms::Form
	{
	public:
		MyForm(void)
		{
			InitializeComponent();
			//
			//TODO: Add the constructor code here
			//
		}

	protected:
		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		~MyForm()
		{
			if (components)
			{
				delete components;
			}
		}
	private: System::Windows::Forms::TextBox^ textBox1;
	private: System::Windows::Forms::TextBox^ textBox2;
	private: System::Windows::Forms::Button^ button1;
	private: System::Windows::Forms::Label^ Answer;

	protected:

	private:
		/// <summary>
		/// Required designer variable.
		/// </summary>
		System::ComponentModel::Container^ components;

#pragma region Windows Form Designer generated code
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		void InitializeComponent(void)
		{
			this->textBox1 = (gcnew System::Windows::Forms::TextBox());
			this->textBox2 = (gcnew System::Windows::Forms::TextBox());
			this->button1 = (gcnew System::Windows::Forms::Button());
			this->Answer = (gcnew System::Windows::Forms::Label());
			this->SuspendLayout();
			// 
			// textBox1
			// 
			this->textBox1->Location = System::Drawing::Point(12, 12);
			this->textBox1->Name = L"textBox1";
			this->textBox1->Size = System::Drawing::Size(260, 20);
			this->textBox1->TabIndex = 0;
			// 
			// textBox2
			// 
			this->textBox2->Location = System::Drawing::Point(12, 38);
			this->textBox2->Name = L"textBox2";
			this->textBox2->Size = System::Drawing::Size(260, 20);
			this->textBox2->TabIndex = 1;
			// 
			// button1
			// 
			this->button1->Location = System::Drawing::Point(12, 113);
			this->button1->Name = L"button1";
			this->button1->Size = System::Drawing::Size(260, 50);
			this->button1->TabIndex = 2;
			this->button1->Text = L"click to sum";
			this->button1->UseVisualStyleBackColor = true;
			this->button1->Click += gcnew System::EventHandler(this, &MyForm::button1_Click);
			// 
			// Answer
			// 
			this->Answer->AutoSize = true;
			this->Answer->Location = System::Drawing::Point(230, 61);
			this->Answer->Name = L"Answer";
			this->Answer->Size = System::Drawing::Size(42, 13);
			this->Answer->TabIndex = 3;
			this->Answer->Text = L"Answer";
			this->Answer->TextAlign = System::Drawing::ContentAlignment::MiddleCenter;
			// 
			// MyForm
			// 
			this->AutoScaleDimensions = System::Drawing::SizeF(6, 13);
			this->AutoScaleMode = System::Windows::Forms::AutoScaleMode::Font;
			this->BackColor = System::Drawing::SystemColors::Control;
			this->ClientSize = System::Drawing::Size(284, 261);
			this->Controls->Add(this->Answer);
			this->Controls->Add(this->button1);
			this->Controls->Add(this->textBox2);
			this->Controls->Add(this->textBox1);
			this->Name = L"MyForm";
			this->Text = L"MyForm";
			this->ResumeLayout(false);
			this->PerformLayout();

		}
#pragma endregion
	private:
		// std::stoi from binary string to int in special function
		int ParseStringToBinary(std::string str)
		{
			return std::stoi(str, 0, 2);
		}
		std::string itoa(int value, int base) {

			std::string buf;

			// check that the base if valid
			if (base < 2 || base > 16) return buf;

			enum { kMaxDigits = 35 };
			buf.reserve(kMaxDigits); // Pre-allocate enough space.


			int quotient = value;

			// Translating number to string with base:
			do {
				buf += "0123456789abcdef"[std::abs(quotient % base)];
				quotient /= base;
			} while (quotient);

			// Append the negative sign
			if (value < 0) buf += '-';

			std::reverse(buf.begin(), buf.end());
			return buf;
		}
		System::Void button1_Click(System::Object^ sender, System::EventArgs^ e) {
			std::string inp, s1, s2, so;
			int size;
			bool is_s1_negative = false;
			bool is_s2_negative = false;
			inp = msclr::interop::marshal_as< std::string >(textBox1->Text);
			std::stringstream stream(inp);
			if (stream.peek() == '-')
			{
				is_s1_negative = true;
				stream.ignore(1);
			}
			getline(stream, s1, ' ');
			if (stream.peek() == '-')
			{
				is_s2_negative = true;
				stream.ignore(1);
			}
			getline(stream, s2);
			//TODO
			// Check multiple sums (101+-10+100)
			// Do work for 101.01 etc.
			// Make output text unchangable (experiment with different form: label, etc.)
			// Make hint for textBox1
			// Check if stoi and itoa are correct
			// Create asserts or autotests (?)

			int x = ParseStringToBinary(s1);
			int y = ParseStringToBinary(s2);
			int i = 0;
			if (is_s1_negative && is_s2_negative)
			{
				i = (-x - y);
			}
			else if (is_s1_negative)
			{
				i = y - x;
			}
			else if (is_s2_negative)
			{
				i = x - y;
			}
			else
			{
				i = -(-x - y);
			}
			so = itoa(i, 2);
			textBox2->Text = msclr::interop::marshal_as< System::String^ >(so);
			Answer->Text = msclr::interop::marshal_as< System::String^ >(so);
		}
	};
}