import os

def combine_sql_files(input_directory, output_file):
    # Collect all SQL files that start with "Lab1_" in the directory
    files_to_combine = sorted(
        [f for f in os.listdir(input_directory) if f.startswith("Lab2_") and f.endswith(".sql")]
    )

    with open(output_file, "w", encoding="utf-8") as output:
        for file_name in files_to_combine:
            file_path = os.path.join(input_directory, file_name)
            with open(file_path, "r", encoding="utf-8") as input_file:
                content = input_file.read()
                # Write the file name as a section header
                output.write(f"/*{file_name}*/\n")
                # Write the file content
                output.write(content + "\n")

# Set the input directory and output file
input_directory = "/Users/simonmikolajek/Repos/Adhoc/BazyDanych"  # Change to your folder path
output_file = "ZestawZadan3.txt"  # Specify the output file name

combine_sql_files(input_directory, output_file)
