# -*- coding: utf-8 -*-
import cherrypy

import os
import platform
import sys
import re
import json
from urlparse import urlparse, parse_qsl, parse_qs

import time

import MySQLdb
from MySQLdb import escape_string as esc

import datetime

start = datetime.datetime.now()

# Here import more specific classes

# Main handler of pages
class Application(object):
    def submitXML (self, longfile):
        out = ""
        while True:
            data = longfile.file.read(8192)
            if data == "":
                break
            out += data
        import xmltodict

        a = xmltodict.xml2json(out)
        data = json.loads(a)

        cnxn = MySQLdb.connect ("localhost", "root", "", "wateraid")
        cursor = cnxn.cursor()

        ind = self.AddObject (cursor, data)

        print ind

        cnxn.commit()
        cnxn.close()

        cherrypy.response.headers['Content-type'] = "application/json"
        return json.dumps (data, indent=3)
    submitXML.exposed = True

    def GetNewIndex (self, cursor):
        query = "SELECT max(ParentId) FROM Attributes;"
        cursor.execute (query)

        index = cursor.fetchone()[0]
        if index == None:
            index = 0
        else:
            index += 1

        return index

    def AddObject (self, cursor, obj):
        index = self.GetNewIndex(cursor)
        out = ""
        links = []
        
        if type (obj) == dict:
            for i in obj:
                ind = self.AddObject (cursor, obj[i])
                links.append ((i, ind))
            index = self.GetNewIndex(cursor)

        elif type (obj) == list:
            ite = 0
            for i in obj:
                ind = self.AddObject (cursor, i)
                links.append ((ite, ind))
                ite += 1
            index = self.GetNewIndex(cursor)
            self.CreateLinks (cursor, index, links)
        else:
            links = [(str(obj), index)]

        # Create the links to all the created objects  
        self.CreateLinks (cursor, index, links)

        return index

    def CreateLinks (self, cursor, fromObj, toObjs):
        for (objname, objid) in toObjs:
            query = "INSERT INTO Attributes (Name, ParentId, ChildId) VALUES ('" + esc(str(objname)) + "', " + str(fromObj) + ", " + str(objid) + ")"
            cursor.execute (query)


    def GetObject (self, objectid):
        cnxn = MySQLdb.connect ("localhost", "root", "", "wateraid")
        cursor = cnxn.cursor()

        obj = self.RetrieveObject (cursor, objectid)

        cnxn.close()
        cherrypy.response.headers['Content-type'] = "application/json"
        return json.dumps (obj, indent=3)
    GetObject.exposed = True

    def FindByAttribute (self, attribute, value):
        cnxn = MySQLdb.connect ("localhost", "root", "", "wateraid")
        cursor = cnxn.cursor()
        
        # Find all the end nodes with desired value
        query = "SELECT ParentId FROM Attributes WHERE Name LIKE '" + value + "%' AND ParentId=ChildId;"
        cursor.execute (query)

        endpoints = cursor.fetchall()

        parents = []
        for i in endpoints:
            # And now fit all of their parents with the right reference
            query = "SELECT ParentId FROM Attributes WHERE ChildId=" + str(i[0]) +" AND Name='" + str(attribute) + "';"
            cursor.execute (query)
            parents += map (lambda x : x[0], cursor.fetchall())
        cherrypy.response.headers['Content-type'] = "application/json"
        return json.dumps (parents, indent=3)
    FindByAttribute.exposed = True

        

    def RetrieveObject (self, cursor, objectid):
        query = "SELECT Name, ChildId FROM Attributes WHERE ParentId=" + str(objectid) + ";"
        cursor.execute (query)

        res = cursor.fetchall()
        print res
        if (len(res) == 1 and int(res[0][1]) == int(objectid)):
            return res[0][0]
        elif (str.isdigit (res[0][0])):
            ret = []
            for i in res:
                ret.append (self.RetrieveObject(cursor, i[1]))
            return ret
        else:
            ret = {}
            for i in res:
                ret[i[0]] = self.RetrieveObject(cursor, i[1])
            return ret

    def index(self):
        global counter
        output = ""
        output += "<h1>Welcome to the internal system on " + str(platform.uname()[1]) + "!</h1>"
        output += "Uptime: " + str(datetime.datetime.now() - start) + "<br/>"
        output += os.popen('uptime').read()
        output += '<form action="submitXML" method="POST" enctype="multipart/form-data">'
        output += '<input type="file" name="longfile" />'
        output += "<br /><input type='submit' value='Upload your XML' />"
        output += '</form>'
        output += "</body>"
        return output
    index.exposed = True


# Connections - they are a little bit confusing - not everything from static is actually static
root                    = Application()

# Start the server locally on port 80 - standard HTTP port
# Look out for the Antivirus program - if it's on server is off the limits
cherrypy.config["tools.encode.on"] = True
cherrypy.config["tools.encode.encoding"] = "utf-8"
cherrypy.server.socket_port = 80
cherrypy.server.socket_host = '0.0.0.0'
if os.name=='nt':
    cherrypy.quickstart(root, config="configWindows.txt")
else:
    cherrypy.quickstart(root, config="configLinux.txt")
