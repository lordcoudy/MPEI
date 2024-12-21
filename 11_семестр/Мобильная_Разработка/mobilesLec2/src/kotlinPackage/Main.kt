package kotlinPackage

import kotlin.random.Random

/*
Контрольная работа №1
Задание 1
Вариант №2
Напишите программу для поиска последовательности соседних чисел в массиве, которая имеет сумму равную определенному числу S.
Пример: {4, 3, 1, 4, 2, 5, 8}, S = 11 -> {4,2, 5}. (Kotlin)
*/
fun findSubarraySum(nums: IntArray, S: Int): List<Int> {
    val map = mutableMapOf<Int, Int>() // Хранит сумму префиксов и их индексы
    var sum = 0

    for (i in nums.indices) {
        sum += nums[i]
        if (sum == S) return listOf(0, i) // Если сумма равна S с самого начала
        if (map.containsKey(sum - S)) {
            return listOf(map[sum - S]!! + 1, i) // Найдена подпоследовательность
        }
        map[sum] = i
    }

    return emptyList() // Если подпоследовательности не найдено
}
/*
Задание 2
Вариант №1
Разработать класс для работы и представления рациональных чисел.
Создать объекты этого класса и проверить работу (Kotlin)
*/
class RationalNumber(private var numerator: Int, private var denominator: Int) {

    init {
        require(denominator != 0) { "Знаменатель не может быть равен нулю" }
        val gcd = gcd(numerator, denominator)
        numerator /= gcd
        denominator /= gcd
        if (denominator < 0) {
            numerator *= -1
            denominator *= -1
        }
    }

    private fun gcd(a: Int, b: Int): Int = if (b == 0) a else gcd(b, a % b)

    operator fun plus(other: RationalNumber): RationalNumber {
        val newNumerator = numerator * other.denominator + other.numerator * denominator
        val newDenominator = denominator * other.denominator
        return RationalNumber(newNumerator, newDenominator)
    }
    operator fun minus(other: RationalNumber): RationalNumber {
        val newNumerator = numerator * other.denominator - other.numerator * denominator
        val newDenominator = denominator * other.denominator
        return RationalNumber(newNumerator, newDenominator)
    }

    operator fun times(other: RationalNumber): RationalNumber {
        val newNumerator = numerator * other.numerator
        val newDenominator = denominator * other.denominator
        return RationalNumber(newNumerator, newDenominator)
    }

    operator fun div(other: RationalNumber): RationalNumber {
        require(other.numerator != 0) { "Cannot divide by zero" }
        val newNumerator = numerator * other.denominator
        val newDenominator = denominator * other.numerator
        return RationalNumber(newNumerator, newDenominator)
    }

    override fun toString(): String {
        return if (denominator == 1) "$numerator" else "$numerator/$denominator"
    }

}
/*
Задание 3
Вариант №2.
Создайте класс BankAccount для представления банковских счетов с полями, такими как номер счета, баланс и владелец.
Создайте коллекцию для хранения объектов BankAccount и реализуйте функции для открытия новых счетов,
внесения и снятия денег, проверки баланса и поиска счетов по владельцу или номеру счета.
Напишите функцию с использованием лямбда-выражения, чтобы найти владельца с определенным именем. (Kotlin)
*/
data class BankAccount(
    val accountNumber: Int,
    var balance: Double,
    val owner: String
)
val accounts = mutableListOf<BankAccount>()
fun openAccount(accountNumber: Int, initialBalance: Double, owner: String) {
    val newAccount = BankAccount(accountNumber, initialBalance, owner)
    accounts.add(newAccount)
    println("Счет $accountNumber открыт для $owner с начальным балансом $initialBalance")
}

fun deposit(accountNumber: Int, amount: Double) {
    val account = accounts.find { it.accountNumber == accountNumber }
    account?.let {
        it.balance += amount
        println("На счет $accountNumber внесено $amount. Новый баланс: ${it.balance}")
    } ?: println("Счет $accountNumber не найден")
}

fun checkFunds(accountNumber: Int) {
    val account = accounts.find { it.accountNumber == accountNumber }
    account?.let {
        println("На счете $accountNumber лежит ${it.balance}")
    } ?: println("Счет $accountNumber не найден")
}

fun withdraw(accountNumber: Int, amount: Double) {
    val account = accounts.find { it.accountNumber == accountNumber }
    account?.let {
        if (amount > it.balance)
        {
            println("Недостаточно средств! На счёте $accountNumber лежит ${it.balance}")
        }
        else {
            it.balance -= amount
            println("Со счета $accountNumber снято $amount. Новый баланс: ${it.balance}")
        }
    } ?: println("Счет $accountNumber не найден")
}

fun findAccountsByOwner(ownerName: String): List<BankAccount> {
    return accounts.filter { it.owner == ownerName }
}

fun findOwnerWithName(name: String): String? {
    return accounts.find { it.owner == name }?.owner
}

/*
Задание 4
Вариант №1.
У вас есть список книг с названиями, авторами и годами выпуска.
Используйте лямбда-выражения, чтобы отфильтровать книги, опубликованные после определенного года, и отсортировать их по авторам (Kotlin).
*/
data class Book(val title: String, val author: String, val year: Int)

fun searchBooksAfterYear()
{
    val books = listOf(
        Book("Война и мир", "Лев Толстой", 1869),
        Book("Преступление и наказание", "Фёдор Достоевский", 1866),
        Book("Идиот", "Фёдор Достоевский", 1869),
        Book("Братья Карамазовы", "Фёдор Достоевский", 1880),
        Book("Анна Каренина", "Лев Толстой", 1877)
    )
    println("Введите параметр фильтрации: год")
    val yearToFilter = readln().toInt()
    val filteredBooks = books.filter { it.year > yearToFilter }
    val sortedBooks = filteredBooks.sortedBy { it.author }
    println("Книги, опубликованные после $yearToFilter, отсортированные по авторам:")
    sortedBooks.forEach { println(it) }
}
/*
Вариант №2.
У вас есть список элементов. Используйте лямбда-выражение, чтобы подсчитать количество уникальных элементов в списке (Kotlin).
*/
fun countUnique()
{
    val list = listOf("apple", "banana", "apple", "orange", "banana")
    val uniqueCount = list.toSet().count()
    println("Количество уникальных элементов: $uniqueCount")
}


fun main() {
    val n = 20
    val numArr = IntArray(n)
    for (i in 0..<n)
        numArr[i] = Random.nextInt(0, 10)
    for (x in numArr)
        print("$x ")
    println()
    println("Введите S")
    val diapason = findSubarraySum(numArr, readln().toInt())
    if (diapason.isEmpty())
        println("Отрезок не найден")
    else {
        for (i in diapason[0]..diapason[1]) {
            print(numArr[i])
            print(" ")
        }
        println()
    }

    val rational1 = RationalNumber(3, 4)
    val rational2 = RationalNumber(1, 2)

    val sum = rational1 + rational2
    val difference = rational1 - rational2
    val product = rational1 * rational2
    val quotient = rational1 / rational2

    println("Сумма: $sum")
    println("Разность: $difference")
    println("Произведение: $product")
    println("Частное: $quotient")

    openAccount(12345, 1000.0, "Иван Иванов")
    openAccount(67890, 500.0, "Петр Петров")

    deposit(12345, 500.0)

    val accountsOfIvan = findAccountsByOwner("Иван Иванов")
    println("Счета Иванова: $accountsOfIvan")

    val ownerWithName = findOwnerWithName("Петр Петров")
    println("Владелец со именем Петр Петров: $ownerWithName")

    searchBooksAfterYear()

    countUnique()
}