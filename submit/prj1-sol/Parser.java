
import java.io.File;
import java.io.FileNotFoundException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
//import org.json.simple.JSONObject;
import java.util.*;

class Token {
    public String kind;
    public String lexeme;
    public Token(String kind, String lexeme){
        this.kind = kind;
        this.lexeme = lexeme;
    }
    public String toString() {
        return "Token{" +
                "type=" + kind +
                ", value='" + lexeme + '\'' +
                '}';
    }
}

public class Parser {

    //EBNF grammar for the declrations language
/*
    program
    : declaration program
    | #empty
    ;

    declaration
    : declaration-type-specifier expression '=' identifier ';'
    ;

    declaration-type-specifier
    : 'const'
    | 'let'
    ;

    expression
    : identifier
    | '[' array-struct
    | '{' object-struct
    ;

    array-struct
    : '[' expression (',' expression)* ']'
    ;

    object-struct
    : '{' keyStruct (',' keyStruct)* '}'
    ;

    keyStruct
    : identifier (':' expression)?
    ;

    identifier
    : [a-zA-Z_][a-zA-Z_0-9]*
    ;

 */
    // class Token {
    //     public String kind;
    //     public String lexeme;
    //     public Token(String kind, String lexeme){
    //         this.kind = kind;
    //         this.lexeme = lexeme;
    //     }
    // }
    public static ArrayList<Token> tokens;
    public static int index;
    public static Token lookahead;

    public static Token nextToken() {
        if (index >= tokens.size()) {
            return new Token("EOF", "<EOF>");
        } else {
            return tokens.get(index++);
        }
    }
    public static boolean peek(String kind) {
        return lookahead.kind.equals(kind);
    }

    public static void consume(String kind) {
        if (peek(kind)) {
            lookahead = nextToken();
        } else {
            System.err.println("Expecting " + kind + " at " + lookahead.kind);
            System.exit(1);
        }
    }

    public static ArrayList<Object> program() {
        ArrayList<Object> values = new ArrayList<>();
        while (!peek("EOF")) {
            values.add(declaration());
        }
        return values;
    }

    public static Object declaration() {
        String decl = "\"decl\": \"" +declarationTypeSpecifier() +"\"";
        String struct = "\"struct\": " +expression();
        if(peek("=")) {
            consume("=");
            String id = "\"id\": " + identifier();
            if(peek(";")){
                consume(";");
                decl = "{" + decl + "," + id + "," + struct + "}";
            }
            else {
                System.exit(1);
            }
        }
        else {
            System.exit(1);
        }
        return decl;
    }

    public static Object declarationTypeSpecifier() {
        if(peek("RESERVED")){
            Object val = lookahead.lexeme;
            consume("RESERVED");
            return val;
        }
        else {
            System.err.println("Not a reserved token");
            System.exit(1);
            return 0;
        }
    }
    public static Object expression() {
        if(peek("IDENTIFIER")){
            return identifier();
        }
        else if(peek("[")){
            return arrayStruct();
        }
        else if(peek("{")){
            return objectStruct();
        }
        else {
            System.exit(1);
            return 0;
        }
    }
    public static Object arrayStruct(){
        if(peek("[")){
            String val1 = lookahead.lexeme;
            consume("[");
            Object val2 = expression();
            while(peek(",")){
                String kind = lookahead.kind;
                consume(kind);
                val2 += kind + expression();
            }
            if(peek("]")){
                String val3 = lookahead.lexeme;
                consume("]");
                return val1 += val2 + val3;
            }
            else {
                System.exit(1);
                return 0;
            }
        }
        else{
            System.exit(1);
            return 0;
        }
    }
    public static Object objectStruct(){
        if(peek("{")){
            String val1 = lookahead.lexeme;
            consume("{");
            Object val2 = keyStruct();
            while(peek(",")){
                String kind = lookahead.kind;
                consume(kind);
                val2 += kind + keyStruct();
            }
            if(peek("}")){
                String val3 = lookahead.lexeme;
                consume("}");
                return val1 += val2 + val3;
            }
            else {
                System.exit(1);
                return 0;
            }
        }
        else{
            System.exit(1);
            return 0;
        }
    }
    public static Object keyStruct() {
        if(peek("IDENTIFIER")){
            Object val1 = identifier();
            if(peek(":")){
                String val2 = lookahead.lexeme;
                consume(":");
                return val1 + val2 + expression();
            }
            else {
                return val1 + ": " + val1;
            }
        }
        else {
            System.exit(1);
            return 0;
        }
    }
    public static Object identifier(){
        if(peek("IDENTIFIER")){
            Object val1 = lookahead.lexeme;
            consume(lookahead.kind);
            return "\"" + val1 + "\"";
        }
        else {
            System.exit(1);
            return 0;
        }
    }

    public static ArrayList<Object> parse(String text) {
        tokens = scan(text);
        index = 0;
        lookahead = nextToken();
        ArrayList<Object> value = program();
        return value;
    }

    public static ArrayList<Token> scan(String text) {
        ArrayList<Token> tokens = new ArrayList<>();
        //System.out.println(text);
        Pattern declarTypeSpecPattern = Pattern.compile("\\b(const|let)\\b");
        Pattern identifierPattern = Pattern.compile("[a-zA-Z_][a-zA-Z_0-9]*");
        Pattern ignoreSpaceComm = Pattern.compile("//.*|/\\*.*?\\*/|\\s+");
        Pattern singleCharPattern = Pattern.compile("[=;:,{}\\[\\]]");

        Matcher matcher = Pattern.compile("(" +
                declarTypeSpecPattern.pattern() + "|" +
                ignoreSpaceComm.pattern() + "|" +
                identifierPattern.pattern() + "|" +
                singleCharPattern.pattern() + "|\\s+"
                + ")").matcher(text);

        while (matcher.find()) {
            //String lexeme = matcher.group().trim();
            String lexeme = matcher.group();
            String kind = "";
            if (ignoreSpaceComm.matcher(lexeme).matches()){
                continue;
            } else if (declarTypeSpecPattern.matcher(lexeme).matches()) {
                //kind = "DECLARATION_TYPE_SPECIFIER";
                kind = "RESERVED";
            } else if (identifierPattern.matcher(lexeme).matches()) {
                kind = "IDENTIFIER"; //ID
            } else if (singleCharPattern.matcher(lexeme).matches()) {
                lexeme = matcher.group(1);
                kind = lexeme;
            } else {
                throw new IllegalArgumentException("Invalid token: " + lexeme);
            }

            tokens.add(new Token(kind, lexeme));
        }
        return tokens;
    }



    public static void main(String args[]){
        //String fileName = args[0];//the name of the file that has definition of the machine

        //System.out.println(fileName);

        // File f = new File(fileName);
        // String filePath = f.getAbsolutePath();
        // File file = new File(filePath);
        // Scanner scanner = null;
        Scanner scanner = new Scanner(System.in);
        String text = ""; //the whole file input into one string
        // try {
        //     scanner = new Scanner(file);
        // } catch (FileNotFoundException e) {
        //     e.printStackTrace();
        // }
        while (scanner.hasNextLine()) {
            String line = scanner.nextLine();
            if (line.equals("EOF")) {
                break; // Exit the loop when 'EOF' is encountered
            }
            text += line + "\n";
        }
        //ArrayList<Token> tokens = scan(text);
        ArrayList<Object> values = parse(text);

        String res = "";
        for (Object decl : values) {
            if(res != "") res += ",";
            res += decl;
        }
        System.out.println("[" + res + "]");
    }
}