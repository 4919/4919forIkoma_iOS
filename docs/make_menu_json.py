# -*- coding:utf-8 -*-
import csv
import pandas as pd
import os

INPUTFILE = 'es_2017_01.csv'
OUTPUTFILE = 'menu_2017_01.json'

# csvをインポート
df= pd.read_csv(INPUTFILE,encoding="SHIFT-JIS")
print df



# print(menu_csv_lines[1])
#
# output = open(OUTPUTFILE, 'w')
# output.write(df)
# output.close()
