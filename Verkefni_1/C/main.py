import json
from statistics import median
from scipy.stats import truncnorm
from matplotlib import pyplot as plt
from matplotlib.pyplot import figure
from random import uniform

# Fall notað í normal curve
def get_truncated_normal(mean=0, sd=1, low=0, upp=10):
    return truncnorm((low - mean) / sd, (upp - mean) / sd, loc=mean, scale=sd)

# Breytir kommutölu í næstu "x.5" tölu
def roundNum(num):
    return round(num * 2) / 2

def main():

    # Init á dataOut json/dict
    dataOut = {
      "courses": {},
      "stats": {
        "highGrade": {
          # "grade": 10,
          # "count": 100
        },
        "lowGrade": {
          # "grade": 0,
          # "count": 100
        }#,
        # "avgGrade": 5,
        # "median": 5
      }
    }

    # Búa til normal curve (engar tölur generated)
    normalCurve = get_truncated_normal(mean=5, sd=2, low=0, upp=10)

    # Stilla glugga
    figure(num="Verkefni 1C - Pétur Steinn", figsize=(15, 8), dpi=80, facecolor='w', edgecolor='k')

    # Búa til labels og liti
    labels = ["GAGN1NG05", "GAGN2HS05", "GAGN2VG05", "GAGN3GS05", "FORR1FG05", "FORR2FA05", "FORR2HF05", "FORR3JS05", "KEST3CR05", "KEST3CS05"]
    colors = ["#e6194B", "#3cb44b", "#ffe119", "#4363d8", "#f58231", "#911eb4", "#42d4f4", "#f032e6", "#bfef45", "#fabebe", "#469990", "#e6beff", "#9A6324", "#fffac8", "#800000", "#aaffc3", "#808000", "#ffd8b1", "#000075", "#a9a9a9", "#ffffff", "#000000"]

    # Búa til lista með tölunum [1...10.5]
    bins = [float(x) for i in range(0, 11) for x in (i, i + 0.5)]

    # Sýna öll möguleg gildi á x ás
    plt.xticks(bins)

    plt.xlabel('Einkun')
    plt.ylabel('Fjöldi nemenda')

    while True:
        print("1) Random einkunnir")
        print("2) Normal curve einkunnir")
        print("q) Hætta")
        select = input("Val: ")
        if select not in ["1", "2", "q"]: print("Vitlaust valið\n")
        else:
            while True:
                saveData = input("Vista gögn? (y/n): ")
                if saveData not in ["y", "n"]: print("Vitlaust valið\n")
                else: break

            if select is "1":

                print("Random einkunnir")

                # Búa til gögn, 1000 nemendur í hverjum áfanga með random einkun frá 0 - 10
                GAGN1NG05 = [round(uniform(0, 10) * 2) / 2 for i in range(1000)]
                GAGN2HS05 = [round(uniform(0, 10) * 2) / 2 for i in range(1000)]
                GAGN2VG05 = [round(uniform(0, 10) * 2) / 2 for i in range(1000)]
                GAGN3GS05 = [round(uniform(0, 10) * 2) / 2 for i in range(1000)]
                FORR1FG05 = [round(uniform(0, 10) * 2) / 2 for i in range(1000)]
                FORR2FA05 = [round(uniform(0, 10) * 2) / 2 for i in range(1000)]
                FORR2HF05 = [round(uniform(0, 10) * 2) / 2 for i in range(1000)]
                FORR3JS05 = [round(uniform(0, 10) * 2) / 2 for i in range(1000)]
                KEST3CR05 = [round(uniform(0, 10) * 2) / 2 for i in range(1000)]
                KEST3CS05 = [round(uniform(0, 10) * 2) / 2 for i in range(1000)]

                # Setja gögn í dataOut
                dataOut['courses']['GAGN1NG05'] = GAGN1NG05
                dataOut['courses']['GAGN2HS05'] = GAGN2HS05
                dataOut['courses']['GAGN2VG05'] = GAGN2VG05
                dataOut['courses']['GAGN3GS05'] = GAGN3GS05
                dataOut['courses']['FORR1FG05'] = FORR1FG05
                dataOut['courses']['FORR2FA05'] = FORR2FA05
                dataOut['courses']['FORR2HF05'] = FORR2HF05
                dataOut['courses']['FORR3JS05'] = FORR3JS05
                dataOut['courses']['KEST3CR05'] = KEST3CR05
                dataOut['courses']['KEST3CS05'] = KEST3CS05

                # Raða upp gögnunum (histogram)
                plt.hist([GAGN1NG05, GAGN2HS05, GAGN2VG05, GAGN3GS05, FORR1FG05, FORR2FA05, FORR2HF05, FORR3JS05, KEST3CR05, KEST3CS05], bins, histtype='bar', align="left", rwidth=0.7, width=0.04, label=[i for i in labels], color=[colors[i] for i in range(10)])
                plt.title('Random einkunnir')
                plt.legend()

                # Niðurstöður sýndar
                plt.show()

            elif select is "2":
                print("Normal curve einkunnir")

                # Búa til gögn, 1000 nemendur í hverjum áfanga með normal curve einkun
                GAGN1NG05 = [roundNum(grade) for grade in normalCurve.rvs(1000)]
                GAGN2HS05 = [roundNum(grade) for grade in normalCurve.rvs(1000)]
                GAGN2VG05 = [roundNum(grade) for grade in normalCurve.rvs(1000)]
                GAGN3GS05 = [roundNum(grade) for grade in normalCurve.rvs(1000)]
                FORR1FG05 = [roundNum(grade) for grade in normalCurve.rvs(1000)]
                FORR2FA05 = [roundNum(grade) for grade in normalCurve.rvs(1000)]
                FORR2HF05 = [roundNum(grade) for grade in normalCurve.rvs(1000)]
                FORR3JS05 = [roundNum(grade) for grade in normalCurve.rvs(1000)]
                KEST3CR05 = [roundNum(grade) for grade in normalCurve.rvs(1000)]
                KEST3CS05 = [roundNum(grade) for grade in normalCurve.rvs(1000)]

                # Setja gögn í dataOut
                dataOut['courses']['GAGN1NG05'] = GAGN1NG05
                dataOut['courses']['GAGN2HS05'] = GAGN2HS05
                dataOut['courses']['GAGN2VG05'] = GAGN2VG05
                dataOut['courses']['GAGN3GS05'] = GAGN3GS05
                dataOut['courses']['FORR1FG05'] = FORR1FG05
                dataOut['courses']['FORR2FA05'] = FORR2FA05
                dataOut['courses']['FORR2HF05'] = FORR2HF05
                dataOut['courses']['FORR3JS05'] = FORR3JS05
                dataOut['courses']['KEST3CR05'] = KEST3CR05
                dataOut['courses']['KEST3CS05'] = KEST3CS05

                # Raða upp gögnunum (histogram)
                plt.hist([GAGN1NG05, GAGN2HS05, GAGN2VG05, GAGN3GS05, FORR1FG05, FORR2FA05, FORR2HF05, FORR3JS05, KEST3CR05, KEST3CS05], bins, histtype='bar', align="left", rwidth=0.7, width=0.04, label=[i for i in labels], color=[colors[i] for i in range(10)])
                plt.title('Normal curve einkunnir')
                plt.legend()
                plt.show()

            elif select is "q":
                print("Hætta...")
            print("Prenta stats...")

            # Allar einkunnir sem voru generated eru sett í totalGrades
            # svo það sé hægt að vinna með þetta á einum stað
            totalGrades = []

            # Farið í gegnum alla courses og splæst saman grades í einn lista
            for i in dataOut['courses'].values(): totalGrades += i

            # Haldið er utanum á hvaða bili eru einkunnir (þetta er alltaf 0 til 10 þegar við erum með mikið af gögnum)
            gradeRange = []

            # Farið í gegn um allar mögulegar einkunnir og athugað hvort einkunin sé til staðar
            for i in [0.0, 0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0, 5.5, 6.0, 6.5, 7.0, 7.5, 8.0, 8.5, 9.0, 9.5, 10.0]:
                if i in totalGrades: gradeRange.append(i)

            # Reiknað út og geymt stats
            highGrade = dataOut['stats']['highGrade']['grade'] = max(gradeRange)
            highGradeCount = dataOut['stats']['highGrade']['count'] = totalGrades.count(max(gradeRange))
            lowGrade = dataOut['stats']['lowGrade']['grade'] = min(gradeRange)
            lowGradeCount = dataOut['stats']['lowGrade']['count'] = totalGrades.count(min(gradeRange))
            avgGrade = dataOut['stats']['avgGrade'] = sum(totalGrades) / len(totalGrades)
            medianGrade = dataOut['stats']['median'] = median(totalGrades)

            # Prentað út general stats
            print("highGrade: {}".format(highGrade))
            print("highGradeCount: {}".format(highGradeCount))
            print("lowGrade: {}".format(lowGrade))
            print("lowGradeCount: {}".format(lowGradeCount))
            print("avgGrade: {}".format(avgGrade))
            print("medianGrade: {}".format(medianGrade))

            # Vista gögn ef notandi vill
            if saveData == "y":
                with open('GENERATED_dataOut.json', 'w') as file: json.dump(dataOut, file)

            # Hættum að keyra forritið alltaf í lokin, ekki er hægt að fara aftur í valmynd
            break

if __name__ == "__main__":
    main();
