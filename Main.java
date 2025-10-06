import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;

public class Main {
    public static void main(String[] args) {
        if (args.length == 0) {
            System.err.println("Usage: java Main <input_file>");
            return;
        }

        try (Reader reader = new FileReader(args[0])) {
            Lexer lexer = new Lexer(reader);
            lexer.yylex(); 
        } catch (IOException e) {
            System.err.println("Error reading file: " + e.getMessage());
        }
    }
}
