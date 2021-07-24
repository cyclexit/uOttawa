# CSI3140 Lecture Note

## Chapter 15
### Basics
1. XML = Extensible Markup Language 
2. XML syntax requires:
    * A single root element
    * A start tag and end tag for each element
    * Properly nested tags
3. An XML document can reference a **Document Type Definition (DTD)** or **schema** that defines the document’s proper structure.
3. Two types of **XML parser**:
    * **Validating parser**: Checks that the XML document conforms with the DTD it references; Generates error if it doesn’t
    * **Non-validating parser**: Checks for well-formedness of the XML document; Can ignore external DTD

### XML Structure
1. An XML document begins with an <u>optional</u> **XML declaration**, which identifies the document as an XML document. The version attribute in the XML declaration specifies the version of XML syntax used in the document.
    ```xml
    <?xml version="1.0"?>
    ```
2. **XML element name** can contain letters, digits, underscores, hyphens and periods. Must begin with either a letter or an underscore, and they should NOT begin with “xml” in any combination of uppercase and lowercase letters, as this is reserved for use in the XML standards
3. **XML namespace**: provide a means for document authors to unambiguously refer to elements with the same name 
    * Default namespace: `xmlns`
4. **Document Type Definition (DTD)**: specify documents’ element types and attributes, and their relationships to one another.
    * A DTD expresses the set of rules for document structure using an **EBNF (Extended Backus-Naur Form)** grammar
    * In a DTD, an `ELEMENT` **element type declaration** defines the rules for an element. An `ATTLIST` **attribute-list declaration** defines attributes for a particular element, e.g.,
        ```
        <!ELEMENT contact (name, addr1, addr2, city, state, zip, phone, flag)>
        <!ELEMENT name(#PCDATA)>
        ```
5. XML Schema
    * Two categories of data types: simple types and complex types. Simple types cannot contain attributes or child elements, but complex types can. Complex types can have either simple content or complex content. Both can contain attributes, but only complex content can contain child elements.
    * Some XML schema data types: string, boolean, decimal, float, double,
    long, int, short, date, time.
6. XML also has Document Object Model (DOM), and XML DOM is very similar to HTML DOM.
    * Use XMLHttpRequest object to get the XML content
        ```js
        var xmlHttpRequest = new XMLHttpRequest();
        xmlHttpRequest.open("get", url, false);
        xmlHttpRequest.send(null);
        var xml_doc = xmlHttpRequest.responseXML;
        // Then, use doc.childNodes to go through XML document
        ```
7. XPath: more efficient way to travel through XML document.

### XSL and XSL Transformation
1. XSL = Extensible Stylesheet Language
2. XSL is a group of 3 technologies:
    * **XSL-FO (XSL Formatting Objects)** is a vocabulary for specifying formatting.
    * **Xpath (XML Path Language)** is a string-based language of expressions used by XML and many of its related technologies for effectively and efficiently locating structures (e.g., elements and attributes) in XML documents.
    * **XSLT (XSL Transformations)** is a technology for transforming XML documents from one form to another form.
3. XSL style-sheet elements

    |Element|Description
    |---|---
    |\<xsl:apply-templates\> |Applies the templates of the XSL document to the children of the current node.
    |<xsl:apply-templates match="expression"> |Applies the templates of the XSL document to the children of expression. The value of the attribute match (i.e., expression) must be an XPath expression that specifies elements.
    |\<xsl:template\> |Contains rules to apply when a specified node is matched.
    |<xsl:value-of select="expression"> |Selects the value of an XML element and adds it to the output tree of the transformation. The required select attribute con- tains an XPath expression.
    |<xsl:for-each select="expression"> |Applies a template to every node selected by the XPath specified by the select attribute.
    |<xsl:sort select="expression"> |Used as a child element of an <xsl:apply-templates> or <xsl:for-each> element. Sorts the nodes selected by the <xsl:apply-template> or <xsl:for-each> element so that the nodes are processed in sorted order.
    |\<xsl:output\> |e.g, `<xsl:output method="html" version="5.0" />`
    |\<xsl:copy\> |Adds the current node to the output tree.


## Chapter 16
### Introduction
1. Rich Internet Application (RIA)
    * Definition: Web applications that approximate the look, feel and usability of desktop applications
    * Two key attributes: Performance and Rich GUI
    * Ajax (Asynchronous JavaScript and XML): use client-side scripting to make web applications more responsive
2. XMLHttpRequest object

    |Event or Property|Description
    |---|---
    |readystatechange|Register a listener for this event to specify the callback function—the event handler that gets called when the server responds.
    |readyState|Keeps track of the request’s progress. It’s usually used in the callback function to determine when the code that processes the response should be launched. The readyState value `0` signifies that the request is unini-tialized; `1` that the request is loading; `2` that the request has been loaded; `3` that data is actively being sent from the server; and `4` that the request has been completed.
    |responseText|Text that’s returned to the client by the server.
    |responseXML|If the server’s response is in XML format, this property contains the XML document; otherwise, it’s empty. It can be used like a document object in JavaScript, which makes it useful for receiving complex data (e.g., populating a table).
    |status|HTTP status code of the request.
    |statusText|Additional information on the request’s status. It’s often used to display the error to the user when the request fails.
    |open|Initializes the request and has two *mandatory* parameters—**method** and **URL**. The method parameter specifies the purpose of the request—typically GET or POST. The URL parameter specifies the address of the file on the server that will generate the response. A third optional Boolean parameter specifies whether the request is asynchronous—it’s set to true by default.
    |send |Sends the request to the server. It has one optional parameter, data, which specifies the data to be POSTed to the server—it’s set to null by default.
    |setRequestHeader |Alters the request header. The two parameters specify the header and its new value. It’s often used to set the content-type field.
    |getResponseHeader |Returns the header data that precedes the response body. It takes one parameter, the name of the header to retrieve. This call is often used to determine the response’s type, to parse the response correctly.
    |getAllResponseHeaders |Returns an array that contains all the headers that precede the response body.
    |abort|Cancels the current request.

3. JSON (JavaScipt Object Notation)
    * `JSON.parse(data)` is used to parse the JSON data. The result will be an array or a dictionary.

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
#### Basic
Anything enclosed in `''` in a print statement is not interpolated, unless the single quotes are nested in a double-quoted string literal.

#### String Comparison
1. `==`, `!=`, `<`, `<=`, `>`, `>=` can be used to compare strings
2. `strcmp($str1, $str2)`: return -1 if `str1 < str2`; 0 if `str1 == str2`; 1 otherwise.
#### Regular Expression
1. `preg_match($regx, $str)`: use regular expressions to search a string for a specified pattern using **Perl-compatible regular expressions**. Return the length of the matched string
2. Regular expressions must be enclosed in `/.../`.
3. Meta-characters for regular expressions
    * `^`: matches the beginning of a string
    * `$`: matches the end of a string
    * `.`: matches any single character
    * `[]`: used for bracket expression; match any single character from the list
    * `-`: range, like `a-z`
    * `\b`: indicate the beginning or end of a word
4. Quantifiers
    * `{n}`: exactly n times
    * `{m, n}` between m and n times, inclusive
    * `{n,}`: n or more times
    * `+`: same as `{1,}`
    * `*`: same as `{0,}`
    * `?`: same as `{0, 1}`
5. `preg_match($regx, $str, $match)`: optional third argument, which is an array that stores matches to the regular expression.
6. `preg_replace($pattern, $replace, $str)`: replace the first occurrence of the `$pattern` in `$str` with `$replace`
7. To find multiple instances of a given pattern, we must make multiple calls to `preg_match`, and remove matched instances before calling the function again by using a function such as `preg_replace`.
8: Character Classes: enclosed by `[::]`
    * alnum: Alphanumeric characters, same as the combination of `[a-zA-Z]` and `[0-9]`.
    * alpha: `[a-zA-z]`
    * lower: `[a-z]`
    * upper: `[A-Z]`
    * digit: `[0-9]`
    * space: White space
9. Some examples about character classes
    * `[[:upper:][:lower:]]*`: represents all strings of uppercase and lowercase letters in any order
    * `[[:upper:]][[:lower:]]*`: matches strings with a single uppercase letter followed by any number of lowercase letters
    * `([[:upper:]][[:lower:]])*`: represents all strings that alternate between uppercase and lowercase characters, starting with an uppercase and ending with a lowercase.

### HTML Form Processing
* `die()`: terminate the script execution </br>
    `die($str)`: print the `$str` when exiting
#### Superglobal Array

|Variable name|Description
|-----|-----
|$_SERVER|Data about the currently running server
|$_ENV|Data about the client's environment
|$_GET|Data sent to the server by a `get` request
|$_POST|Data sent to the server by a `post` request
|$_COOKIE|Data contained in cookies on the client's computer
|$GLOBALS|Array containing all global variables

### Database Operation
1. `mysql_connect($host, $usr, $password)`: connect to a database; return a database handler or false if failed.
2. `mysql_select_db($name, $database)`: select and open the database to be queried
3. `mysql_query($query, $database)`: specifying the query string; return a **resource** containing the query result.
4. `mysql_error()`: return any error string from the database
5. `mysql_fetch_row($result)`: return an array containing the values for each column in the current row of the query result. </br>
    `mysql_num_rows($result)`: return the number of rows in `$result`

### Cookies
* `setcookie($cookie_name, $value, $expire)`
    * If no expiration date is specified, the cookie lasts only until the end of the current session—that is, when the user closes the browser. This type of cookie is known as **session cookie** while the one with an expiration date is a **persistent cookie**.
    * If only the cookie name argument is passed to function setcookie, the cookie is deleted from the client’s computer.

### Dynamic Content
* `isset($_POST["key"])`: determine whether the `$_POST` array contain keys representing the various form fields.
