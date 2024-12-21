package com.milord.km3_1

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.ListAdapter
import androidx.recyclerview.widget.RecyclerView
import com.milord.km3_1.databinding.ItemVisitorBinding

class VisitorAdapter : ListAdapter<Visitor, VisitorAdapter.VisitorViewHolder>(VisitorDiffCallback()) {

    enum class ViewOption {
        FULL_DATA, NAME_AND_AGE, NAME_AND_WEIGHT
    }

    var viewOption: ViewOption = ViewOption.FULL_DATA

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): VisitorViewHolder {
        val binding = ItemVisitorBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        return VisitorViewHolder(binding)
    }

    override fun onBindViewHolder(holder: VisitorViewHolder, position: Int) {
        val visitor = getItem(position)
        holder.bind(visitor, viewOption)
    }

    class VisitorViewHolder(private val binding: ItemVisitorBinding) : RecyclerView.ViewHolder(binding.root) {
        fun bind(visitor: Visitor, viewOption: ViewOption) {
            binding.visitor = visitor
            binding.viewOption = viewOption
            binding.executePendingBindings()
        }
    }
}

class VisitorDiffCallback : DiffUtil.ItemCallback<Visitor>() {
    override fun areItemsTheSame(oldItem: Visitor, newItem: Visitor): Boolean {
        return oldItem == newItem
    }

    override fun areContentsTheSame(oldItem: Visitor, newItem: Visitor): Boolean {
        return oldItem == newItem
    }
}