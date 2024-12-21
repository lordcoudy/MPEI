package com.milord.mobiledev_hw1

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ArrayAdapter
import android.widget.ListView
import android.widget.RadioGroup
import androidx.lifecycle.ViewModelProvider
import com.milord.mobiledev_hw1.databinding.FragmentSecondBinding

class SecondFragment : Fragment() {

    private var _binding: FragmentSecondBinding? = null
    private val binding get() = _binding!!
    private lateinit var visitorViewModel: VisitorViewModel

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        _binding = FragmentSecondBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        visitorViewModel = ViewModelProvider(requireActivity()).get(VisitorViewModel::class.java)

        val listView: ListView = binding.visitorList
        val radioGroup: RadioGroup = binding.radioGroup

        visitorViewModel.visitors.observe(viewLifecycleOwner, { visitors : ArrayList<Visitor> ->
            val displayList: ArrayList<String> = ArrayList()
            radioGroup.setOnCheckedChangeListener { _, checkedId ->
                displayList.clear()
                when (checkedId) {
                    R.id.radioAllData -> displayList.addAll(visitors.map { it.toString() })
                    R.id.radioNameAge -> displayList.addAll(visitors.map { it.toStringEx(true) })
                    R.id.radioNameWeight -> displayList.addAll(visitors.map { it.toStringEx(false) })
                }
                listView.adapter = ArrayAdapter(requireContext(), android.R.layout.simple_list_item_1, displayList)
            }
            heightEt.text.clear()
            weightEt.text.clear()
            birthYearEt.text.clear()
            showBtn.visibility = Button.VISIBLE
        }

        showBtn.setOnClickListener {
            if (visitorViewModel.visitors.value.isNullOrEmpty()) {
                Toast.makeText(this.activity, "Список посетителей пуст", Toast.LENGTH_SHORT).show()
                return@setOnClickListener
            }
            findNavController().navigate(R.id.action_FirstFragment_to_SecondFragment)
        }
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }
}