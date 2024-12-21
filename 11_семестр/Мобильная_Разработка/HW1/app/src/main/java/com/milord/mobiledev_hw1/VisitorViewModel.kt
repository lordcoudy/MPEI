package com.milord.mobiledev_hw1

import android.widget.RadioGroup
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.navigation.fragment.NavHostFragment.Companion.findNavController

class VisitorViewModel : ViewModel() {
    val radioGroup : RadioGroup = binding.radioGroup
    private val _visitors = MutableLiveData<ArrayList<Visitor>>(ArrayList())
            radioGroup.check(R.id.radioAllData)
        })

        binding.returnButton.setOnClickListener {
            findNavController().navigate(R.id.action_SecondFragment_to_FirstFragment)
        }
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }
}