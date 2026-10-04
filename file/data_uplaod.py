#import libraries
import pandas as pd
from sqlalchemy import create_engine

#CSV file load into sql
connection_string = 'mysql+pymysql://root:root@localhost:3306/CRM'
engine = create_engine(connection_string)

files = ['accounts','data_dictionary','products','sales_pipeline','sales_teams']

for file in files:
    pat = rf"C:\Users\shobi\Documents\GitHub\CRM_sales_opportunity\data\{file}.csv"
    df = pd.read_csv(pat)
    print(df.head().to_string)
    df.to_sql(file,con=connection_string,if_exists='replace',index=False)

