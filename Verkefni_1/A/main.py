import json

jsonOutput = {}

def main():
    while True:
        path = "resources/The_Frozen_Dead_S01E01_ENGLISH.srt"
        language = input("Language: ").lower()
        while True:
            result = input('Use default date/studio/translators? (y/n): ')
            if result == '' or not result.lower() in ['y','n']:print('Please answer with y or n')
            else: break
        if result.lower() == 'y':
            date = "01-01-2019"
            studio = "Media Subtitle Studio"
            translators = ["Oscar Johnson"]
        else:
            date = input("Date: ")
            studio = input("Studio: ")
            translators = input("Translators (split with ','): ").title().split(",")

        print("Working...")
        if buildTree(date, studio, translators, language): print("Building tree for language worked")
        else:
            print("Building tree for language failed")
            break
        if convertToDict(path, language): print("Converting srt to dictionary worked")
        else:
            print("Converting srt to dictionary failed")
            break
        print("Success!")

        while True:
            result = input('Add another language? (y/n): ')
            if result == '' or not result.lower() in ['y','n']:print('Please answer with y or n')
            else: break
        if result.lower() == 'y':
            print("Continuing...")
        else:
            print("Ok")
            with open('GENERATED_The_Frozen_Dead_S01E01.json', 'w') as file: json.dump(jsonOutput, file)
            break



# Options
# path = "The_Frozen_Dead_S01E01_ENGLISH.srt"
# language = "english"
# date = "01-01-2019"
# studio = "Media Subtitle Studio"
# translators = ["Oscar Johnson"]

# Foundation

def buildTree(date, studio, translators, language):
    try:
        jsonOutput[language] = {}
        jsonOutput[language]['date'] = date
        jsonOutput[language]['studio'] = studio
        jsonOutput[language]['translators'] = translators
        jsonOutput[language]['id'] = {}
        return True
    except:
        return False

# Statuses
# 1: ID
# 2: Timestamps
# >2: Text

def convertToDict(path, language):
    try:
        with open(path, 'r', encoding='UTF-8-SIG') as file:
            status = 0
            currID = ""
            for index, i in enumerate(file):
                status += 1
                i = i.strip()
                if status == 1:
                    currID = i
                    jsonOutput[language]['id'][currID] = {}
                elif status == 2:
                    jsonOutput[language]['id'][currID]['start'] = i.split(' --> ')[0]
                    jsonOutput[language]['id'][currID]['end'] = i.split(' --> ')[1]
                elif status > 2:
                    if len(i):
                        if "text" in jsonOutput[language]['id'][currID]: jsonOutput[language]['id'][currID]['text'] += "\n" + i
                        else: jsonOutput[language]['id'][currID]['text'] = i
                if len(i) == 0: status = 0
        return True
    except:
        return False

if __name__ == "__main__": main()
