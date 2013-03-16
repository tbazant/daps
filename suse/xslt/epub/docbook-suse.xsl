<?xml version="1.0"?>
<xsl:stylesheet 
  xmlns:db="http://docbook.org/ns/docbook"
  xmlns:dc="http://purl.org/dc/elements/1.1/"  
  xmlns:exsl="http://exslt.org/common" 
  xmlns:h="http://www.w3.org/1999/xhtml"
  xmlns:ncx="http://www.daisy.org/z3986/2005/ncx/"
  xmlns:ng="http://docbook.org/docbook-ng"
  xmlns:opf="http://www.idpf.org/2007/opf"
  xmlns:stext="http://nwalsh.com/xslt/ext/com.nwalsh.saxon.TextFactory"
  xmlns:str="http://exslt.org/strings"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xtext="xalan://com.nwalsh.xalan.Text"

  extension-element-prefixes="stext xtext"
  exclude-result-prefixes="exsl db dc h ncx ng opf stext str xtext"

  version="1.0">

  <xsl:import href="../xhtml-1_1/docbook.xsl" />
  <xsl:import href="../xhtml-1_1/chunk-common.xsl" />
  <xsl:include href="../xhtml-1_1/chunk-code.xsl" />


  <!-- We want a separate TOC file, please -->
  <xsl:param name="chunk.tocs.and.lots">1</xsl:param>
  <xsl:param name="toc.section.depth">2</xsl:param>
  <xsl:param name="generate.toc">
  book   toc,title
  </xsl:param>

  <xsl:param name="ade.extensions" select="0"/>
  <xsl:param name="epub.autolabel" select="'1'"/> 
  <xsl:param name="epub.ncx.depth">4</xsl:param> <!-- Not functional until http://code.google.com/p/epubcheck/issues/detail?id=70 is resolved -->


  <xsl:param name="manifest.in.base.dir" select="'1'"/> 
  <xsl:param name="base.dir" select="$epub.oebps.dir"/>

  <xsl:param name="epub.oebps.dir" select="'OEBPS/'"/> 
  <xsl:param name="epub.ncx.filename" select="'toc.ncx'"/> 
  <xsl:param name="epub.container.filename" select="'container.xml'"/> 
  <xsl:param name="epub.opf.filename" select="concat($epub.oebps.dir,'content.opf')"/> 
  <xsl:param name="epub.cover.filename" select="concat($epub.oebps.dir, 'cover', $html.ext)"/> 
  <xsl:param name="epub.cover.id" select="'cover'"/> 
  <xsl:param name="epub.cover.html" select="'cover.html'" />
  <xsl:param name="epub.cover.image.id" select="'cover-image'"/> 
  <xsl:param name="epub.cover.linear" select="0" />
  <xsl:param name="epub.ncx.toc.id">ncxtoc</xsl:param>
  <xsl:param name="epub.html.toc.id">htmltoc</xsl:param>
  <xsl:param name="epub.metainf.dir" select="'META-INF/'"/> 

  <xsl:param name="epub.embedded.fonts"></xsl:param>

  <!-- Turning this on crashes ADE, which is unbelievably awesome -->
  <xsl:param name="formal.object.break.after">0</xsl:param>


  <!-- Per Bob Stayton:
       """Process your documents with the css.decoration parameter set to zero. 
          That will avoid the use of style attributes in XHTML elements where they are not permitted."""
       http://www.sagehill.net/docbookxsl/OtherOutputForms.html#StrictXhtmlValid -->
  <xsl:param name="css.decoration" select="0"/>
  <xsl:param name="custom.css.source"></xsl:param> <!-- FIXME: Align with current CSS parameter design -->

  <xsl:param name="callout.graphics" select="1"/>
  <xsl:param name="callout.graphics.extension">.png</xsl:param>
  <xsl:param name="callout.graphics.number.limit" select="15"/>
  <xsl:param name="callout.graphics.path" select="'images/callouts/'"/>

  <!-- no navigation in .epub -->
  <xsl:param name="suppress.navigation" select="'1'"/> 

  <xsl:variable name="toc.params">
    <xsl:call-template name="find.path.params">
      <xsl:with-param name="node" select="/*"/>
      <xsl:with-param name="table" select="normalize-space($generate.toc)"/>
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="root.is.a.chunk">
    <xsl:choose>
      <xsl:when test="/*[not(self::book)][not(sect1) or not(section)]">
        <xsl:text>1</xsl:text>
      </xsl:when>
      <xsl:when test="/book[*[last()][self::bookinfo]]|book[bookinfo]">
        <xsl:text>1</xsl:text>
      </xsl:when>
      <xsl:when test="/book[*[last()][self::info]]|book[info]">
        <xsl:text>1</xsl:text>
      </xsl:when>
      <xsl:when test="/bibliography">
        <xsl:text>1</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>0</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:key name="image-filerefs" match="graphic|inlinegraphic|imagedata" use="@fileref"/>

  <xsl:template match="/" priority="1">
    <!-- * Get a title for current doc so that we let the user -->
    <!-- * know what document we are processing at this point. -->
    <xsl:variable name="doc.title">
      <xsl:call-template name="get.doc.title" />
    </xsl:variable>
    <xsl:choose>
      <!-- Hack! If someone hands us a DocBook V5.x or DocBook NG document,
        toss the namespace and continue.  Use the docbook5 namespaced
        stylesheets for DocBook5 if you don't want to use this feature.-->
      <!-- include extra test for Xalan quirk -->
      <xsl:when test="$exsl.node.set.available != 0
                    and (*/self::ng:* or */self::db:*)">
        <xsl:call-template name="log.message">
          <xsl:with-param name="level">Note</xsl:with-param>
          <xsl:with-param name="source" select="$doc.title" />
          <xsl:with-param name="context-desc">
            <xsl:text>namesp. cut</xsl:text>
          </xsl:with-param>
          <xsl:with-param name="message">
            <xsl:text>stripped namespace before processing</xsl:text>
          </xsl:with-param>
        </xsl:call-template>
        <xsl:variable name="nons">
          <xsl:apply-templates mode="stripNS" />
        </xsl:variable>
        <xsl:call-template name="log.message">
          <xsl:with-param name="level">Note</xsl:with-param>
          <xsl:with-param name="source" select="$doc.title" />
          <xsl:with-param name="context-desc">
            <xsl:text>namesp. cut</xsl:text>
          </xsl:with-param>
          <xsl:with-param name="message">
            <xsl:text>processing stripped document</xsl:text>
          </xsl:with-param>
        </xsl:call-template>
        <xsl:apply-templates select="exsl:node-set($nons)" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="$rootid != ''">
            <xsl:choose>
              <xsl:when
                test="count(key('id',$rootid)) = 0">
                <xsl:message terminate="yes">
                  <xsl:text>ID '</xsl:text>
                  <xsl:value-of select="$rootid" />
                  <xsl:text>' not found in document.</xsl:text>
                </xsl:message>
              </xsl:when>
              <xsl:otherwise>
                <xsl:if
                  test="$collect.xref.targets = 'yes' or
                                $collect.xref.targets = 'only'">
                  <xsl:apply-templates
                    select="key('id', $rootid)" mode="collect.targets" />
                </xsl:if>
                <xsl:if
                  test="$collect.xref.targets != 'only'">
                  <xsl:message>
                    Formatting from
                    <xsl:value-of select="$rootid" />
                  </xsl:message>
                  <xsl:apply-templates
                    select="key('id',$rootid)" mode="process.root" />
                  <xsl:call-template name="ncx" />
                </xsl:if>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:otherwise>
            <xsl:if
              test="$collect.xref.targets = 'yes' or
                    $collect.xref.targets = 'only'">
              <xsl:apply-templates select="/"
                mode="collect.targets" />
            </xsl:if>
            <xsl:if
              test="$collect.xref.targets != 'only'">
              <xsl:apply-templates select="/"
                mode="process.root" />
              <xsl:call-template name="ncx" />
              <xsl:call-template name="opf" />
              <xsl:call-template name="cover" />
              <xsl:call-template name="container" />
            </xsl:if>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="package-identifier">
    <xsl:choose>
      <xsl:when test="/*/*[contains(name(.), 'info')]/biblioid">
        <xsl:if test="/*/*[contains(name(.), 'info')][1]/biblioid[1][@class = 'doi' or 
                                                                      @class = 'isbn' or
                                                                      @class = 'isrn' or
                                                                      @class = 'issn']">
          <xsl:text>urn:</xsl:text>
          <xsl:value-of select="/*/*[contains(name(.), 'info')][1]/biblioid[1]/@class"/>
          <xsl:text>:</xsl:text>
        </xsl:if>
        <xsl:value-of select="/*/*[contains(name(.), 'info')][1]/biblioid[1]"/>
      </xsl:when>
      <xsl:when test="/*/*[contains(name(.), 'info')]/isbn">
        <xsl:text>urn:isbn:</xsl:text>
        <xsl:value-of select="/*/*[contains(name(.), 'info')][1]/isbn[1]"/>
      </xsl:when>
      <xsl:when test="/*/*[contains(name(.), 'info')]/issn">
        <xsl:text>urn:issn:</xsl:text>
        <xsl:value-of select="/*/*[contains(name(.), 'info')][1]/issn[1]"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="/*/*[contains(name(.), 'info')]/invpartnumber"> <xsl:value-of select="/*/*[contains(name(.), 'info')][1]/invpartnumber[1]"/> </xsl:when>
          <xsl:when test="/*/*[contains(name(.), 'info')]/issuenum">      <xsl:value-of select="/*/*[contains(name(.), 'info')][1]/issuenum[1]"/> </xsl:when>
          <xsl:when test="/*/*[contains(name(.), 'info')]/productnumber"> <xsl:value-of select="/*/*[contains(name(.), 'info')][1]/productnumber[1]"/> </xsl:when>
          <xsl:when test="/*/*[contains(name(.), 'info')]/seriesvolnums"> <xsl:value-of select="/*/*[contains(name(.), 'info')][1]/seriesvolnums[1]"/> </xsl:when>
          <xsl:when test="/*/*[contains(name(.), 'info')]/volumenum">     <xsl:value-of select="/*/*[contains(name(.), 'info')][1]/volumenum[1]"/> </xsl:when>
          <!-- Deprecated -->
          <xsl:when test="/*/*[contains(name(.), 'info')]/pubsnumber">    <xsl:value-of select="/*/*[contains(name(.), 'info')][1]/pubsnumber[1]"/> </xsl:when>
        </xsl:choose>  
        <xsl:text>_</xsl:text>
        <xsl:choose>
          <xsl:when test="/*/@id">
            <xsl:value-of select="/*/@id"/>
          </xsl:when>
          <xsl:when test="/*/@xml:id">
            <xsl:value-of select="/*/@xml:id"/>
          </xsl:when>
          <xsl:otherwise>
            <!-- TODO: Do UUIDs here -->
            <xsl:value-of select="generate-id(/*)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="opf">
    <xsl:variable name="package-identifier-id"><xsl:value-of select="concat(name(/*), 'id')"/></xsl:variable>
    <xsl:variable name="doc.title">
      <xsl:call-template name="get.doc.title" />
    </xsl:variable>
    <xsl:call-template name="write.chunk">
      <xsl:with-param name="filename">
        <xsl:value-of select="$epub.opf.filename" />
      </xsl:with-param>
      <xsl:with-param name="method" select="'xml'" />
      <xsl:with-param name="encoding" select="'utf-8'" />
      <xsl:with-param name="indent" select="'no'" />
      <xsl:with-param name="quiet" select="$chunk.quietly" />
      <xsl:with-param name="doctype-public" select="''"/> <!-- intentionally blank -->
      <xsl:with-param name="doctype-system" select="''"/> <!-- intentionally blank -->
      <xsl:with-param name="content">
        <package xmlns="http://www.idpf.org/2007/opf"
          version="2.0" unique-identifier="{$package-identifier-id}">

          <metadata>
            <dc:identifier id="{$package-identifier-id}">
              <xsl:call-template name="package-identifier"/>
            </dc:identifier>

            <dc:title>
              <xsl:value-of select="normalize-space($doc.title)"/>
            </dc:title>

            <xsl:apply-templates select="/*/*[contains(name(.), 'info')]/*"
                                 mode="opf.metadata"/>
            <dc:language>
              <xsl:call-template name="l10n.language">
                <xsl:with-param name="target" select="/*"/>
              </xsl:call-template>
            </dc:language>

            <xsl:if test="/*/*[cover or contains(name(.), 'info')]//mediaobject[@role='cover' or ancestor::cover]"> 
              <meta name="cover" content="{$epub.cover.image.id}"/>
            </xsl:if>

          </metadata>
          <xsl:call-template name="opf.manifest"/>
          <xsl:call-template name="opf.spine"/>
          <xsl:call-template name="opf.guide"/>

        </package>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="container">
    <xsl:call-template name="write.chunk">
      <xsl:with-param name="filename">
        <xsl:value-of select="$epub.metainf.dir" />
        <xsl:value-of select="$epub.container.filename" />
      </xsl:with-param>
      <xsl:with-param name="method" select="'xml'" />
      <xsl:with-param name="encoding" select="'utf-8'" />
      <xsl:with-param name="indent" select="'no'" />
      <xsl:with-param name="quiet" select="$chunk.quietly" />
      <xsl:with-param name="doctype-public" select="''"/> <!-- intentionally blank -->
      <xsl:with-param name="doctype-system" select="''"/> <!-- intentionally blank -->

      <xsl:with-param name="content">
        <container xmlns="urn:oasis:names:tc:opendocument:xmlns:container"
          version="1.0">
          <rootfiles>
            <rootfile full-path="{$epub.opf.filename}"
              media-type="application/oebps-package+xml"/>
          </rootfiles>
        </container>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="ncx">
    <xsl:call-template name="write.chunk">
      <xsl:with-param name="filename">
        <xsl:if test="$manifest.in.base.dir != 0">
          <xsl:value-of select="$chunk.base.dir" />
        </xsl:if>
        <xsl:value-of select="$epub.ncx.filename" />
      </xsl:with-param>
      <xsl:with-param name="method" select="'xml'" />
      <xsl:with-param name="encoding" select="'utf-8'" />
      <xsl:with-param name="indent" select="'no'" />
      <xsl:with-param name="quiet" select="$chunk.quietly" />
      <xsl:with-param name="doctype-public" select="''"/> <!-- intentionally blank -->
      <xsl:with-param name="doctype-system" select="''"/> <!-- intentionally blank -->
      <xsl:with-param name="content">
        <ncx xmlns="http://www.daisy.org/z3986/2005/ncx/" version="2005-1">

            <!-- Via Martin Goerner: On covers: the IDPF2.0 standard unfortunately does not have a provision for
            covers. We had to add one and we did so in conjunction with the IDPF and
            various publishers. The tag chosen to define the covers is:
            <meta name="cover" content="-reference to a manifest item-">
            Then, we also added a bit of logic to get rid cleanly of the HTML cover
            people usually add because the logical cover is not specced by the IDPF. So,
            if the HTML cover item is marked linear="no" AND there is a guide item of
            type="cover" pointing to it AND there is a logical cover specified in a
            <meta name="cover"> tag, THEN, the HTML cover is discarded. -->
          <head>
            <xsl:if test="/*/*[cover or contains(name(.), 'info')]//mediaobject[@role='cover' or ancestor::cover]"> 
              <meta name="cover" content="{$epub.cover.id}"/>
            </xsl:if>
            <meta name="dtb:uid">
              <xsl:attribute name="content"><xsl:call-template name="package-identifier"/></xsl:attribute>
            </meta>
          </head>

          <xsl:choose>
            <xsl:when test="$rootid != ''">
              <xsl:variable name="title">
                <xsl:if test="$epub.autolabel != 0">
                  <xsl:variable name="label.markup">
                    <xsl:apply-templates select="key('id',$rootid)" mode="label.markup" />
                  </xsl:variable>
                  <xsl:if test="normalize-space($label.markup)">
                    <xsl:value-of select="concat($label.markup,$autotoc.label.separator)" />
                  </xsl:if>
                </xsl:if>
                <xsl:apply-templates select="key('id',$rootid)" mode="title.markup" />
              </xsl:variable>
              <xsl:variable name="href">
                <xsl:call-template name="href.target.with.base.dir">
                  <xsl:with-param name="object" select="key('id',$rootid)" />
                </xsl:call-template>
              </xsl:variable>
              <docTitle>
                <text><xsl:value-of select="normalize-space($title)"/></text>
              </docTitle>
              <navMap>
                <xsl:apply-templates select="key('id',$rootid)/*" mode="ncx" />
              </navMap>
            </xsl:when>
            <xsl:otherwise>
              <xsl:variable name="title">
                <xsl:if test="$epub.autolabel != 0">
                  <xsl:variable name="label.markup">
                    <xsl:apply-templates select="/*" mode="label.markup" />
                  </xsl:variable>
                  <xsl:if test="normalize-space($label.markup)">
                    <xsl:value-of select="concat($label.markup,$autotoc.label.separator)" />
                  </xsl:if>
                </xsl:if>
                <xsl:apply-templates select="/*" mode="title.markup" />
              </xsl:variable>
              <xsl:variable name="href">
                <xsl:call-template name="href.target.with.base.dir">
                  <xsl:with-param name="object" select="/" />
                </xsl:call-template>
              </xsl:variable>
              <docTitle>
                <text><xsl:value-of select="normalize-space($title)" /></text>
              </docTitle>
              <navMap>
                <xsl:choose>
                  <xsl:when test="$root.is.a.chunk != '0'">
                    <xsl:apply-templates select="/*" mode="ncx" />
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:apply-templates select="/*/*" mode="ncx" />
                  </xsl:otherwise>
                </xsl:choose>
              </navMap>
            </xsl:otherwise>

          </xsl:choose>
        </ncx>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="book|
                       article|
                       part|
                       reference|
                       preface|
                       chapter|
                       bibliography|
                       appendix|
                       glossary|
                       section|
                       sect1|
                       sect2|
                       sect3|
                       sect4|
                       sect5|
                       refentry|
                       colophon|
                       bibliodiv[title]|
                       setindex|
                       index"
                mode="ncx">
    <xsl:variable name="depth" select="count(ancestor::*)"/>
    <xsl:variable name="title">
      <xsl:if test="$epub.autolabel != 0">
        <xsl:variable name="label.markup">
          <xsl:apply-templates select="." mode="label.markup" />
        </xsl:variable>
        <xsl:if test="normalize-space($label.markup)">
          <xsl:value-of
            select="concat($label.markup,$autotoc.label.separator)" />
        </xsl:if>
      </xsl:if>
      <xsl:apply-templates select="." mode="title.markup" />
    </xsl:variable>

    <xsl:variable name="href">
      <xsl:call-template name="href.target.with.base.dir">
        <xsl:with-param name="context" select="/" />
        <!-- Generate links relative to the location of root file/toc.xml file -->
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="id">
      <xsl:value-of select="generate-id(.)"/>
    </xsl:variable>
    <xsl:variable name="order">
      <xsl:value-of select="$depth +
                                  count(preceding::part|
                                  preceding::reference|
                                  preceding::book[parent::set]|
                                  preceding::preface|
                                  preceding::chapter|
                                  preceding::bibliography|
                                  preceding::appendix|
                                  preceding::article|
                                  preceding::glossary|
                                  preceding::section[not(parent::partintro)]|
                                  preceding::sect1[not(parent::partintro)]|
                                  preceding::sect2[not(ancestor::partintro)]|
                                  preceding::sect3[not(ancestor::partintro)]|
                                  preceding::sect4[not(ancestor::partintro)]|
                                  preceding::sect5[not(ancestor::partintro)]|
                                  preceding::refentry|
                                  preceding::colophon|
                                  preceding::bibliodiv[title]|
                                  preceding::index)"/>
    </xsl:variable>

    <navPoint xmlns="http://www.daisy.org/z3986/2005/ncx/" id="{$id}">
      <xsl:attribute name="playOrder">
        <xsl:choose>
          <xsl:when test="/*[self::set]">
            <xsl:value-of select="$order"/>
          </xsl:when>
          <xsl:when test="$root.is.a.chunk != '0'">
            <xsl:value-of select="$order + 1"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$order - 0"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <navLabel>
        <text><xsl:value-of select="normalize-space($title)"/></text>
      </navLabel>
      <content src="{$href}"/>      
      <xsl:apply-templates select="book[parent::set]|part|reference|preface|chapter|bibliography|appendix|article|glossary|section|sect1|sect2|sect3|sect4|sect5|refentry|colophon|bibliodiv[title]|setindex|index" mode="ncx"/>
    </navPoint>
  </xsl:template>

  <xsl:template match="*" mode="opf.metadata">
    <!-- override if you care -->
  </xsl:template>

  <xsl:template match="authorgroup" mode="opf.metadata">
    <xsl:apply-templates select="author|corpauthor" mode="opf.metadata"/>
  </xsl:template>


  <xsl:template match="author|corpauthor" mode="opf.metadata">
    <xsl:variable name="n">
      <xsl:call-template name="person.name">
        <xsl:with-param name="node" select="."/>
      </xsl:call-template>
    </xsl:variable>
    <dc:creator>
      <xsl:attribute name="opf:file-as">
        <xsl:call-template name="person.name.last-first">
          <xsl:with-param name="node" select="."/>
        </xsl:call-template>
      </xsl:attribute>
      <xsl:value-of select="normalize-space(string($n))"/>
    </dc:creator>
  </xsl:template>


  <xsl:template match="date" mode="opf.metadata">
    <dc:date>
      <xsl:value-of select="normalize-space(string(.))"/>
    </dc:date>
  </xsl:template>


  <!-- Space separate the compontents of the abstract (dropping the inline markup, sadly) -->
  <xsl:template match="abstract" mode="opf.metadata">
    <dc:description>
      <xsl:for-each select="formalpara|para|simpara|title">
        <xsl:choose>
          <xsl:when test="self::formalpara">
            <xsl:value-of select="normalize-space(string(title))"/>
            <xsl:text>: </xsl:text>
            <xsl:value-of select="normalize-space(string(para))"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="normalize-space(string(.))"/>
          </xsl:otherwise>  
        </xsl:choose>
        <xsl:if test="self::title">
          <xsl:text>:</xsl:text>
        </xsl:if>
        <xsl:if test="not(position() = last())">
          <xsl:text> </xsl:text>
        </xsl:if>
      </xsl:for-each>  
    </dc:description>
  </xsl:template>

  <xsl:template match="subjectset" mode="opf.metadata">
    <xsl:apply-templates select="subject/subjectterm" mode="opf.metadata"/>
  </xsl:template>
  
  <xsl:template match="subjectterm" mode="opf.metadata">
    <dc:subject>
      <xsl:value-of select="normalize-space(string(.))"/>
    </dc:subject>
  </xsl:template>

  <xsl:template match="publisher" mode="opf.metadata">
    <xsl:apply-templates select="publishername" mode="opf.metadata"/>
  </xsl:template>
  
  <xsl:template match="publishername" mode="opf.metadata">
    <dc:publisher>
      <xsl:value-of select="normalize-space(string(.))"/>
    </dc:publisher>
  </xsl:template>

  <xsl:template match="copyright" mode="opf.metadata">
    <xsl:variable name="copyright.date">
      <xsl:call-template name="copyright.years">
        <xsl:with-param name="years" select="year"/>
        <xsl:with-param name="print.ranges" select="$make.year.ranges"/>
        <xsl:with-param name="single.year.ranges" select="$make.single.year.ranges"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:if test="not(../date)">
      <dc:date>
        <xsl:call-template name="copyright.years">
          <xsl:with-param name="years" select="year[last()]"/>
          <xsl:with-param name="print.ranges" select="0"/>
          <xsl:with-param name="single.year.ranges" select="0"/>
        </xsl:call-template>
      </dc:date>
    </xsl:if>
    <dc:rights>
      <xsl:call-template name="gentext">
        <xsl:with-param name="key" select="'Copyright'"/>
      </xsl:call-template>
      <xsl:call-template name="gentext.space"/>
      <xsl:text>&#x00A9;</xsl:text>
      <xsl:call-template name="gentext.space"/>
      <xsl:value-of select="$copyright.date"/>
      <xsl:call-template name="gentext.space"/>
      <xsl:apply-templates select="holder" mode="titlepage.mode"/>
    </dc:rights>
  </xsl:template>

  <xsl:template name="opf.guide">
    <xsl:if test="contains($toc.params, 'toc') or 
                  /*/*[cover or contains(name(.), 'info')]//mediaobject[@role='cover' or ancestor::cover]"> 
      <guide xmlns="http://www.idpf.org/2007/opf">
        <xsl:if test="/*/*[cover or contains(name(.), 'info')]//mediaobject[@role='cover' or ancestor::cover]"> 
          <reference href="{$epub.cover.html}" 
            type="cover" title="cover"/>
        </xsl:if>  

        <xsl:if test="contains($toc.params, 'toc')">
          <reference type="toc" title="Table of Content">
            <xsl:attribute name="href">
              <xsl:call-template name="toc-href">
                <xsl:with-param name="node" select="/*"/>
              </xsl:call-template>
            </xsl:attribute>
          </reference>
        </xsl:if>  
      </guide>  
    </xsl:if>  
  </xsl:template>

  <xsl:template name="opf.spine">

    <spine xmlns="http://www.idpf.org/2007/opf" toc="{$epub.ncx.toc.id}">
      <xsl:if test="/*/*[cover or contains(name(.), 'info')]//mediaobject[@role='cover' or ancestor::cover]"> 
        <itemref idref="{$epub.cover.id}">
          <xsl:attribute name="linear">
          <xsl:choose>
            <xsl:when test="$epub.cover.linear">
              <xsl:text>yes</xsl:text>
            </xsl:when>
            <xsl:otherwise>no</xsl:otherwise>
          </xsl:choose>
          </xsl:attribute>
        </itemref>
      </xsl:if>

      <xsl:if test="contains($toc.params, 'toc')">
        <itemref idref="{$epub.html.toc.id}" linear="yes"/>
      </xsl:if>  

      <!-- TODO: be nice to have a idref="titlepage" here -->
      <xsl:choose>
        <xsl:when test="$root.is.a.chunk != '0'">
          <xsl:apply-templates select="/*" mode="opf.spine"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="/*/*" mode="opf.spine"/>
        </xsl:otherwise>
      </xsl:choose>                                   
    </spine>
  </xsl:template>

  <xsl:template match="*" mode="opf.spine">
    <xsl:variable name="is.chunk">
      <xsl:call-template name="chunk">
        <xsl:with-param name="node" select="."/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:if test="$is.chunk != 0">
      <itemref xmlns="http://www.idpf.org/2007/opf"
        idref="{generate-id(.)}"/>
      <xsl:apply-templates select="*|.//refentry" mode="opf.spine"/>
    </xsl:if>
  </xsl:template>

  <xsl:template name="opf.manifest">
    <manifest xmlns="http://www.idpf.org/2007/opf">
      <item xmlns="http://www.idpf.org/2007/opf" 
        id="{$epub.ncx.toc.id}"
        media-type="application/x-dtbncx+xml"
        href="{$epub.ncx.filename}"/>
      

      <xsl:if test="contains($toc.params, 'toc')">
        <item xmlns="http://www.idpf.org/2007/opf"
          id="{$epub.html.toc.id}"
          media-type="application/xhtml+xml">
          <xsl:attribute name="href">
            <xsl:call-template name="toc-href">
              <xsl:with-param name="node" select="/*"/>
            </xsl:call-template>
          </xsl:attribute>
        </item>
      </xsl:if>  

      <xsl:if test="$html.stylesheet != ''">
        <item xmlns="http://www.idpf.org/2007/opf"
          media-type="text/css"
          id="css"
          href="{$html.stylesheet}"/>
      </xsl:if>

      <xsl:if test="/*/*[cover or contains(name(.), 'info')]//mediaobject[@role='cover' or ancestor::cover]"> 
        <item xmlns="http://www.idpf.org/2007/opf"
          id="{$epub.cover.id}" 
          media-type="application/xhtml+xml">
          <xsl:attribute name="href"> 
            <xsl:value-of select="$epub.cover.html"/>
          </xsl:attribute>
        </item>
      </xsl:if>  

      <xsl:choose>
        <xsl:when test="$epub.embedded.fonts != '' and not(contains($epub.embedded.fonts, ','))">
          <xsl:call-template name="embedded-font-item">
            <xsl:with-param name="font.file" select="$epub.embedded.fonts"/> <!-- There is just one -->
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="$epub.embedded.fonts != ''">
          <xsl:variable name="font.file.tokens" select="str:tokenize($epub.embedded.fonts, ',')"/>
          <xsl:for-each select="exsl:node-set($font.file.tokens)">
            <xsl:call-template name="embedded-font-item">
              <xsl:with-param name="font.file" select="."/>
              <xsl:with-param name="font.order" select="position()"/>
            </xsl:call-template>
          </xsl:for-each>
        </xsl:when>
      </xsl:choose>

      <!-- TODO: be nice to have a id="titlepage" here -->
      <xsl:apply-templates select="//part|
                                   //book[*[last()][self::bookinfo]]|
                                   //book[bookinfo]|
                                   //book[*[last()][self::info]]|
                                   //book[info]|
                                   /set|
                                   /set/book|
                                   //reference|
                                   //preface|
                                   //chapter|
                                   //bibliography|
                                   //appendix|
                                   //article|
                                   //glossary|
                                   //section|
                                   //sect1|
                                   //sect2|
                                   //sect3|
                                   //sect4|
                                   //sect5|
                                   //refentry|
                                   //colophon|
                                   //bibliodiv[title]|
                                   //index|
                                   //setindex|
                                   //graphic|
                                   //inlinegraphic|
                                   //mediaobject|
                                   //mediaobjectco|
                                   //inlinemediaobject" 
                           mode="opf.manifest"/>
      <xsl:call-template name="opf.calloutlist"/>
    </manifest>
  </xsl:template>

  <xsl:template name="opf.calloutlist">
    <xsl:variable name="format">
      <xsl:call-template name="guess-media-type">
        <xsl:with-param name="ext" select="$callout.graphics.extension"/>
      </xsl:call-template>
    </xsl:variable>  
    <xsl:if test="(//calloutlist|//co)">
      <xsl:call-template name="opf.reference.callout">
        <xsl:with-param name="conum" select="1"/>
        <xsl:with-param name="format" select="$format"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template name="opf.reference.callout">
    <xsl:param name="conum"/>
    <xsl:param name="format"/>

    <xsl:variable name="filename" select="concat($callout.graphics.path, $conum, $callout.graphics.extension)"/>

    <item xmlns="http://www.idpf.org/2007/opf"
      id="{concat(generate-id(.), 'callout', $conum)}"
      href="{$filename}"
      media-type="{$format}"/>
    
    <xsl:if test="($conum &lt; $callout.graphics.number.limit)">
      <xsl:call-template name="opf.reference.callout">
        <xsl:with-param name="conum" select="$conum + 1"/>
        <xsl:with-param name="format" select="$format"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template name="guess-media-type">
    <xsl:param name="ext"></xsl:param>
    <xsl:choose>
      <xsl:when test="contains($ext, '.gif')">
        <xsl:text>image/gif</xsl:text>
      </xsl:when>
      <xsl:when test="contains($ext, 'GIF')">
        <xsl:text>image/gif</xsl:text>
      </xsl:when>
      <xsl:when test="contains($ext, '.png')">
        <xsl:text>image/png</xsl:text>
      </xsl:when>
      <xsl:when test="contains($ext, 'PNG')">
        <xsl:text>image/png</xsl:text>
      </xsl:when>
      <xsl:when test="contains($ext, '.jpeg')">
        <xsl:text>image/jpeg</xsl:text>
      </xsl:when>
      <xsl:when test="contains($ext, 'JPEG')">
        <xsl:text>image/jpeg</xsl:text>
      </xsl:when>
      <xsl:when test="contains($ext, '.jpg')">
        <xsl:text>image/jpeg</xsl:text>
      </xsl:when>
      <xsl:when test="contains($ext, 'JPG')">
        <xsl:text>image/jpeg</xsl:text>
      </xsl:when>
      <xsl:when test="contains($ext, '.svg')">
        <xsl:text>image/svg+xml</xsl:text>
      </xsl:when>
      <xsl:when test="contains($ext, 'SVG')">
        <xsl:text>image/svg+xml</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <!-- we failed -->
        <xsl:text></xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="mediaobject|
                       mediaobjectco|
                       inlinemediaobject" 
                mode="opf.manifest">

    <xsl:variable name="olist" select="imageobject|imageobjectco                      |videoobject|audioobject                      |textobject"/>

    <xsl:variable name="object.index">
      <xsl:call-template name="select.mediaobject.index">
        <xsl:with-param name="olist" select="$olist"/>
        <xsl:with-param name="count" select="1"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="object" select="$olist[position() = $object.index]"/>

    <xsl:choose>
      <xsl:when test="$object/descendant::imagedata[@format = 'GIF' or 
                                                    @format = 'GIF87a' or 
                                                    @format = 'GIF89a' or 
                                                    @format = 'JPEG' or 
                                                    @format = 'JPG' or 
                                                    @format = 'PNG' or 
                                                    @format = 'SVG']">
        <xsl:apply-templates select="$object[descendant::imagedata[@format = 'GIF' or 
                                                                   @format = 'GIF87a' or 
                                                                   @format = 'GIF89a' or 
                                                                   @format = 'JPEG' or 
                                                                   @format = 'JPG' or 
                                                                   @format = 'PNG' or 
                                                                   @format = 'SVG']][1]/imagedata"
                             mode="opf.manifest"/>              
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="$object/imagedata[1]"
                             mode="opf.manifest"/>              
      </xsl:otherwise>
    </xsl:choose>  
  </xsl:template>

  <xsl:template match="cover/mediaobject|
                       mediaobject[@role='cover']"
                mode="opf.manifest">
    <xsl:choose>
      <xsl:when test="imageobject[@role='front-large']">
        <xsl:apply-templates select="imageobject[@role='front-large']/imagedata"
                             mode="opf.manifest"/>              
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="imageobject/imagedata[1]"
                             mode="opf.manifest"/>              
      </xsl:otherwise>
    </xsl:choose>  
  </xsl:template>

  <xsl:template match="mediaobjectco"
                mode="opf.manifest">
    <xsl:message>WARNING: mediaobjectco almost certainly will not render as expected in .epub!</xsl:message>
    <xsl:apply-templates select="imageobjectco/imageobject/imagedata" 
                         mode="opf.manifest"/>              
  </xsl:template>

  <!-- TODO: Barf (xsl:message terminate=yes) if you find a graphic with no reasonable format or a mediaobject w/o same? [option to not die?] -->

  <!-- wish I had XSLT2 ...-->
  <!-- TODO: priority a hack -->
  <xsl:template match="graphic[not(@format)]|
                       inlinegraphic[not(@format)]|
                       imagedata[not(@format)]"
                mode="opf.manifest">        
    <xsl:variable name="filename">
      <xsl:choose>
        <xsl:when test="contains(name(.), 'graphic')">
          <xsl:choose>
            <xsl:when test="@entityref">
              <xsl:value-of select="unparsed-entity-uri(@entityref)"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:apply-templates select="@fileref"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="mediaobject.filename">
            <xsl:with-param name="object" select=".."/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>  
    <xsl:variable name="format"> 
      <xsl:call-template name="guess-media-type">
        <xsl:with-param name="ext" select="@fileref"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="fr" select="@fileref"/>
    <xsl:if test="$format != ''">
      <!-- only do this if we're the first file to match -->
      <!-- TODO: Why can't this be simple equality?? (I couldn't get it to work) -->
      <xsl:if test="generate-id(.) = generate-id(key('image-filerefs', $fr)[1])">
        <item xmlns="http://www.idpf.org/2007/opf"
          href="{$filename}"
          media-type="{$format}">
          <xsl:attribute name="id"> 
            <xsl:choose>
              <xsl:when test="ancestor::mediaobject[@role='cover'] and parent::*[@role='front-large']">
                <xsl:value-of select="$epub.cover.image.id"/>
              </xsl:when>
              <xsl:when test="ancestor::mediaobject[@role='cover'] and (count(ancestor::mediaobject//imageobject) = 1)">
                <xsl:value-of select="$epub.cover.image.id"/>
              </xsl:when>
              <xsl:when test="ancestor::cover">
                <xsl:value-of select="$epub.cover.image.id"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="generate-id(.)"/> 
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
        </item>
      </xsl:if>
    </xsl:if>
  </xsl:template>

  <!-- Note: Selection of the first interesting imagedata is done in the select -->
  <xsl:template match="graphic[@format = 'GIF' or @format = 'GIF87a' or @format = 'GIF89a' or @format = 'JPEG' or @format = 'JPG' or @format = 'PNG' or @format = 'SVG']|
                       inlinegraphic[@format = 'GIF' or @format = 'GIF87a' or @format = 'GIF89a' or @format = 'JPEG' or @format = 'JPG' or @format = 'PNG' or @format = 'SVG']|
                       imagedata[@format]"
                mode="opf.manifest">
    <xsl:variable name="filename">
      <xsl:choose>
        <xsl:when test="contains(name(.), 'graphic')">
          <xsl:choose>
            <xsl:when test="@entityref">
              <xsl:value-of select="unparsed-entity-uri(@entityref)"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:apply-templates select="@fileref"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="mediaobject.filename">
            <xsl:with-param name="object" select=".."/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>  
    <xsl:variable name="fr" select="@fileref"/>
    <xsl:variable name="mediatype">
      <xsl:call-template name="guess-media-type">
         <xsl:with-param name="ext" select="@format"/>
      </xsl:call-template>
    </xsl:variable>
    <!-- only do this if we're the first file to match -->
    <!-- TODO: Why can't this be simple equality?? (I couldn't get it to work) -->
    <xsl:if test="generate-id(.) = generate-id(key('image-filerefs', $fr)[1])">
      <item xmlns="http://www.idpf.org/2007/opf" 
        href="{$filename}" 
        media-type="{$mediatype}">
        <xsl:attribute name="id"> 
          <xsl:choose>
            <xsl:when test="ancestor::mediaobject[@role='cover'] and parent::*[@role='front-large']">
              <xsl:value-of select="$epub.cover.image.id"/>
            </xsl:when>
            <xsl:when test="ancestor::mediaobject[@role='cover'] and (count(ancestor::mediaobject//imageobject) = 1)">
              <xsl:value-of select="$epub.cover.image.id"/>
            </xsl:when>
            <xsl:when test="ancestor::cover">
              <xsl:value-of select="$epub.cover.image.id"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="generate-id(.)"/> 
            </xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
      </item>
    </xsl:if>
  </xsl:template>

  <!-- Warning: While the test indicate this match list is accurate, it may 
       need further tweaking to ensure _never_ dropping generated content (XHTML)
       from the manifest (OPF file) -->
  <xsl:template
      match="set|
            book[parent::set]|
            book[*[last()][self::bookinfo]]|
            book[bookinfo]|
            book[*[last()][self::info]]|
            book[info]|
            article|
            part|
            reference|
            preface|
            chapter|
            bibliography|
            appendix|
            glossary|
            section|
            sect1|
            sect2|
            sect3|
            sect4|
            sect5|
            refentry|
            colophon|
            bibliodiv[title]|
            setindex|
            index"
      mode="opf.manifest">
    <xsl:variable name="href">
      <xsl:call-template name="href.target.with.base.dir">
        <xsl:with-param name="context" select="/" />
        <!-- Generate links relative to the location of root file/toc.xml file -->
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="id">
      <xsl:value-of select="generate-id(.)"/>
    </xsl:variable>

    <xsl:variable name="is.chunk">
      <xsl:call-template name="chunk">
        <xsl:with-param name="node" select="."/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:if test="$is.chunk != 0">
      <item xmlns="http://www.idpf.org/2007/opf"
        id="{$id}"
        href="{$href}"
        media-type="application/xhtml+xml"/>
    </xsl:if>  
  </xsl:template>  

  <xsl:template match="text()" mode="ncx" />

  <xsl:template name="html.head">
    <xsl:param name="prev" select="/foo"/>
    <xsl:param name="next" select="/foo"/>
    <xsl:variable name="this" select="."/>
    <xsl:variable name="home" select="/*[1]"/>
    <xsl:variable name="up" select="parent::*"/>

    <head xmlns="http://www.w3.org/1999/xhtml">
      <xsl:call-template name="system.head.content"/>
      <xsl:call-template name="head.content"/>

      <xsl:call-template name="user.head.content"/>
    </head>
  </xsl:template>

  <!-- OVERRIDES xhtml-1_1/graphics.xsl -->
  <!-- we can't deal with no img/@alt, because it's required. Try grabbing a title before it instead (hopefully meaningful) -->
  <xsl:template name="process.image.attributes">
    <xsl:param name="alt"/>
    <xsl:param name="html.width"/>
    <xsl:param name="html.depth"/>
    <xsl:param name="longdesc"/>
    <xsl:param name="scale"/>
    <xsl:param name="scalefit"/>
    <xsl:param name="scaled.contentdepth"/>
    <xsl:param name="scaled.contentwidth"/>
    <xsl:param name="viewport"/>

    <xsl:choose>
      <xsl:when test="@contentwidth or @contentdepth">
        <!-- ignore @width/@depth, @scale, and @scalefit if specified -->
        <xsl:if test="@contentwidth and $scaled.contentwidth != ''">
          <xsl:attribute name="width">
            <xsl:value-of select="$scaled.contentwidth"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:if test="@contentdepth and $scaled.contentdepth != ''">
          <xsl:attribute name="height">
            <xsl:value-of select="$scaled.contentdepth"/>
          </xsl:attribute>
        </xsl:if>
      </xsl:when>

      <xsl:when test="number($scale) != 1.0">
        <!-- scaling is always uniform, so we only have to specify one dimension -->
        <!-- ignore @scalefit if specified -->
        <xsl:attribute name="width">
          <xsl:value-of select="$scaled.contentwidth"/>
        </xsl:attribute>
      </xsl:when>

      <xsl:when test="$scalefit != 0">
        <xsl:choose>
          <xsl:when test="contains($html.width, '%')">
            <xsl:choose>
              <xsl:when test="$viewport != 0">
                <!-- The *viewport* will be scaled, so use 100% here! -->
                <xsl:attribute name="width">
                  <xsl:value-of select="'100%'"/>
                </xsl:attribute>
              </xsl:when>
              <xsl:otherwise>
                <xsl:attribute name="width">
                  <xsl:value-of select="$html.width"/>
                </xsl:attribute>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>

          <xsl:when test="contains($html.depth, '%')">
            <!-- HTML doesn't deal with this case very well...do nothing -->
          </xsl:when>

          <xsl:when test="$scaled.contentwidth != '' and $html.width != ''                         and $scaled.contentdepth != '' and $html.depth != ''">
            <!-- scalefit should not be anamorphic; figure out which direction -->
            <!-- has the limiting scale factor and scale in that direction -->
            <xsl:choose>
              <xsl:when test="$html.width div $scaled.contentwidth &gt;                             $html.depth div $scaled.contentdepth">
                <xsl:attribute name="height">
                  <xsl:value-of select="$html.depth"/>
                </xsl:attribute>
              </xsl:when>
              <xsl:otherwise>
                <xsl:attribute name="width">
                  <xsl:value-of select="$html.width"/>
                </xsl:attribute>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>

          <xsl:when test="$scaled.contentwidth != '' and $html.width != ''">
            <xsl:attribute name="width">
              <xsl:value-of select="$html.width"/>
            </xsl:attribute>
          </xsl:when>

          <xsl:when test="$scaled.contentdepth != '' and $html.depth != ''">
            <xsl:attribute name="height">
              <xsl:value-of select="$html.depth"/>
            </xsl:attribute>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
    </xsl:choose>

    <!-- AN OVERRIDE -->
    <xsl:if test="not(@format ='SVG')">
      <xsl:attribute name="alt">
        <xsl:choose>
          <xsl:when test="$alt != ''">
            <xsl:value-of select="normalize-space($alt)"/>
          </xsl:when>
          <xsl:when test="preceding::title[1]">
            <xsl:value-of select="normalize-space(preceding::title[1])"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>(missing alt)</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
    </xsl:if>
    <!-- END OF OVERRIDE -->

    <xsl:if test="$longdesc != ''">
      <xsl:attribute name="longdesc">
        <xsl:value-of select="$longdesc"/>
      </xsl:attribute>
    </xsl:if>

    <xsl:if test="@align and $viewport = 0">
      <xsl:attribute name="style"><xsl:text>text-align: </xsl:text>
        <xsl:choose>
          <xsl:when test="@align = 'center'">middle</xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="@align"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
    </xsl:if>
  </xsl:template>
  
  <!-- OVERRIDES xhtml-1_1/chunk-common.xsl   -->
  <!-- make a bibliography always a chunk -->
  <xsl:template name="chunk">       
    <xsl:param name="node" select="."/>
    <!-- returns 1 if $node is a chunk -->

    <!-- ==================================================================== -->
    <!-- What's a chunk?

        The root element
        appendix
        article
        bibliography  ### NO LONGER TRUE in article or part or book
        book
        chapter
        colophon
        glossary      in article or part or book
        index         in article or part or book
        part
        preface
        refentry
        reference
        sect{1,2,3,4,5}  if position()>1 && depth < chunk.section.depth
        section          if position()>1 && depth < chunk.section.depth
        set
        setindex
                                                                              -->
    <!-- ==================================================================== -->

  <!--
    <xsl:message>
      <xsl:text>chunk: </xsl:text>
      <xsl:value-of select="name($node)"/>
      <xsl:text>(</xsl:text>
      <xsl:value-of select="$node/@id"/>
      <xsl:text>)</xsl:text>
      <xsl:text> csd: </xsl:text>
      <xsl:value-of select="$chunk.section.depth"/>
      <xsl:text> cfs: </xsl:text>
      <xsl:value-of select="$chunk.first.sections"/>
      <xsl:text> ps: </xsl:text>
      <xsl:value-of select="count($node/parent::section)"/>
      <xsl:text> prs: </xsl:text>
      <xsl:value-of select="count($node/preceding-sibling::section)"/>
    </xsl:message>
  -->

    <xsl:choose>
      <xsl:when test="not($node/parent::*)">1</xsl:when>

      <xsl:when test="local-name($node) = 'sect1'                     and $chunk.section.depth &gt;= 1                     and ($chunk.first.sections != 0                          or count($node/preceding-sibling::sect1) &gt; 0)">
        <xsl:text>1</xsl:text>
      </xsl:when>
      <xsl:when test="local-name($node) = 'sect2'                     and $chunk.section.depth &gt;= 2                     and ($chunk.first.sections != 0                          or count($node/preceding-sibling::sect2) &gt; 0)">
        <xsl:call-template name="chunk">
          <xsl:with-param name="node" select="$node/parent::*"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="local-name($node) = 'sect3'                     and $chunk.section.depth &gt;= 3                     and ($chunk.first.sections != 0                          or count($node/preceding-sibling::sect3) &gt; 0)">
        <xsl:call-template name="chunk">
          <xsl:with-param name="node" select="$node/parent::*"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="local-name($node) = 'sect4'                     and $chunk.section.depth &gt;= 4                     and ($chunk.first.sections != 0                          or count($node/preceding-sibling::sect4) &gt; 0)">
        <xsl:call-template name="chunk">
          <xsl:with-param name="node" select="$node/parent::*"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="local-name($node) = 'sect5'                     and $chunk.section.depth &gt;= 5                     and ($chunk.first.sections != 0                          or count($node/preceding-sibling::sect5) &gt; 0)">
        <xsl:call-template name="chunk">
          <xsl:with-param name="node" select="$node/parent::*"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="local-name($node) = 'section'                     and $chunk.section.depth &gt;= count($node/ancestor::section)+1                     and ($chunk.first.sections != 0                          or count($node/preceding-sibling::section) &gt; 0)">
        <xsl:call-template name="chunk">
          <xsl:with-param name="node" select="$node/parent::*"/>
        </xsl:call-template>
      </xsl:when>

      <xsl:when test="local-name($node)='preface'">1</xsl:when>
      <xsl:when test="local-name($node)='chapter'">1</xsl:when>
      <xsl:when test="local-name($node)='appendix'">1</xsl:when>
      <xsl:when test="local-name($node)='article'">1</xsl:when>
      <xsl:when test="local-name($node)='part'">1</xsl:when>
      <xsl:when test="local-name($node)='reference'">1</xsl:when>
      <xsl:when test="local-name($node)='refentry'">1</xsl:when>
      <xsl:when test="local-name($node)='index' and ($generate.index != 0 or count($node/*) &gt; 0)                     and (local-name($node/parent::*) = 'article'                     or local-name($node/parent::*) = 'book'                     or local-name($node/parent::*) = 'part'                     )">1</xsl:when>
      <!-- AN OVERRIDE -->
      <xsl:when test="local-name($node)='bibliography'">1</xsl:when>
      <!-- END OF OVERRIDE -->
      <xsl:when test="local-name($node)='glossary'                     and (local-name($node/parent::*) = 'article'                     or local-name($node/parent::*) = 'book'                     or local-name($node/parent::*) = 'part'                     )">1</xsl:when>
      <xsl:when test="local-name($node)='colophon'">1</xsl:when>
      <xsl:when test="local-name($node)='book'">1</xsl:when>
      <xsl:when test="local-name($node)='set'">1</xsl:when>
      <xsl:when test="local-name($node)='setindex'">1</xsl:when>
      <xsl:when test="local-name($node)='legalnotice'                     and $generate.legalnotice.link != 0">1</xsl:when>
      <xsl:otherwise>0</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- OVERRIDES xhtml-1_1/chunk-code.xsl   -->
  <!-- Add chunking for bibliography as root element -->
  <!-- AN OVERRIDE --> 
  <xsl:template match="set|
                       book|
                       part|
                       preface|
                       chapter|
                       appendix|
                       article|
                       reference|
                       refentry|
                       book/glossary|
                       article/glossary|
                       part/glossary|
                       bibliography|
                       colophon"
                priority="1">       
  <!-- END OF OVERRIDE --> 
    <xsl:choose>
      <xsl:when test="$onechunk != 0 and parent::*">
        <xsl:apply-imports/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="process-chunk-element"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- OVERRIDES xhtml-1_1/graphics.xsl   -->
  <!-- Do _NOT_ output any xlink garbage, so if you don't have 
       processor with extensions, you're screwed and we're terminating -->
  <xsl:template match="inlinegraphic">
    <xsl:variable name="filename">
      <xsl:choose>
        <xsl:when test="@entityref">
          <xsl:value-of select="unparsed-entity-uri(@entityref)"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="@fileref"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:call-template name="anchor"/>

    <xsl:choose>
      <xsl:when test="@format='linespecific'">
        <xsl:choose>
          <xsl:when test="$use.extensions != '0'                         and $textinsert.extension != '0'">
            <xsl:choose>
              <xsl:when test="element-available('stext:insertfile')">
                <stext:insertfile href="{$filename}" encoding="{$textdata.default.encoding}"/>
              </xsl:when>
              <xsl:when test="element-available('xtext:insertfile')">
                <xtext:insertfile href="{$filename}"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:message terminate="yes">
                  <xsl:text>No insertfile extension available.</xsl:text>
                </xsl:message>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:otherwise>
            <!-- AN OVERRIDE --> 
            <xsl:message terminate="yes">
              <xsl:text>No insertfile extension available. Use a different processor (with extensions) or turn on $use.extensions and $textinsert.extension (see docs for more).  </xsl:text>
            </xsl:message>
            <!-- END OF OVERRIDE --> 
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="process.image"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>  

  <xsl:template name="cover">
    <xsl:apply-templates select="/*/*[contains(name(.), 'info')]//mediaobject[@role='cover' or ancestor::cover]"/>
  </xsl:template>  

  <xsl:template match="/*/*[cover or contains(name(.), 'info')]//mediaobject[@role='cover' or ancestor::cover]">
    <xsl:call-template name="write.chunk">
      <xsl:with-param name="filename">
        <xsl:value-of select="$epub.cover.filename" />
      </xsl:with-param>
      <xsl:with-param name="method" select="'xml'" />
      <xsl:with-param name="encoding" select="'utf-8'" />
      <xsl:with-param name="indent" select="'no'" />
      <xsl:with-param name="quiet" select="$chunk.quietly" />
      <xsl:with-param name="content">
        <html xmlns="http://www.w3.org/1999/xhtml">
          <head>
            <title name="title">Cover</title>
            <style type="text/css">
              <!-- Help the cover image scale nicely in the CSS then apply a max-width to look better in Adobe Digital Editions -->
              <xsl:text> img { max-width: 100%; }</xsl:text>
            </style>
          </head>
          <body>
            <div id="{$epub.cover.image.id}">
              <xsl:choose>
                <xsl:when test="imageobject[@role='front-large']">
                  <xsl:apply-templates select="imageobject[@role='front-large']"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:apply-templates select="imageobject[1]"/>
                </xsl:otherwise>
              </xsl:choose>
            </div>
            <!-- If this is defined as an explicit cover page, then process
            any remaining text -->
            <xsl:if test="ancestor::cover">
              <xsl:apply-templates select="ancestor::cover/para"/>
            </xsl:if>
          </body>
        </html>
      </xsl:with-param>  
    </xsl:call-template>  
  </xsl:template>

  <xsl:template name="cover-svg">
    <xsl:param name="node"/>
  </xsl:template>

  <xsl:template name="toc-href">
    <xsl:param name="node" select="."/>
    <xsl:apply-templates select="$node" mode="recursive-chunk-filename">
      <xsl:with-param name="recursive" select="true()"/>
    </xsl:apply-templates>
    <xsl:text>-toc</xsl:text>
    <xsl:value-of select="$html.ext"/>
  </xsl:template>

  <xsl:template match="bibliodiv[title]" mode="label.markup">
  </xsl:template>

  <xsl:template match="token" mode="opf.manifest.font">
    <xsl:call-template name="embedded-font-item">
      <xsl:with-param name="font.file" select="."/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="embedded-font-item">
    <xsl:param name="font.file"/>
    <xsl:param name="font.order" select="1"/>

    <item xmlns="http://www.idpf.org/2007/opf"
      id="{concat('epub.embedded.font.', $font.order)}"
      href="{$font.file}">
      <xsl:choose>
        <xsl:when test="contains($font.file, 'otf')">
          <xsl:attribute name="media-type">font/opentype</xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:message>
            <xsl:text>WARNING: OpenType fonts should be supplied! (</xsl:text>
            <xsl:value-of select="$font.file"/>
            <xsl:text>)</xsl:text>
          </xsl:message>
        </xsl:otherwise>  
      </xsl:choose>
    </item>
  </xsl:template>

<!-- Change section.heading to improve SEO on generated HTML by doing heading levels 
     "correctly". SEO rules are sometimes silly silly, but this does actually create 
     a semantic improvement.
     Note: This template needs to be manually maintained outside of the html/sections.xsl 
     code, so make sure important changes get reintegrated. -->
<xsl:template name="section.heading">
  <xsl:param name="section" select="."/>
  <xsl:param name="level" select="1"/>
  <xsl:param name="allow-anchors" select="1"/>
  <xsl:param name="title"/>
  <xsl:param name="class" select="'title'"/>

  <xsl:variable name="id">
    <xsl:choose>
      <!-- Make sure the subtitle doesn't get the same id as the title -->
      <xsl:when test="self::subtitle">
        <xsl:call-template name="object.id">
          <xsl:with-param name="object" select="."/>
        </xsl:call-template>
      </xsl:when>
      <!-- if title is in an *info wrapper, get the grandparent -->
      <xsl:when test="contains(local-name(..), 'info')">
        <xsl:call-template name="object.id">
          <xsl:with-param name="object" select="../.."/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="object.id">
          <xsl:with-param name="object" select=".."/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <!-- For SEO, we try to actually ensure we *always* output one and only one h1,
       so unlike the regular stylesheets, we don't add one to the section level and
       we get the right behavior because of chunking. -->
  <xsl:variable name="hlevel">
    <xsl:choose>
      <!-- highest valid HTML H level is H6; so anything nested deeper
           than 7 levels down just becomes H6 -->
      <xsl:when test="$level &gt; 6">6</xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$level"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:element name="h{$hlevel}" namespace="http://www.w3.org/1999/xhtml">
    <xsl:attribute name="class"><xsl:value-of select="$class"/></xsl:attribute>
    <xsl:if test="$css.decoration != '0'">
      <xsl:if test="$hlevel&lt;3">
        <xsl:attribute name="style">clear: both</xsl:attribute>
      </xsl:if>
    </xsl:if>
    <xsl:if test="$allow-anchors != 0 and $generate.id.attributes = 0">
      <xsl:call-template name="anchor">
        <xsl:with-param name="node" select="$section"/>
        <xsl:with-param name="conditional" select="0"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$generate.id.attributes != 0 and not(local-name(.) = 'appendix')">
      <xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
    </xsl:if>
    <xsl:copy-of select="$title"/>
  </xsl:element>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="bridgehead">
  <xsl:variable name="container" select="(ancestor::appendix                         |ancestor::article                         |ancestor::bibliography                         |ancestor::chapter                         |ancestor::glossary                         |ancestor::glossdiv                         |ancestor::index                         |ancestor::partintro                         |ancestor::preface                         |ancestor::refsect1                         |ancestor::refsect2                         |ancestor::refsect3                         |ancestor::sect1                         |ancestor::sect2                         |ancestor::sect3                         |ancestor::sect4                         |ancestor::sect5                         |ancestor::section                         |ancestor::setindex                         |ancestor::simplesect)[last()]"/>

  <xsl:variable name="clevel">
    <xsl:choose>
      <xsl:when test="local-name($container) = 'appendix'                       or local-name($container) = 'chapter'                       or local-name($container) = 'article'                       or local-name($container) = 'bibliography'                       or local-name($container) = 'glossary'                       or local-name($container) = 'index'                       or local-name($container) = 'partintro'                       or local-name($container) = 'preface'                       or local-name($container) = 'setindex'">1</xsl:when>
      <xsl:when test="local-name($container) = 'glossdiv'">
        <xsl:value-of select="count(ancestor::glossdiv)+1"/>
      </xsl:when>
      <xsl:when test="local-name($container) = 'sect1'                       or local-name($container) = 'sect2'                       or local-name($container) = 'sect3'                       or local-name($container) = 'sect4'                       or local-name($container) = 'sect5'                       or local-name($container) = 'refsect1'                       or local-name($container) = 'refsect2'                       or local-name($container) = 'refsect3'                       or local-name($container) = 'section'                       or local-name($container) = 'simplesect'">
        <xsl:variable name="slevel">
          <xsl:call-template name="section.level">
            <xsl:with-param name="node" select="$container"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:value-of select="$slevel + 1"/>
      </xsl:when>
      <xsl:otherwise>1</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <!-- HTML H level is one higher than section level -->
  <xsl:variable name="hlevel">
    <xsl:choose>
      <xsl:when test="@renderas = 'sect1'">1</xsl:when>
      <xsl:when test="@renderas = 'sect2'">2</xsl:when>
      <xsl:when test="@renderas = 'sect3'">3</xsl:when>
      <xsl:when test="@renderas = 'sect4'">4</xsl:when>
      <xsl:when test="@renderas = 'sect5'">5</xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$clevel + 1"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:element name="h{$hlevel}" namespace="http://www.w3.org/1999/xhtml">
    <xsl:call-template name="anchor">
      <xsl:with-param name="conditional" select="0"/>
    </xsl:call-template>
    <xsl:apply-templates/>
  </xsl:element>
</xsl:template>

<!-- SEO customization #2 -->
<xsl:template name="component.title">
  <xsl:param name="node" select="."/>

  <xsl:variable name="level">
    <xsl:choose>
      <xsl:when test="ancestor::section">
        <xsl:value-of select="count(ancestor::section)+1"/>
      </xsl:when>
      <xsl:when test="ancestor::sect5">6</xsl:when>
      <xsl:when test="ancestor::sect4">5</xsl:when>
      <xsl:when test="ancestor::sect3">4</xsl:when>
      <xsl:when test="ancestor::sect2">3</xsl:when>
      <xsl:when test="ancestor::sect1">2</xsl:when>
      <xsl:otherwise>1</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:element name="h{$level}" namespace="http://www.w3.org/1999/xhtml">
    <xsl:attribute name="class">title</xsl:attribute>
    <xsl:if test="$generate.id.attributes = 0">
      <xsl:call-template name="anchor">
	<xsl:with-param name="node" select="$node"/>
	<xsl:with-param name="conditional" select="0"/>
      </xsl:call-template>
    </xsl:if>
      <xsl:apply-templates select="$node" mode="object.title.markup">
      <xsl:with-param name="allow-anchors" select="1"/>
    </xsl:apply-templates>
  </xsl:element>
</xsl:template>

</xsl:stylesheet>