import pyodbc

def export_binary_file(project_id, output_path):

    conn = pyodbc.connect(
        "DRIVER={ODBC Driver 17 for SQL Server};"
        "SERVER=localhost,1433;"
        "DATABASE=AdventureWorks2019;"
        "UID=sa;"
        "PWD=Password"
    )
    cursor = conn.cursor()


    query = """
    SELECT proj_umowa_plik
    FROM dbo.Projekty
    WHERE proj_id = ?
    """
    cursor.execute(query, project_id)
    row = cursor.fetchone()

    if row and row[0]:

        with open(output_path, "wb") as file:
            file.write(row[0])
        print(f"File successfully saved to {output_path}")
    else:
        print("No binary data found for the specified project ID.")


    cursor.close()
    conn.close()

project_id = 1  
output_path = "file.png"  
export_binary_file(project_id, output_path)
