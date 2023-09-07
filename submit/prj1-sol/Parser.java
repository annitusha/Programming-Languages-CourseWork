
import java.io.File;
import java.io.FileNotFoundException;
import java.util.*;

import oracle.jvm.hotspot.jfr.ThreadStates.States;

public class Parser {






    public static void main(String args[]){
        String fileName = args[0];//the name of the file that has definition of the machine

        System.out.println(fileName);

        File f = new File(fileName);
        String filePath = f.getAbsolutePath();
        File file = new File(filePath);
        Scanner scanner = null;
        try {
            scanner = new Scanner(file);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        while (scanner.hasNextLine()) {
             String line = scanner.nextLine();
    }
}