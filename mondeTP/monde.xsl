<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output encoding="UTF-8" indent="yes"></xsl:output>
    <xsl:template match="/">
       
        
      <monde>
          <xsl:for-each select="mondial/country">
              <xsl:variable name="population">
                  <xsl:value-of select="population[last()]"></xsl:value-of>
              </xsl:variable>
              <pays>
                  <xsl:attribute name="code">
                      <xsl:value-of select="@car_code"></xsl:value-of>
                  </xsl:attribute>
                  <!-- nom, capitale, population, religions, ville+, frontiere* -->
                  <nom>
                      <xsl:value-of select="name[1]"></xsl:value-of>
                  </nom>
                  <capitale>
                      <xsl:value-of select="city[@id = ../@capital]/name[1]"></xsl:value-of>
                  </capitale>
                  
                  <population>
                      <xsl:attribute name="annee">
                          <xsl:value-of select="population[last()]/@year"/>
                      </xsl:attribute>
                      <!--<xsl:value-of select="population[last()]"></xsl:value-of>-->
                      <xsl:copy-of select="$population" /> <!-- colling variable -->
                  </population>
                  
                  <religions>
                      <!-- musulman?, cretien?, juif?, autre? -->
                      
                      <!-- test if exist -->
                      <!-- adding population to variable -->
                      <!-- get religion percentage, and calc population * percentage/ 100 -->
                      <!-- /mondial/country[1]/religion/@percentage -->
                      
                      
                      <!-- /mondial/country[1]/religion[.='Muslim']/@percentage -->
                      <xsl:if test="religion[contains(., 'Muslim')]">
                          <musulman>
                              <xsl:value-of select="$population * (religion[.='Muslim']/@percentage div 100)"></xsl:value-of> 
                          </musulman>
                      </xsl:if>
                      <xsl:if test="religion[.='Protestant' or .='Catholic'or  contains(., 'Orthodox')]">
                        <cretien>
                            <xsl:value-of select="($population * (religion[.='Protestant']/@percentage div 100)) +
                                ($population * (religion[.='Catholic']/@percentage div 100)) +
                                ($population * (religion[contains(., 'Orthodox')]/@percentage div 100))"></xsl:value-of>
                        </cretien>
                      </xsl:if>
                      <xsl:if test="religion[contains(., 'Jewish')]">    
                         <juif>
                             <xsl:value-of select="$population * (religion[.='Jewish']/@percentage div 100)"></xsl:value-of>
                         </juif>
                      </xsl:if>
                      <autre>
                          <xsl:value-of select="$population * ((sum(religion[.!='Jewish' and .!='Muslim' and .!='Protestant' and .!='Catholic' and not(contains(., 'Orthodox'))]/@percentage)) div 100)"/>
                      </autre>
                      
                  </religions>
                  
                  <xsl:for-each select="city">
                      <ville>
                          <nom><xsl:value-of select="name[1]"/></nom>
                          <longitude><xsl:value-of select="longitude"/></longitude>
                          <latitude><xsl:value-of select="latitude"/></latitude>
                      </ville>
                  </xsl:for-each>
                  
                  <xsl:for-each select="border">
                      <frontiere>
                          <xsl:attribute name="pays">
                              <xsl:call-template name="join">
                                  <xsl:with-param name="list" select="." />
                                  <xsl:with-param name="separator" select="' '" />
                              </xsl:call-template>
                          </xsl:attribute>
                          <xsl:attribute name="longeur">
                              <xsl:value-of select="sum(@length)"></xsl:value-of>
                          </xsl:attribute>
                      </frontiere>
                  </xsl:for-each>
                  
                  
                  
              </pays>
          </xsl:for-each>
      </monde>
    </xsl:template>
    <xsl:template name="join">
        <xsl:param name="list" />
        <xsl:param name="separator"/>
        
        <xsl:for-each select="$list">
            <xsl:value-of select="@country" />
            <xsl:if test="position() != last()">
                <xsl:value-of select="$separator" />
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>