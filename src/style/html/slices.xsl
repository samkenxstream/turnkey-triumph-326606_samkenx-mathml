<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:saxon="http://icl.com/saxon"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:xalanredirect="org.apache.xalan.xslt.extensions.Redirect"
                extension-element-prefixes="saxon xalanredirect lxslt"
                version="2.0">

<!-- This stylesheet does not work with XT. Use xtslices.xsl instead. -->

<xsl:include href="slices-common.xsl"/>

<!-- ==================================================================== -->
<!-- This is a workaround for a XalanJ1 bug in element-available. -->

<lxslt:component prefix="xalanredirect" elements="write">
  <lxslt:script lang="javaclass"
                src="org.apache.xalan.xslt.extensions.Redirect"/>
</lxslt:component>

<!-- ==================================================================== -->

<xsl:template name="write.chunk">
  <xsl:param name="filename" select="''"/>
  <xsl:param name="content" select="''"/>
  <xsl:result-document href="{$filename}">
    <xsl:fallback>
      <xalanredirect:write file="{$filename}">
	<xsl:copy-of select="$content"/>
	<xsl:fallback>
	  <!-- doctype not propagating down from top level xsl:output
	       using saxon, not sure why (dpc) -->
	  <saxon:output method="html" 
			
			doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"
			doctype-system="http://www.w3.org/TR/html4/loose.dtd"
			
			href="{$filename}" encoding="utf-8">
	    <xsl:copy-of select="$content"/>
	    <xsl:fallback>
	      <xsl:copy-of select="$content"/>
	    </xsl:fallback>
	  </saxon:output>
	</xsl:fallback>
      </xalanredirect:write> 
    </xsl:fallback>
    <xsl:copy-of select="$content"/>
    </xsl:result-document>
</xsl:template>

</xsl:stylesheet>

