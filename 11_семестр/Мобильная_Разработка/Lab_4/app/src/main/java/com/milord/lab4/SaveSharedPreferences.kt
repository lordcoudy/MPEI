package com.milord.lab4

import android.content.Context
import android.content.SharedPreferences

class SaveSharedPreference (context: Context)
{
    companion object {
        const val PREF_PLAYERS = "players"
    }
    private var prefs: SharedPreferences = context.getSharedPreferences(context.getString(R.string.app_name), Context.MODE_PRIVATE)

    fun setPlayers(players : ArrayList<Player>)
    {
        val editor = prefs.edit()
        editor.putStringSet(PREF_PLAYERS, players.map { it.name }.toSet())
        editor.apply()
    }

    fun getPlayers(): ArrayList<Player>
    {
        return prefs.getStringSet(PREF_PLAYERS, setOf())?.map { Player(it, Team.NONE) }?.toCollection(ArrayList()) ?: ArrayList()
    }
}