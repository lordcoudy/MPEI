import java.io.PrintStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

///Записать логическое выражение, соответствующее заданной области
///истинности. Составить функцию, возвращающее 1 -  если точка
///принадлежит заданной и 0 – если не принадлежит. Подсчитать
///количество точек, попавших в заданную область.

public class Main {
    public static boolean isInArea(List<Integer> coords)
    {
        List<List<Integer>> squareCoords = new ArrayList<>();
        squareCoords.add(List.of(-3, -3));                       // BL
        squareCoords.add(List.of(-3, 3));                        // TL
        squareCoords.add(List.of(3, -3));                        // BR
        squareCoords.add(List.of(3, 3));                         // TR
        int circleR = 2;
        return (Math.pow(coords.getFirst(), 2) + Math.pow(coords.getLast(), 2) >= Math.pow(circleR, 2)) &&
                (coords.getFirst() >= squareCoords.getFirst().getFirst()) &&
                (coords.getFirst() <= squareCoords.getLast().getFirst()) &&
                (coords.getLast() >= squareCoords.getFirst().getLast()) &&
                (coords.getLast() <= squareCoords.getLast().getLast());
    }

    public static void main(String[] args) {
        int ch = 0;
        boolean cycle = true;
        int counter = 0;
        List<List<Integer>> coordsInside = new ArrayList<>();
        Scanner input = new Scanner(System.in);
        PrintStream output = new PrintStream(System.out);
        while (cycle)
        {
            output.println("Enter 1 - to write coordinates, 2 - to count number of dots inside area, 0 - to exit");
            ch = input.nextInt();
            switch (ch)
            {
                case 1: {
                    List<Integer> coords = new ArrayList<>();
                    output.println("Enter X coordinate: ");
                    coords.add(input.nextInt());
                    output.println("Enter Y coordinate: ");
                    coords.add(input.nextInt());
                    output.print("Your dot is ");
                    if (isInArea(coords))
                    {
                        counter++;
                        coordsInside.add(coords);
                        output.print("in ");
                    }
                    else
                    {
                        output.print("not in ");
                    }
                    output.println("the area!");
                    break;
                }
                case 2: {
                    output.print("There ");
                    if (counter == 0)
                    {
                        output.println("are no dots inside the area!");
                    } else if (counter == 1) {
                        output.println("is 1 dot inside the area!");
                        output.println("[" + coordsInside.getFirst().getFirst() + "," + coordsInside.getFirst().getLast() + "]");
                    } else if (counter > 1) {
                        output.println("are " + counter + " dots inside the area!");
                        coordsInside.forEach(coord -> output.println("[" + coord.getFirst() + "," + coord.getLast() + "]"));
                    }
                    break;
                }
                case 0: {
                    cycle = false;
                    break;
                }
            }
        }
    }
}