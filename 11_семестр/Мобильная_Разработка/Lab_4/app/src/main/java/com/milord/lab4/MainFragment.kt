package com.milord.lab4

import android.app.AlertDialog
import android.content.DialogInterface
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.EditText
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.milord.lab4.databinding.FragmentMainBinding
import kotlin.random.Random


class MainFragment : Fragment()
{
    private val viewModel = PlayersViewModel.getInstance()
    private lateinit var players: ArrayList<Player>
    private lateinit var binding : FragmentMainBinding
    private lateinit var playersAdapter : PlayersAdapter
    private lateinit var recyclerView : RecyclerView

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View
    {
        binding = FragmentMainBinding.inflate(layoutInflater)
        return binding.root
    }
    override fun onViewCreated(view: View, savedInstanceState: Bundle?)
    {
        super.onViewCreated(view, savedInstanceState)
        val addPlayer = binding.addPlayer
        val updatePlayer = binding.updatePlayer
        val deletePlayer = binding.deletePlayer
        val createTeams = binding.createTeams
        var oldName: String
        recyclerView = binding.recyclerView
        players = if (SaveSharedPreference(requireContext()).getPlayers().isEmpty())
            ArrayList()
        else
            SaveSharedPreference(requireContext()).getPlayers()
        viewModel.updatePlayers(players)

        viewModel.players.observe(viewLifecycleOwner) { dataPlayers ->
            players = dataPlayers
        }

        playersAdapter = PlayersAdapter(players)
        recyclerView.layoutManager = LinearLayoutManager(context)
        recyclerView.setHasFixedSize(false)
        recyclerView.adapter = playersAdapter

        addPlayer.setOnClickListener()
        {
            val alertDialog = AlertDialog.Builder(context)
            val edittext = EditText(context)
            alertDialog.setMessage("Напишите имя игрока")
            alertDialog.setTitle("Новый игрок")

            alertDialog.setView(edittext)

            alertDialog.setPositiveButton(
                "Добавить"
            ) { _, _ -> //What ever you want to do with the value
                if (edittext.text.toString().isEmpty())
                {
                    edittext.error = "Введите имя!"
                }
                else
                {
                    val newPlayer = edittext.text.toString()
                    players.add(Player(newPlayer, Team.NONE))
                    viewModel.updatePlayers(players)
                    update(players)
                }
            }

            alertDialog.setNegativeButton(
                "Отмена",
                DialogInterface.OnClickListener { _, _ ->
                    // what ever you want to do with No option.
                })

            alertDialog.show()
        }

        updatePlayer.setOnClickListener()
        {
            var chosen = false
            for (i in 0 until players.size)
            {
                val holder = recyclerView.findViewHolderForAdapterPosition(i) as PlayersViewHolder
                if (holder.playerCheckBox.isChecked)
                {
                    val alertDialog = AlertDialog.Builder(context)
                    val edittext = EditText(context)
                    alertDialog.setMessage(getString(R.string.change_name))
                    alertDialog.setTitle(holder.playerName.text)
                    edittext.setText(holder.playerName.text)
                    alertDialog.setView(edittext)
                    alertDialog.setPositiveButton(
                        getString(R.string.change)
                    ) { _, _ -> //What ever you want to do with the value
                        if (edittext.text.toString().isEmpty())
                        {
                            edittext.error = getString(R.string.new_name)
                        }
                        else
                        {
                            players = viewModel.players.value!!
                            oldName = holder.playerName.text.toString()
                            val freshPlayer = edittext.text.toString()
                            players.add(players.indexOf(Player(oldName, Team.NONE)), Player(freshPlayer, Team.NONE))
                            players.remove(Player(oldName, Team.NONE))
                            oldName = ""
                            viewModel.updatePlayers(players)
                            update(players)
                        }
                    }

                    alertDialog.setNegativeButton(
                        getString(R.string.cancel),
                        DialogInterface.OnClickListener { _, _ ->
                            // what ever you want to do with No option.
                        })

                    alertDialog.show()
                    chosen = true
                    break
                }
            }
            if (!chosen)
            {
                Toast.makeText(context, getString(R.string.choose_player), Toast.LENGTH_SHORT).show()
                return@setOnClickListener
            }
        }

        deletePlayer.setOnClickListener()
        {
            var chosen = false
            for (i in 0 until players.size)
            {
                val holder = recyclerView.findViewHolderForAdapterPosition(i) as PlayersViewHolder
                if (holder.playerCheckBox.isChecked)
                {
                    players = viewModel.players.value!!
                    chosen = true
                    val removedPlayer = holder.playerName.text.toString()
                    players.remove(Player(removedPlayer, Team.NONE))
                    viewModel.updatePlayers(players)
                    update(players)
                    break
                }
            }
            if (!chosen)
            {
                Toast.makeText(context, getString(R.string.choose_player), Toast.LENGTH_SHORT).show()
                return@setOnClickListener
            }
        }

        createTeams.setOnClickListener()
        {
            val teamPlayers = ArrayList<Player>()
            for (i in 0 until players.size)
            {
                val holder = recyclerView.findViewHolderForAdapterPosition(i) as PlayersViewHolder
                if (holder.playerCheckBox.isChecked)
                {
                    teamPlayers.add(players[i])
                }
            }
            if (teamPlayers.size < 2)
            {
                Toast.makeText(context, getString(R.string.choose_at_least_two), Toast.LENGTH_SHORT).show()
                return@setOnClickListener
            }
            for (i in 0 until teamPlayers.size)
            {
                teamPlayers[i].team = Random.nextBoolean().let { if (it) Team.RED else Team.GREEN }
            }
            viewModel.updateTeamPlayers(teamPlayers)
            findNavController().navigate(R.id.action_mainFragment_to_teamsFragment)
        }
    }

    private fun update(newList:ArrayList<Player>){
        players = newList
        SaveSharedPreference(requireContext()).setPlayers(players)
        playersAdapter = PlayersAdapter(players)
        recyclerView.adapter = playersAdapter
    }
}