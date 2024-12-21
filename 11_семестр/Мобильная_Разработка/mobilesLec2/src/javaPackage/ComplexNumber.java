package javaPackage;

/*
Задание 2
Вариант №2
Разработать класс для представления комплексных чисел.
Создать объекты этого класса и проверить работу (Java)
 */
public class ComplexNumber {
    private final double real;
    private final double imaginary;

    // Конструктор для создания комплексного числа
    public ComplexNumber(double real, double imaginary) {
        this.real = real;
        this.imaginary = imaginary;
    }

    // Геттеры для получения действительной и мнимой частей
    public double getReal() {
        return real;
    }

    public double getImaginary() {
        return imaginary;
    }

    // Метод для сложения комплексных чисел
    public ComplexNumber add(ComplexNumber other) {
        return new ComplexNumber(this.real + other.real, this.imaginary + other.imaginary);
    }

    // Метод для вычитания комплексных чисел
    public ComplexNumber subtract(ComplexNumber other) {
        return new ComplexNumber(this.real - other.real, this.imaginary - other.imaginary);
    }

    // Метод для умножения комплексных чисел
    public ComplexNumber multiply(ComplexNumber other) {
        return new ComplexNumber(
                this.real * other.real - this.imaginary * other.imaginary,
                this.real * other.imaginary + this.imaginary * other.real
        );
    }

    // Метод для деления комплексных чисел
    public ComplexNumber divide(ComplexNumber other) {
        double denominator = Math.pow(other.real, 2) + Math.pow(other.imaginary, 2);
        return new ComplexNumber(
                (this.real * other.real + this.imaginary * other.imaginary) / denominator,
                (this.imaginary * other.real - this.real * other.imaginary) / denominator
        );
    }

    // Переопределение метода toString для удобного вывода
    @Override
    public String toString() {
        return real + " + " + imaginary + "i";
    }
}
