import csv

class BtlDisco:
    def __init__(self, title, released, label, ukChartPosition, usChartPosition, bpiCertification, riaaCertification):
        self.title = title
        self.released = released
        self.label = label
        self.ukChartPosition = ukChartPosition
        self.usChartPosition = usChartPosition
        self.bpiCertification = bpiCertification
        self.riaaCertification = riaaCertification


with open('resources/beatles-discography.csv', 'r', encoding='UTF-8-sig') as file:
    reader = csv.reader(file, delimiter=',')
    next(reader, None)
    btlDiscoList = list()
    for row in reader:
        entry = BtlDisco(row[0], row[1], row[2], row[3], row[4], row[5], row[6])
        btlDiscoList.append(entry)
print(btlDiscoList[0].title)
