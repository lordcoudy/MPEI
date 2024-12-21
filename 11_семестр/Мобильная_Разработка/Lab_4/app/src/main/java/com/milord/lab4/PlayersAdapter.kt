package com.milord.lab4

import android.graphics.Color
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView

class PlayersAdapter(private val list : ArrayList<Player>) : RecyclerView.Adapter<PlayersViewHolder>()
{
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): PlayersViewHolder
    {
        val viewLayout = LayoutInflater.from(parent.context).inflate(
            R.layout.player_item,
            parent,false)
        return PlayersViewHolder(viewLayout)
    }

    override fun getItemCount(): Int = list.size

    override fun onBindViewHolder(holder: PlayersViewHolder, position: Int)
    {
        holder.playerName.text = list[position].name
        holder.playerCheckBox.isChecked = false
    }
}

class PlayersAdapterEx(private val list : ArrayList<Player>) : RecyclerView.Adapter<PlayersViewHolderEx>()
{
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): PlayersViewHolderEx
    {
        val viewLayout = LayoutInflater.from(parent.context).inflate(
            R.layout.player_item_ex,
            parent,false)
        return PlayersViewHolderEx(viewLayout)
    }

    override fun getItemCount(): Int = list.size

    override fun onBindViewHolder(holder: PlayersViewHolderEx, position: Int)
    {
        holder.playerName.text = list[position].name
        holder.playerTeam.text = list[position].team.name
        if (list[position].team == Team.RED)
            holder.playerTeam.setTextColor(Color.RED)
        else
            holder.playerTeam.setTextColor(Color.GREEN)
    }
}