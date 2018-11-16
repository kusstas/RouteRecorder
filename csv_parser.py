import csv
import glob

routes = []

csv_files = glob.glob("./*.csv")

print('Files:', csv_files)

for file_name in csv_files:
    with open(file_name, 'r') as fp:
        reader = csv.reader(fp, delimiter=',')
        data = [row for row in reader]
        routes.append(data)

print(routes)
