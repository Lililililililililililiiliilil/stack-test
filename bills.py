directories = {}
payments = set()

with open('чеки.txt') as f:
    for line in f:
        month = line.split("_")[1].split(".")[0]
        pay = line.split("_")[0]
        payments.add(pay)
        if month in directories:
            directories[month].append(pay)
        else:
            directories[month] = [pay]

new_file = open("чеки_по_папкам.txt", "w")

for key in directories:
    for value in directories[key]:
        new_file.write("/" + key + "/" + value + "_" + key + ".pdf\n")

new_file.write("не оплачено:\n")

for key in directories:
    debt = payments.difference(set(directories[key]))
    if len(debt) > 0:
        new_file.write(key + ":\n")
        for item in debt:
            new_file.write(" " + item + "\n")

new_file.close()
