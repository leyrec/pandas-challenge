'HEROES OF PYMOLI
' Dependencies and Setup
import pandas as pd

' Path to the data file )
file_to_load = "purchase_data.csv"

' Read data file and store into Pandas dataframe
df = pd.read_csv(file_to_load)
df.head(10)

'PLAYER COUNT
'Calculate the number of total players
players_count = len(df["SN"].unique())

'Place the data of total players into a DataFrame
summary_table = pd.DataFrame({"Total Players": [players_count]})

'Display the summary table
summary_table

'PURCHASING ANALYSIS (Total)

'Calculate the total number of unique items
unique_items= len(df["Item Name"].unique())

'Calculate the average price
average_price= df["Price"].mean()

'Calculate the total number of purchases
total_purchase= df["Purchase ID"].count()

'Calculate the total revenue
total_revenue = df["Price"].sum()

'Place all values in a summary table

summary_table = pd.DataFrame({"Number of Unique Items":[unique_items],
                              "Average Price":average_price,
                              "Number of Purchases":total_purchase,
                              "Total Revenue":total_revenue})

'Give format to the summary table 
summary_table["Average Price"] = summary_table["Average Price"].map("${:.2f}".format)
summary_table["Total Revenue"] = summary_table["Total Revenue"].map("${:,.2f}".format)

'Display the summary table
summary_table 

'GENDER DEMOGRAPHICS

'Create a file with unique players values
unique_df = pd.DataFrame(df.drop_duplicates(["SN"]))

'Group by Gender
gender_grouped_df = unique_df.groupby(["Gender"])

'Create a DataFrame with unique player values and grouped by gender
unique_df = pd.DataFrame({
            "Total Count":gender_grouped_df["Gender"].count(),
            "Percentage of players":gender_grouped_df["Gender"].count()/players_count*100})


'Group the DataFramed values by Gender
gender_purchase = pd.DataFrame(df).groupby(["Gender"])

'Create a new DataFrame
gender_purchase_df = pd.DataFrame({
                     "Purchase Count":gender_purchase["Price"].count(),
                     "Average Purchase Price":gender_purchase["Price"].mean(),
                     "Total Purchase Value":gender_purchase["Price"].sum(),
                     "Avg Total Purchase per Person":gender_purchase["Price"].sum()/unique_df["Total Count"]})

'Format the DataFrame
gender_purchase_df["Average Purchase Price"] = gender_purchase_df["Average Purchase Price"].map("${:.2f}".format)
gender_purchase_df["Total Purchase Value"] = gender_purchase_df["Total Purchase Value"].map("${:,.2f}".format)
gender_purchase_df["Avg Total Purchase per Person"] = gender_purchase_df["Avg Total Purchase per Person"].map("${:,.2f}".format)

'Display the DataFrame
gender_purchase_df.head()

'PURCHASING ANALYSIS

'Create a file with unique players values
unique_df = pd.DataFrame(df.drop_duplicates(["SN"]))

'Group by Gender
gender_grouped_df = unique_df.groupby(["Gender"])

'Create a DataFrame with unique player values and grouped by gender
unique_df = pd.DataFrame({
            "Total Count":gender_grouped_df["Gender"].count(),
            "Percentage of players":gender_grouped_df["Gender"].count()/players_count*100})

'Format the DataFrame
unique_df["Percentage of players"] = unique_df["Percentage of players"].map("{:.2f}%".format)
sort_unique_df = unique_df.sort_values("Total Count", ascending=False)

'Display the DataFrame
sort_unique_df.head()

'AGE DEMOGRAPHICS

'Create a new DataFrame with unique player values
age_analysis = pd.DataFrame(df.drop_duplicates(["SN"]))

'Create bins in which to place values based on Age
bins = [0, 9, 14, 19, 24, 29, 34, 39, 50]

'Create labels for the bins
group_labels= ["<10", "10-14", "15-19", "20-24", "25-29", "30-34", "35-39", "40+"]

'Slice the data and place it into bins
age_grouped = age_analysis.groupby(pd.cut(age_analysis["Age"], bins, labels=group_labels))

Total_players = sum(age_grouped["Age"].count())

'Create the names for the columns
age_demo_df = pd.DataFrame({
              "Total Count":age_grouped["SN"].count(), 
              "Percentage of Players":(age_grouped["Age"].count()/ Total_players)*100})

' Formatting the DataFrame
age_demo_df["Percentage of Players"] = age_demo_df["Percentage of Players"].map("{:,.2f}%".format)

age_demo_df

'PURCHASING ANALYSIS

'Create a new DataFrame with unique player values
purchase_analysis = pd.DataFrame(df)


'Create bins in which to place values based on Age
bins = [0, 9, 14, 19, 24, 29, 34, 39, 50]

'Create labels for the bins
group_labels= ["<10", "10-14", "15-19", "20-24", "25-29", "30-34", "35-39", "40+"]

'Slice the data and place it into bins
age_grouped = purchase_analysis.groupby(pd.cut(purchase_analysis["Age"], bins, labels=group_labels))

purchasing_analysis_df = pd.DataFrame({
              "Purchase Count":age_grouped["Item ID"].count(), 
              "Average Purchase Price":age_grouped["Price"].mean(),
              "Total Purchase Value":age_grouped["Price"].sum(),
              "Avg Total Purchase per Person": age_grouped["Price"].sum()/age_grouped["SN"].nunique()})

'Formnatting DataFrame
purchasing_analysis_df["Average Purchase Price"] = purchasing_analysis_df["Average Purchase Price"].map("${:.2f}".format)
purchasing_analysis_df["Total Purchase Value"] = purchasing_analysis_df["Total Purchase Value"].map("${:,.2f}".format)
purchasing_analysis_df["Avg Total Purchase per Person"] = purchasing_analysis_df["Avg Total Purchase per Person"].map("${:,.2f}".format)            

purchasing_analysis_df

'TOP SPENDERS

'Create a new DataFrame 
top_spenders = pd.DataFrame(df)

'Group by SN
top_spenders_grouped = top_spenders.groupby(["SN"])

'Select the DataFrame columns
top_spenders_df = pd.DataFrame({
                           "Purchase Count":top_spenders_grouped["Item ID"].count(), 
                           "Average Purchase Price":top_spenders_grouped["Price"].mean(),
                           "Total Purchase Value":top_spenders_grouped["Price"].sum()})
'Sorting by "Purchase Count" in descending order
top_spenders_df = top_spenders_df.sort_values("Total Purchase Value", ascending=False)

'Formatting the DataFrame
top_spenders_df["Average Purchase Price"] = top_spenders_df["Average Purchase Price"].map("${:,.2f}".format)
top_spenders_df["Total Purchase Value"] = top_spenders_df["Total Purchase Value"].map("${:,.2f}".format)            

top_spenders_df. head(5)

'MOST POPULAR ITEMS

'Create a new DataFrame 
popular_items = pd.DataFrame(df)

'Group by SN
popular_items_grouped = popular_items.groupby(["Item ID", "Item Name"])

'Select the DataFrame columns
popular_items_df = pd.DataFrame({
                           "Purchase Count":popular_items_grouped["Item ID"].count(), 
                           "Item Price":popular_items_grouped["Price"].mean(),
                           "Total Purchase Value":popular_items_grouped["Price"].sum()})

'Sorting by "Purchase Count" in ascending order
popular_items_df = popular_items_df.sort_values("Purchase Count", ascending=False)

'Formatting the DataFrame
popular_items_df["Item Price"] = popular_items_df["Item Price"].map("${:,.2f}".format)
popular_items_df["Total Purchase Value"] = popular_items_df["Total Purchase Value"].map("${:,.2f}".format)            

popular_items_df. head(5)

'MOST PROFITABLE ITEMS

'Create a new DataFrame 
popular_items = pd.DataFrame(df)

'Group by SN
popular_items_grouped = popular_items.groupby(["Item ID", "Item Name"])

'Select the DataFrame columns
popular_items_df = pd.DataFrame({
                           "Purchase Count":popular_items_grouped["Item ID"].count(), 
                           "Item Price":popular_items_grouped["Price"].mean(),
                           "Total Purchase Value":popular_items_grouped["Price"].sum()})

'Sorting by "Purchase Count" in ascending order
popular_items_df = popular_items_df.sort_values("Total Purchase Value", ascending=False)

'Formatting the DataFrame
popular_items_df["Item Price"] = popular_items_df["Item Price"].map("${:,.2f}".format)
popular_items_df["Total Purchase Value"] = popular_items_df["Total Purchase Value"].map("${:,.2f}".format)            

popular_items_df. head(5)








