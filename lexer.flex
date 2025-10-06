import java.util.*;

%%
%class Lexer
%standalone
%line
%column

//Token pattern declaration
op_multi   = "=="|">="|"<="|"++"|"--"
op_single  = "+"|"-"|"*"|"/"|"="|">"|"<"        
parenth    = "("|")"                                                       
semicolon  = ";"                                                           
keyword    = "if"|"then"|"else"|"endif"|"while"|"do"|"endwhile"|"print"|"newline"|"read"   
integer    = [0-9]+                                                        
identifier = [A-Za-z_][A-Za-z0-9_]*                                          
string     = \"[^\"]*\"
comments   = \/\/.* | \/\*([^*]|(\*+[^*/]))*\*+\/
whitespace = [ \t\r\n\f]+ 

%{
    private final java.util.HashSet<String> symbolTable = new java.util.HashSet<>();

    public enum Symbol {
        OPERATOR, PARENTH, SEMICOLON, KEYWORD, INTEGER, IDENTIFIER, STRING, COMMENT, UNKNOWN      
    }

    public static final class Token {
        public final Symbol type;
        public final String text;
        public Token(Symbol type, String text) { this.type = type; this.text = text; }
        @Override public String toString() { return type + ": " + text; }
    }

    private void emitToken(Token t) {
        switch (t.type) {
            case KEYWORD    -> System.out.println("keyword: " + t.text);
            case OPERATOR   -> System.out.println("operator: " + t.text);
            case INTEGER    -> System.out.println("integer: " + t.text);
            case PARENTH    -> System.out.println("parenthesis: " + t.text);
            case SEMICOLON  -> System.out.println("semicolon: " + t.text);
            case STRING     -> System.out.println("string: " + t.text);
            case IDENTIFIER -> recordIdentifier(t.text);
            case COMMENT    -> { /* ignore */ }
            default         -> System.out.println(t);
        }
    }

    private void recordIdentifier(String id) {
        if (symbolTable.contains(id)) {
            System.out.println("identifier \"" + id + "\" already in symbol table");
        } 
        
        else {
            symbolTable.add(id);
            System.out.println("new identifier: " + id);
        }
    }

    private void syntaxError() {
        System.out.println("Syntax error: Invalid token \"" + yytext() + "\"");
        System.exit(1);
    }

%}


//Rules
%%
{comments}   { /* ignore */ }
{whitespace} { /* ignore */ }
{keyword}    { emitToken(new Token(Symbol.KEYWORD, yytext())); }
{op_multi}   { emitToken(new Token(Symbol.OPERATOR, yytext())); }
{op_single}  { emitToken(new Token(Symbol.OPERATOR, yytext())); }
{parenth}    { emitToken(new Token(Symbol.PARENTH, yytext())); }
{semicolon}  { emitToken(new Token(Symbol.SEMICOLON, yytext())); }
{integer}    { emitToken(new Token(Symbol.INTEGER, yytext())); }
{identifier} { emitToken(new Token(Symbol.IDENTIFIER, yytext())); }
{string}     { emitToken(new Token(Symbol.STRING, yytext())); }
.            { syntaxError(); }


                                                
