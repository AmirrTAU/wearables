this code book updates and is based on:

* README.txt - "Human Activity Recognition Using Smartphones Dataset Version 1.0"
* features_info.txt - "Feature Selection"

both can be found by sourcing the prepare.R script under the newly created subfolder "/UCI HAR Dataest"

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Important intermediate Environment Variables

*fullset - a joined and tidied version of the two original training and testing sets
        * no new calculations, just the joining of input files.
        * variables: 
                * Subject_ID - the subject's identifier
                * activity - activity type
                * 561 measurement variables as described in "features_info.txt"
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Environment Variables considered as Output:

                
*fullset.means.stds - a subset of the "fullset" output, with only measurement variables that are contain mean() or std() in their names

*grp_summary - a summary of the "fullset.means.stds" output, showing the mean of each measurement variable by Subject_ID and activity 



~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
additional Environment Variables

(see description inside run_analysis.R)



