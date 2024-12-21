package com.milord.lab4

import androidx.annotation.MainThread
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel

class PlayersViewModel: ViewModel()
{
    private val _players = MutableLiveData<ArrayList<Player>>()
    val players: LiveData<ArrayList<Player>> = _players

    private val _teamPlayers = MutableLiveData<ArrayList<Player>>()
    val teamPlayers: LiveData<ArrayList<Player>> = _teamPlayers

    fun updatePlayers(list : ArrayList<Player>) {
        _players.value = list
    }

    fun updateTeamPlayers(list : ArrayList<Player>) {
        _teamPlayers.value = list
    }

    companion object{
        private lateinit var instance: PlayersViewModel

        @MainThread
        fun getInstance(): PlayersViewModel
        {
            instance = if(Companion::instance.isInitialized) instance else PlayersViewModel()
            return instance
        }
    }
}