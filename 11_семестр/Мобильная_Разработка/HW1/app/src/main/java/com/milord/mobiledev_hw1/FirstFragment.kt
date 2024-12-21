package com.milord.mobiledev_hw1

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.EditText
import android.widget.Toast
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.fragment.findNavController
import com.milord.mobiledev_hw1.databinding.FragmentFirstBinding

class FirstFragment : Fragment() {

    private var _binding: FragmentFirstBinding? = null
    private val binding get() = _binding!!
    private lateinit var visitorViewModel: VisitorViewModel

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        _binding = FragmentFirstBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        visitorViewModel = ViewModelProvider(requireActivity()).get(VisitorViewModel::class.java)

        val firstNameEt: EditText = binding.firstName
        val lastNameEt: EditText = binding.lastName
        val heightEt: EditText = binding.height
        val weightEt: EditText = binding.weight
        val birthYearEt: EditText = binding.birthYear
        val addBtn: Button = binding.addButton
        val showBtn: Button = binding.showButton

        addBtn.setOnClickListener {
            if (firstNameEt.text.isEmpty() || lastNameEt.text.isEmpty() || heightEt.text.isEmpty() || weightEt.text.isEmpty() || birthYearEt.text.isEmpty()) {
                Toast.makeText(this.activity, "Заполните все поля", Toast.LENGTH_SHORT).show()
                return@setOnClickListener
            }
            val visitor = Visitor(
                firstNameEt.text.toString(),
                lastNameEt.text.toString(),
                heightEt.text.toString().toInt(),
                weightEt.text.toString().toInt(),
                birthYearEt.text.toString().toInt()
            )
            visitorViewModel.addVisitor(visitor)
            firstNameEt.text.clear()
            lastNameEt.text.clear()
    val visitors: LiveData<ArrayList<Visitor>> get() = _visitors

    fun addVisitor(visitor: Visitor) {
        _visitors.value?.add(visitor)
        _visitors.value = _visitors.value // Trigger LiveData update
    }
}