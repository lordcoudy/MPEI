/* Определите класс Student, который содержит следующую
информацию о студентах: полное имя, курс, предмет, университет,
адрес электронной почты и номер телефона. Объявите несколько
конструкторов для класса Student, которые имеют разные списки
параметров (для получения полной информации о студенте или его
части). Данные, которые не имеют начального значения для
инициализации с нулем. Используйте обнуляемые типы для всех
необязательных данных*/
class Student(val name : String, val surname : String) {
    constructor(
        name: String,
        middlename: String? = "",
        surname: String,
        course: Int? = 0,
        subject: String? = "",
        university: String? = "",
        email: String? = "",
        phone: String? = ""
    ) : this(name, surname)
    {
        this.middlename = middlename
        this.course = course
        this.subject = subject
        this.university = university
        this.email = email
        this.phone = phone
    }

    constructor(name: String, middlename: String?, surname: String, course: Int?) : this(name, surname)
    {
        this.middlename = middlename
        this.course = course
    }

    fun print()
    {
        println("Name: $surname $name $middlename")
        if (course?.equals(0) == false)
            println("Course: $course")
        if (subject?.isEmpty() == false)
            println("Subject: $subject")
        if (university?.isEmpty() == false)
            println("University: $university")
        if (email?.isEmpty() == false)
            println("E-mail: $email")
        if (phone?.isEmpty() == false)
            println("Phone: $phone")
    }

    var middlename: String? = ""
    var course: Int? = 0
    var subject: String? = ""
    var university: String? = ""
    var email: String? = ""
    var phone: String? = ""
}

fun main() {
    val student = Student(name = "Savva", surname = "Balashov")
    println("Введите Имя, Фамилию и курс обучения студента:")
    val student2 = Student(name = readln(), surname = readln(), course = readln().toInt())
    val student3 = Student(name = "Николай", middlename = "Владимирович", surname = "Кретов", course = 5)
    println("Student 1")
    student.print()
    println("Student 2")
    student2.print()
    println("Student 3")
    student3.print()
}