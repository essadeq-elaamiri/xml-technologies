<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="html" indent="yes"></xsl:output> <!-- use indentation -->
    <xsl:template match="/">
        <html>
            <head>
                <title>XSLT</title>
            </head>
            <body>
                <h2>Hello  <xsl:value-of select="meteo/mesure[1]/ville[@nom='Rabat']/@temperature"></xsl:value-of> </h2>
                <!-- relative path in select parapport au element selectionné dans le template -->
                
                <xsl:for-each select="meteo/mesure">
                    <h2>
                        <!--<xsl:value-of select="@date"></xsl:value-of>-->
                        <xsl:apply-templates select="."></xsl:apply-templates>
                    </h2>
                    <ul>
                        <xsl:for-each select="ville">
                            <xsl:sort select="@temperature" order="ascending"/>
                            
                            <li>
                                <!-- <xsl:if test="@temperature &gt; 20">
                                    <xsl:text > ++ </xsl:text>
                                </xsl:if> -->
                                <xsl:value-of select="@nom"></xsl:value-of> : 
                                <xsl:value-of select="@temperature"></xsl:value-of>
                                <xsl:choose>
                                    <xsl:when test="@temperature &gt; 15 and @temperature &lt; 27">
                                        <span>(il fait Beau)</span> 
                                    </xsl:when>
                                    <xsl:when test="@temperature &gt; 27">
                                        <span>(il fait chaud)</span>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <span>(il fait froid)</span>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </li>
                        </xsl:for-each>
                    </ul>
                </xsl:for-each>
                
            </body>
        </html>
    </xsl:template>
    <xsl:template match="mesure">
       Date : <xsl:value-of select="@date"></xsl:value-of> 
       Nombre villes:  <xsl:value-of select="count(ville)"></xsl:value-of>
    </xsl:template>
</xsl:stylesheet>

<!-- meteo.xsl -->