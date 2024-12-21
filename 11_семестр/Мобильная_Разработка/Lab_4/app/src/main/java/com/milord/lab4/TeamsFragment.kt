package com.milord.lab4

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.activity.OnBackPressedCallback
import androidx.fragment.app.Fragment
import androidx.fragment.app.clearFragmentResult
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.milord.lab4.databinding.FragmentTeamsBinding

class TeamsFragment : Fragment()
{
    private val viewModel = PlayersViewModel.getInstance()
    private lateinit var players: ArrayList<Player>
    private lateinit var binding : FragmentTeamsBinding
    private lateinit var playersAdapter : PlayersAdapterEx
    private lateinit var recyclerView : RecyclerView

    override fun onCreate(savedInstanceState: Bundle?)
    {
        super.onCreate(savedInstanceState)
        activity?.onBackPressedDispatcher?.addCallback(this, object : OnBackPressedCallback(true) {
            override fun handleOnBackPressed() {
                update(ArrayList())
                findNavController().navigate(R.id.action_teamsFragment_to_mainFragment)
            }
        })
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View
    {
        binding = FragmentTeamsBinding.inflate(layoutInflater)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?)
    {
        super.onViewCreated(view, savedInstanceState)
        recyclerView = binding.recyclerViewEx
        val gobackBtn = binding.goBack

        players = viewModel.teamPlayers.value ?: ArrayList()

        viewModel.teamPlayers.observe(viewLifecycleOwner) { dataPlayers ->
            players = dataPlayers
            update(players)
        }

        playersAdapter = PlayersAdapterEx(players)
        recyclerView.layoutManager = LinearLayoutManager(context)
        recyclerView.setHasFixedSize(true)
        recyclerView.adapter = playersAdapter

        gobackBtn.setOnClickListener()
        {
            findNavController().navigate(R.id.action_teamsFragment_to_mainFragment)
        }
    }

    private fun update(newList:ArrayList<Player>){
        players = newList
        playersAdapter = PlayersAdapterEx(players)
        recyclerView.adapter = playersAdapter
    }


}