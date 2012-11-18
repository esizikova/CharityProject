import xmltodict, json

fil = open("wateraidiatiorganisationdata201012.xml")
txt = fil.read()

a = xmltodict.xml2json(txt)


data = json.loads(a)['iati-organisations']['iati-organisation']
