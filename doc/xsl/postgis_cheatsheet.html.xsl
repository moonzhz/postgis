<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [ <!ENTITY nbsp "&#160;"> ]>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!-- ********************************************************************
     ********************************************************************
	 Copyright 2011, Regina Obe
     License: BSD
	 Purpose: This is an xsl transform that generates PostgreSQL COMMENT ON FUNCTION ddl
	 statements from postgis xml doc reference
     ******************************************************************** -->

	<xsl:include href="common_utils.xsl" />
	<xsl:include href="common_cheatsheet.xsl" />

	<xsl:output method="html" />

<xsl:template match="/">
	<html>
		<head>
			<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
			<title>PostGIS Cheat Sheet</title>
			<style type="text/css">
table { page-break-inside:avoid; page-break-after:auto }
tr    { page-break-inside:avoid; page-break-after:avoid }
thead { display:table-header-group }
tfoot { display:table-footer-group }
body {
	font-family: Arial, sans-serif;
	font-size: 8.5pt;
}
@media print { a , a:hover, a:focus, a:active{text-decoration: none;color:black} }
@media screen { a , a:hover, a:focus, a:active{text-decoration: underline} }

.comment {font-size:x-small;color:green;font-family:"courier new"}
.notes {
	font-size:x-small;
	color:#dd1111;
	font-weight:500;
	font-family:verdana;
}
#example_heading {
	border-bottom: 1px solid #000;
	margin: 10px 15px 10px 85px;
	color: #4a124a;font-size: 7.5pt;
}


#content_functions {
	width:100%;
	float: left;
}

#content_functions_left {
	width:100%;
	float: left;
}

#content_functions_right {
	width: 100%;
	float: right;
}


#content_examples {
	float: left;
	width: 100%;
}

.section {
	border: 1px solid #000;
	margin: 4px;

	<xsl:choose><xsl:when test="$output_purpose = 'false'">width: 100%</xsl:when><xsl:otherwise>width: 100%;</xsl:otherwise></xsl:choose>

	float: left;
}

.example {
	border: 1px solid #000;
	margin: 4px;
	width: 100%;
	float:left;
}

.example b {font-size: 7.5pt}
.example th {
	border: 1px solid #000;
	color: #000;
	background-color: #ddd;
	font-size: 8.0pt;
}

.section th {
	border: 1px solid #000;
	color: #fff;
	background-color: #FF9900;
	font-size: 9.5pt;

}
.section td {
	font-family: Arial, sans-serif;
	font-size: 8.5pt;
	vertical-align: top;
	border: 0;
}

.func {font-weight: 600}
.func {font-weight: 600}
.func_args {font-size: 8pt;font-family:"courier new";float:left}

.evenrow {
	background-color: #eee;
}

.oddrow {
	background-color: #fff;
}

h1 {
	margin: 0px;
	padding: 0px;
	font-size: 14pt;
}
code {font-size: 8pt}
			</style>
		</head>
		<body><h1 style='text-align:center'>PostGIS  <xsl:value-of select="$postgis_version" /> Cheatsheet</h1>
			<span class='notes'>
				<!-- TODO: make text equally distributed horizontally ? -->
				<xsl:value-of select="$cheatsheets_config/para[@role='new_in_release']" />
					<sup>1</sup>
				<xsl:value-of select="$cheatsheets_config/para[@role='enhanced_in_release']" />
					<sup>2</sup> &nbsp;
				<xsl:value-of select="$cheatsheets_config/para[@role='aggregate']" />
					<sup>agg</sup> &nbsp;&nbsp;
				<xsl:value-of select="$cheatsheets_config/para[@role='window_function']" />
					<sup>W</sup> &nbsp;
				<xsl:value-of select="$cheatsheets_config/para[@role='requires_geos_3.9_or_higher']" />
					<sup>g3.9</sup> &nbsp;
				<xsl:value-of select="$cheatsheets_config/para[@role='z_support']" />
					<sup>3d</sup> &nbsp;
				SQL-MM<sup>mm</sup> &nbsp;
				<xsl:value-of select="$cheatsheets_config/para[@role='geography_support']" />
					<sup>G</sup>
			</span>
			<div id="content_functions">
				<xsl:apply-templates select="/book/chapter[@id='reference']" />
			</div>
		</body>
	</html>
</xsl:template>


    <xsl:template match="chapter" name="function_list">

			<div id="content_functions_left">

    	<xsl:variable name="col_func_count"><xsl:value-of select="count(descendant::*//funcprototype) div 1.65" /></xsl:variable>

    <!--count(preceding-sibling::*/refentry/refsynopsisdiv/funcsynopsis/funcprototype)-->
		<xsl:for-each select="sect1[count(//funcprototype) &gt; 0 and not( contains(@id,'sfcgal') )]">

			<xsl:variable name="col_cur"><xsl:value-of select="count(current()//funcprototype) + count(preceding-sibling::*//funcprototype)"/></xsl:variable>

			<xsl:if test="$col_cur &gt;$col_func_count and count(preceding-sibling::*//funcprototype) &lt; $col_func_count ">
				<![CDATA[
					</div><div id="content_functions_right">
				]]>
			</xsl:if>

			<!--Beginning of section -->
			<table class="section"><tr><th colspan="2"><xsl:value-of select="title" />
				<!-- end of section header beginning of function list -->
				</th></tr>
			<xsl:for-each select="current()//refentry">
				<!-- add row for each function and alternate colors of rows -->
				<!-- , hyperlink to online manual -->
				<tr>
					<xsl:attribute name="class">
						<xsl:choose>
							<xsl:when test="position() mod 2 = 0">evenrow</xsl:when>
							<xsl:otherwise>oddrow</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>

				<td colspan='2'>
					<span class='func'>
						<a target="_blank">
							<xsl:attribute name="href">
								<xsl:value-of select="concat(concat($linkstub, @id), '.html')" />
							</xsl:attribute>
							<xsl:value-of select="refnamediv/refname" />
						</a>
					</span>
				<xsl:if test="contains(.,$new_tag)"><sup>1</sup> </xsl:if>
		 		<!-- enhanced tag -->
		 		<xsl:if test="contains(.,$enhanced_tag)"><sup>2</sup> </xsl:if>
		 		<xsl:if test="contains(.,'implements the SQL/MM')"><sup>mm</sup> </xsl:if>
		 		<xsl:if test="contains(refsynopsisdiv/funcsynopsis,'geography') or contains(refsynopsisdiv/funcsynopsis/funcprototype/funcdef,'geography')"><sup>G</sup>  </xsl:if>
		 		<xsl:if test="contains(.,'GEOS &gt;= 3.9')"><sup>g3.9</sup> </xsl:if>
		 		<xsl:if test="contains(.,'This function supports 3d')"><sup>3d</sup> </xsl:if>
		 		<!-- if only one proto just dispaly it on first line -->
		 		<xsl:if test="count(refsynopsisdiv/funcsynopsis/funcprototype) = 1">
		 			(<xsl:call-template name="list_in_params"><xsl:with-param name="func" select="refsynopsisdiv/funcsynopsis/funcprototype" /></xsl:call-template>)
		 		</xsl:if>

		 		&nbsp;&nbsp;
		 		<xsl:if test="$output_purpose = 'true'"><xsl:value-of select="refnamediv/refpurpose" /></xsl:if>
		 		<!-- output different proto arg combos -->
		 		<xsl:if test="count(refsynopsisdiv/funcsynopsis/funcprototype) &gt; 1"><span class='func_args'><ol><xsl:for-each select="refsynopsisdiv/funcsynopsis/funcprototype"><li><xsl:call-template name="list_in_params"><xsl:with-param name="func" select="." /></xsl:call-template><xsl:if test=".//paramdef[contains(type,' set')] or .//paramdef[contains(type,'geography set')] or
						.//paramdef[contains(type,'raster set')]"><sup> agg</sup> </xsl:if><xsl:if test=".//paramdef[contains(type,'winset')]"> <sup>W</sup> </xsl:if></li></xsl:for-each>
		 		</ol></span></xsl:if>
		 		</td></tr>
		 		</xsl:for-each>
		 		</table><br />
		 		<!--close section -->
		 	</xsl:for-each>
		</div>

	</xsl:template>

</xsl:stylesheet>
