<xsl:stylesheet version="1.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:exist="http://exist.sourceforge.net/NS/exist"
xmlns:TransactionType="http://dev.yipl.com.np/iati-aims/public/api/codelists/TransactionType"
xmlns:CountryLocation="https://www.cia.gov/library/publications/the-world-factbook/fields/2011.html">

  <!--ToDo: Currency warning. Need to warn when we've got an activity with multiple currencies-->
  <!--  <xsl:output method="text" encoding="application/json"/> -->

  <xsl:variable name="currentReportingYearEnd">2011</xsl:variable>
  <xsl:variable name="prevReportingYearEnd">2010</xsl:variable>  
  

  <!--Useful function to format currency-->
  <xsl:template name="formatCurrency">
    <xsl:param name="currency" select="''"/>
    <xsl:param name="value" select="0"/>
    <xsl:value-of select="$currency"/>
    <xsl:text> </xsl:text>
    <xsl:element name="span" >
      <xsl:attribute name="class">currency currency-<xsl:value-of select="$currency"/>
    </xsl:attribute>
        <xsl:value-of select="format-number($value,'###,###.##')"/>
    </xsl:element><!--span-->
  </xsl:template>

  <!--Lookup template-->
  <xsl:template match="TransactionType:codes">
    <xsl:param name="code"/>
    <xsl:value-of select="TransactionType:code[@id=$code]"/>
  </xsl:template>

  <!--Lookup list-->
  <TransactionType:codes>
    <TransactionType:code id="C">Commitment</TransactionType:code>
    <TransactionType:code id="D">Disbursement</TransactionType:code>
    <TransactionType:code id="E">Expenditure</TransactionType:code>
    <TransactionType:code id="IR">Interest Repayment</TransactionType:code>
    <TransactionType:code id="LR">Loan Repayment</TransactionType:code>
    <TransactionType:code id="R">Reimbursement</TransactionType:code>
  </TransactionType:codes>

  <!--Lookup template-->
  <xsl:template match="CountryLocation:codes">
    <xsl:param name="code"/>
    <xsl:value-of select="CountryLocation:code[@id=$code]"/>
  </xsl:template>  
  
  <!--Lookup list - grabbed from http://www.simile-widgets.org/exhibit/examples/flags/data.json checked with CIA - remember want decimal not degrees and minutes which is what CIA is in-->
  <CountryLocation:codes>
    <CountryLocation:code id="AO">-12.5,18.5</CountryLocation:code> 
    <CountryLocation:code id="BD">24,90</CountryLocation:code>
    <CountryLocation:code id="BF">13,-2</CountryLocation:code>
    <CountryLocation:code id="ET">8,38</CountryLocation:code>
    <CountryLocation:code id="GH">8,-2</CountryLocation:code>
    <CountryLocation:code id="IN">20,77</CountryLocation:code>
    <CountryLocation:code id="KE">1,38</CountryLocation:code>
    <CountryLocation:code id="LR">6.5,-9.5</CountryLocation:code>
    <CountryLocation:code id="MG">-20,47</CountryLocation:code>
    <CountryLocation:code id="MW">-13.5,34</CountryLocation:code>
    <CountryLocation:code id="ML">17,-4</CountryLocation:code>
    <CountryLocation:code id="MZ">-18.25,35</CountryLocation:code>
    <CountryLocation:code id="NE">16,8</CountryLocation:code>
    <CountryLocation:code id="NP">28,84</CountryLocation:code>
    <CountryLocation:code id="NG">10,8</CountryLocation:code>
    <CountryLocation:code id="PK">30,70</CountryLocation:code>
    <CountryLocation:code id="RW">-2,30</CountryLocation:code>
    <CountryLocation:code id="SL">8.5,-11.5</CountryLocation:code>
    <CountryLocation:code id="TZ">-6,35</CountryLocation:code>
    <CountryLocation:code id="UG">1,32</CountryLocation:code>
    <CountryLocation:code id="ZM">-15,30</CountryLocation:code>
  </CountryLocation:codes>
    <!--    //{ id: "ap", latlng: "35,105" },
    //{ id: "eu", latlng: "47,8" },
    { id: "ad", latlng: "42.5,1.5" },
    { id: "ae", latlng: "24,54" },
    { id: "af", latlng: "33,65" },
    { id: "ag", latlng: "17.05,-61.8" },
    { id: "ai", latlng: "18.25,-63.1667" },
    { id: "al", latlng: "41,20" },
    { id: "am", latlng: "40,45" },
    { id: "an", latlng: "12.25,-68.75" },
     //{ id: "aq", latlng: "-90,0" },
    { id: "ar", latlng: "-34,-64" },
    { id: "as", latlng: "-14.3333,-170" },
    { id: "at", latlng: "47.3333,13.3333" },
    { id: "au", latlng: "-27,133" },
    { id: "aw", latlng: "12.5,-69.9667" },
    { id: "ax", latlng: "60.228,19.995" },
    { id: "az", latlng: "40.5,47.5" },
    { id: "ba", latlng: "44,18" },
    { id: "bb", latlng: "13.1667,-59.5333" },
    { id: "be", latlng: "50.8333,4" },
    { id: "bg", latlng: "43,25" },
    { id: "bh", latlng: "26,50.55" },
    { id: "bi", latlng: "-3.5,30" },
    { id: "bj", latlng: "9.5,2.25" },
    { id: "bm", latlng: "32.3333,-64.75" },
    { id: "bn", latlng: "4.5,114.6667" },
    { id: "bo", latlng: "-17,-65" },
    { id: "br", latlng: "-10,-55" },
    { id: "bs", latlng: "24.25,-76" },
    { id: "bt", latlng: "27.5,90.5" },
    { id: "bv", latlng: "-54.4333,3.4" },
    { id: "bw", latlng: "-22,24" },
    { id: "by", latlng: "53,28" },
    { id: "bz", latlng: "17.25,-88.75" },
    { id: "ca", latlng: "60,-95" },
    { id: "cc", latlng: "-12.5,96.8333" },
    { id: "cf", latlng: "7,21" },
    { id: "cg", latlng: "-1,15" },
    { id: "ch", latlng: "47,8" },
    { id: "ci", latlng: "8,-5" },
    { id: "ck", latlng: "-21.2333,-159.7667" },
    { id: "cl", latlng: "-30,-71" },
    { id: "cm", latlng: "6,12" },
    { id: "cn", latlng: "35,105" },
    { id: "co", latlng: "4,-72" },
    { id: "cr", latlng: "10,-84" },
    { id: "cu", latlng: "21.5,-80" },
    { id: "cv", latlng: "16,-24" },
    { id: "cx", latlng: "-10.5,105.6667" },
    { id: "cy", latlng: "35,33" },
    { id: "cz", latlng: "49.75,15.5" },
    { id: "de", latlng: "51,9" },
    { id: "dj", latlng: "11.5,43" },
    { id: "dk", latlng: "56,10" },
    { id: "dm", latlng: "15.4167,-61.3333" },
    { id: "do", latlng: "19,-70.6667" },
    { id: "dz", latlng: "28,3" },
    { id: "ec", latlng: "-2,-77.5" },
    { id: "ee", latlng: "59,26" },
    { id: "eg", latlng: "27,30" },
    { id: "eh", latlng: "24.5,-13" },
    { id: "er", latlng: "15,39" },
    { id: "es", latlng: "40,-4" },
    { id: "fi", latlng: "64,26" },
    { id: "fj", latlng: "-18,175" },
    { id: "fk", latlng: "-51.75,-59" },
    { id: "fm", latlng: "6.9167,158.25" },
    { id: "fo", latlng: "62,-7" },
    { id: "fr", latlng: "46,2" },
    { id: "ga", latlng: "-1,11.75" },
    { id: "gb", latlng: "54,-2" },
    { id: "gd", latlng: "12.1167,-61.6667" },
    { id: "ge", latlng: "42,43.5" },
    { id: "gf", latlng: "4,-53" },
    { id: "gi", latlng: "36.1833,-5.3667" },
    { id: "gl", latlng: "72,-40" },
    { id: "gm", latlng: "13.4667,-16.5667" },
    { id: "gn", latlng: "11,-10" },
    { id: "gp", latlng: "16.25,-61.5833" },
    { id: "gq", latlng: "2,10" },
    { id: "gr", latlng: "39,22" },
    { id: "gs", latlng: "-54.5,-37" },
    { id: "gt", latlng: "15.5,-90.25" },
    { id: "gu", latlng: "13.4667,144.7833" },
    { id: "gw", latlng: "12,-15" },
    { id: "gy", latlng: "5,-59" },
    { id: "hk", latlng: "22.25,114.1667" },
    { id: "hm", latlng: "-53.1,72.5167" },
    { id: "hn", latlng: "15,-86.5" },
    { id: "hr", latlng: "45.1667,15.5" },
    { id: "ht", latlng: "19,-72.4167" },
    { id: "hu", latlng: "47,20" },
    { id: "id", latlng: "-5,120" },
    { id: "ie", latlng: "53,-8" },
    { id: "il", latlng: "31.5,34.75" },
    { id: "io", latlng: "-6,71.5" },
    { id: "iq", latlng: "33,44" },
    { id: "ir", latlng: "32,53" },
    { id: "is", latlng: "65,-18" },
    { id: "it", latlng: "42.8333,12.8333" },
    { id: "jm", latlng: "18.25,-77.5" },
    { id: "jo", latlng: "31,36" },
    { id: "jp", latlng: "36,138" },
    { id: "kg", latlng: "41,75" },
    { id: "kh", latlng: "13,105" },
    { id: "ki", latlng: "1.4167,173" },
    { id: "km", latlng: "-12.1667,44.25" },
    { id: "kn", latlng: "17.3333,-62.75" },
    { id: "kp", latlng: "40,127" },
    { id: "kr", latlng: "37,127.5" },
    { id: "kw", latlng: "29.5,45.75" },
    { id: "ky", latlng: "19.5,-80.5" },
    { id: "kz", latlng: "48,68" },
    { id: "la", latlng: "18,105" },
    { id: "lb", latlng: "33.8333,35.8333" },
    { id: "lc", latlng: "13.8833,-61.1333" },
    { id: "li", latlng: "47.1667,9.5333" },
    { id: "lk", latlng: "7,81" },
    { id: "ls", latlng: "-29.5,28.5" },
    { id: "lt", latlng: "56,24" },
    { id: "lu", latlng: "49.75,6.1667" },
    { id: "lv", latlng: "57,25" },
    { id: "ly", latlng: "25,17" },
    { id: "ma", latlng: "32,-5" },
    { id: "mc", latlng: "43.7333,7.4" },
    { id: "md", latlng: "47,29" },
    { id: "mh", latlng: "9,168" },
    { id: "mk", latlng: "41.8333,22" },
    { id: "mn", latlng: "46,105" },
    { id: "mo", latlng: "22.1667,113.55" },
    { id: "mp", latlng: "15.2,145.75" },
    { id: "mq", latlng: "14.6667,-61" },
    { id: "mr", latlng: "20,-12" },
    { id: "ms", latlng: "16.75,-62.2" },
    { id: "mt", latlng: "35.8333,14.5833" },
    { id: "mu", latlng: "-20.2833,57.55" },
    { id: "mv", latlng: "3.25,73" },
    { id: "mx", latlng: "23,-102" },
    { id: "my", latlng: "2.5,112.5" },
    { id: "na", latlng: "-22,17" },
    { id: "nc", latlng: "-21.5,165.5" },
    { id: "nf", latlng: "-29.0333,167.95" },
    { id: "ni", latlng: "13,-85" },
    { id: "nl", latlng: "52.5,5.75" },
    { id: "no", latlng: "62,10" },
    { id: "nr", latlng: "-0.5333,166.9167" },
    { id: "nu", latlng: "-19.0333,-169.8667" },
    { id: "nz", latlng: "-41,174" },
    { id: "om", latlng: "21,57" },
    { id: "pa", latlng: "9,-80" },
    { id: "pe", latlng: "-10,-76" },
    { id: "pf", latlng: "-15,-140" },
    { id: "pg", latlng: "-6,147" },
    { id: "ph", latlng: "13,122" },
    { id: "pl", latlng: "52,20" },
    { id: "pm", latlng: "46.8333,-56.3333" },
    { id: "pr", latlng: "18.25,-66.5" },
    { id: "ps", latlng: "32,35.25" },
    { id: "pt", latlng: "39.5,-8" },
    { id: "pw", latlng: "7.5,134.5" },
    { id: "py", latlng: "-23,-58" },
    { id: "qa", latlng: "25.5,51.25" },
    { id: "re", latlng: "-21.1,55.6" },
    { id: "ro", latlng: "46,25" },
    { id: "ru", latlng: "60,100" },
    { id: "sa", latlng: "25,45" },
    { id: "sb", latlng: "-8,159" },
    { id: "sc", latlng: "-4.5833,55.6667" },
    { id: "sd", latlng: "15,30" },
    { id: "se", latlng: "62,15" },
    { id: "sg", latlng: "1.3667,103.8" },
    { id: "sh", latlng: "-15.9333,-5.7" },
    { id: "si", latlng: "46,15" },
    { id: "sj", latlng: "78,20" },
    { id: "sk", latlng: "48.6667,19.5" },
    { id: "sm", latlng: "43.7667,12.4167" },
    { id: "sn", latlng: "14,-14" },
    { id: "so", latlng: "10,49" },
    { id: "sr", latlng: "4,-56" },
    { id: "st", latlng: "1,7" },
    { id: "sv", latlng: "13.8333,-88.9167" },
    { id: "sy", latlng: "35,38" },
    { id: "sz", latlng: "-26.5,31.5" },
    { id: "tc", latlng: "21.75,-71.5833" },
    { id: "td", latlng: "15,19" },
    { id: "tg", latlng: "8,1.1667" },
    { id: "th", latlng: "15,100" },
    { id: "tj", latlng: "39,71" },
    { id: "tk", latlng: "-9,-172" },
    { id: "tm", latlng: "40,60" },
    { id: "tn", latlng: "34,9" },
    { id: "to", latlng: "-20,-175" },
    { id: "tr", latlng: "39,35" },
    { id: "tt", latlng: "11,-61" },
    { id: "tv", latlng: "-8,178" },
    { id: "tw", latlng: "23.5,121" },
    { id: "ua", latlng: "49,32" },
    { id: "um", latlng: "19.2833,166.6" },
    { id: "us", latlng: "38,-97" },
    { id: "uy", latlng: "-33,-56" },
    { id: "uz", latlng: "41,64" },
    { id: "va", latlng: "41.9,12.45" },
    { id: "vc", latlng: "13.25,-61.2" },
    { id: "ve", latlng: "8,-66" },
    { id: "vg", latlng: "18.5,-64.5" },
    { id: "vi", latlng: "18.3333,-64.8333" },
    { id: "vn", latlng: "16,106" },
    { id: "vu", latlng: "-16,167" },
    { id: "wf", latlng: "-13.3,-176.2" },
    { id: "ws", latlng: "-13.5833,-172.3333" },
    { id: "ye", latlng: "15,48" },
    { id: "yt", latlng: "-12.8333,45.1667" },
    //{ id: "yu", latlng: "44,21" },
    { id: "za", latlng: "-29,24" },
    //{ id: "zr", latlng: "0,25" },
    { id: "zw", latlng: "-20,30" }-->

    <!--only interested in participating orgs - Assummed that reporting org is participating <xsl:key name="reporting-orgs" match="reporting-org|participating-org" use="@ref"/> -->
  <xsl:key name="participating-orgs" match="participating-org" use="@ref"/>
<xsl:key name="policy-marker" match="policy-marker" use="."/>
<xsl:key name="countries" match="recipient-country" use="@code"/>
<xsl:key name="sector" match="sector" use="@code"/>
<xsl:template match="/">

<xsl:text>{
 "properties": {
   "participating-org" : {
     "valueType":"item",
     "label":"Participating Organisation",
     "pluralLabel":"Participating Organisations"
    },
   "title": {
     "valueType":"text",
     "label" : "Title"	     
   },
   "title-link": {
     "valueType":"item",
     "label" : "Activity"	     
   },
   "iati-identifier": {
     "valueType":"text",
     "label" : "IATI\nIdentifier"	     
   },
   "transaction-restricted": {
     "valueType":"number",
     "label" : "Expenditure\n(Restricted)"	     
   },
   "transaction-unrestricted": {
     "valueType":"number",
     "label" : "Expenditure\n(Unrestricted)"	     
   },
   "table": {
     "valueType":"text",
     "label" : "Main Funded Partners in Country"	     
   },
   "uri": {
     "valueType":"text",
     "label" : "Country Programme Website"	     
   },
   "reporting-org": {
     "valueType":"item",
     "label" : "Reporting organisation"	     
   },
   "funding-org": {
     "valueType":"item",
     "label" : "Funding organisation"	     
   },
   "components": {
      "valueType":"item",
      "label":"Project Components"
   },
   "parents": {
      "valueType":"item",
      "label":"Parent Project"
   },
   "siblings": {
      "valueType":"item",
      "label":"Related Components/Projects"
   },
   "policy-marker": {
      "valueType":"item",
      "label":"Thematic Focus"
   },
   "sector": {
      "valueType":"text",
      "label":"Sector"
   },
   "start-date-actual": {
      "valueType":"date",
      "label":"Start Date\n(Actual)"
   },
   "end-date-actual": {
      "valueType":"date",
      "label":"End Date\n(Actual)"
   },
   "start-date-planned": {
      "valueType":"date",
      "label":"Start Date\n(Planned)"
   },
   "end-date-planned": {
      "valueType":"date",
      "label":"End Date\n(Planned)"
   },
   "recipient-region": {
      "valueType":"item",
      "label":"Recipient Region"
   },
   "recipient-country": {
      "valueType":"item",
      "label":"Recipient Country"
   },
   "default-aid-type": {
      "valueType":"text",
      "label":"Default Aid Type"
   },
   "total-commitments-current": {
		"valueType":"number",
		"label":"Commitments"
   },
   "total-expenditure-current": {
	"valueType":"number",
	"label":"Expenditure"
   },
   "total-disbursment-current": {
 	"valueType":"number",
	"label":"Disbursments"
   },
   "total-reimbursment-current": {
	"valueType":"number",
	"label":"Reimbursment"
   },
   "total-incoming-funds-current": {
	"valueType":"number",
	"label":"Incoming"
   },
   "total-loan-repayment-current": {
	"valueType":"number",
	"label":"Loan Repayment"
   },
   "total-interest-repayment-current": {
	"valueType":"number",
	"label":"Interest Repayment"
   },
   "total-commitments-previous": {
		"valueType":"number",
		"label":"Commitments\n(2009-2010)"
   },
   "total-expenditure-previous": {
	"valueType":"number",
	"label":"Expenditure\n(2009-2010)"
   },
   "total-disbursment-previous": {
 	"valueType":"number",
	"label":"Disbursments\n(2009-2010)"
   },
   "total-reimbursment-previous": {
	"valueType":"number",
	"label":"Reimbursment\n(2009-2010)"
   },
   "total-incoming-funds-previous": {
	"valueType":"number",
	"label":"Incoming\n(2009-2010)"
   },
   "total-loan-repayment-previous": {
	"valueType":"number",
	"label":"Loan Repayment\n(2009-2010)"
   },
   "total-interest-repayment-previous": {
	"valueType":"number",
	"label":"Interest Repayment\n(2009-2010)"
   }


  },
"items": 
  [</xsl:text>
<xsl:for-each select="/exist:result">
	<xsl:text>{</xsl:text> "type":"summary",
		"id":"query-summary",
		"label":"Data Summary",	
		"label":"Showing <xsl:value-of select="@exist:count"/> of <xsl:value-of select="@exist:hits"/> projects or components."	
	<xsl:text>},
	  </xsl:text>
</xsl:for-each>

  <xsl:for-each select="//iati-activity">
  <xsl:variable name="currency">
    <xsl:value-of select="@default-currency"/>
  </xsl:variable>  
  
  <xsl:text>{</xsl:text> "type":"activity",
    "id":"<xsl:value-of select="iati-identifier"/>",
    "label":"<xsl:value-of select="translate(title,'&quot;','-')"/>",<!--<xsl:value-of select="iati-identifier"/>",-->
    "iati-identifier":"<xsl:value-of select="iati-identifier"/>",
    "title-link":"<xsl:value-of select="iati-identifier"/>",
    "title":"<xsl:value-of select="translate(title,'&quot;','-')"/>",
    "uri":"<xsl:call-template name="urlPattern"><xsl:with-param name="activity" select="."/></xsl:call-template>",
    "type":"<xsl:call-template name="hierarchy"> <xsl:with-param name="hierarchy" select="@hierarchy"/></xsl:call-template>",
    "description":"<xsl:call-template name="fixedstring"><xsl:with-param name="targetVar"><xsl:value-of select="translate(description,'&quot;','-')"/></xsl:with-param><xsl:with-param name="allowablelength" select="250"/></xsl:call-template>",
    "start-date-actual":"<xsl:call-template name="iati-date"><xsl:with-param name="value" select="activity-date[@type='start-actual']"/> </xsl:call-template>",  
    "end-date-actual":"<xsl:call-template name="iati-date"><xsl:with-param name="value" select="activity-date[@type='end-actual']"/> </xsl:call-template>",  
    "start-date-planned":"<xsl:call-template name="iati-date"><xsl:with-param name="value" select="activity-date[@type='start-planned']"/> </xsl:call-template>",  
    "end-date-planned":"<xsl:call-template name="iati-date"><xsl:with-param name="value" select="activity-date[@type='end-planned']"/> </xsl:call-template>",  
    "activity-status":"<xsl:value-of select="activity-status"/>", 
    "collaboration-type":"<xsl:value-of select="collaboration-type"/>",
    "default-flow-type":"<xsl:value-of select="default-flow-type"/>", 
    "default-aid-type":"<xsl:value-of select="default-aid-type"/>", 
    "default-tied-status":"<xsl:value-of select="default-tied-status"/>", 
    "reporting-org":"<xsl:value-of select="reporting-org/@ref"/>",
	  "funding-org":[<xsl:call-template name="join"> <xsl:with-param name="valueList" select="participating-org[@role='Funding']/@ref"/> </xsl:call-template>],
    "participating-org":[<xsl:call-template name="join"> <xsl:with-param name="valueList" select="participating-org/@ref"/> </xsl:call-template>],
    "default-currency":"<xsl:value-of select="@default-currency"/>",
    "currency-note":"<xsl:value-of select="'Not available'"/>",
    "total-commitments-current":"<xsl:value-of select="sum(transaction[transaction-type/@code='C' and contains(transaction-date/@iso-date, $currentReportingYearEnd) and tied-status/@code!=3]/value)"/>",
  "total-expenditure-current":"<xsl:value-of select="sum(transaction[transaction-type/@code='E' and contains(transaction-date/@iso-date, $currentReportingYearEnd) and tied-status/@code!=3]/value)"/>",
  "total-disbursment-current":"<xsl:value-of select="sum(transaction[transaction-type/@code='D' and contains(transaction-date/@iso-date, $currentReportingYearEnd) and tied-status/@code!=3]/value)"/>",
  "total-reimbursment-current":"<xsl:value-of select="sum(transaction[transaction-type/@code='R' and contains(transaction-date/@iso-date, $currentReportingYearEnd) and tied-status/@code!=3]/value)"/>",
  "total-incoming-funds-current":"<xsl:value-of select="sum(transaction[transaction-type/@code='IF' and contains(transaction-date/@iso-date, $currentReportingYearEnd) and tied-status/@code!=3]/value)"/>",
  "total-loan-repayment-current":"<xsl:value-of select="sum(transaction[transaction-type/@code='LR' and contains(transaction-date/@iso-date, $currentReportingYearEnd) and tied-status/@code!=3]/value)"/>",
  "total-interest-repayment-current":"<xsl:value-of select="sum(transaction[transaction-type/@code='IR' and contains(transaction-date/@iso-date, $currentReportingYearEnd) and tied-status/@code!=3]/value)"/>",
  "total-commitments-previous":"<xsl:value-of select="sum(transaction[transaction-type/@code='C' and contains(transaction-date/@iso-date, $prevReportingYearEnd)]/value)"/>",
  "total-expenditure-previous":"<xsl:value-of select="sum(transaction[transaction-type/@code='E' and contains(transaction-date/@iso-date, $prevReportingYearEnd) ]/value)"/>",
  "total-disbursment-previous":"<xsl:value-of select="sum(transaction[transaction-type/@code='D' and contains(transaction-date/@iso-date, $prevReportingYearEnd)]/value)"/>",
  "total-reimbursment-previous":"<xsl:value-of select="sum(transaction[transaction-type/@code='R' and contains(transaction-date/@iso-date, $prevReportingYearEnd)]/value)"/>",
  "total-incoming-funds-previous":"<xsl:value-of select="sum(transaction[transaction-type/@code='IF' and contains(transaction-date/@iso-date, $prevReportingYearEnd)]/value)"/>",
  "total-loan-repayment-previous":"<xsl:value-of select="sum(transaction[transaction-type/@code='LR' and contains(transaction-date/@iso-date, $prevReportingYearEnd)]/value)"/>",
  "total-interest-repayment-previous":"<xsl:value-of select="sum(transaction[transaction-type/@code='IR' and contains(transaction-date/@iso-date, $prevReportingYearEnd)]/value)"/>",
  "policy-marker":[<xsl:call-template name="joinSectorsAndPolicy"> <xsl:with-param name="valueList" select="policy-marker[@significance &gt; 0]"/> </xsl:call-template>], 
    "sector":[<xsl:call-template name="joinSectorsAndPolicy"> <xsl:with-param name="valueList" select="sector"/> </xsl:call-template>], 
    "sector-amounts":[<xsl:call-template name="join"> <xsl:with-param name="valueList" select="sector/@percentage"/> </xsl:call-template>], 
    "components":[<xsl:call-template name="join"> <xsl:with-param name="valueList" select="related-activity[@type=2]/@ref"/> </xsl:call-template>],
    "parents":[<xsl:call-template name="join"> <xsl:with-param name="valueList" select="related-activity[@type=1]/@ref"/> </xsl:call-template>],
	  "latlng":"<xsl:value-of select="geocoded-latlng"/>",
  "geotype":"<xsl:value-of select="geocoded-type"/>",
    "recipient-country":"<xsl:value-of select="recipient-country"/>", 
    "recipient-region":"<xsl:value-of select="recipient-region"/>", 
    "recipient-country-code":"<xsl:value-of select="recipient-country/@code"/>",
    "transaction-restricted":"<xsl:value-of select="transaction[tied-status/@code='4']/value"/>",
    "transaction-unrestricted":"<xsl:value-of select="transaction[tied-status/@code='5']/value"/>",
  "approxLocation":"<xsl:apply-templates select='document("")//CountryLocation:codes'><xsl:with-param name="code" select="recipient-country/@code"/></xsl:apply-templates>",
  "table":'<xsl:if test="count(child::transaction/child::value) > 3">
    <xsl:element name="table">
    <xsl:attribute name="title">Transaction_Table-<xsl:value-of select="iati-identifier"/></xsl:attribute>
    <xsl:attribute name="class">transactions</xsl:attribute>
    <xsl:element name="tr">
      <xsl:element name="th" >
        <xsl:attribute name="class">transaction-receiver</xsl:attribute>Main Funded Partners in Country</xsl:element><!--th-->
      <xsl:element name="th" >
        <xsl:attribute name="class">transaction-value</xsl:attribute>Expenditure</xsl:element><!--th-->
    </xsl:element>
    <!-- tr-->
    <xsl:for-each select="transaction">
      <xsl:if test="receiver-org != ''">
        <xsl:element name="tr">
          <xsl:element name="td" >
            <xsl:attribute name="class">transaction-receiver</xsl:attribute>
            <xsl:element name="span" >
              <xsl:attribute name="class">organisation</xsl:attribute>
              <xsl:attribute name="id">
                <xsl:value-of select="receiver-org/@ref"></xsl:value-of>
              </xsl:attribute>
              <xsl:value-of select="receiver-org"/>
            </xsl:element>
            <!--span-->
          </xsl:element>
          <!--td-->
          <xsl:element name="td" >
            <xsl:attribute name="class">transaction-value</xsl:attribute>
            <!-- Note, at the moment we're only handling for the default currency -->
            <xsl:call-template name="formatCurrency">
              <xsl:with-param name="currency" select="$currency"/>
              <xsl:with-param name="value" select="value"/>
            </xsl:call-template>
          </xsl:element>
          <!--td-->
        </xsl:element>
        <!--tr-->
      </xsl:if>
    </xsl:for-each>
  </xsl:element>
  <!--table-->
</xsl:if>',
  "last-updated-datetime":"<xsl:value-of select="@last-updated-datetime"/>"
  <xsl:text>},
  </xsl:text>   
</xsl:for-each>

<!--Pull out each unique reporting for each organisation that is listed in the file and create data for them-->
<!-- before, but we only want participating orgs!<xsl:for-each select="//reporting-org[generate-id() = generate-id(key('reporting-orgs',@ref)[1])]|//participating-org[generate-id() = generate-id(key('reporting-orgs',@ref)[1])]">-->
  <xsl:for-each select="//participating-org[generate-id() = generate-id(key('participating-orgs',@ref)[1])]">
  <xsl:text>
{</xsl:text> "type":"organisation",
  "id":"<xsl:value-of select="@ref"/>",
  "label":"<xsl:value-of select="translate(.,'&quot;','')"/>",
  "code":"<xsl:value-of select="@ref"/>"<xsl:if test="@role != 'Funding'">,
  "countryOfOperation":"<xsl:value-of select="parent::*/recipient-country"></xsl:value-of>"</xsl:if><!--figure out how to make linkable! Maybe title will help along as this is the label?title-->
<xsl:if test="position() != last()"><xsl:text>
},</xsl:text></xsl:if><xsl:if test="position() = last()"><xsl:text>
},</xsl:text></xsl:if>
</xsl:for-each>

<!--Pull out each unique country and create data for them-->
<xsl:for-each select="//recipient-country[generate-id() = generate-id(key('countries',@code)[1])]">
  <xsl:text>{</xsl:text> "type":"country",
  "id":"<xsl:value-of select="@code"/>",
  "label":"<xsl:value-of select="."/>"
  <xsl:if test="position() != last()"><xsl:text>},</xsl:text></xsl:if><xsl:if test="position() = last()"><xsl:text>}</xsl:text></xsl:if>
</xsl:for-each>

<!--Pull out each unique policy marker and create items for them-->
<xsl:for-each select="//policy-marker[generate-id() = generate-id(key('policy-marker',.)[1])]">
  <xsl:if test="position() = 1">,</xsl:if>
  <xsl:text>{</xsl:text> "type":"policy-marker",
  "id":"<xsl:value-of select="concat(@vocabulary,'-',@code)"/>",
  "vocabulary":"<xsl:value-of select="@vocabulary"/>",
  "code":"<xsl:value-of select="@code"/>",
  "label":"<xsl:value-of select="."/>"
  <xsl:if test="position() != last()"><xsl:text>},</xsl:text></xsl:if><xsl:if test="position() = last()"><xsl:text>}</xsl:text></xsl:if>
</xsl:for-each>

<!--Pull out each unique policy marker and create items for them-->
<xsl:for-each select="//sector[generate-id() = generate-id(key('sector',@code)[1])]">
  <xsl:if test="position() = 1">,</xsl:if>
  <xsl:text>{</xsl:text> "type":"sector",
  "id":"<xsl:value-of select="@vocabulary"/>-<xsl:value-of select="@code"/>",
  "vocabulary":"<xsl:value-of select="@vocabulary"/>",
  "code":"<xsl:value-of select="@code"/>",
  "label":"<xsl:value-of select="."/>"
  <xsl:if test="position() != last()"><xsl:text>},</xsl:text></xsl:if><xsl:if test="position() = last()"><xsl:text>}</xsl:text></xsl:if>
</xsl:for-each>
  <xsl:text>]}</xsl:text>
</xsl:template>

<xsl:template name="joinSectorsAndPolicy" >
   <xsl:param name="valueList" select="''"/>
   <xsl:for-each select="$valueList">
     <xsl:choose>
       <xsl:when test="position() = 1">
         <xsl:value-of select="concat('&quot;',./@vocabulary,'-',./@code,'-',parent::*/sector,'&quot;')"/>
       </xsl:when>
       <xsl:otherwise>
         <xsl:value-of select="concat(',','&quot;',./@vocabulary,'-',./@code,'-',parent::*/sector,'&quot;') "/>
       </xsl:otherwise>
     </xsl:choose>
   </xsl:for-each>
 </xsl:template>
 
 <xsl:template name="fixedstring">
  <xsl:param name="targetVar"/>
  <xsl:param name="allowablelength"/>
  <xsl:value-of select="substring($targetVar, 1, $allowablelength)"/>
  <xsl:if test="string-length($targetVar) &gt; $allowablelength">
    <xsl:text>...</xsl:text>
  </xsl:if>
</xsl:template>
 




 <xsl:template name="urlPattern"><!--Designed to be extended to provide authoritative URLs for different IATI Providing organisations. We trust our authoritative URIs over activity-website in most cases -->
   <xsl:param name="activity" select="''"/>
	   <xsl:choose>
	     <xsl:when test="$activity/reporting-org/@ref = 'GB-1'"><!--DFID-->
	       <xsl:value-of select="concat('http://projects.dfid.gov.uk/project.aspx?Project=',substring($activity/iati-identifier,6,6))"/>
	     </xsl:when>
	     <xsl:when test="$activity/reporting-org/@ref = '44000'"><!--World Bank-->
			<xsl:value-of select="$activity/activity-website" />
	     </xsl:when>
	     <xsl:otherwise>
			<xsl:if test="$activity/activity-website"><!--Other-->
				<xsl:value-of select="$activity/activity-website" />
			</xsl:if>
			<xsl:if test="not($activity/activity-website)">
	       		<xsl:value-of select="concat('#',$activity/iati-identifier)" />				
			</xsl:if>
	     </xsl:otherwise>
	   </xsl:choose>
 </xsl:template>

 <xsl:template name="join" >
    <xsl:param name="valueList" select="''"/>
    <xsl:for-each select="$valueList">
      <xsl:choose>
        <xsl:when test="position() = 1">
          <xsl:value-of select="concat('&quot;',.,'&quot;')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="concat(',','&quot;',.,'&quot;') "/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>


<!--IATI Dates could be found in @iso-date or in the node. This checks for the former, and if not available, uses the later-->
<!--We assume an ISO-Date in YYYY-MM-DD format which is what IATIStandard.org describes, so use substring to fetch this. -->
<xsl:template name="iati-date">
  <xsl:param name="value" select="''"/> 
  <xsl:choose>
  	<xsl:when test="$value/@iso-date"><xsl:value-of select="substring($value/@iso-date,1,10)" /></xsl:when>
  	<xsl:otherwise><xsl:value-of select="substring($value,1,10)" /></xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="hierarchy">
  <xsl:param name="hierarchy" select="''"/> 
  <xsl:choose>
  	<xsl:when test="1">project</xsl:when>
  	<xsl:when test="2">component</xsl:when>
    <!--    <xsl:when test="3">country program</xsl:when>
    <xsl:when test="4">region</xsl:when>-->
  	<xsl:otherwise>component</xsl:otherwise>
  </xsl:choose>
</xsl:template>





</xsl:stylesheet>
