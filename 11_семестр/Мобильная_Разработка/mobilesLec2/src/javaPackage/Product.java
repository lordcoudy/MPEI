package javaPackage;
/*
Задание 3
Вариант №1.
Создайте класс Product для представления товаров в магазине с полями, такими как название, цена и количество на складе.
Создайте коллекцию для хранения объектов Product и реализуйте функции для добавления товаров,
учета продаж, расчета общей стоимости товаров и поиска товаров по различным параметрам с помощью лямбда-выражения. (Java)
*/
public class Product {
    private String name;
    private double price;
    private int quantity;

    public Product(String name, double price, int quantity) {
        this.name = name;
        this.price = price;
        this.quantity = quantity;
    }

    // Геттеры и сеттеры
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}

