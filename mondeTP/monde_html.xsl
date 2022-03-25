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
        </style>
        <table id="tab">
            <tr>
                <th>Pays</th>
                <th>Population</th>
                <th>Religions</th>
            </tr>
            <xsl:for-each select="monde/pays"> 
                <xsl:sort select="nom"/>
                <tr>
                    <td>
                        <xsl:value-of select="nom"></xsl:value-of>
                    </td>
                    <td>
                        <xsl:value-of select="population"></xsl:value-of>
                    </td>
                    <td>
                        <xsl:for-each select="religions/element()">
                            <li>
                                <xsl:value-of select="name()"></xsl:value-of> : <xsl:value-of select="."></xsl:value-of>
                            </li>
                        </xsl:for-each>
                    </td>
                    
                </tr>
                
            </xsl:for-each>
        </table>
    </xsl:template>
    
</xsl:stylesheet>