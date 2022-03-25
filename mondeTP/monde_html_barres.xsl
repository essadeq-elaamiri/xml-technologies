<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="html" encoding="UTF-8" indent="yes"></xsl:output>
    <xsl:template match="/">
        <style>
            #tab {
            font-family: Arial, Helvetica, sans-serif;
            border-collapse: collapse;
            width: 100%;
            }
            
            #tab td, #tab th {
            border: 1px solid #ddd;
            padding: 8px;
            }
            
            #tab tr:nth-child(even){background-color: #f2f2f2;}
            
            #tab tr:hover {background-color: #ddd;}
            
            #tab th {
            padding-top: 12px;
            padding-bottom: 12px;
            text-align: left;
            background-color: #04AA6D;
            color: white;
            }
            .container {
            background-color: rgb(192, 192, 192);
            width: 100%;
            }
            
            .progress {
            background-color: rgb(116, 194, 92);
            color: white;
            padding: 1%;
            text-align: right;
            margin-top: 5px;
            margin-bottom: 5px;
            }
        </style>
        <table id="tab">
            <tr>
                <th>Pays</th>
                <th>Population</th>
                <th>Religions</th>
            </tr>
            <xsl:for-each select="monde/pays"> 
                <xsl:sort select="nom"/>
                <xsl:variable name="pop" select="population"></xsl:variable>
                <tr>
                    <td>
                        <xsl:value-of select="nom"></xsl:value-of>
                    </td>
                    <td>
                        <!--<xsl:value-of select="population"></xsl:value-of>-->
                        <xsl:copy-of select="$pop"></xsl:copy-of>
                    </td>
                    <td>
                        <xsl:for-each select="religions/element()">
                            
                            <div class="container">
                                <div class="progress"> <!-- ( number(../population) * number(.) div 100) -->
                                    <xsl:attribute name="style">width:<xsl:value-of select=" (number(.) * 100) div $pop"></xsl:value-of>%;</xsl:attribute>
                                    <xsl:value-of select="name()"></xsl:value-of>
                                    
                                    
                                </div>
                            </div>
                            
                        </xsl:for-each>
                    </td>
                    
                </tr>
                
            </xsl:for-each>
        </table>
    </xsl:template>
    
</xsl:stylesheet>