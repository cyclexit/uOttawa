# CSI3140 Lecture Note

## Chapter 19
### Introduction
1. PHP code is embedded directly into text-based documents, such as HTML. PHP code can be placed anywhere in HTML markup.
2. PHP variables are loosely typed.

### Types
|Type|Description
|------|----
|int, integer|Integers
|float, double, float|Real numbers
|string|Text enclosed in either `''` or `""`. Using `""` allows PHP to recognize more escape sequences.
|bool, boolean| Boolean value
|array|Array
|object|Group of associated data and methods
|NULL|No value

1. `settype($var, type)` function: used for type conversions </br>
    `gettype($var)` function: return the current type of its argument
2. When converting from a string to a number, PHP uses the value of the number that appears at the beginning of the string. If no number appears at the beginning, the string evaluates to 0.
3. Type casting: C style type casting, e.g. `(int) $var`.
    * Casting creates a temporary copy of a variable’s value in memory.
    * Casting is useful when a different type is required in a specific operation but you would like to retain the variable’s original value and type.

### Operator

|Operator|Type|Associativity
|----|----|----
|new|constructor|none
|clone|copy an object|none
|[]|subscript|left to right
|++|increment|none
|--|decrement|none
|~|bitwise not|right to left
|-|unary negative|right to left
|@|error control|right to left
|(type)|cast|right to left
|instanceof| |none
|!|not|right to left
|*|multiplication|left to right
|/|division|left to right
|%|modulus|left to right
|+|addition|left to right
|-|subtraction|left to right
|.|concatenation|left to right
|<<|bitwise shift left|left to right
|>>|bitwise shift right|left to right
|<|less than|none
|>|greater than|none
|<=|less than or equal to|none
|>=|greater than or equal to|none
|==|equal|none
|!=|not equal|none
|===|identical|none
|!==|not identical|none
|&|bitwise AND|left to right
|^|bitwise XOR|left to right
|\||bitwise OR|left to right
|&&|logical AND|left to right
|\|\||logical OR|left to right
|?:|ternary conditional|left to right
|=, +=, -=, *=, /=, %=, &=, \|=, ^=, .=, <<=, >>=|assignment operators| right to left
|=>|assign value to a named key|right to left
|and|logical AND|left to right
|xor|exclusive OR|left to right
|or|logical OR|left to right
|,|list|left to right

1. The concatenation operator `.` combines multiple strings.

### Keyword
https://www.php.net/manual/en/reserved.keywords.php

### Grammar
1. PHP code is inserted between the **scripting delimiters** `<?php ... ?>`.
2. **Variables** are preceded by a `$`.
3. Single-line comments: `//` or `#` </br>
    Multiline comments: `/*...*/`
4. When a variable is encountered inside a double-quoted string, PHP inserts the value of the variable where the variable name appears.
5. `define` function creates a named constant.

### Array
1. If a value is assigned to an element of an array that does not exist, then the array is created. Assigning a value to an element where the index is omitted appends a new element to the end of the array.
    * `count($arr)`: return the length of the array
    ```php
    <?php
        $num[0] = "zero";
        $num[1] = "one";
        // use index
        for ($i = 0; $i < count($num); ++$i) {
            print("Element $i is $first[$i]");
        }
    ?>
    ```
2. Each array has a **built-in internal pointer**, which points to the array element currently being referenced.
3. Arrays with nonnumeric indices are called associative arrays. An associative array can be created using the operator `=>`, where the value to the left of the operator is the array index, and the value to the right is the element’s value.
    * `reset($arr)`: set the internal pointer to the first array element
    * `key($arr)`: return the index of the element currently referenced by the internal pointer
    * `next($arr)`: move the internal pointer to the next element
    ```php
    <?php
        $age["Amy"] = 21;
        $age["Bob"] = 18;
        $age["Carol"] = 23;
        for (reset($age); $name = key($age); next($age)) {
            print("$name is $age[$name]");
        }
    ?>
    ```

### String