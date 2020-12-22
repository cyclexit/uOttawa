# CSI 3120
## **Lab 5: Grammars**
Note that in this lab, non-terminals are written using angle brackets, for example: \<expression\>

### **Problem 3. A grammar of binary numbers**
Write a grammar of the language whose elements are all and only those unsigned binary numbers which contain at least three consecutive digits 1. The language includes, for example, 111, 00001111111010 and 1111110, but not 0011000101011 or 1010101010.

### **Problem 4. Derivations**
Consider the following grammar of expressions in the Reverse Polish notation:

\<expr RP\>  ->  \<arg\> \<arg\> \<binary op\> | \<arg\> \<unary op\> | \<const\>

\<arg\>  ->  \<expr RP\>

\<const\>  ->  \<digit\>

\<binary op\>  ->  + | - | * | /

\<unary op\>  ->  ~

\<digit\>  ->  0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9

Observe that productions with a single right-hand side (here, \<arg\>, \<const\>, \<unary op\>) are not really necessary, but they do make the grammar clearer.

Give derivations for the following two strings

1 6 / 4 ~ +

8 ~ 7 + 3 /

### **Problem 5. An ambiguous grammar**
Show that the following grammar with four terminal symbols     a b c *     is ambiguous.

\<S\>  ->  \<X\> 

\<X\>  ->  \<X\> * \<X\> | \<Y\> 

\<Y\>  ->  a | b | c

Propose an equivalent unambiguous grammar which generates the same language.