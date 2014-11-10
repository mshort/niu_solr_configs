<?xml version="1.0" encoding="UTF-8"?>
<!-- Basic MODS -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:foxml="info:fedora/fedora-system:def/foxml#"
    xmlns:mods="http://www.loc.gov/mods/v3" exclude-result-prefixes="mods">

    <xsl:template match="foxml:datastream[@ID='MODS']/foxml:datastreamVersion[last()]"
        name="index_MODS">
        <xsl:param name="content"/>
        <xsl:param name="prefix">mods_</xsl:param>
        <xsl:param name="suffix">_ms</xsl:param>

        <xsl:apply-templates select="$content/mods:mods">
            <xsl:with-param name="prefix" select="$prefix"/>
            <xsl:with-param name="suffix" select="$suffix"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="mods:mods">
        <xsl:param name="prefix">mods_</xsl:param>
        <xsl:param name="suffix">_ms</xsl:param>
        <xsl:param name="pid">not provided</xsl:param>
        <xsl:param name="datastream">not provided</xsl:param>
        <!-- Index stuff from the auth-module. -->
        <xsl:for-each select=".//*[@authorityURI='info:fedora'][@valueURI]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'related_object', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="@valueURI"/>
            </field>
        </xsl:for-each>
        <!-- Main Title, with non-sorting prefixes -->
        <xsl:for-each select="(mods:titleInfo/mods:title[not(@*)][normalize-space(text())])[1]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, local-name(), $suffix)"/>
                </xsl:attribute>
                <xsl:if test="../mods:nonSort">
                    <xsl:value-of select="../mods:nonSort/text()"/>
                    <xsl:text> </xsl:text>
                </xsl:if>
                <xsl:value-of select="normalize-space(text())"/>
            </field>
            <!-- bit of a hack so it can be sorted on... -->
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, local-name(), '_mlt')"/>
                </xsl:attribute>
                <xsl:if test="../mods:nonSort">
                    <xsl:value-of select="../mods:nonSort/text()"/>
                    <xsl:text> </xsl:text>
                </xsl:if>
                <xsl:value-of select="normalize-space(text())"/>
            </field>
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'title_full', $suffix)"/>
                </xsl:attribute>
                <xsl:if test="../mods:nonSort">
                    <xsl:value-of select="../mods:nonSort"/>
                    <xsl:text> </xsl:text>
                </xsl:if>
                <xsl:value-of select="../mods:title"/>
                <xsl:if test="../mods:subTitle">
                    <xsl:text> : </xsl:text>
                    <xsl:value-of select="../mods:subTitle"/>
                </xsl:if>
                <xsl:if test="../mods:partNumber">
                    <xsl:text>. </xsl:text>
                    <xsl:value-of select="../mods:partNumber"/>
                </xsl:if>
                <xsl:if test="../mods:partName">
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="../mods:partName"/>
                </xsl:if>
            </field>
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'title_full', '_mlt')"/>
                </xsl:attribute>
                <xsl:if test="../mods:nonSort">
                    <xsl:value-of select="../mods:nonSort"/>
                    <xsl:text> </xsl:text>
                </xsl:if>
                <xsl:value-of select="../mods:title"/>
                <xsl:if test="../mods:subTitle">
                    <xsl:text> : </xsl:text>
                    <xsl:value-of select="../mods:subTitle"/>
                </xsl:if>
                <xsl:if test="../mods:partNumber">
                    <xsl:text>. </xsl:text>
                    <xsl:value-of select="../mods:partNumber"/>
                </xsl:if>
                <xsl:if test="../mods:partName">
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="../mods:partName"/>
                </xsl:if>
            </field>
            <xsl:if test="../@lang">
                <field>
                    <xsl:attribute name="name">
                        <xsl:value-of select="concat($prefix, local-name(), '_', ../@lang, $suffix)"
                        />
                    </xsl:attribute>
                    <xsl:if test="../mods:nonSort">
                        <xsl:value-of select="../mods:nonSort/text()"/>
                        <xsl:text> </xsl:text>
                    </xsl:if>
                    <xsl:value-of select="text()"/>
                </field>
                <field>
                    <xsl:attribute name="name">
                        <xsl:value-of select="concat($prefix, 'title_full', '_', ../@lang, $suffix)"
                        />
                    </xsl:attribute>
                    <xsl:if test="../mods:nonSort">
                        <xsl:value-of select="../mods:nonSort"/>
                        <xsl:text> </xsl:text>
                    </xsl:if>
                    <xsl:value-of select="../mods:title"/>
                    <xsl:if test="../mods:subTitle">
                        <xsl:text> : </xsl:text>
                        <xsl:value-of select="../mods:subTitle"/>
                    </xsl:if>
                    <xsl:if test="../mods:partNumber">
                        <xsl:text>. </xsl:text>
                        <xsl:value-of select="../mods:partNumber"/>
                    </xsl:if>
                    <xsl:if test="../mods:partName">
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="../mods:partName"/>
                    </xsl:if>
                </field>
                <xsl:if test="../@script">
                    <field>
                        <xsl:attribute name="name">
                            <xsl:value-of
                                select="concat($prefix, local-name(), '_', ../@lang, '_', ../@script, $suffix)"
                            />
                        </xsl:attribute>
                        <xsl:if test="../mods:nonSort">
                            <xsl:value-of select="../mods:nonSort/text()"/>
                            <xsl:text> </xsl:text>
                        </xsl:if>
                        <xsl:value-of select="text()"/>
                    </field>
                    <field>
                        <xsl:attribute name="name">
                            <xsl:value-of
                                select="concat($prefix, 'title_full', '_', ../@lang, '_', ../@script, $suffix)"
                            />
                        </xsl:attribute>
                        <xsl:if test="../mods:nonSort">
                            <xsl:value-of select="../mods:nonSort"/>
                            <xsl:text> </xsl:text>
                        </xsl:if>
                        <xsl:value-of select="../mods:title"/>
                        <xsl:if test="../mods:subTitle">
                            <xsl:text> : </xsl:text>
                            <xsl:value-of select="../mods:subTitle"/>
                        </xsl:if>
                        <xsl:if test="../mods:partNumber">
                            <xsl:text>. </xsl:text>
                            <xsl:value-of select="../mods:partNumber"/>
                        </xsl:if>
                        <xsl:if test="../mods:partName">
                            <xsl:text>, </xsl:text>
                            <xsl:value-of select="../mods:partName"/>
                        </xsl:if>
                    </field>
                </xsl:if>
            </xsl:if>
        </xsl:for-each>
        <xsl:for-each select="mods:titleInfo[@type]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'title_', @type, $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="mods:title/text()"/>
            </field>
            <xsl:if test="@lang">
                <field>
                    <xsl:attribute name="name">
                        <xsl:value-of select="concat($prefix, 'title_', @type, '_', @lang, $suffix)"
                        />
                    </xsl:attribute>
                    <xsl:value-of select="mods:title/text()"/>
                </field>
            </xsl:if>
            <xsl:if test="@authority">
                <field>
                    <xsl:attribute name="name">
                        <xsl:value-of
                            select="concat($prefix, 'title_', @type, '_', @authority, $suffix)"/>
                    </xsl:attribute>
                    <xsl:value-of select="mods:title/text()"/>
                </field>
            </xsl:if>
        </xsl:for-each>
        <!-- Sub-title -->
        <xsl:for-each select="mods:titleInfo/mods:subTitle[normalize-space(text())][1]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, local-name(), $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, local-name(), '_mlt')"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
        </xsl:for-each>
        <!-- Names and Roles -->
        <xsl:for-each select="mods:name">
            <xsl:variable name="role" select="mods:role/mods:roleTerm/text()"/>
            <xsl:variable name="authority">
                <xsl:choose>
                    <xsl:when test="@authority">
                        <xsl:value-of select="concat('_', @authority)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>_local</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:if test="mods:role">
                <field>
                    <xsl:attribute name="name">
                        <xsl:value-of select="concat($prefix, 'primaryName_', $role, $suffix)"/>
                    </xsl:attribute>
                    <xsl:value-of select="(mods:namePart[not(@*)])[1]/text()"/>
                    <xsl:for-each select="mods:namePart[not(@*) and position()>=2]">
                        <xsl:text>. </xsl:text>
                        <xsl:value-of select="./text()"/>
                    </xsl:for-each>
                    <xsl:if
                        test="mods:namePart[@type='termsOfAddress'] and not(starts-with(mods:namePart[@type='termsOfAddress'], '('))">
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="mods:namePart[@type='termsOfAddress']/text()"/>
                    </xsl:if>
                    <xsl:if
                        test="mods:namePart[@type='termsOfAddress'] and starts-with(mods:namePart[@type='termsOfAddress'], '(')">
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="mods:namePart[@type='termsOfAddress']/text()"/>
                    </xsl:if>
                    <xsl:if test="mods:namePart[@type='date']">
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="mods:namePart[@type='date']/text()"/>
                    </xsl:if>
                </field>
                <field>
                    <xsl:attribute name="name">
                        <xsl:value-of
                            select="concat($prefix, 'primaryName_', $role, $authority, $suffix)"/>
                    </xsl:attribute>
                    <xsl:value-of select="(mods:namePart[not(@*)])[1]/text()"/>
                    <xsl:for-each select="mods:namePart[not(@*) and position()>=2]">
                        <xsl:text>. </xsl:text>
                        <xsl:value-of select="./text()"/>
                    </xsl:for-each>
                    <xsl:if
                        test="mods:namePart[@type='termsOfAddress'] and not(starts-with(mods:namePart[@type='termsOfAddress'], '('))">
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="mods:namePart[@type='termsOfAddress']/text()"/>
                    </xsl:if>
                    <xsl:if
                        test="mods:namePart[@type='termsOfAddress'] and starts-with(mods:namePart[@type='termsOfAddress'], '(')">
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="mods:namePart[@type='termsOfAddress']/text()"/>
                    </xsl:if>
                    <xsl:if test="mods:namePart[@type='date']">
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="mods:namePart[@type='date']/text()"/>
                    </xsl:if>
                </field>
                <field>
                    <xsl:attribute name="name">
                        <xsl:value-of select="concat($prefix, 'name_', $role, $suffix)"/>
                    </xsl:attribute>
                    <xsl:value-of select="(mods:namePart[not(@*)])[1]/text()"/>
                    <xsl:for-each select="mods:namePart[not(@*) and position()>=2]">
                        <xsl:text>. </xsl:text>
                        <xsl:value-of select="./text()"/>
                    </xsl:for-each>
                    <xsl:if
                        test="mods:namePart[@type='termsOfAddress'] and not(starts-with(mods:namePart[@type='termsOfAddress'], '('))">
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="mods:namePart[@type='termsOfAddress']/text()"/>
                    </xsl:if>
                    <xsl:if
                        test="mods:namePart[@type='termsOfAddress'] and starts-with(mods:namePart[@type='termsOfAddress'], '(')">
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="mods:namePart[@type='termsOfAddress']/text()"/>
                    </xsl:if>
                    <xsl:if test="mods:namePart[@type='date']">
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="mods:namePart[@type='date']/text()"/>
                    </xsl:if>
                </field>
                <field>
                    <xsl:attribute name="name">
                        <xsl:value-of select="concat($prefix, 'name_', $role, $authority, $suffix)"
                        />
                    </xsl:attribute>
                    <xsl:value-of select="(mods:namePart[not(@*)])[1]/text()"/>
                    <xsl:for-each select="mods:namePart[not(@*) and position()>=2]">
                        <xsl:text>. </xsl:text>
                        <xsl:value-of select="./text()"/>
                    </xsl:for-each>
                    <xsl:if
                        test="mods:namePart[@type='termsOfAddress'] and not(starts-with(mods:namePart[@type='termsOfAddress'], '('))">
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="mods:namePart[@type='termsOfAddress']/text()"/>
                    </xsl:if>
                    <xsl:if
                        test="mods:namePart[@type='termsOfAddress'] and starts-with(mods:namePart[@type='termsOfAddress'], '(')">
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="mods:namePart[@type='termsOfAddress']/text()"/>
                    </xsl:if>
                    <xsl:if test="mods:namePart[@type='date']">
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="mods:namePart[@type='date']/text()"/>
                    </xsl:if>
                </field>
            </xsl:if>
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'name', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="(mods:namePart[not(@*)])[1]/text()"/>
                <xsl:for-each select="mods:namePart[not(@*) and position()>=2]">
                    <xsl:text>. </xsl:text>
                    <xsl:value-of select="./text()"/>
                </xsl:for-each>
                <xsl:if
                    test="mods:namePart[@type='termsOfAddress'] and not(starts-with(mods:namePart[@type='termsOfAddress'], '('))">
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="mods:namePart[@type='termsOfAddress']/text()"/>
                </xsl:if>
                <xsl:if
                    test="mods:namePart[@type='termsOfAddress'] and starts-with(mods:namePart[@type='termsOfAddress'], '(')">
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="mods:namePart[@type='termsOfAddress']/text()"/>
                </xsl:if>
                <xsl:if test="mods:namePart[@type='date']">
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="mods:namePart[@type='date']/text()"/>
                </xsl:if>
            </field>
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'name', $authority, $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="(mods:namePart[not(@*)])[1]/text()"/>
                <xsl:for-each select="mods:namePart[not(@*) and position()>=2]">
                    <xsl:text>. </xsl:text>
                    <xsl:value-of select="./text()"/>
                </xsl:for-each>
                <xsl:if
                    test="mods:namePart[@type='termsOfAddress'] and not(starts-with(mods:namePart[@type='termsOfAddress'], '('))">
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="mods:namePart[@type='termsOfAddress']/text()"/>
                </xsl:if>
                <xsl:if
                    test="mods:namePart[@type='termsOfAddress'] and starts-with(mods:namePart[@type='termsOfAddress'], '(')">
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="mods:namePart[@type='termsOfAddress']/text()"/>
                </xsl:if>
                <xsl:if test="mods:namePart[@type='date']">
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="mods:namePart[@type='date']/text()"/>
                </xsl:if>
            </field>
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'primaryName', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="(mods:namePart[not(@*)])[1]/text()"/>
                <xsl:for-each select="mods:namePart[not(@*) and position()>=2]">
                    <xsl:text>. </xsl:text>
                    <xsl:value-of select="./text()"/>
                </xsl:for-each>
                <xsl:if
                    test="mods:namePart[@type='termsOfAddress'] and not(starts-with(mods:namePart[@type='termsOfAddress'], '('))">
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="mods:namePart[@type='termsOfAddress']/text()"/>
                </xsl:if>
                <xsl:if
                    test="mods:namePart[@type='termsOfAddress'] and starts-with(mods:namePart[@type='termsOfAddress'], '(')">
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="mods:namePart[@type='termsOfAddress']/text()"/>
                </xsl:if>
                <xsl:if test="mods:namePart[@type='date']">
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="mods:namePart[@type='date']/text()"/>
                </xsl:if>
            </field>
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'primaryName', $authority, $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="(mods:namePart[not(@*)])[1]/text()"/>
                <xsl:for-each select="mods:namePart[not(@*) and position()>=2]">
                    <xsl:text>. </xsl:text>
                    <xsl:value-of select="./text()"/>
                </xsl:for-each>
                <xsl:if
                    test="mods:namePart[@type='termsOfAddress'] and not(starts-with(mods:namePart[@type='termsOfAddress'], '('))">
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="mods:namePart[@type='termsOfAddress']/text()"/>
                </xsl:if>
                <xsl:if
                    test="mods:namePart[@type='termsOfAddress'] and starts-with(mods:namePart[@type='termsOfAddress'], '(')">
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="mods:namePart[@type='termsOfAddress']/text()"/>
                </xsl:if>
                <xsl:if test="mods:namePart[@type='date']">
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="mods:namePart[@type='date']/text()"/>
                </xsl:if>
            </field>
        </xsl:for-each>
        <xsl:for-each select="mods:name/mods:description[normalize-space(text())]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'name_description', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="normalize-space(text())"/>
            </field>
        </xsl:for-each>
        <!-- Index URI's by role -->
        <xsl:for-each
            select="mods:name[@valueURI] | mods:relatedItem[@type='constituent']/mods:name[@valueURI]">
            <xsl:variable name="role" select="mods:role/mods:roleTerm/text()"/>
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'name_valueURI_', $role, $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="@valueURI"/>
            </field>
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'name_valueURI', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="@valueURI"/>
            </field>
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'valueURI', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="@valueURI"/>
            </field>
        </xsl:for-each>
        <!-- Resource Type (a.k.a. broad doctype) -->
        <xsl:for-each select="mods:typeOfResource[normalize-space(text())]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'resource_type', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="normalize-space(text())"/>
            </field>
        </xsl:for-each>
        <!-- Genre (a.k.a. specific doctype) -->
        <xsl:for-each select="mods:genre[normalize-space(text())]">
            <xsl:variable name="authority">
                <xsl:choose>
                    <xsl:when test="@authority">
                        <xsl:value-of select="concat('_', @authority)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>_local</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:if test=".!='Fiction'">
                <field>
                    <xsl:attribute name="name">
                        <xsl:value-of select="concat($prefix, local-name(), $authority, $suffix)"/>
                    </xsl:attribute>
                    <xsl:value-of select="normalize-space(text())"/>
                </field>
                <field>
                    <xsl:attribute name="name">
                        <xsl:value-of select="concat($prefix, local-name(), $suffix)"/>
                    </xsl:attribute>
                    <xsl:value-of select="normalize-space(text())"/>
                </field>
            </xsl:if>
        </xsl:for-each>
        <!-- Index genre URI -->
        <xsl:for-each select="mods:genre[@valueURI]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'genre_valueURI', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="@valueURI"/>
            </field>
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'valueURI', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="@valueURI"/>
            </field>
        </xsl:for-each>
        <!-- Place of publication -->
        <xsl:for-each
            select="mods:originInfo/mods:place/mods:placeTerm[@type='text'][normalize-space(text())]">
            <xsl:if test="../../@eventType">
                <field>
                    <xsl:attribute name="name">
                        <xsl:value-of
                            select="concat($prefix, 'place_', ../../@eventType, '_text', $suffix)"/>
                    </xsl:attribute>
                    <xsl:value-of select="normalize-space(text())"/>
                </field>
            </xsl:if>
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'place_text', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="normalize-space(text())"/>
            </field>
        </xsl:for-each>
        <xsl:for-each
            select="mods:originInfo/mods:place/mods:placeTerm[@type='code'][normalize-space(text())]">
            <xsl:if test="../../@eventType">
                <field>
                    <xsl:attribute name="name">
                        <xsl:value-of
                            select="concat($prefix, 'place_', ../../@eventType, '_code', $suffix)"/>
                    </xsl:attribute>
                    <xsl:value-of select="normalize-space(text())"/>
                </field>
            </xsl:if>
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'place_code', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="normalize-space(text())"/>
            </field>
        </xsl:for-each>
        <!-- Publisher's Name -->
        <xsl:for-each select="mods:originInfo/mods:publisher[normalize-space(text())]">
            <xsl:if test="../@eventType">
                <field>
                    <xsl:attribute name="name">
                        <xsl:value-of select="concat($prefix, 'publisher_', ../@eventType, $suffix)"
                        />
                    </xsl:attribute>
                    <xsl:value-of select="normalize-space(text())"/>
                </field>
            </xsl:if>
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'publisher', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="normalize-space(text())"/>
            </field>
        </xsl:for-each>
        <!-- Edition (Book) -->
        <xsl:for-each select="mods:originInfo/mods:edition[normalize-space(text())]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, local-name(), $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
        </xsl:for-each>
        <!-- Dates -->
        <xsl:for-each
            select="mods:originInfo/mods:dateIssued | mods:originInfo/mods:dateCreated | mods:originInfo/mods:dateCaptured | mods:copyrightDate">
            <xsl:if test="not(@point)">
                <field>
                    <xsl:attribute name="name">
                        <xsl:value-of select="concat($prefix, local-name(), $suffix)"/>
                    </xsl:attribute>
                    <xsl:value-of select="text()"/>
                </field>
            </xsl:if>
            <xsl:if test="@keyDate='yes'">
                <field>
                    <xsl:attribute name="name">
                        <xsl:value-of select="concat($prefix, 'year_s')"/>
                    </xsl:attribute>
                    <xsl:if test="contains(text(),'-')">
                        <xsl:value-of select="substring-before(text(), '-')"/>
                    </xsl:if>
                    <xsl:if test="not(contains(text(),'-'))">
                        <xsl:value-of select="text()"/>
                    </xsl:if>
                </field>
            </xsl:if>
        </xsl:for-each>
        <xsl:if test="mods:originInfo/*[@point]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of
                        select="concat($prefix, local-name(mods:originInfo/*[@point]), $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="mods:originInfo/*[@point='start']"/>
                <xsl:text>-</xsl:text>
                <xsl:value-of select="mods:originInfo/*[@point='end']"/>
            </field>
        </xsl:if>
        <!-- Other Date -->
        <xsl:for-each select="mods:originInfo/mods:dateOther[@tynpe][normalize-space(text())]">
            <xsl:if test="not(@point)">
                <field>
                    <xsl:attribute name="name">
                        <xsl:value-of
                            select="concat($prefix, local-name(), '_', translate(@type, ' ABCDEFGHIJKLMNOPQRSTUVWXYZ', '_abcdefghijklmnopqrstuvwxyz'), $suffix)"
                        />
                    </xsl:attribute>
                    <xsl:value-of select="normalize-space(text())"/>
                </field>
            </xsl:if>
            <xsl:if test="@keyDate='yes'">
                <field>
                    <xsl:attribute name="name">
                        <xsl:value-of select="concat($prefix, 'year_s')"/>
                    </xsl:attribute>
                    <xsl:if test="contains(text(),'-')">
                        <xsl:value-of select="substring-before(text(), '-')"/>
                    </xsl:if>
                    <xsl:if test="not(contains(text(),'-'))">
                        <xsl:value-of select="text()"/>
                    </xsl:if>
                </field>
            </xsl:if>
        </xsl:for-each>
        <!-- Issuance (i.e. ongoing, monograph, etc. ) -->
        <xsl:for-each select="mods:originInfo/mods:issuance[normalize-space(text())]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, local-name(), $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
        </xsl:for-each>
        <!-- Languague Term -->
        <xsl:for-each select="mods:language/mods:languageTerm[normalize-space(text())]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of
                        select="concat($prefix, local-name(), '_', @type, '_', @authority, $suffix)"
                    />
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
        </xsl:for-each>
        <xsl:for-each select="mods:language/mods:scriptTerm[normalize-space(text())]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of
                        select="concat($prefix, local-name(), '_', @type, '_', @authority, $suffix)"
                    />
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
        </xsl:for-each>
        <!-- Physical Description -->
        <xsl:for-each select="mods:physicalDescription[normalize-space(text())]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, local-name(), $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
        </xsl:for-each>
        <!-- Physical Description (note) -->
        <xsl:for-each select="mods:physicalDescription/mods:note[normalize-space(text())]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of
                        select="concat($prefix, 'physicalDescription_', local-name(), $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
        </xsl:for-each>
        <!-- Physical Description (form) -->
        <xsl:for-each select="mods:physicalDescription/mods:form[normalize-space(text())]">
            <xsl:variable name="authority">
                <xsl:choose>
                    <xsl:when test="@authority">
                        <xsl:value-of select="concat('_', @authority)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>_local</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:if test="@type">
                <field>
                    <xsl:attribute name="name">
                        <xsl:value-of
                            select="concat($prefix, 'physicalDescription_', local-name(), '_', @type, $authority, $suffix)"
                        />
                    </xsl:attribute>
                    <xsl:value-of select="text()"/>
                </field>
            </xsl:if>
            <xsl:if test="not(@type)">
                <field>
                    <xsl:attribute name="name">
                        <xsl:value-of
                            select="concat($prefix, 'physicalDescription_', local-name(), $authority, $suffix)"
                        />
                    </xsl:attribute>
                    <xsl:value-of select="text()"/>
                </field>
            </xsl:if>
        </xsl:for-each>
        <!-- MIME type -->
        <xsl:for-each
            select="mods:physicalDescription/mods:internetMediaType[normalize-space(text())]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, local-name(), $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
        </xsl:for-each>
        <xsl:for-each select="mods:physicalDescription/mods:extent[normalize-space(text())]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, local-name(), $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
        </xsl:for-each>
        <!-- Pages -->
        <xsl:for-each
            select="mods:physicalDescription/mods:extent[@unit='pages'][normalize-space(text())]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'pageNumbers', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
                <xsl:text> pages</xsl:text>
            </field>
        </xsl:for-each>
        <xsl:for-each select="mods:physicalDescription/mods:digitalOrigin[normalize-space(text())]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, local-name(), $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
        </xsl:for-each>
        <!-- Abstract -->
        <xsl:for-each select="mods:abstract[normalize-space(text())]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, local-name(), $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
        </xsl:for-each>
        <!-- Table of Contents -->
        <xsl:for-each select="mods:tableOfContents[normalize-space(text())]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, local-name(), $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
        </xsl:for-each>
        <!-- Notes with no type -->
        <xsl:for-each select="mods:note[not(@type)][normalize-space(text())]">
            <!--don't bother with empty space-->
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, local-name(), $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
        </xsl:for-each>
        <!-- Notes -->
        <xsl:for-each select="mods:note[@type][normalize-space(text())]">
            <!--don't bother with empty space-->
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of
                        select="concat($prefix, local-name(), '_', translate(@type, ' ', '_'), $suffix)"
                    />
                </xsl:attribute>
                <xsl:value-of select="normalize-space(text())"/>
            </field>
        </xsl:for-each>
        <!-- Classification -->
        <xsl:for-each select="mods:classification[normalize-space(text())]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, local-name(), '_', @authority, $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
        </xsl:for-each>
        <!-- Index subject URI -->
        <xsl:for-each
            select="mods:subject[@valueURI] | mods:subject/mods:topic[@valueURI] | mods:subject/mods:geographic[@valueURI] | mods:subject/mods:temporal[@valueURI] | mods:subject/mods:name[@valueURI] | mods:subject/mods:titleInfo[@valueURI]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'subject_valueURI', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="@valueURI"/>
            </field>
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'valueURI', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="@valueURI"/>
            </field>
        </xsl:for-each>
        <xsl:for-each select="mods:subject">

            <xsl:variable name="authority">
                <xsl:choose>
                    <xsl:when test="@authority">
                        <xsl:value-of select="concat('_', @authority)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>_local</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>

            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'subject_precoordinated', $suffix)"/>
                </xsl:attribute>
                <xsl:for-each select="*[position()=1 and position()=last()]">
                    <xsl:if test="name()='mods:name'">
                        <xsl:value-of select="./mods:namePart[not(@*)]"/>
                        <xsl:if
                            test="./mods:namePart[@type='termsOfAddress'] and not(starts-with(./mods:namePart[@type='termsOfAddress'], '('))">
                            <xsl:text>, </xsl:text>
                            <xsl:value-of select="./mods:namePart[@type='termsOfAddress']/text()"/>
                        </xsl:if>
                        <xsl:if
                            test="./mods:namePart[@type='termsOfAddress'] and starts-with(./mods:namePart[@type='termsOfAddress'], '(')">
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="./mods:namePart[@type='termsOfAddress']/text()"/>
                        </xsl:if>
                        <xsl:if test="./mods:namePart[@type='date']">
                            <xsl:text>, </xsl:text>
                            <xsl:value-of select="./mods:namePart[@type='date']"/>
                        </xsl:if>
                    </xsl:if>
                    <xsl:if test="name()='mods:titleInfo'">
                        <xsl:value-of select="./mods:title"/>
                    </xsl:if>
                    <xsl:if test="name()!='mods:name' and name()!='mods:titleInfo'">
                        <xsl:value-of select="."/>
                    </xsl:if>
                </xsl:for-each>
                <xsl:for-each select="*[position()>=1 and position()!=last()]">
                    <xsl:if test="name()='mods:name'">
                        <xsl:value-of select="./mods:namePart[not(@*)]"/>
                        <xsl:if
                            test="./mods:namePart[@type='termsOfAddress'] and not(starts-with(./mods:namePart[@type='termsOfAddress'], '('))">
                            <xsl:text>, </xsl:text>
                            <xsl:value-of select="./mods:namePart[@type='termsOfAddress']/text()"/>
                        </xsl:if>
                        <xsl:if
                            test="./mods:namePart[@type='termsOfAddress'] and starts-with(./mods:namePart[@type='termsOfAddress'], '(')">
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="./mods:namePart[@type='termsOfAddress']/text()"/>
                        </xsl:if>
                        <xsl:if test="./mods:namePart[@type='date']">
                            <xsl:text>, </xsl:text>
                            <xsl:value-of select="./mods:namePart[@type='date']"/>
                        </xsl:if>
                        <xsl:text>--</xsl:text>
                    </xsl:if>
                    <xsl:if test="name()='mods:titleInfo'">
                        <xsl:value-of select="./mods:title"/>
                        <xsl:text>--</xsl:text>
                    </xsl:if>
                    <xsl:if test="name()!='mods:name' and name()!='mods:titleInfo'">
                        <xsl:value-of select="."/>
                        <xsl:text>--</xsl:text>
                    </xsl:if>
                </xsl:for-each>
                <xsl:for-each select="*[position()!=1 and position()=last()]">
                    <xsl:if test="name()='mods:name'">
                        <xsl:value-of select="./mods:namePart[not(@*)]"/>
                        <xsl:if
                            test="./mods:namePart[@type='termsOfAddress'] and not(starts-with(./mods:namePart[@type='termsOfAddress'], '('))">
                            <xsl:text>, </xsl:text>
                            <xsl:value-of select="./mods:namePart[@type='termsOfAddress']/text()"/>
                        </xsl:if>
                        <xsl:if
                            test="./mods:namePart[@type='termsOfAddress'] and starts-with(./mods:namePart[@type='termsOfAddress'], '(')">
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="./mods:namePart[@type='termsOfAddress']/text()"/>
                        </xsl:if>
                        <xsl:if test="./mods:namePart[@type='date']">
                            <xsl:text>, </xsl:text>
                            <xsl:value-of select="./mods:namePart[@type='date']"/>
                        </xsl:if>
                    </xsl:if>
                    <xsl:if test="name()='mods:titleInfo'">
                        <xsl:value-of select="./mods:title"/>
                    </xsl:if>
                    <xsl:if test="name()!='mods:name' and name()!='mods:titleInfo'">
                        <xsl:value-of select="."/>
                    </xsl:if>
                </xsl:for-each>
            </field>

            <field>
                <xsl:attribute name="name">
                    <xsl:value-of
                        select="concat($prefix, 'subject_precoordinated', $authority, $suffix)"/>
                </xsl:attribute>
                <xsl:for-each select="*[position()=1 and position()=last()]">
                    <xsl:if test="name()='mods:name'">
                        <xsl:value-of select="./mods:namePart[not(@*)]"/>
                        <xsl:if
                            test="./mods:namePart[@type='termsOfAddress'] and not(starts-with(./mods:namePart[@type='termsOfAddress'], '('))">
                            <xsl:text>, </xsl:text>
                            <xsl:value-of select="./mods:namePart[@type='termsOfAddress']/text()"/>
                        </xsl:if>
                        <xsl:if
                            test="./mods:namePart[@type='termsOfAddress'] and starts-with(./mods:namePart[@type='termsOfAddress'], '(')">
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="./mods:namePart[@type='termsOfAddress']/text()"/>
                        </xsl:if>
                        <xsl:if test="./mods:namePart[@type='date']">
                            <xsl:text>, </xsl:text>
                            <xsl:value-of select="./mods:namePart[@type='date']"/>
                        </xsl:if>
                    </xsl:if>
                    <xsl:if test="name()='mods:titleInfo'">
                        <xsl:value-of select="./mods:title"/>
                    </xsl:if>
                    <xsl:if test="name()!='mods:name' and name()!='mods:titleInfo'">
                        <xsl:value-of select="."/>
                    </xsl:if>
                </xsl:for-each>
                <xsl:for-each select="*[position()>=1 and position()!=last()]">
                    <xsl:if test="name()='mods:name'">
                        <xsl:value-of select="./mods:namePart[not(@*)]"/>
                        <xsl:if
                            test="./mods:namePart[@type='termsOfAddress'] and not(starts-with(./mods:namePart[@type='termsOfAddress'], '('))">
                            <xsl:text>, </xsl:text>
                            <xsl:value-of select="./mods:namePart[@type='termsOfAddress']/text()"/>
                        </xsl:if>
                        <xsl:if
                            test="./mods:namePart[@type='termsOfAddress'] and starts-with(./mods:namePart[@type='termsOfAddress'], '(')">
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="./mods:namePart[@type='termsOfAddress']/text()"/>
                        </xsl:if>
                        <xsl:if test="./mods:namePart[@type='date']">
                            <xsl:text>, </xsl:text>
                            <xsl:value-of select="./mods:namePart[@type='date']"/>
                        </xsl:if>
                        <xsl:text>--</xsl:text>
                    </xsl:if>
                    <xsl:if test="name()='mods:titleInfo'">
                        <xsl:value-of select="./mods:title"/>
                        <xsl:text>--</xsl:text>
                    </xsl:if>
                    <xsl:if test="name()!='mods:name' and name()!='mods:titleInfo'">
                        <xsl:value-of select="."/>
                        <xsl:text>--</xsl:text>
                    </xsl:if>
                </xsl:for-each>
                <xsl:for-each select="*[position()!=1 and position()=last()]">
                    <xsl:if test="name()='mods:name'">
                        <xsl:value-of select="./mods:namePart[not(@*)]"/>
                        <xsl:if
                            test="./mods:namePart[@type='termsOfAddress'] and not(starts-with(./mods:namePart[@type='termsOfAddress'], '('))">
                            <xsl:text>, </xsl:text>
                            <xsl:value-of select="./mods:namePart[@type='termsOfAddress']/text()"/>
                        </xsl:if>
                        <xsl:if
                            test="./mods:namePart[@type='termsOfAddress'] and starts-with(./mods:namePart[@type='termsOfAddress'], '(')">
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="./mods:namePart[@type='termsOfAddress']/text()"/>
                        </xsl:if>
                        <xsl:if test="./mods:namePart[@type='date']">
                            <xsl:text>, </xsl:text>
                            <xsl:value-of select="./mods:namePart[@type='date']"/>
                        </xsl:if>
                    </xsl:if>
                    <xsl:if test="name()='mods:titleInfo'">
                        <xsl:value-of select="./mods:title"/>
                    </xsl:if>
                    <xsl:if test="name()!='mods:name' and name()!='mods:titleInfo'">
                        <xsl:value-of select="."/>
                    </xsl:if>
                </xsl:for-each>
            </field>
        </xsl:for-each>
        <!-- Specific subjects -->
        <xsl:for-each select="mods:subject/mods:topic[normalize-space(text())]">
            <xsl:variable name="authority">
                <xsl:choose>
                    <xsl:when test="@authority">
                        <xsl:value-of select="concat('_', ../@authority)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>_local</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'subject_topic', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
            <xsl:if test="../@authority">
                <field>
                    <xsl:attribute name="name">
                        <xsl:value-of select="concat($prefix, 'subject_topic', $authority, $suffix)"
                        />
                    </xsl:attribute>
                    <xsl:value-of select="text()"/>
                </field>
            </xsl:if>
        </xsl:for-each>
        <xsl:for-each select="mods:subject/mods:name">

            <xsl:variable name="subject_authority">
                <xsl:choose>
                    <xsl:when test="../@authority">
                        <xsl:value-of select="concat('_', ../@authority)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>_local</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>

            <xsl:variable name="name_authority">
                <xsl:choose>
                    <xsl:when test="@authority">
                        <xsl:value-of select="concat('_', @authority)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>_local</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>

            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'subject_name', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="mods:namePart[not(@*)]"/>
                <xsl:if
                    test="mods:namePart[@type='termsOfAddress'] and not(starts-with(mods:namePart[@type='termsOfAddress'], '('))">
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="mods:namePart[@type='termsOfAddress']/text()"/>
                </xsl:if>
                <xsl:if
                    test="mods:namePart[@type='termsOfAddress'] and starts-with(mods:namePart[@type='termsOfAddress'], '(')">
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="mods:namePart[@type='termsOfAddress']/text()"/>
                </xsl:if>
                <xsl:if test="./mods:namePart[@type='date']">
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="mods:namePart[@type='date']"/>
                </xsl:if>
            </field>

            <field>
                <xsl:attribute name="name">
                    <xsl:value-of
                        select="concat($prefix, 'subject_name', $subject_authority, $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="mods:namePart[not(@*)]"/>
                <xsl:if
                    test="mods:namePart[@type='termsOfAddress'] and not(starts-with(mods:namePart[@type='termsOfAddress'], '('))">
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="mods:namePart[@type='termsOfAddress']/text()"/>
                </xsl:if>
                <xsl:if
                    test="mods:namePart[@type='termsOfAddress'] and starts-with(mods:namePart[@type='termsOfAddress'], '(')">
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="mods:namePart[@type='termsOfAddress']/text()"/>
                </xsl:if>
                <xsl:if test="./mods:namePart[@type='date']">
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="mods:namePart[@type='date']"/>
                </xsl:if>
            </field>

            <xsl:if test="@authority">
                <field>
                    <xsl:attribute name="name">
                        <xsl:value-of
                            select="concat($prefix, 'subject_name', $subject_authority, $name_authority, $suffix)"
                        />
                    </xsl:attribute>
                    <xsl:value-of select="mods:namePart[not(@*)]"/>
                    <xsl:if
                        test="mods:namePart[@type='termsOfAddress'] and not(starts-with(mods:namePart[@type='termsOfAddress'], '('))">
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="mods:namePart[@type='termsOfAddress']/text()"/>
                    </xsl:if>
                    <xsl:if
                        test="mods:namePart[@type='termsOfAddress'] and starts-with(mods:namePart[@type='termsOfAddress'], '(')">
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="mods:namePart[@type='termsOfAddress']/text()"/>
                    </xsl:if>
                    <xsl:if test="./mods:namePart[@type='date']">
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="mods:namePart[@type='date']"/>
                    </xsl:if>
                </field>
            </xsl:if>
        </xsl:for-each>
        <xsl:for-each select="mods:subject/mods:titleInfo/mods:title">

            <xsl:variable name="authority">
                <xsl:choose>
                    <xsl:when test="../../@authority">
                        <xsl:value-of select="concat('_', ../../@authority)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>_local</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>

            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'subject_title', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
            <xsl:if test="../@authority">
                <field>
                    <xsl:attribute name="name">
                        <xsl:value-of select="concat($prefix, 'subject_title', $authority, $suffix)"
                        />
                    </xsl:attribute>
                    <xsl:value-of select="text()"/>
                </field>
            </xsl:if>
        </xsl:for-each>
        <xsl:for-each select="mods:subject/mods:geographic[normalize-space(text())]">

            <xsl:variable name="authority">
                <xsl:choose>
                    <xsl:when test="../@authority">
                        <xsl:value-of select="concat('_', ../@authority)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>_local</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>

            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'subject_geographic', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
            <xsl:if test="../@authority">
                <field>
                    <xsl:attribute name="name">
                        <xsl:value-of
                            select="concat($prefix, 'subject_geographic', $authority, $suffix)"/>
                    </xsl:attribute>
                    <xsl:value-of select="text()"/>
                </field>
            </xsl:if>
        </xsl:for-each>
        <xsl:for-each select="mods:subject/mods:temporal[normalize-space(text())]">

            <xsl:variable name="authority">
                <xsl:choose>
                    <xsl:when test="../@authority">
                        <xsl:value-of select="concat('_', ../@authority)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>_local</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>

            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'subject_temporal', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
            <xsl:if test="../@authority">
                <field>
                    <xsl:attribute name="name">
                        <xsl:value-of
                            select="concat($prefix, 'subject_temporal', $authority, $suffix)"/>
                    </xsl:attribute>
                    <xsl:value-of select="text()"/>
                </field>
            </xsl:if>
        </xsl:for-each>
        <!-- Coordinates (lat,long) -->
        <xsl:for-each
            select="mods:subject/mods:cartographics/mods:coordinates[normalize-space(text())]">
            <!--don't bother with empty space-->
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'subject_coordinates', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
        </xsl:for-each>
        <!-- Constituent parts -->
        <xsl:for-each
            select="mods:relatedItem[@type='constituent']/mods:titleInfo/mods:title[normalize-space(text())]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'constituent_title', $suffix)"/>
                </xsl:attribute>
                <xsl:if test="../mods:nonSort">
                    <xsl:value-of select="../mods:nonSort/text()"/>
                    <xsl:text> </xsl:text>
                </xsl:if>
                <xsl:value-of select="text()"/>
            </field>
        </xsl:for-each>
        <xsl:for-each select="mods:relatedItem[@type='constituent']/mods:name">

            <xsl:variable name="authority">
                <xsl:choose>
                    <xsl:when test="@authority">
                        <xsl:value-of select="concat('_', @authority)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>_local</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>

            <xsl:variable name="role" select="mods:role/mods:roleTerm/text()"/>

            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'name', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="(mods:namePart[not(@*)])[1]/text()"/>
                <xsl:for-each select="mods:namePart[not(@*) and position()>=2]">
                    <xsl:text>. </xsl:text>
                    <xsl:value-of select="./text()"/>
                </xsl:for-each>
                <xsl:if
                    test="mods:namePart[@type='termsOfAddress'] and not(starts-with(mods:namePart[@type='termsOfAddress'], '('))">
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="mods:namePart[@type='termsOfAddress']/text()"/>
                </xsl:if>
                <xsl:if
                    test="mods:namePart[@type='termsOfAddress'] and starts-with(mods:namePart[@type='termsOfAddress'], '(')">
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="mods:namePart[@type='termsOfAddress']/text()"/>
                </xsl:if>
                <xsl:if test="mods:namePart[@type='date']">
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="mods:namePart[@type='date']/text()"/>
                </xsl:if>
            </field>
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'name', $authority, $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="(mods:namePart[not(@*)])[1]/text()"/>
                <xsl:for-each select="mods:namePart[not(@*) and position()>=2]">
                    <xsl:text>. </xsl:text>
                    <xsl:value-of select="./text()"/>
                </xsl:for-each>
                <xsl:if
                    test="mods:namePart[@type='termsOfAddress'] and not(starts-with(mods:namePart[@type='termsOfAddress'], '('))">
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="mods:namePart[@type='termsOfAddress']/text()"/>
                </xsl:if>
                <xsl:if
                    test="mods:namePart[@type='termsOfAddress'] and starts-with(mods:namePart[@type='termsOfAddress'], '(')">
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="mods:namePart[@type='termsOfAddress']/text()"/>
                </xsl:if>
                <xsl:if test="mods:namePart[@type='date']">
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="mods:namePart[@type='date']/text()"/>
                </xsl:if>
            </field>
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'constituentName', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="(mods:namePart[not(@*)])[1]/text()"/>
                <xsl:for-each select="mods:namePart[not(@*) and position()>=2]">
                    <xsl:text>. </xsl:text>
                    <xsl:value-of select="./text()"/>
                </xsl:for-each>
                <xsl:if
                    test="mods:namePart[@type='termsOfAddress'] and not(starts-with(mods:namePart[@type='termsOfAddress'], '('))">
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="mods:namePart[@type='termsOfAddress']/text()"/>
                </xsl:if>
                <xsl:if
                    test="mods:namePart[@type='termsOfAddress'] and starts-with(mods:namePart[@type='termsOfAddress'], '(')">
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="mods:namePart[@type='termsOfAddress']/text()"/>
                </xsl:if>
                <xsl:if test="mods:namePart[@type='date']">
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="mods:namePart[@type='date']/text()"/>
                </xsl:if>
            </field>
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'constituentName', $authority, $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="(mods:namePart[not(@*)])[1]/text()"/>
                <xsl:for-each select="mods:namePart[not(@*) and position()>=2]">
                    <xsl:text>. </xsl:text>
                    <xsl:value-of select="./text()"/>
                </xsl:for-each>
                <xsl:if
                    test="mods:namePart[@type='termsOfAddress'] and not(starts-with(mods:namePart[@type='termsOfAddress'], '('))">
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="mods:namePart[@type='termsOfAddress']/text()"/>
                </xsl:if>
                <xsl:if
                    test="mods:namePart[@type='termsOfAddress'] and starts-with(mods:namePart[@type='termsOfAddress'], '(')">
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="mods:namePart[@type='termsOfAddress']/text()"/>
                </xsl:if>
                <xsl:if test="mods:namePart[@type='date']">
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="mods:namePart[@type='date']/text()"/>
                </xsl:if>
            </field>
            <xsl:if test="mods:role/mods:roleTerm">
                <field>
                    <xsl:attribute name="name">
                        <xsl:value-of select="concat($prefix, 'name_', $role, $suffix)"/>
                    </xsl:attribute>
                    <xsl:value-of select="mods:namePart[not(@*)]"/>
                    <xsl:if
                        test="mods:namePart[@type='termsOfAddress'] and not(starts-with(mods:namePart[@type='termsOfAddress'], '('))">
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="mods:namePart[@type='termsOfAddress']/text()"/>
                    </xsl:if>
                    <xsl:if
                        test="mods:namePart[@type='termsOfAddress'] and starts-with(mods:namePart[@type='termsOfAddress'], '(')">
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="mods:namePart[@type='termsOfAddress']/text()"/>
                    </xsl:if>
                    <xsl:if test="mods:namePart[@type='date']">
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="mods:namePart[@type='date']/text()"/>
                    </xsl:if>
                </field>
                <field>
                    <xsl:attribute name="name">
                        <xsl:value-of select="concat($prefix, 'name_', $role, $authority, $suffix)"
                        />
                    </xsl:attribute>
                    <xsl:value-of select="mods:namePart[not(@*)]"/>
                    <xsl:if
                        test="mods:namePart[@type='termsOfAddress'] and not(starts-with(mods:namePart[@type='termsOfAddress'], '('))">
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="mods:namePart[@type='termsOfAddress']/text()"/>
                    </xsl:if>
                    <xsl:if
                        test="mods:namePart[@type='termsOfAddress'] and starts-with(mods:namePart[@type='termsOfAddress'], '(')">
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="mods:namePart[@type='termsOfAddress']/text()"/>
                    </xsl:if>
                    <xsl:if test="mods:namePart[@type='date']">
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="mods:namePart[@type='date']/text()"/>
                    </xsl:if>
                </field>
                <field>
                    <xsl:attribute name="name">
                        <xsl:value-of select="concat($prefix, 'constituentName_', $role, $suffix)"/>
                    </xsl:attribute>
                    <xsl:value-of select="(mods:namePart[not(@*)])[1]/text()"/>
                    <xsl:for-each select="mods:namePart[not(@*) and position()>=2]">
                        <xsl:text>. </xsl:text>
                        <xsl:value-of select="./text()"/>
                    </xsl:for-each>
                    <xsl:if
                        test="mods:namePart[@type='termsOfAddress'] and not(starts-with(mods:namePart[@type='termsOfAddress'], '('))">
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="mods:namePart[@type='termsOfAddress']/text()"/>
                    </xsl:if>
                    <xsl:if
                        test="mods:namePart[@type='termsOfAddress'] and starts-with(mods:namePart[@type='termsOfAddress'], '(')">
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="mods:namePart[@type='termsOfAddress']/text()"/>
                    </xsl:if>
                    <xsl:if test="mods:namePart[@type='date']">
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="mods:namePart[@type='date']/text()"/>
                    </xsl:if>
                </field>
                <field>
                    <xsl:attribute name="name">
                        <xsl:value-of
                            select="concat($prefix, 'constituentName_', $role, $authority, $suffix)"
                        />
                    </xsl:attribute>
                    <xsl:value-of select="(mods:namePart[not(@*)])[1]/text()"/>
                    <xsl:for-each select="mods:namePart[not(@*) and position()>=2]">
                        <xsl:text>. </xsl:text>
                        <xsl:value-of select="./text()"/>
                    </xsl:for-each>
                    <xsl:if
                        test="mods:namePart[@type='termsOfAddress'] and not(starts-with(mods:namePart[@type='termsOfAddress'], '('))">
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="mods:namePart[@type='termsOfAddress']/text()"/>
                    </xsl:if>
                    <xsl:if
                        test="mods:namePart[@type='termsOfAddress'] and starts-with(mods:namePart[@type='termsOfAddress'], '(')">
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="mods:namePart[@type='termsOfAddress']/text()"/>
                    </xsl:if>
                    <xsl:if test="mods:namePart[@type='date']">
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="mods:namePart[@type='date']/text()"/>
                    </xsl:if>
                </field>
            </xsl:if>
        </xsl:for-each>
        <!-- Series Title Proper -->
        <xsl:for-each
            select="mods:relatedItem[@type='series']/mods:titleInfo[not (@type='uniform')]/mods:title[normalize-space(text())]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'series_title_proper', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
        </xsl:for-each>
        <!-- Series Title Preferred -->
        <xsl:for-each
            select="mods:relatedItem[@type='series']/mods:titleInfo[@type='uniform']/mods:title[normalize-space(text())]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'series_title_preferred', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
        </xsl:for-each>
        <xsl:for-each
            select="mods:relatedItem[@type='series']/mods:titleInfo[not(@type='uniform')]/mods:partNumber[normalize-space(text())]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'series_number', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
        </xsl:for-each>
        <!-- Series Statement -->
        <xsl:for-each select="mods:relatedItem[@type='series']">
            <xsl:if test="mods:titleInfo[not(@type='uniform')]">
                <field>
                    <xsl:attribute name="name">
                        <xsl:value-of select="concat($prefix, 'series_statement_proper', $suffix)"/>
                    </xsl:attribute>
                    <xsl:value-of select="mods:titleInfo[not(@type='uniform')]/mods:title"/>
                    <xsl:text> ; </xsl:text>
                    <xsl:value-of select="mods:titleInfo[not(@type='uniform')]/mods:partNumber"/>
                </field>
            </xsl:if>
            <xsl:if test="mods:titleInfo[@type='uniform']">
                <field>
                    <xsl:attribute name="name">
                        <xsl:value-of
                            select="concat($prefix, 'series_statement_preferred', $suffix)"/>
                    </xsl:attribute>
                    <xsl:value-of select="mods:titleInfo[@type='uniform']/mods:title"/>
                    <xsl:text> ; </xsl:text>
                    <xsl:value-of select="mods:titleInfo[@type='uniform']/mods:partNumber"/>
                </field>
            </xsl:if>
        </xsl:for-each>
        <!-- Host Name -->
        <xsl:for-each
            select="mods:relatedItem[@type='host']/mods:titleInfo/mods:title[normalize-space(text())]">
            <!--don't bother with empty space-->
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'host_title', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
        </xsl:for-each>
        <xsl:for-each
            select="mods:relatedItem[@type='host']/mods:location/mods:url[normalize-space(text())]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'host_url', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
        </xsl:for-each>

        <!-- DOI, ISSN, ISBN, and any other typed IDs -->
        <xsl:for-each select="mods:identifier[@type][normalize-space(text())]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of
                        select="concat($prefix, local-name(), '_', translate(@type, ' ', '_'), $suffix)"
                    />
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
        </xsl:for-each>
        <!-- Location (physical) -->
        <xsl:for-each select="mods:location/mods:physicalLocation[not(@*)]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'physicalLocation', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="normalize-space(text())"/>
            </field>
        </xsl:for-each>
        <xsl:for-each select="mods:location/mods:physicalLocation[@type='text']">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'physicalLocation', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="normalize-space(text())"/>
            </field>
        </xsl:for-each>
        <xsl:for-each select="mods:location/mods:physicalLocation[@authority]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'physicalLocation_', @authority, $suffix)"
                    />
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
        </xsl:for-each>
        <!-- Location (shelf) -->
        <xsl:for-each select="mods:location/mods:shelfLocator[normalize-space(text())]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, local-name(), $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
        </xsl:for-each>
        <xsl:for-each
            select="mods:location/mods:holdingSimple/mods:copyInformation/mods:subLocation[normalize-space(text())]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'physicalLocation_NIUdb', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
        </xsl:for-each>
        <xsl:for-each
            select="mods:location/mods:holdingSimple/mods:copyInformation/mods:shelfLocator[normalize-space(text())]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'shelfLocator', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
        </xsl:for-each>


        <!-- Location (url) -->
        <xsl:for-each select="mods:location/mods:url[normalize-space(text())]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'location_', local-name(), $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="normalize-space(text())"/>
            </field>
        </xsl:for-each>

        <!-- Access Condition -->
        <xsl:for-each select="mods:accessCondition[normalize-space(text())]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'accessCondition', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="normalize-space(text())"/>
            </field>
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'accessCondition_', @type, $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="normalize-space(text())"/>
            </field>
        </xsl:for-each>
        <!-- Descriptive standard -->
        <xsl:for-each select="mods:recordInfo/mods:descriptionStandard[normalize-space(text())]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, local-name(), $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="normalize-space(text())"/>
            </field>
        </xsl:for-each>
        <!-- Record identifier -->
        <xsl:for-each select="mods:recordInfo/mods:recordIdentifier[normalize-space(text())]">
            <xsl:variable name="source">
                <xsl:value-of select="concat('_', @source)"/>
            </xsl:variable>
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, local-name(), $source, $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>
