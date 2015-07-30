### Answers exercises Session 1 EEG R workshop ###

## Subset exercise
# 1.
testoM = subset(predictors,testosterone!="NA" & sex=="m")
# you should have a dataset of 38 rows and 19 columns

# 2.
sub_testoM = subset(testoM, testosterone >1000 & badge.size>250, select=c(id,badge.size,testosterone,SVL,head.length,head.width,head.height,condition,repro.tactic,sex))
# you should have a dataset of 29 rows and 10 columns
# alternatively
sub_testoM1 = with(testoM, testoM[testosterone >1000 & badge.size>250,c(1,11:19)])


## Creating columns exercise 
# 1.
males = subset(predictors, sex=="m" & badge.PC1 !="NA")
modBadge = lm(badge.PC1 ~ badge.size,  data= males)
maleBadge_Resid = modBadge$residuals

# 2.
predictors$corr.badge.PC1 = with(predictors, ifelse(sex=="m", maleBadge_Resid, females$badge.PC1))

## Merging exercise
# 1.
sub_merge = na.omit(subset(predictors, select=c(id,throat.PC1,testosterone,head.length,head.width,head.height,sex)))

# 2. 
merge_Win = merge(sub_merge,tab_Win, by.x="id",by.y="ID",all=FALSE)

# 3.
merge_Loss = merge(sub_merge, tab_Loss, by.x="id",by.y="ID", all.y=TRUE)
