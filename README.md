# getting_and_cleaning_data

## Files in this repo
* README.md -- Current file
* CodeBook.md -- codebook describing variables, transformations
* run_analysis.R -- actual R code

## run_analysis.R Targets

Create the R script- run_analysis.R that does the following:

1.The submitted data set is tidy.
2.The Github repo contains the required scripts.
3.GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
4.The README that explains the analysis files is clear and understandable.
5.The work submitted for this project is the work of the student who submitted it.

The script assumes it has in it's working directory and in folder: UCI HAR Dataset and the following files and folders:
* activity_labels.txt
* features.txt
* test/
* train/

The output is created in working directory with the name of gctidy.txt

## run_analysis.R walkthrough
Descriptions in sequence as per the target requirements.

* 1.The submitted data set is tidy:

  * Read all the test and training files: y_test.txt, subject_test.txt and X_test.txt; y_train.txt, subject_train.txt and X_train.txt
  * Merge the files to a data frame in the form of subjects, labels and the rest of the data.

* 2.The Github repo contains the required scripts.

  * Read the features from features.txt and filter it to only leave features that are either means ("mean()") or standard deviations ("std()").
  * A new data frame is then created that includes subjects, labels and described features.

* 3.Uses descriptive activity names to name the activities in the data set.

  * Read the activity labels from activity_labels.txt and replace labels with names.

* 4.Appropriately labels the data set with descriptive variable names.

  * Make a column list as "subjects" and "label" at the start.
  * Make tidy the list by removing all non-alphanumeric characters and converting the result to lowercase letters.
  * Apply the good-column names to the data frame.
  
* 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
    for each activity and each subject.
    
  * Create a new data frame by finding the mean for each combination of subject and label. It's done by `aggregate()` function.
  
* Finally write the new tidy set into a text file called gctidy.txt, formatted similarly to the original files.