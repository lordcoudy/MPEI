package com.milord.km3_1

import android.content.Intent
import android.os.Bundle
import androidx.activity.viewModels
import androidx.appcompat.app.AppCompatActivity
import androidx.databinding.DataBindingUtil
import com.milord.km3_1.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity() {
    private val viewModel: VisitorViewModel by viewModels()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val binding: ActivityMainBinding = DataBindingUtil.setContentView(this, R.layout.activity_main)
        binding.viewModel = viewModel
        binding.lifecycleOwner = this

        binding.addButton.setOnClickListener {
            val firstName = binding.firstName.text.toString()
            val lastName = binding.lastName.text.toString()
            val height = binding.height.text.toString().toInt()
            val weight = binding.weight.text.toString().toInt()
            val birthYear = binding.birthYear.text.toString().toInt()

            val visitor = Visitor(firstName, lastName, height, weight, birthYear)
            viewModel.addVisitor(visitor)
        }

        binding.showListButton.setOnClickListener {
            val intent = Intent(this, VisitorListActivity::class.java)
            startActivity(intent)
        }
    }
}