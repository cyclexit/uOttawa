<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" version="5.0" />
    <xsl:template match="/">
        <html>
            <head>
                <meta charset="UTF-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <title>Question 7</title>
                <style>
                    table {
                        text-align: center;
                    }
                </style>
            </head>

            <body>
                <h1>
                    <xsl:value-of select="product/@name" />
                </h1>
                <table border="1">
                    <tr>
                        <th>Serving Size</th>
                        <td colspan="2">
                            <xsl:value-of select="product/serving_size" />
                            &#160;
                            <xsl:value-of select="product/serving_size/@unit" />
                        </td>
                    </tr>
                    <tr>
                        <th rowspan="{count(product/nutrition/*)+1}">
                            Nutrition Facts <br />
                            Per serving size
                        </th>
                    </tr>
                    <xsl:for-each select="product/nutrition/*">
                        <tr>
                            <th>
                                <xsl:value-of select="local-name()" />
                            </th>
                            <td>
                                <xsl:value-of select="." />
                                <xsl:value-of select="./@unit" />
                            </td>
                        </tr>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>