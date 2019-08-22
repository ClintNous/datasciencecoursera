=================================================================
Goal:The run_analysis script download raw input files and converts these into a tidy data set 
=================================================================
The script consist of 6 steps:
Step 1: download and unzip the data
Step 2: Read the test data - The script reads the direct measurements specified in the 'Internial Signals' folder and summarized the values by calculating the mean and standard deviation of eacht row
Step 3: The subject and activty at eacht time stamp is added to the data set
Step 4: Step 2 and 3 are repeated for the train data
Step 5: The two trainings set are merged
Step 6: Substitute activty codes by meaningfull values 
Step 7: Create the final data set by summaring the data by taking the means of all values grouped by activity and subject