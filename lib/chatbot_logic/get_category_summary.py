import pandas as pd
df = pd.read_json('/Users/ayushpatne/Documents/Flutter/expense_tracker/lib/data/transaction2.json')


def modify_dataset():
    months_col = []
    for index, row in df.iterrows():
        date_obj = pd.to_datetime(row['date'])
        month = date_obj.month_name()
        year = date_obj.year

        months_col.append(f'{month}, {year}')

    df['month'] = months_col

    

def get_category_and_max_category(month):
    modify_dataset()
    groupby_category_df = df.drop(columns=['date']).groupby(['month', 'category'])
    groupby_category_df.sum().drop(columns=['title'])

    ls = []
    for category in ["Food", "Entertainment", "Transportation", "Shopping", "Fitness"]:
        amt = groupby_category_df.get_group((month, category)).sum()['amount']
        ls.append([category, amt])
    
    return ls, max(ls)
