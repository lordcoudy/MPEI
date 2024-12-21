package com.milord.km3_1

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel

class VisitorViewModel : ViewModel() {
    private val _visitors = MutableLiveData<MutableList<Visitor>>(mutableListOf())
    val visitors: LiveData<MutableList<Visitor>> get() = _visitors

    fun addVisitor(visitor: Visitor) {
        _visitors.value?.add(visitor)
        _visitors.value = _visitors.value // Обновление данных для LiveData
    }
}