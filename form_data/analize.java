package csv_analizer;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

public class analize {

    public static void main(String[] args) {
    	
    	int i = 0;
    	
        BufferedReader br = null;
        String line = "";
        String cvsSplitBy = ",";

        try {

            br = new BufferedReader(new FileReader("results.csv"));
            while ((line = br.readLine()) != null) {

                // use comma as separator
                String[] res = line.split(cvsSplitBy);
                System.out.println(res[i]);
            }

        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (br != null) {
                try {
                    br.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
