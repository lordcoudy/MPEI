package com.milord.km3_1

import android.os.Bundle
import androidx.activity.viewModels
import androidx.appcompat.app.AppCompatActivity
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.LinearLayoutManager
import com.milord.km3_1.databinding.ActivityVisitorListBinding

class VisitorListActivity : AppCompatActivity() {
    private val viewModel: VisitorViewModel by viewModels()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val binding: ActivityVisitorListBinding = DataBindingUtil.setContentView(this, R.layout.activity_visitor_list)
        binding.viewModel = viewModel
        binding.lifecycleOwner = this

        val adapter = VisitorAdapter()
        binding.recyclerView.layoutManager = LinearLayoutManager(this)
        binding.recyclerView.adapter = adapter

        viewModel.visitors.observe(this, Observer { visitors ->
            adapter.submitList(visitors)
        })

        binding.viewOptions.setOnCheckedChangeListener { _, checkedId ->
            adapter.viewOption = when (checkedId) {
                R.id.fullData -> VisitorAdapter.ViewOption.FULL_DATA
                R.id.nameAndAge -> VisitorAdapter.ViewOption.NAME_AND_AGE
                R.id.nameAndWeight -> VisitorAdapter.ViewOption.NAME_AND_WEIGHT
                else -> VisitorAdapter.ViewOption.FULL_DATA
            }
            adapter.notifyDataSetChanged()
        }
    }
}