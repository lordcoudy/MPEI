package javaPackage;

import java.util.ArrayList;
import java.util.List;
import java.util.function.Predicate;

public class ProductManager {
    private List<Product> products = new ArrayList<>();

    // Добавление товара
    public void addProduct(Product product) {
        products.add(product);
    }

    // Учет продаж
    public void sellProduct(String name, int quantity) {
        for (Product product : products) {
            if (product.getName().equals(name)) {
                if (product.getQuantity() >= quantity) {
                    product.setQuantity(product.getQuantity() - quantity);
                    break;
                } else {
                    System.out.println("Недостаточно товара на складе.");
                }
            }
        }
    }

    // Расчет общей стоимости товаров
    public double getTotalCost() {
        double total = 0;
        for (Product product : products) {
            total += product.getPrice() * product.getQuantity();
        }
        return total;
    }

    // Поиск товаров по условию (лямбда-выражение)
    public List<Product> findProducts(Predicate<Product> predicate) {
        List<Product> result = new ArrayList<>();
        for (Product product : products) {
            if (predicate.test(product)) {
                result.add(product);
            }
        }
        return result;
    }
}
