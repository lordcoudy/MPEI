package javaPackage;

import java.util.List;
import java.util.Arrays;

public class Main {
    public static void main(String[] args) {
        ComplexNumber z1 = new ComplexNumber(2, 3);
        ComplexNumber z2 = new ComplexNumber(-1, 4);

        ComplexNumber sum = z1.add(z2);
        ComplexNumber product = z1.multiply(z2);

        System.out.println("z1 = " + z1);
        System.out.println("z2 = " + z2);
        System.out.println("z1 + z2 = " + sum);
        System.out.println("z1 * z2 = " + product);

        ProductManager manager = new ProductManager();

        Product product1 = new Product("Телефон",
                20000, 10);
        Product product2 = new Product("Ноутбук", 50000, 5);
        manager.addProduct(product1);
        manager.addProduct(product2);

        // Продажа 5 телефонов
        manager.sellProduct("Телефон", 5);

        // Поиск всех товаров дороже 30000
        List<Product> expensiveProducts = manager.findProducts(p -> p.getPrice() > 30000);
        expensiveProducts.forEach(product3 -> {System.out.print(product3.getName());});
        System.out.println();

        // Вывод общей стоимости товаров
        System.out.println("Общая стоимость: " + manager.getTotalCost());


        int[] arr = {1, 1, 2, 3, 2, 2, 2, 1};
        int[] maxSequence = MaxSequence.findMaxSequence(arr);
        System.out.println(Arrays.toString(maxSequence));
    }
}