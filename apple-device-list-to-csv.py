import csv

devices = []

with open('devices.txt') as f:
    lines = f.readlines()
    it = iter(lines)
    for x, y, z in zip(it, it, it):
        x = x.replace('\n', '')
        y = y.replace('\n', '')
        z = z.replace('\n', '')
        # print(f'{x},{y},{z}')
        devices.append([x, y, z])
    f.close()

header = ['name', 'identifier', 'type']
with open('devices.csv', 'w', encoding='UTF8') as f:
    writer = csv.writer(f)
    writer.writerow(header)
    writer.writerows(devices)
    f.close()
