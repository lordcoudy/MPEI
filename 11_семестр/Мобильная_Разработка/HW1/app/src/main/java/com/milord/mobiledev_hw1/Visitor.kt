package com.milord.mobiledev_hw1

import android.os.Parcel
import android.os.Parcelable
import android.icu.util.Calendar

data class Visitor(
    val firstName: String,
    val lastName: String,
    val height: Int,
    val weight: Int,
    val birthYear: Int
) : Parcelable {
    constructor(parcel: Parcel) : this(
        parcel.readString()!!,
        parcel.readString()!!,
        parcel.readInt(),
        parcel.readInt(),
        parcel.readInt()
    )

    override fun writeToParcel(parcel: Parcel, flags: Int) {
        parcel.writeString(firstName)
        parcel.writeString(lastName)
        parcel.writeInt(height)
        parcel.writeInt(weight)
        parcel.writeInt(birthYear)
    }

    override fun describeContents(): Int {
        return 0
    }

    companion object CREATOR : Parcelable.Creator<Visitor> {
        override fun createFromParcel(parcel: Parcel): Visitor {
            return Visitor(parcel)
        }

        override fun newArray(size: Int): Array<Visitor?> {
            return arrayOfNulls(size)
        }
    }

    fun getAge(): Int {
        val year = Calendar.getInstance().get(Calendar.YEAR)
        return year - birthYear
    }

    fun toStringEx(age: Boolean): String {
        return if (age) {
            "Имя: $firstName, Фамилия: $lastName, Возраст: ${getAge()}"
        } else {
            "Имя: $firstName, Фамилия: $lastName, Вес: $weight"
        }
    }
}