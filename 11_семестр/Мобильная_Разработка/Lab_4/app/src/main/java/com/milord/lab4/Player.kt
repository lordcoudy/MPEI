package com.milord.lab4

enum class Team
{
    NONE,
    RED,
    GREEN,
}

data class Player(
    val name: String,
    var team: Team
)
