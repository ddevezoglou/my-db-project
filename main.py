import pandas as pd
from db.connection import get_engine

engine = get_engine()
"""
query = "SELECT * FROM app.users LIMIT 5;"

df = pd.read_sql(query, engine)

print("Rows:", len(df))
print(df)

query1 = "SELECT u.id,u.name,u.surname,SUM(p.budget) AS TOTAL_BUDGET  from app.users u join app.projects p on u.id=p.user_id group by u.id,u.name,u.surname"
df1 = pd.read_sql (query1,engine)
print(df1)
"""




users_query = "SELECT * FROM app.users;"
projects_query = "SELECT * FROM app.projects;"

users_df = pd.read_sql(users_query, engine)
projects_df = pd.read_sql(projects_query, engine)

merged_df = users_df.merge(
    projects_df,
    left_on="id",
    right_on="user_id")

print("Users rows:", len(users_df))
print("Projects rows:", len(projects_df))
print("Merged rows:", len(merged_df))
print(merged_df.head())
