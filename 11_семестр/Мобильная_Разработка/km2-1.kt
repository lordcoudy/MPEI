import java.time.LocalDateTime
import java.time.format.DateTimeFormatter

data class Event(val start: LocalDateTime, val end: LocalDateTime, val title: String)

class ConferenceRoom {
    private val events: MutableList<Event> = mutableListOf()
    // Добавление события
    fun addEvent(start: LocalDateTime, end: LocalDateTime, title: String): Boolean {
        if (isAvailable(start, end)) {
            events.add(Event(start, end, title))
            return true
        }
        return false
    }
    
    // Проверка доступности зала
    fun isAvailable(start: LocalDateTime, end: LocalDateTime): Boolean {
        return events.none { event ->
            // Проверяем перекрытие событий
     (start.isBefore(event.end) && end.isAfter(event.start))       }
    }
    // Получение всех событий
    fun getEvents(): List<Event> {
        return events
    }
    // Метод для отображения событий
    fun printEvents() {
        val formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")
        for (event in events) {
            println("${event.title}: ${event.start.format(formatter)} - ${event.end.format(formatter)}")
            
        }
    }
}

fun main() {
    val conferenceRoom = ConferenceRoom()
        // Пример использования
    val dateFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")
        // Добавим события
    val event1Start = LocalDateTime.parse("2023-10-10 10:00", dateFormat)
    val event1End = LocalDateTime.parse("2023-10-10 12:00", dateFormat)
    val event2Start = LocalDateTime.parse("2023-10-10 13:00", dateFormat)
    val event2End = LocalDateTime.parse("2023-10-10 14:00", dateFormat)
        println("Adding Event 1: ${conferenceRoom.addEvent(event1Start, event1End, "Meeting 1")}")
        println("Adding Event 2: ${conferenceRoom.addEvent(event2Start, event2End, "Meeting 2")}")
        // Проверка доступности
    val checkStart = LocalDateTime.parse("2023-10-10 11:00", dateFormat)
    val checkEnd = LocalDateTime.parse("2023-10-10 13:00", dateFormat)
    println("Is available from ${checkStart.format(dateFormat)} to ${checkEnd.format(dateFormat)}: ${conferenceRoom.isAvailable(checkStart, checkEnd)}")
       // Печать событий
    conferenceRoom.printEvents()
}
