<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output indent="yes" method="text"/>
    <xsl:variable name="customers" select="document('retail_customers.xml')/*" />
    <xsl:template match="/">
        
        <!-- <xsl:value-of select="transactions/transaction/transaction_date"></xsl:value-of> -->
        <!--<transactions>--> [
            <!-- select all transictions grouped by giftshop -->
            <xsl:for-each-group select="transactions/transaction" group-by="giftShop">
                <!--<xsl:value-of select="current-grouping-key()"></xsl:value-of>-->
                <xsl:variable name="current_giftShop" select="current-grouping-key()"/>
                <!--<giftshop>-->{
                    <!--<xsl:attribute name="number" select="current-grouping-key()"></xsl:attribute>-->
                "number": <xsl:value-of select="current-grouping-key()"></xsl:value-of>, "dates":[
                    <!-- select all transictions with the current giftshop grouped by date -->
                    <xsl:for-each-group select="/transactions/transaction[giftShop=$current_giftShop]" group-by="transaction_date">
                        <xsl:variable name="current_trans_date" select="current-grouping-key()"/>
                        <!--<date>-->{
                            <!--<xsl:attribute name="date_vale" select="current-grouping-key()"></xsl:attribute>-->
                        "date_value": "<xsl:value-of select="current-grouping-key()"></xsl:value-of>","transactions":[
                            <!--current date: <xsl:value-of select="$current_trans_date"></xsl:value-of>
                            / current shop: <xsl:value-of select="$current_giftShop"></xsl:value-of> -->
                            <xsl:for-each select="/transactions/transaction[giftShop= $current_giftShop and transaction_date = current-grouping-key()]">
                                <!--<transaction>-->{                                    
                                    <!--<xsl:attribute name="id" select="./transactionID"></xsl:attribute>-->
                                "id": "<xsl:value-of select="./transactionID"></xsl:value-of>",
                                    <xsl:variable name="customer_id" select="./customerID"></xsl:variable>
                                    <!--<value>
                                        <xsl:attribute name="currency" select="./value/@currency"></xsl:attribute>
                                        <xsl:value-of select="./value"></xsl:value-of>
                                    </value>-->
                                "value":{"currency": "<xsl:value-of select="./value/@currency"></xsl:value-of>", "value": <xsl:value-of select="./value"></xsl:value-of>  },
                                    <!--<xsl:for-each select="$customers/customer[customerID=$customer_id]">
                                        <customer >
                                            <xsl:attribute name="id" select="./customerID"/>
                                            <prefix>
                                                <xsl:value-of select="./prefix"></xsl:value-of>
                                            </prefix>
                                            <lastName>
                                                <xsl:value-of select="./lastName"></xsl:value-of>
                                            </lastName>
                                            <givenName>
                                                <xsl:value-of select="./givenName"></xsl:value-of>
                                            </givenName>
                                            <addressID>
                                                <xsl:value-of select="./addressID"></xsl:value-of>
                                            </addressID>
                                        </customer>
                                        "customer":{
                                        "id": "<xsl:value-of select="./customerID"></xsl:value-of>",
                                        "prefix": "<xsl:value-of select="./prefix"></xsl:value-of>",
                                        "lastName": "<xsl:value-of select="./lastName"></xsl:value-of>",
                                        "givenName": "<xsl:value-of select="./givenName"></xsl:value-of>",
                                        "addressID": "<xsl:value-of select="./addressID"></xsl:value-of>"
                                        
                                        }
                                    </xsl:for-each> -->
                                <xsl:variable name="customer_elm" select="$customers/customer[customerID=$customer_id]"></xsl:variable>
                                "customer":{
                                "id": "<xsl:value-of select="$customer_elm/customerID"></xsl:value-of>",
                                "prefix": "<xsl:value-of select="$customer_elm/prefix"></xsl:value-of>",
                                "lastName": "<xsl:value-of select="$customer_elm/lastName"></xsl:value-of>",
                                "givenName": "<xsl:value-of select="$customer_elm/givenName"></xsl:value-of>",
                                "addressID": "<xsl:value-of select="$customer_elm/addressID"></xsl:value-of>"
                                
                                }
                                <!--</transaction>-->}<!--,-->
                                <xsl:if test="not(position() = last())">,</xsl:if>
                            </xsl:for-each>]
                        <!--</date>--> }<!--,-->
                        <xsl:if test="not(position() = last())">,</xsl:if>
                    </xsl:for-each-group> ]    
                <!--</giftshop>-->}<!--,-->
                <xsl:if test="not(position() = last())">,</xsl:if>
            </xsl:for-each-group>
        <!--</transactions>-->]
    </xsl:template>
</xsl:stylesheet>