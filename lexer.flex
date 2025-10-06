import java.util.*;

%%
%class Lexer
%unicode
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
string     = \"[^\r\n"]*\"
comments   = "//"[^\r\n]* | "/\*"([^*]|(\*+[^*/]))*\*+\/"
whitespace = [ \t\r\n\f]+ 



                                                
