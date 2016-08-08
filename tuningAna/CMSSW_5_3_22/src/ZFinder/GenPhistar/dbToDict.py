#!/usr/bin/python
import xmltodict
import sys
import os
from datetime import date

#####################################################################################################
def makeData(command, dict, dataList = []):
    numVals = 0
    valString = ""
    vals = list(command)
    vals.reverse()
    vals.pop()
    vals.pop()
    vals.pop()
    vals.pop()
    vals.reverse()
  #  print vals
  #  print command
    for val in vals:
        valString += (val+" ")
        numVals = numVals + 1
    valString = valString.strip()
    dataDict = {'@elements':str(numVals),'@encoding':'dec','@card':command[2],'@qie':command[3],'#text':valString}
    rbxLocation = findRBX(command[1], dict)
    if rbxLocation == -1:
        print "RBX not found"
        return dataList;

    for data in dict["CFGBrickSet"]["CFGBrick"][rbxLocation]["Data"]:
        if int(data['@card']) == int(command[2]) and int(data['@qie']) == int(command[3]):
            print "Changed: "+data['#text']
            data['#text'] = valString
            print "To: "+valString
            return dataList;
    dataList.append(dataDict)
    return dataList;
#####################################################################################################
def makeRBXBrick(command, dict):
    today = str(date.today())
    tag = str(raw_input("Please give the db tag: "))
    if len(tag) == 0:
        tag = "unspecified"
    type = str(raw_input("Please give the info type (e.g. PEDESTAL): "))
    if len(type) == 0:
        type = "unspecified"
    rbxName = command[1]
    nameDict = {'@name':'RBX','@type':'string','#text':rbxName}
    typeDict = {'@name':'INFOTYPE','@type':'string','#text':type}
    tagDict = {'@name':'CREATIONTAG','@type':'string','#text':tag}
    timeDict = {'@name':'CREATIONSTAMP','@type':'string','#text':today}
    data = []
    newRBXdict = {'Parameter':[nameDict,typeDict,tagDict,timeDict], 'Data':data}
    dict["CFGBrickSet"]["CFGBrick"].append(newRBXdict)
  #  print "Now the db looks like:\n"+xmltodict.unparse(dict, pretty=True)
    return dict;
######################################################################################################
def findRBX(rbxName, dict):
    rbxLoc = -1
    found = False
   # print "Looking for RBX: "+rbxName
    for rbx in  dict["CFGBrickSet"]["CFGBrick"]:
    #    print "RBX in DB: "+rbx["Parameter"][0]['#text']
        if rbx["Parameter"][0]['#text'] == rbxName:
            rbxLoc = rbxLoc+1
            found = True
            break
        rbxLoc = rbxLoc+1
    if not found:
        print "RBX not found in database"
        return -1;
  #  print "Found RBX in brick: "+str(rbxLoc+1)
    return rbxLoc;
#################################################################################################
def rbxList(dict):
    for rbx in  dict["CFGBrickSet"]["CFGBrick"]:
        print "RBX in DB: "+rbx["Parameter"][0]['#text']
    return;
def read(command, dict):
    rbxLocation = findRBX(command[1], dict)
    if rbxLocation == -1:
        return;
    for data in dict["CFGBrickSet"]["CFGBrick"][rbxLocation]["Data"]:
        if int(data['@card']) == int(command[2]) and int(data['@qie']) == int(command[3]):
            print dict["CFGBrickSet"]["CFGBrick"][rbxLocation]["Parameter"][1]['#text']+" in Card: "+command[2]+" QIE: "+command[3]+" is: "+data['#text']
            return;
    print "Card: "+command[2]+" or QIE: "+command[3]+" for RBX: "+command[1]+" not found in database."
    return;
################################################################################################
def edit(command, dict):
    rbxBrick = findRBX(command[1], dict)
    dict = dict
    if rbxBrick == -1:
        choice = str(raw_input("Create new RBX cfg brick? (y/anything): "))
        if(choice == "y"):
            print "Creating RBX cfg brick with RBX name: "+command[1]
            dict = makeRBXBrick(command, dict)
            edit(command, dict)
        else:
            return dict;

    dict["CFGBrickSet"]["CFGBrick"][rbxBrick]["Data"] = makeData(command, dict, dict["CFGBrickSet"]["CFGBrick"][rbxBrick]["Data"])   
 #   print "Just added to data list:"
 #   print makeData(command, dict, dict["CFGBrickSet"]["CFGBrick"][rbxBrick]["Data"])
 #   print dict["CFGBrickSet"]["CFGBrick"][rbxBrick]["Data"]
 #   print "end block"
 #   print "Here is the new dict"
 #   print dict
 #   print xmltodict.unparse(dict, pretty=True)
    return dict;
#########################################################################################
def cleanString(fileText):
    
    lines = fileText.splitlines()
    reversed = True
    foundParamBlock = False
    foundDataBlock = False
    newBrick = False
    dataStart = -1
    paramStart = -1
    fixedLines = list(lines)
    for i, line in enumerate(lines):
        if "<CFGBrick>" in line:
            reversed = False
            foundParamBlock = False    #resets search
            foundDataBlock = False
        if "Parameter" in line:
            if not foundParamBlock:
                paramStart = i
                foundParamBlock = True
        if ("Data" in line):
            if not foundParamBlock:
                reversed = True
            if not foundDataBlock:
                dataStart = i
                foundDataBlock = True
        if reversed and ("</CFGBrick>" in line):
            fixedLines.insert(dataStart, fixedLines.pop(paramStart))
            fixedLines.insert(dataStart+1, fixedLines.pop(paramStart+1))
            fixedLines.insert(dataStart+2, fixedLines.pop(paramStart+2))
            fixedLines.insert(dataStart+3, fixedLines.pop(paramStart+3))
        newBrick = False
    newString = ""
    for line in fixedLines:
        newString += (line+"\n")
    return newString;
#########################################################################################
def editDB(xmlFileName, commandFileName = "notGiven"):
    xmlFile = open(xmlFileName)
    commandFile = open(commandFileName)
    original_db = xmlFile.read()
    xmlFile.close()
    dbDict = xmltodict.parse(original_db)
    usrIn = "CHEESE"
    input = "frenchCHEese"
    if not commandFile == "notGiven":
        print "Reading in commands from: "+commandFileName
        usrIn = commandFile.readline().strip()
        print "Command: "+usrIn
    else: 
        usrIn = str(raw_input("Enter Command [HELP]: "))
    while usrIn != "DONE" :
        skip = False
        if (len(usrIn) < 1) | (usrIn == "HELP"):
            print "To Edit: EDIT <RBXNAME> <CARD> <QIE> <VALUE(s)>"
            print "To Read: READ <RBXNAME> <CARD> <QIE>"
            print "To Write Out: WRITE <FILENAME.XML"+"="+xmlFileName+">"
            print "To Print DB To Screen: PRINT"
            print "To Print RBX List: RBXLIST"
            print "To Finish: DONE"
            skip=True
        if skip:
            usrIn = str(raw_input("What next (HELP): "))
            continue
        usrCommand = usrIn.split(" ")
   #     print usrCommand
        if(usrCommand[0]=="READ" and len(usrCommand) == 4):
            read(usrCommand, dbDict)
        elif(usrCommand[0]=="EDIT" and len(usrCommand) >= 5):
            if not (len(usrCommand) == 5 or len(usrCommand)==9):
                input = str(raw_input("Warning: standard databases take 5 values or 1 value, do you wish to continue anyways? (y/anything): "))
                if input == "y":
                    dbDict = edit(usrCommand, dbDict)
            else:
                newDict = edit(usrCommand, dbDict)
            #    print "DBDict fresh from editor"
            #    print newDict
        elif(usrCommand[0]=="PRINT"):
            print dbDict
            print xmltodict.unparse(dbDict, pretty=True)
        elif(usrCommand[0]=="RBXLIST"):
            rbxList(dbDict)
        elif(usrCommand[0]=="WRITE"):
            if(len(usrCommand) == 1):
                newFile = open(xmlFileName, 'w')
                newFile.write(cleanString(xmltodict.unparse(dbDict, pretty=True)))
                newFile.close()
            if(len(usrCommand) == 2):
                xmlFileName = usrCommand[1]
                newFile = open(xmlFileName, 'w')
                newFile.write(cleanString(xmltodict.unparse(dbDict, pretty=True)))
                newFile.close()
        else:
            print "Command not valid!"
        
        if not commandFile == "notGiven":
            usrIn = commandFile.readline().strip()
            print "Command: "+usrIn
        else: 
            usrIn = str(raw_input("Enter Command [HELP]: "))
    return;
############################################################################################
try: 
    sys.argv[1]
except IndexError:
    print "No file name given"
    sys.exit(1)
else:
   xmlFileName=sys.argv[1]
if not os.path.isfile(xmlFileName):
   print "File is not accesible or does not exist"
   sys.exit(1)
if len(sys.argv) == 3:
   commandFile = sys.argv[2]
   if not os.path.isfile(commandFile):
       print "Command file is not accesible or does not exist"
       sys.exit(1)
   editDB(xmlFileName, commandFile)
   sys.exit(0)
editDB(xmlFileName)
    
