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
        <xsl:for-each select="(mods:titleInfo/mods:title[normalize-space(text())])[1]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, local-name(), $suffix)"/>
                </xsl:attribute>
                <xsl:if test="../mods:nonSort">
                    <xsl:value-of select="../mods:nonSort/text()"/>
                    <xsl:text> </xsl:text>
                </xsl:if>
                <xsl:value-of select="text()"/>
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
                <xsl:value-of select="text()"/>
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
            </field>

        </xsl:for-each>

        <xsl:for-each select="mods:titleInfo[@type]">

            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'title_', @type, $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="mods:title/text()"/>
            </field>

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

            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'primary_name_', $role, $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="mods:namePart[not(@*)]/text()"/>
                <xsl:if test="mods:namePart[@type='termsOfAddress']">
                    <xsl:text>, </xsl:text>
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
                <xsl:value-of select="mods:namePart[not(@*)]/text()"/>
                <xsl:if test="mods:namePart[@type='termsOfAddress']">
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="mods:namePart[@type='termsOfAddress']/text()"/>
                </xsl:if>
                <xsl:if test="mods:namePart[@type='date']">
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="mods:namePart[@type='date']/text()"/>
                </xsl:if>
            </field>

            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'name', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="mods:namePart[not(@*)]/text()"/>
                <xsl:if test="mods:namePart[@type='termsOfAddress']">
                    <xsl:text>, </xsl:text>
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
                    <xsl:value-of select="concat($prefix, local-name(), $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
        </xsl:for-each>

        <!-- Matt: index URI's by role -->
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
                <xsl:value-of select="text()"/>
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
                    <xsl:value-of select="text()"/>
                </field>
                <field>
                    <xsl:attribute name="name">
                        <xsl:value-of select="concat($prefix, local-name(), $suffix)"/>
                    </xsl:attribute>
                    <xsl:value-of select="text()"/>
                </field>
            </xsl:if>
        </xsl:for-each>

        <!-- Matt: index genre URI -->

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
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'place_of_publication_text', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
        </xsl:for-each>

        <xsl:for-each
            select="mods:originInfo/mods:place/mods:placeTerm[@type='code'][normalize-space(text())]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'place_of_publication_code', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
        </xsl:for-each>

        <!-- Publisher's Name -->
        <xsl:for-each select="mods:originInfo/mods:publisher[normalize-space(text())]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, local-name(), $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
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

        <!-- Date Issued -->

        <xsl:for-each select="mods:originInfo/mods:dateIssued[not(@point)][normalize-space(text())]">

            <!-- Matt: these variables let us use the Joda time library -->

            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, local-name(), $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>

            <!-- use the first for a sortable field -->
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'dateIssued_year', '_s')"/>
                </xsl:attribute>
                <xsl:if test="contains(text(),'-')">
                    <xsl:value-of select="substring-before(text(), '-')"/>
                </xsl:if>
                <xsl:if test="not(contains(text(),'-'))">
                    <xsl:value-of select="text()"/>
                </xsl:if>
            </field>

        </xsl:for-each>

        <!-- Matt: these two if tests handle date ranges -->

        <xsl:if test="mods:originInfo/mods:dateIssued[@point]">

            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'dateIssued', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="mods:originInfo/mods:dateIssued[@point='start']"/>
                <xsl:text>-</xsl:text>
                <xsl:value-of select="mods:originInfo/mods:dateIssued[@point='end']"/>
            </field>
        </xsl:if>

        <xsl:if test="mods:originInfo/mods:dateIssued[@point='start']">
            <!-- use the first for a sortable field -->
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'dateIssued_year', '_s')"/>
                </xsl:attribute>
                <xsl:value-of select="mods:originInfo/mods:dateIssued[@point='start']"/>
            </field>
        </xsl:if>


        <!-- Date Captured -->
        <xsl:for-each
            select="mods:originInfo/mods:dateCaptured[not(@point)][normalize-space(text())]">


            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, local-name(), $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
            <xsl:if test="position() = 1">
                <!-- use the first for a sortable field -->
                <field>
                    <xsl:attribute name="name">
                        <xsl:value-of select="concat($prefix, 'dateCaptured_year', '_s')"/>
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

        <xsl:if test="mods:originInfo/mods:dateCaptured[@point]">

            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'dateCaptured', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="mods:originInfo/mods:dateCaptured[@point='start']"/>
                <xsl:text>-</xsl:text>
                <xsl:value-of select="mods:originInfo/mods:dateCaptured[@point='end']"/>
            </field>
        </xsl:if>

        <xsl:if test="mods:originInfo/mods:dateCaptured[@point='start']">
            <!-- use the first for a sortable field -->
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'dateCaptured_year', '_s')"/>
                </xsl:attribute>
                <xsl:value-of select="mods:originInfo/mods:dateCaptured[@point='start']"/>
            </field>
        </xsl:if>

        <!-- Date Created -->
        <xsl:for-each
            select="mods:originInfo/mods:dateCreated[not(@point)][normalize-space(text())]">

            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, local-name(), $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
            <xsl:if test="position() = 1">
                <!-- use the first for a sortable field -->
                <field>
                    <xsl:attribute name="name">
                        <xsl:value-of select="concat($prefix, 'dateCreated_year', '_s')"/>
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


        <xsl:if test="mods:originInfo/mods:dateCreated[@point]">

            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'dateCreated', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="mods:originInfo/mods:dateCreated[@point='start']"/>
                <xsl:text>-</xsl:text>
                <xsl:value-of select="mods:originInfo/mods:dateCreated[@point='end']"/>
            </field>
        </xsl:if>

        <xsl:if test="mods:originInfo/mods:dateCreated[@point='start']">
            <!-- use the first for a sortable field -->
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'dateCreated_year', '_s')"/>
                </xsl:attribute>
                <xsl:value-of select="mods:originInfo/mods:dateCreated[@point='start']"/>
            </field>
        </xsl:if>

        <!-- Other Date -->
        <xsl:for-each select="mods:originInfo/mods:dateOther[@type][normalize-space(text())]">

            <field>
                <xsl:attribute name="name">
                    <xsl:value-of
                        select="concat($prefix, local-name(), '_', translate(@type, ' ABCDEFGHIJKLMNOPQRSTUVWXYZ', '_abcdefghijklmnopqrstuvwxyz'), $suffix)"
                    />
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>

            <xsl:if test="position() = 1">
                <!-- use the first for a sortable field -->
                <field>
                    <xsl:attribute name="name">
                        <xsl:value-of
                            select="concat($prefix, 'dateOther_year', '_', translate(@type, ' ', '_'), '_s')"
                        />
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

        <xsl:if test="mods:originInfo/mods:dateOther[@point]">

            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'dateOther', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="mods:originInfo/mods:dateOther[@point='start']"/>
                <xsl:text>-</xsl:text>
                <xsl:value-of select="mods:originInfo/mods:dateOther[@point='end']"/>
            </field>
        </xsl:if>

        <xsl:if test="mods:originInfo/mods:dateOther[@point='start']">
            <!-- use the first for a sortable field -->
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of
                        select="concat($prefix, 'dateOther_year','_', translate(@type, ' ABCDEFGHIJKLMNOPQRSTUVWXYZ', '_abcdefghijklmnopqrstuvwxyz'), '_s')"
                    />
                </xsl:attribute>
                <xsl:value-of select="mods:originInfo/mods:dateOther[@point='start']"/>
            </field>
        </xsl:if>

        <!-- Copyright Date (is an okay substitute for Issued Date in many circumstances) -->
        <xsl:for-each
            select="mods:originInfo/mods:copyrightDate[not(@point)][normalize-space(text())]">

            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, local-name(), $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
            <xsl:if test="position() = 1">
                <!-- use the first for a sortable field -->
                <field>
                    <xsl:attribute name="name">
                        <xsl:value-of select="concat($prefix, 'copyrightDate_year', '_s')"/>
                    </xsl:attribute>
                    <xsl:value-of select="text()"/>
                </field>
            </xsl:if>
        </xsl:for-each>

        <xsl:if test="mods:originInfo/mods:copyrightDate[@point]">

            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'copyrightDate', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="mods:originInfo/mods:copyrightDate[@point='start']"/>
                <xsl:text>-</xsl:text>
                <xsl:value-of select="mods:originInfo/mods:copyrightDate[@point='end']"/>
            </field>
        </xsl:if>

        <xsl:if test="mods:originInfo/mods:copyrightDate[@point='start']">
            <!-- use the first for a sortable field -->
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'copyrightDate_year', '_s')"/>
                </xsl:attribute>
                <xsl:value-of select="mods:originInfo/mods:copyrightDate[@point='start']"/>
            </field>
        </xsl:if>

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
        <xsl:for-each
            select="mods:language/mods:languageTerm[@authority='iso639-2b' and @type='code'][normalize-space(text())]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'languageTerm_iso639-2b_code', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
        </xsl:for-each>

        <xsl:for-each
            select="mods:language/mods:languageTerm[@authority='iso639-2b' and @type='text'][normalize-space(text())]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'languageTerm_iso639-2b_text', $suffix)"/>
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
                        select="concat($prefix, 'physical_description_', local-name(), $suffix)"/>
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
                            select="concat($prefix, 'physical_description_', local-name(), '_', @type, $authority, $suffix)"
                        />
                    </xsl:attribute>
                    <xsl:value-of select="text()"/>
                </field>
            </xsl:if>

            <xsl:if test="not(@type)">
                <field>
                    <xsl:attribute name="name">
                        <xsl:value-of
                            select="concat($prefix, 'physical_description_', local-name(), $authority, $suffix)"
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

        <!-- Pages -->

        <xsl:for-each
            select="mods:physicalDescription/mods:extent[@unit='pages'][normalize-space(text())]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'page_number_count', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
                <xsl:text> pages</xsl:text>
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
                <xsl:value-of select="text()"/>
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

        <!-- Matt: index subject URI -->

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
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'subject_coordinated', $suffix)"/>
                </xsl:attribute>

                <xsl:if test="count(*)>1">
                    <xsl:if test="*[position()=1]">
                        <xsl:if test="mods:name">
                            <xsl:value-of select="mods:name/mods:namePart[not(@*)]"/>
                            <xsl:if test="mods:name/mods:namePart[@type='termsOfAddress']">
                                <xsl:text>, </xsl:text>
                                <xsl:value-of
                                    select="mods:name/mods:namePart[@type='termsOfAddress']"/>
                            </xsl:if>
                            <xsl:if test="mods:name/mods:namePart[@type='date']">
                                <xsl:text>, </xsl:text>
                                <xsl:value-of select="mods:name/mods:namePart[@type='date']"/>
                            </xsl:if>
                            <xsl:text>--</xsl:text>
                        </xsl:if>
                        <xsl:if test="mods:title">
                            <xsl:value-of select="mods:title/mods:titleInfo"/>
                            <xsl:text>--</xsl:text>
                        </xsl:if>
                        <xsl:if test="mods:topic | mods:geographic | mods:temporal">
                            <xsl:value-of select="mods:topic | mods:geographic | mods:temporal"/>
                            <xsl:text>--</xsl:text>
                        </xsl:if>
                    </xsl:if>
                    <xsl:if test="*[position()=2 and position()!=last()]">
                        <xsl:if test="mods:name">
                            <xsl:value-of select="mods:name/mods:namePart[not(@*)]"/>
                            <xsl:if test="mods:name/mods:namePart[@type='termsOfAddress']">
                                <xsl:text>, </xsl:text>
                                <xsl:value-of
                                    select="mods:name/mods:namePart[@type='termsOfAddress']"/>
                            </xsl:if>
                            <xsl:if test="mods:name/mods:namePart[@type='date']">
                                <xsl:text>, </xsl:text>
                                <xsl:value-of select="mods:name/mods:namePart[@type='date']"/>
                            </xsl:if>
                            <xsl:text>--</xsl:text>
                        </xsl:if>
                        <xsl:if test="mods:title">
                            <xsl:value-of select="mods:title/mods:titleInfo"/>
                            <xsl:text>--</xsl:text>
                        </xsl:if>
                        <xsl:if test="mods:topic | mods:geographic | mods:temporal">
                            <xsl:value-of
                                select="*[position()=2 and position()!=last() and not(mods:name) and not(mods:title)]"/>
                            <xsl:text>--</xsl:text>
                        </xsl:if>
                    </xsl:if>
                    <xsl:if test="*[position()=3 and position()!=last()]">
                        <xsl:if test="mods:name">
                            <xsl:value-of select="mods:name/mods:namePart[not(@*)]"/>
                            <xsl:if test="mods:name/mods:namePart[@type='termsOfAddress']">
                                <xsl:text>, </xsl:text>
                                <xsl:value-of
                                    select="mods:name/mods:namePart[@type='termsOfAddress']"/>
                            </xsl:if>
                            <xsl:if test="mods:name/mods:namePart[@type='date']">
                                <xsl:text>, </xsl:text>
                                <xsl:value-of select="mods:name/mods:namePart[@type='date']"/>
                            </xsl:if>
                            <xsl:text>--</xsl:text>
                        </xsl:if>
                        <xsl:if test="mods:title">
                            <xsl:value-of select="mods:title/mods:titleInfo"/>
                            <xsl:text>--</xsl:text>
                        </xsl:if>
                        <xsl:if test="mods:topic | mods:geographic | mods:temporal">
                            <xsl:value-of
                                select="*[position()=3 and position()!=last() and not(mods:name) and not(mods:title)]"/>
                            <xsl:text>--</xsl:text>
                        </xsl:if>
                    </xsl:if>
                    <xsl:if test="*[last()]">
                        <xsl:value-of select="*[last()]"/>
                    </xsl:if>

                </xsl:if>

                <xsl:if test="count(*)=1">
                    <xsl:value-of select="*"/>
                </xsl:if>

            </field>
        </xsl:for-each>

        <!-- Specific subjects -->

        <xsl:for-each select="mods:subject/mods:topic[normalize-space(text())]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'subject_topic', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
            <xsl:if test="../@authority">
                <field>
                    <xsl:attribute name="name">
                        <xsl:value-of
                            select="concat($prefix, 'subject_', ../@authority, '_topic', $suffix)"/>
                    </xsl:attribute>
                    <xsl:value-of select="text()"/>
                </field>
            </xsl:if>
        </xsl:for-each>

        <xsl:for-each select="mods:subject/mods:name">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'subject_name', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="mods:namePart[not(@*)]"/>
                <xsl:if test="mods:namePart[@type='termsOfAddress']">
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="mods:namePart[@type='termsOfAddress']"/>
                </xsl:if>
                <xsl:if test="./mods:namePart[@type='date']">
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="mods:namePart[@type='date']"/>
                </xsl:if>
            </field>

            <xsl:if test="../@authority">
                <field>
                    <xsl:attribute name="name">
                        <xsl:value-of
                            select="concat($prefix, 'subject_', ../@authority, '_name', $suffix)"/>
                    </xsl:attribute>
                    <xsl:value-of select="mods:namePart[not(@*)]"/>
                    <xsl:if test="mods:namePart[@type='termsOfAddress']">
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="mods:namePart[@type='termsOfAddress']"/>
                    </xsl:if>
                    <xsl:if test="./mods:namePart[@type='date']">
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="mods:namePart[@type='date']"/>
                    </xsl:if>
                </field>
            </xsl:if>
            <xsl:if test="@authority">
                <field>
                    <xsl:attribute name="name">
                        <xsl:value-of select="concat($prefix, 'subject_name_', @authority, $suffix)"
                        />
                    </xsl:attribute>
                    <xsl:value-of select="mods:namePart[not(@*)]"/>
                    <xsl:if test="mods:namePart[@type='termsOfAddress']">
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="mods:namePart[@type='termsOfAddress']"/>
                    </xsl:if>
                    <xsl:if test="./mods:namePart[@type='date']">
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="mods:namePart[@type='date']"/>
                    </xsl:if>
                </field>
            </xsl:if>

        </xsl:for-each>
        
        <xsl:for-each select="mods:subject/mods:titleInfo/mods:title">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of
                        select="concat($prefix, 'subject_title', $suffix)"
                    />
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
            <xsl:if test="../@authority">
                <field>
                    <xsl:attribute name="name">
                        <xsl:value-of
                            select="concat($prefix, 'subject_', ../@authority, '_title', $suffix)"
                        />
                    </xsl:attribute>
                    <xsl:value-of select="text()"/>
                </field>
            </xsl:if>
        </xsl:for-each>
        
        <xsl:for-each select="mods:subject/mods:geographic[normalize-space(text())]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of
                        select="concat($prefix, 'subject_geographic', $suffix)"
                    />
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
            <xsl:if test="../@authority">
                <field>
                    <xsl:attribute name="name">
                        <xsl:value-of
                            select="concat($prefix, 'subject_', ../@authority, '_geographic', $suffix)"
                        />
                    </xsl:attribute>
                    <xsl:value-of select="text()"/>
                </field>
            </xsl:if>
        </xsl:for-each>
        
        <xsl:for-each select="mods:subject/mods:temporal[normalize-space(text())]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of
                        select="concat($prefix, 'subject_temporal', $suffix)"
                    />
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
            <xsl:if test="../@authority">
                <field>
                    <xsl:attribute name="name">
                        <xsl:value-of
                            select="concat($prefix, 'subject_', ../@authority, '_temporal', $suffix)"
                        />
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
                    <xsl:value-of select="concat($prefix, local-name(), $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
        </xsl:for-each>

        <!-- Coordinates (lat,long) -->
        <xsl:for-each
            select="mods:subject/mods:topic[../mods:cartographics/text()][normalize-space(text())]">
            <!--don't bother with empty space-->
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'cartographic_topic', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
        </xsl:for-each>

        <!-- Country -->
        <xsl:for-each select="mods:country[normalize-space(text())]">
            <!--don't bother with empty space-->
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, local-name(), $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
        </xsl:for-each>

        <xsl:for-each select="mods:province[normalize-space(text())]">
            <!--don't bother with empty space-->
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, local-name(), $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
        </xsl:for-each>

        <xsl:for-each select="mods:county[normalize-space(text())]">
            <!--don't bother with empty space-->
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, local-name(), $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
        </xsl:for-each>

        <xsl:for-each select="mods:region[normalize-space(text())]">
            <!--don't bother with empty space-->
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, local-name(), $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
        </xsl:for-each>

        <xsl:for-each select="mods:city[normalize-space(text())]">
            <!--don't bother with empty space-->
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, local-name(), $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
        </xsl:for-each>

        <xsl:for-each select="mods:citySection[normalize-space(text())]">
            <!--don't bother with empty space-->
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, local-name(), $suffix)"/>
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
                <xsl:value-of select="text()"/>
            </field>
        </xsl:for-each>

        <xsl:for-each select="mods:relatedItem[@type='constituent']/mods:name">

            <xsl:variable name="role" select="mods:role/mods:roleTerm/text()"/>

            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'name_', $role, $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="mods:namePart[not(@*)]"/>
                <xsl:if test="mods:namePart[@type='termsOfAddress']">
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="mods:namePart[@type='termsOfAddress']/text()"/>
                </xsl:if>
                <xsl:if test="mods:namePart[@type='date']">
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="mods:namePart[@type='date']/text()"/>
                </xsl:if>
            </field>

            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'name', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="mods:namePart[not(@*)]"/>
                <xsl:if test="mods:namePart[@type='termsOfAddress']">
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="mods:namePart[@type='termsOfAddress']/text()"/>
                </xsl:if>
                <xsl:if test="mods:namePart[@type='date']">
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="mods:namePart[@type='date']/text()"/>
                </xsl:if>
            </field>

            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'constituent_name_', $role, $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="mods:namePart[not(@*)]"/>
                <xsl:if test="mods:namePart[@type='termsOfAddress']">
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="mods:namePart[@type='termsOfAddress']/text()"/>
                </xsl:if>
                <xsl:if test="mods:namePart[@type='date']">
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="mods:namePart[@type='date']/text()"/>
                </xsl:if>
            </field>

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

        <!-- Series Title Preferred -->
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
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'series_statement', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="mods:titleInfo/mods:title"/>
                <xsl:text> ; </xsl:text>
                <xsl:value-of select="mods:titleInfo/mods:partNumber"/>
            </field>
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

        <!-- Volume (e.g. journal vol) -->
        <xsl:for-each select="mods:part/mods:detail[@type='volume']/*[normalize-space(text())]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'volume', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
        </xsl:for-each>

        <!-- Issue (e.g. journal vol) -->
        <xsl:for-each select="mods:part/mods:detail[@type='issue']/*[normalize-space(text())]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'issue', $suffix)"/>
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
                <xsl:value-of select="text()"/>
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


        <!-- Location (url) -->
        <xsl:for-each select="mods:location/mods:url[normalize-space(text())]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'location_', local-name(), $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
        </xsl:for-each>

        <!-- Access Condition -->
        <xsl:for-each select="mods:accessCondition[normalize-space(text())]">

            <xsl:variable name="type">
                <xsl:value-of select="concat('_', @type)"/>
            </xsl:variable>

            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, local-name(), $type, $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </field>
        </xsl:for-each>

        <!-- Descriptive standard -->
        <xsl:for-each select="mods:recordInfo/mods:descriptionStandard[normalize-space(text())]">

            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, local-name(), $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
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

        <!--************************************ END MODS subset for Bibliographies ******************************************-->
    </xsl:template>

</xsl:stylesheet>
