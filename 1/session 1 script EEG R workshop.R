        
              ##############################################
              #### EEG R workshop session 1: The basics ####
              ##############################################

## for these workshops we'll use R studio which makes R more user friendly, but everything that we'll do can be done in R itself
              
    ## 0. The very basics ##
              
## R is a calculator: type: 5+2 in the console, but you can also type it in a script (which can later be saved)
5+2 # type Ctrl + Enter with the cursor on this line
              
## but R is more than that, it's a programming language, which allows you to automate some process, analyse data etc...
x = 5+2 # creates an object'x' which value is 5+2
X
y = x+5
y

## you can also create a vector of multiple values using the c() function, for combine or concatenate
z = c(1,3,8,12,15,23,7,38,96)
z-x # this will automatically substract x to every element of z
              
## but you don't have to code everything in R, there are some in-built function for basic and more advanced functions
mean(z) # calculates the mean of z
sd(z) # calcultates the standard deviation of z
              
## most of you will use R to analyse data, so let's see how to import and play with them

              
    ## 1. Choosing the working directory ##          
              
## this is where your files are located and where your graphs and files will be saved
## 2 solutions: 1) go to 'Session' then 'Set workind directory' and then 'Choose directory', once you've done that you'll see something appearing in the Console below starting with setwd(file path)
              ##2) you can run the setwd function directly from your script        
setwd("E:/Users/Thomas/Documents/postdoc/workshops/EEG R workshop")

getwd() ## tells you where R is currently looking, you should have the file path you entered above

## if you open a new script and you've been working on something else, it's safer to clean the workspace
ls() # gives you a list of the objects in your workspace
rm(list=ls()) # removes all these objects, you can see that the 'environment' window is empty
              
              
    ## 2. Import datasets ##
              
## contests is in .csv, which is easily imported into R using either the 'Import Dataset' button on the top right of your screen (make sure to choose the right separator and decimal)
## alternatively you can type in your script:
contests = read.table("contests.csv",sep =";", header=TRUE) ## if you set your working directory you don't need the whole file path, the 'sep' argument is for the separator:";","," or "\t" (for tabulation), 'header=TRUE' means that your first row is column header
# once imported you can view the dataset by clicking on its name on the top right
## this dataset is a list of individual ID, the ID of the contest they were involved in and the outcome of the contest (1=win)
            
## let say you don't remember how to use the read.table function, you can look for help using:
?read.table ## it will open a help file on the bottom right

## different functions to explore the structure of the dataset
names(contests)# returns the names of the columns
dim(contests)# returns the dimension of the dataset, a good way to check that the importation went as planned
head(contests)# returns the first 6 rows of the dataset
tail(contests)# returns the last 6 rows of the dataset
str(contests) # returns the structure of the dataset: 'ID' is "Factor" whereas 'contestID' and 'outcome' are "integer'
## you can also get the 'str' info by clicking on the blue arrow left of 'contests' at the top left
class(contests)# returns the class of the object, 'data.frame' in this case
# some function requires specific object classes, the class() function enables you to check that the object is in the right class
matrix_contests = as.matrix(contests) # changing 'contests' into a matrix, also exists: 'as.data.frame', 'as.list' etc ...
class(matrix_contests)# this object is a matrix
              
## predictors is an Excel file, this cannot be imported directly using the 'Import Dataset' button, we need to download a package to help us doing that
## we'll install the 'readxl' package: go to 'Packages' on the bottom left, click on 'Install'
## there are 2 ways to install a package: from a compressed file (.zip, .tar.gz) or from the CRAN server, the most common is through CRAN
## type 'readxl' in the search bar and click on install
## once the package is installed, it will appear in your package library on the bottom left and we'll need to load it
## you can either check the box next to the desired package or type in your script:
library(readxl)
## that's a package we've never used before, so we may not even now which function to use, by clicking on the package name (bottom right) it opens the list of functions in the package to get help
## we want to use the 'read_excel' function
predictors = read_excel("predictors.xls", sheet=1, col_names=TRUE,na="NA") ## the 'sheet' argument allows you to choose which sheet to import, 'col_names' is equivalent to 'header',and 'na' is to say how you defined missing values
## 'id' is the individual ID, the 'PC' variable are PCA scores on colour measurements of different body parts, 'SVL' is for 'snout-to-vent length
              
names(predictors)# returns the names of the columns
dim(predictors)# returns the dimension of the dataset
head(predictors)# returns the first 6 rows of the dataset
tail(predictors)# returns the last 6 rows of the dataset
str(predictors) # returns the structure of the dataset, "chr" is for "character" and "num" for "numeric"

summary(predictors)# useful for numeric variables to have an idea of variance
## also shows you that there are NAs in some columns
pred_withoutNA = na.omit(predictors) # removes all lines with AT LEAST one NA, so be careful when using it
## another way to see if (and where) there are NAs in a column is is.na()
is.na(predictors$testosterone)# gives TRUE for NA values and FALSE for non-NA
!is.na(predictors$testosterone) # gives the reverse as before, '!' gives the negation of a logical expression
is.na(predictors$sex)# no NA in this one
              
contin_tab = table(predictors$sex,predictors$repro.tactic)# gives a contingency table for the columns 'sex' and 'repro.tactic' of the 'predictors' dataset
contin_tab ## contrary to 'predictors', which is 'data.frame', contin_tab is a 'matrix'
## you can ask R what format your object is currently in
is.matrix(contin_tab) # asks whether 'contin_tab' is a matrix
is.data.frame(predictors) # # asks whether 'predictos' is a data.frame
is.data.frame(contin_tab) # asks whether 'contin_tab' is a data.frame
## you can change the format of an object
contin_tab = as.data.frame(contin_tab) # changes 'contin_tab' in data.frame
contin_tab  

## now that we know how to install packages, a quick word about the 'swirl' package (thanks Jessie for telling me about it)
## this package contains R courses on different topics for beginners to more advanced people
## if you are looking for a way to learn how to better use R, this is probably a good start
## let's give it a quick try here, download the 'swirl' package
library(swirl) # loads the package
swirl() # opens the dialog with Swirl and follow the steps in the console !
         
              
    ## 3. Making subsets of datasets ##

  ## a. subset of lines ##
              
## let say we want to look at females only in the 'predictors' dataset, we'll use the 'subset' function
females = subset(predictors, sex=="f") # first you need to tell which dataset you are subsetting and what you want to subset
## another way to do the same thing
females1 = predictors[predicors$sex=="f",] ## here we use the [,] to tell R to select the lines for which "sex" is "f"

## a bit more complicated, looking at females with a resident 'reprod.tactic'
## first, we need to get rid of the lines for which we have 'NA' in 'repro.tactic'
tactic_withoutNA = subset(predictors,repro.tactic!="NA") ## selecting lines where 'repro.tactic' is DIFFERENT from 'NA'

resid_female = subset(tactic_withoutNA, sex=="f" & repro.tactic =="resident") ## selecting lines where 'sex' is '"f" AND where 'repro.tactic' is "resident"
## or
resid_female1 = with(tactic_withoutNA, tactic_withoutNA[sex=="f" & repro.tactic=="resident",]) ## here using with(), allows us to not used 'tactic_withoutNA$' before the column names

## to use the 'OR' logical argument, let's do a subset of resident female and floater males
resF_floatM = subset(tactic_withoutNA, (sex=="f" & repro.tactic=="resident") | (sex=="m" & repro.tactic=="floater"))
## use the 'order' function to order dataset by 'sex'
resF_floatM = resF_floatM[order(resF_floatM$sex),]
              
## now say we want to work with individuals above a certan size
big_indiv = subset(predictors, SVL > 0.10) ## select lines for which SVL is larger than 0.10
## Note: '>= 0.10' would select individuals with SVL larger or equal to 0.10
big_indiv1 = with(predictors, predictors[SVL>0.10,])              
              
  ## b. subset of columns ##
              
## if you want to work with a subset of columns of your data, say the head data:
head = subset(predictors, select = c(id,head.length,head.width,head.height))
## alternatively
head1 = predictors[,c("id","head.length","head.width","head.height")]
## or 
head2 = predictors[,c(1,14:16)] ## in [,], BEFORE the comma is for LINES and AFTER the comma is for COLUMNS, so here we select the first column + 14 to 16

   ## c. Exercise on subsets ##           
              
##  1. Remove the lines with 'NA' for 'Testosterone' for males only
##  2. Using the object created in 1., select rows with Testosterone values above 1000 and badge size above 250 and remove all columns concerning colour measurements (the .PC columns)

              
    ## 4. Creating new columns and adding them to existing datasets ##
              
boxplot(condition~repro.tactic,data=tactic_withoutNA)) ## floaters are in better condition than resident

  ## a. Using aggregate and ifelse ##            
              
## now say that we want to statistically remove this effect, by centering data within tactic
## first we use the 'aggregate' function to calculate the mean condition for each tactic
mean_CondbyTactic = with(tactic_withoutNA, aggregate(condition,by=list(repro.tactic),mean)) # aggregate works like this: aggregate("variable to aggregate",by=list("variables by which to aggregate"),function)
mean_CondbyTactic ## aggregate doesn't keep column names, let's rename this columns as we want
colnames(mean_CondbyTactic) = c("Tactic","MeanCond")
mean_CondbyTactic

## ok now we'll create a new column where we'll substract the average condition of each tactic to the condition value of each individual
tactic_withoutNA$avgCond = with(tactic_withoutNA, ifelse(repro.tactic=="floater",condition - mean_CondbyTactic$MeanCond[1], condition - mean_CondbyTactic$MeanCond[2]))
## 'ifelse()' works like the Excel 'if' function, ifelse("your condition","what to do if TRUE","what to do if FALSE")
tactic_withoutNA ## one column has been added
              
## the 'by' argument from aggregate can take more than one variable, for example:
mean_CondbyTacticSex = with(tactic_withoutNA, aggregate(condition,by=list(repro.tactic,sex),mean))
mean_CondbyTacticSex ## aggregates by tactic and sex !

  ## b. Using cbind and rbind ##
              
## you can also use the 'cbind()' function to bind columns together, let's try to add columns to the 'head' dataset
head = cbind(head,tactic_withoutNA[,c(2:4)]) # this gives you an error message because the 2 datasets don't have the same length
head = cbind(head,predictors[,c(2:4)]) # by naming this object 'head' we deleted the previous one, this can be a way to reduce the number of object you deal with, but be careful !!
              
## rbind() can be used to bind rows together, in this case the 2 dataset must have the same number of columns and which identical names
rbind_example = rbind(resid_female, big_indiv)

plot(frontleg.PC3 ~ SVL, data = predictors) # basic scatterplot of frontleg PC3 against SVL, colour score seem to increase with size
colour_model = lm(frontleg.PC3 ~ SVL, data = predictors) # linear model of frontleg PC3 against SVL
summary(colour_model) # gives all the needed info about the model, significant effect of SVL
# now say that we want to save the residuals of this model for another analysis, where to find the residuals
?lm ## look at the 'Value' section, this tells you which object are created by 'lm()'
hist(colour_model$residuals)# histogram of the residuals
Throat_SVL_resid = colour_model$residuals # creating a object with the residuals
predictors_withResid = cbind(predictors,Throat_SVL_resid) # adds the residuals
              
## just a quick word about another interesting function: apply(). It allows you to apply a function at different rows or columns of an object
## how it works: apply(dataset, 1 or 2, function to apply), 1 is for 'by line' and 2 is for 'by column'
apply(predictors[,2:16],1,mean) ## returns the mean over the column 2 to 16 for each line, as you can see there are NAs
apply(predictors[,2:16],1,mean,na.rm=TRUE)# same as before but no more NAs, na.rm = TRUE removes the NAs and allows mean to be calculated              
# this doesn't make much sense in this case because all columns are different things, but assume it does,we can add a column to the dataset
predictors_withResid$mean_pred = apply(predictors[,2:16],1,mean,na.rm=TRUE)
apply(predictors[,2:16],2,mean,na.rm=TRUE)# returns the mean per column for column 2 to 16

              
## we can export this dataset in .csv or in .txt
write.table(predictors_withResid, "new predictors file.csv",row.names=FALSE,sep=";") # creates a .csv filr with ";" separator
write.table(predictors_withResid, "new predictors file.txt",row.names=FALSE,sep="\t") # creates a .txt file with tabulation separator
              
              
  ## c. Exercise on creating new columns ##

## The researchers think that in males badge size may influence badge colour and they want to control for that.
##   1. For males only, get the residuals of the regression of badge PC1 against badge size
##   2. Create a new column for badge PC1 where it'll be the raw value for females and the residuals calculated above for males
              
    ## 5. Merging data together ##

  ## a. With the same number of 'individuals' ##
              
## R also allows you to create data.frame from scratch:
new_data = data.frame(ID = predictors$id, HeadRatio = with(predictors, head.length/head.width), NbWin = 0, NbLoss = 0)
## notice that only one value has been entered for NbWin and NbLoss, but no error message. Look at the data: R puts the value for each row
new_data

## now let's try to fill in the NbWin and NbLoss columns using the 'contests' data
Win = subset(contests, outcome==1) 
Loss = subset(contests, outcome==0)

tab_Win = with(Win, table(ID)) # gives how many times each ID appears in the data, i.e. how many times they won
tab_Win = as.data.frame(tab_Win)
tab_Loss = as.data.frame(with(Loss, table(ID))) # gives how many times each ID appears in the data, i.e. how many times they lost
## before merging with 'new_data' we need to check whether each indidivual appears in both 'tab_Win' and 'tab_Loss'
levels(tab_Win$ID) # gives the levels of factor for this variable
levels(tab_Loss$ID)
length(levels(tab_Win$ID)) # gives the number of levels for this variable, which is the same as in new_data
length(levels(tab_Loss$ID))#

## adding the Win/Loss info to new_data
new_data$NbWin = tab_Win$Freq
new_data$NbLoss = tab_Loss$Freq
## in this case, it was simple because the same individuals were present in both datasets, but that's not always the case and you also need to make sure that they are in the same order

  ## b. With different number of individuals ##
              
## we'll use the 'merge()' function to see how to properly merge datasets with unequal lengths
## for example in the 'tactic_withoutNA' dataset we removed individuals whom tactic was 'NA', so it's only 64 rows long
## let say we want to merge 'tactic_withoutNA' with 'tab_Win'
new_tactic = merge(tactic_withoutNA,tab_Win,by.x="id",by.y="ID",all=FALSE) # merge(file1, file2, by.x= "column by which to merge in file1",by.y= "column by which to merge in file2")
## have a look at the help file to understand how the 'all' argument works !!
?merge
## for instance, with all = TRUE, it'll add lines filled with NAs corresponding to the individuals not present in 'tactic_withoutNA'
new_tactic1 = merge(tactic_withoutNA,tab_Win,by.x="id",by.y="ID",all=TRUE) 
              
  ## c. Exercise on merging datasets ##
            
## You'll also need functions seen in the previous part :)
            
## 1. Make a subset of the head measurements, sex, testosterone and throat PC1 values, and keep only individuals with all variables available
## 2. Merge the previous object with tab_Win to have only lines for which values are present in the previous object
## 3. Merge the previous object with tab_Loss to keep one line per individual
              
              