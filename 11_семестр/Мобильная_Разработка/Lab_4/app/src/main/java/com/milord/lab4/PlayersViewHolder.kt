package com.milord.lab4

import android.view.View
import android.widget.CheckBox
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView

class PlayersViewHolder(itemView: View): RecyclerView.ViewHolder(itemView)
{
    val playerName : TextView = itemView.findViewById(R.id.playerNameIt)
    val playerCheckBox : CheckBox = itemView.findViewById(R.id.playerCheckBox)
}

class PlayersViewHolderEx(itemView: View): RecyclerView.ViewHolder(itemView)
{
    val playerName: TextView = itemView.findViewById(R.id.playerNameItEx)
    val playerTeam: TextView = itemView.findViewById(R.id.playerTeam)
}