package javaPackage;
/*
Контрольная работа №1
Задание 1
Вариант №1
Напишите программу, которая находит максимальную последовательность последовательных равных элементов в массиве.
Например: {1, 1, 2, 3, 2, 2, 2, 1} -> {2, 2, 2}  (Java)
*/
import java.util.Arrays;

public class MaxSequence {
    public static int[] findMaxSequence(int[] arr) {
        int maxLength = 1;
        int currentLength = 1;
        int startIndex = 0;
        int endIndex = 0;

        for (int i = 1; i < arr.length; i++) {
            if (arr[i] == arr[i - 1]) {
                currentLength++;
            } else {
                if (currentLength > maxLength) {
                    maxLength = currentLength;
                    endIndex = i - 1;
                    startIndex = endIndex - maxLength + 1;
                }
                currentLength = 1;
            }
        }

        // Проверка последней последовательности
        if (currentLength > maxLength) {
            maxLength = currentLength;
            endIndex = arr.length - 1;
            startIndex = endIndex - maxLength + 1;
        }

        return Arrays.copyOfRange(arr, startIndex, endIndex + 1);
    }
}
