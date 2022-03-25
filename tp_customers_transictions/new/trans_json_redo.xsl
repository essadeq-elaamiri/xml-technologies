<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output indent="yes" method="text"></xsl:output>
    <xsl:variable name="customers" select="document('retail_customers.xml')/*" />
    <xsl:template match="/">
        
        <!-- <xsl:value-of select="transactions/transaction/transaction_date"></xsl:value-of> -->
        Transactions
        <!-- select all transictions grouped by giftshop -->
        <xsl:for-each-group select="transactions/transaction" group-by="giftShop">
            <!--<xsl:value-of select="current-grouping-key()"></xsl:value-of>-->
            <xsl:variable name="current_giftShop" select="current-grouping-key()"/>
            GiftShop <xsl:value-of select="current-grouping-key()"></xsl:value-of>
            <!--<xsl:attribute name="number" select="current-grouping-key()"></xsl:attribute>-->
            <!-- select all transictions with the current giftshop grouped by date -->
            <xsl:for-each-group select="/transactions/transaction[giftShop=$current_giftShop]" group-by="transaction_date">
                <xsl:variable name="current_trans_date" select="current-grouping-key()"/>
                Date <xsl:value-of select="current-grouping-key()"></xsl:value-of>
                <!--<xsl:attribute name="date_value" select="current-grouping-key()"></xsl:attribute>-->
                <!--current date: <xsl:value-of select="$current_trans_date"></xsl:value-of>
                            / current shop: <xsl:value-of select="$current_giftShop"></xsl:value-of> -->
                <xsl:for-each select="/transactions/transaction[giftShop= $current_giftShop and transaction_date = current-grouping-key()]">
                    Transaction <xsl:value-of select="./transactionID"></xsl:value-of>
                    <!--<xsl:attribute name="id" select="./transactionID"></xsl:attribute>-->
                    <xsl:text>&#10;</xsl:text> <!-- newline character -->
                    <xsl:variable name="customer_id" select="./customerID"></xsl:variable>
                    
                    <!--<xsl:attribute name="currency" select="./value/@currency"></xsl:attribute>-->
                    
                    <xsl:value-of select="./value/@currency"> </xsl:value-of> <xsl:value-of select="./value"></xsl:value-of>
                    
                    <xsl:for-each select="$customers/customer[customerID=$customer_id]">
                        
                        <!--<xsl:attribute name="id" select="./customerID"/>-->
                        <xsl:text>&#10;</xsl:text>
                        <xsl:value-of select="./prefix"></xsl:value-of>
                        <xsl:text>&#10;</xsl:text>
                        <xsl:value-of select="./prefix"></xsl:value-of>  
                        <xsl:text>&#10;</xsl:text>
                        <xsl:value-of select="./lastName"></xsl:value-of>
                        <xsl:text>&#10;</xsl:text>
                        <xsl:value-of select="./givenName"></xsl:value-of>
                        <xsl:text>&#10;</xsl:text>
                        <xsl:value-of select="./addressID"></xsl:value-of>
                        
                        
                    </xsl:for-each>
                    
                </xsl:for-each>
                
            </xsl:for-each-group>    
            
        </xsl:for-each-group>
        
    </xsl:template>
</xsl:stylesheet>