###MD. DIDER HOSSAIN (Soli Chemistry-2020)_218203108

library(boot)
library(MASS)
library(rcompanion)
library(ggplot2)
library(gridExtra)
library(FSA)
setwd("C:/Users/bipua/OneDrive/Desktop/Soil chemistry dider 2020/R-code MD_DIDER_218203108")
combined <- read.csv("Combined treatment Cmic Nmic.csv")
combined

##checking the normality of data with graph
par(mfrow = c(2,1))
plot(density(combined$Nmic..µg..g.soil..1.))
plot(density(combined$Cmic..mg.kg.))
shapiro.test(combined$Cmic..mg.kg.)
shapiro.test(combined$Nmic..µg..g.soil..1.)

##To see the difference between median and mean
summary(combined$Cmic..mg.kg.)
summary(combined$Nmic..µg..g.soil..1.)

### Since, for Cmic value there is a significant difference between median and mean value, we will do the Cmic data transformation for getting the normal data
#Transformation for Cmic (combined treatment)

#####squareroot transformation (p value = 0.05977)
u <- combined$Cmic..mg.kg.
plotNormalHistogram(u)
u_sqrt <- sqrt(u)
summary(u_sqrt)
plotNormalHistogram(u_sqrt)
qqnorm(u_sqrt)
qqline(u_sqrt,col="red", main = "Q-Q plot for individual treatment (Cmic)", cex.main = 1)
shapiro.test(u_sqrt)

#log transformation (p value = 0.1122)
u_log <- log10(u+1)
plotNormalHistogram(u_log)
summary(u_log)
qqnorm(u_log)
qqline(u_log,col="red", main = "Q-Q plot for individual treatment (Cmic)", cex.main = 1)
shapiro.test(u_log)
# median and mean value are now closure

#Boxcox transformation (p value = 0.1168)
d = 1
u2 <- u+d #add  because the minimum value is zero
e <- boxcox(u2 ~ 1, lambda = seq(-6,6,0.3))
f <- data.frame(e$x, e$y)#this is to create the data frame from the fitting
f2 <- f[with(f,order(-f$e.y)),]#this is to sort the dataframe of c from the lowest value
#then extract the lambda
lambda <-f2[1,"e.x"]
#transform the original data
u.box <- (u^lambda - 1)/lambda ##cmic combined
plotNormalHistogram(u.box)
summary(u.box)
#### Median and mean values are now closure.
qqnorm(u.box)
qqline(u.box,col="red", main = "Q-Q plot for individual treatment (Cmic)", cex.main = 1)
shapiro.test(u.box)

#### we will use boxcox transformation due to highest p-value than other transformation
qqnorm(u.box,main = "Q-Q plot for combined treatment (Cmic)", cex.main = 1)
qqline((u.box), col= "blue")
boxplot(u.box ~ combined$Combined.Treatments, xlab = "Treatments", ylab = "Cmic (mg/kg)", main = "Combined treatment", cex.main = 1)
#For Boxcox transformationb p value is not reject null hypothesis
## Now Cmic data has normality

####Q-Q plot for Cmic and Nmic
par(mfrow = c(1,2))
qqnorm(u.box, main = "Q-Q plot for Cmic (Box-cox transformation)", cex.main = 1)
qqline((u.box), col= "blue")
qqnorm(combined$Nmic..µg..g.soil..1., main = "Q-Q plot for Nmic", cex.main = 1)
qqline((combined$Nmic..µg..g.soil..1.), col= "blue")
shapiro.test(u.box)
shapiro.test(combined$Nmic..µg..g.soil..1.)
par(oma=c(4,0,0,0))
mtext("Dider", side=1, outer=TRUE,adj=1, cex=0.6)


####Boxplot for Cmic and Nmic
par(mfrow = c(1,2))
boxplot(u.box ~ combined$Combined.Treatments, xlab = "Treatments", ylab = "Cmic (mg/kg)", main = "Combined treatment (Box-cox transformation)", cex.main = 1)
boxplot(combined$Nmic..µg..g.soil..1. ~ combined$Combined.Treatments, xlab = "Treatments", ylab = "Nmic (µg/(g.soil))", main = "Combined treatment", cex.main = 1)
par(oma=c(4,0,0,0))
mtext("Dider", side=1, outer=TRUE,adj=1, cex=0.6)


####ANOVA for Cmic and Nmic
#For Cmic
model1 <- aov(u.box ~ combined$Combined.Treatments)
summary(model1)
TukeyHSD(model1)


#For Nmic
model2 <- aov(combined$Nmic..µg..g.soil..1. ~ combined$Combined.Treatments)
summary(model2)
TukeyHSD(model2)



#######################################################################################
#### Multiple linear regression model to see the influence of fixed parameters
library(Hmisc)
library(psych)
library(car)
setwd("C:/Users/bipua/OneDrive/Desktop/Soil chemistry dider 2020/R-code MD_DIDER_218203108")
biomassvariables <- read.csv("Exp variables for Cmic and Nmic.csv", header = TRUE, na.strings = "?")
summary(biomassvariables)
biomassvariables$Cmic..mg.kg. <- as.numeric(impute(biomassvariables$Cmic..mg.kg., mean))
biomassvariables$Nmic..µg..g.soil..1. <- as.numeric(impute(biomassvariables$Nmic..µg..g.soil..1., mean))
biomassvariables$C.N.ratio.... <- as.numeric(impute(biomassvariables$C.N.ratio...., mean))
biomassvariables$Ctot.... <- as.numeric(impute(biomassvariables$Ctot...., mean))
biomassvariables$N.tot.... <- as.numeric(impute(biomassvariables$N.tot...., mean))
biomassvariables$Humus.... <- as.numeric(impute(biomassvariables$Humus...., mean))
biomassvariables$CEC..mmolc.kg. <- as.numeric(impute(biomassvariables$CEC..mmolc.kg., mean))
biomassvariables$pH..CaCl2. <- as.numeric(impute(biomassvariables$pH..CaCl2., mean))
biomassvariables$Clay.content.... <- as.numeric(impute(biomassvariables$Clay.content...., mean))
summary(biomassvariables)

# Selecting a subset of numeric variables for regression modelling
biomassvariables.sel <- subset(biomassvariables, select = c(Cmic..mg.kg., C.N.ratio...., Ctot...., N.tot...., Humus...., CEC..mmolc.kg., pH..CaCl2., Clay.content....))

#visual inspection of vars
pairs.panels(biomassvariables.sel, col="red")
par(oma=c(4,0,0,0))
mtext("Dider", side=1, outer=TRUE,adj=1, cex=0.6)



#####Develop a linear model
####For Cmic
set.seed(2017)
train.size <- 0.8
train.index <- sample.int(length(biomassvariables.sel$Cmic..mg.kg.), round(length(biomassvariables.sel$Cmic..mg.kg.) * train.size))
train.sample <- biomassvariables.sel[train.index,]
valid.sample <- biomassvariables.sel[-train.index,]

####Multiple regression model for Cmic

fit <- lm(Cmic..mg.kg. ~ C.N.ratio....+Ctot....+N.tot....+Humus....+CEC..mmolc.kg.+pH..CaCl2.+Clay.content...., data = train.sample)
summary(fit) #R2=73%

fit <- lm(Cmic..mg.kg. ~ C.N.ratio....+Ctot....+N.tot....+Humus....+pH..CaCl2.+Clay.content...., data = train.sample)
summary(fit) #R2=73%

fit <- lm(Cmic..mg.kg. ~ C.N.ratio....+Ctot....+N.tot....+Humus....+Clay.content...., data = train.sample)
summary(fit) #R2=73%
plot(fit)



####For influencing parameter on Cmic
# Selecting a subset of numeric variables for regression modelling
biomassvariables.sel <- subset(biomassvariables, select = c(Cmic..mg.kg., C.N.ratio...., Ctot...., N.tot...., Humus...., Clay.content....))

#visual inspection of vars
pairs.panels(biomassvariables.sel, col="red")
par(oma=c(4,0,0,0))
mtext("Dider", side=1, outer=TRUE,adj=1, cex=0.6)


##### VIF analysis
library(faraway)
###Cmic
setwd("C:/Users/bipua/OneDrive/Desktop/Soil chemistry dider 2020/R-code MD_DIDER_218203108")
biomassvariables <- read.csv("Exp variables for Cmic and Nmic.csv")
head(biomassvariables)
mydata <- data.frame(biomassvariables[,-1])
head(mydata)
####Checking colinearity
round(cor(mydata),3)

####Check coefficient
Cmicmodel <- lm(Cmic..mg.kg.~., mydata)
Cmicmodel
summary(Cmicmodel)
vif(Cmicmodel)


####################################################################################################################################################################################
#####Linear regression model for Nmic
# Selecting a subset of numeric variables for regression modelling
biomassvariables.sel <- subset(biomassvariables, select = c(Nmic..µg..g.soil..1., C.N.ratio...., Ctot...., N.tot...., Humus...., CEC..mmolc.kg., pH..CaCl2., Clay.content....))

#visual inspection of vars
pairs.panels(biomassvariables.sel, col="red")
par(oma=c(4,0,0,0))
mtext("Dider", side=1, outer=TRUE,adj=1, cex=0.6)



#####Develop a linear model
####For Nmic
set.seed(2017)
train.size <- 0.8
train.index <- sample.int(length(biomassvariables.sel$Nmic..µg..g.soil..1.), round(length(biomassvariables.sel$Nmic..µg..g.soil..1.) * train.size))
train.sample <- biomassvariables.sel[train.index,]
valid.sample <- biomassvariables.sel[-train.index,]

####Multiple regression model for Cmic

fit <- lm(Nmic..µg..g.soil..1. ~ C.N.ratio....+Ctot....+N.tot....+Humus....+CEC..mmolc.kg.+pH..CaCl2.+Clay.content...., data = train.sample)
summary(fit) #R2=73%

fit <- lm(Nmic..µg..g.soil..1. ~ C.N.ratio....+Ctot....+Humus....+CEC..mmolc.kg.+pH..CaCl2.+Clay.content...., data = train.sample)
summary(fit) #R2=73%

fit <- lm(Nmic..µg..g.soil..1. ~ Ctot....+Humus....+CEC..mmolc.kg.+pH..CaCl2.+Clay.content...., data = train.sample)
summary(fit) #R2=73%

fit <- lm(Nmic..µg..g.soil..1. ~ Humus....+CEC..mmolc.kg.+pH..CaCl2.+Clay.content...., data = train.sample)
summary(fit) #R2=73%

fit <- lm(Nmic..µg..g.soil..1. ~ Humus....+pH..CaCl2.+Clay.content...., data = train.sample)
summary(fit) #R2=73%
plot(fit)



####For influencing parameter on Nmic
# Selecting a subset of numeric variables for regression modelling
biomassvariables.sel <- subset(biomassvariables, select = c(Nmic..µg..g.soil..1.,Humus...., pH..CaCl2., Clay.content....))

#visual inspection of vars
pairs.panels(biomassvariables.sel, col="red")
par(oma=c(4,0,0,0))
mtext("Dider", side=1, outer=TRUE,adj=1, cex=0.6)


##### VIF analysis
library(faraway)
###Cmic
setwd("C:/Users/bipua/OneDrive/Desktop/Soil chemistry dider 2020/R-code MD_DIDER_218203108")
biomassvariables <- read.csv("Exp variables for Cmic and Nmic.csv")
head(biomassvariables)
mydata <- data.frame(biomassvariables[,-1])
head(mydata)
####Checking colinearity
round(cor(mydata),3)

####Check coefficient
Nmicmodel <- lm(Nmic..µg..g.soil..1.~., mydata)
Nmicmodel
summary(Nmicmodel)
vif(Nmicmodel)


###For explanatory variables
head(biomassvariables)
###Cmic response or Nmic response variables vs Explanatory variables
boxplot(biomassvariables$C.N.ratio.... ~ biomassvariables$Combined.Treatments, xlab = "Treatments with control", ylab = "C/N ratio (%)", main = "Combined treatment", cex.main = 1)
boxplot(biomassvariables$Ctot.... ~ biomassvariables$Combined.Treatments, xlab = "Treatments with control", ylab = "Ctot (%)", main = "Combined treatment", cex.main = 1)
boxplot(biomassvariables$N.tot.... ~ biomassvariables$Combined.Treatments, xlab = "Treatments with control", ylab = "Ntot (%)", main = "Combined treatment", cex.main = 1)
boxplot(biomassvariables$Humus.... ~ biomassvariables$Combined.Treatments, xlab = "Treatments with control", ylab = "Humus content (%)", main = "Combined treatment", cex.main = 1)
boxplot(biomassvariables$Clay.content.... ~ biomassvariables$Combined.Treatments, xlab = "Treatments with control", ylab = "clay content (%)", main = "Combined treatment", cex.main = 1)
boxplot(biomassvariables$ pH..CaCl2. ~ biomassvariables$Combined.Treatments, xlab = "Treatments with control", ylab = "pH (CaCl2)", main = "Combined treatment", cex.main = 1)

shapiro.test(biomassvariables$C.N.ratio....)#normal
#For C/N ratio
model3 <- aov(biomassvariables$C.N.ratio.... ~ biomassvariables$Combined.Treatments)
summary(model3)
TukeyHSD(model3)

shapiro.test(biomassvariables$Ctot....)
##For Ctot
###non parametric test
biomassvariables
bartlett.test(biomassvariables$Ctot....,biomassvariables$Combined.Treatments)
model4 <- kruskal.test(biomassvariables$Ctot....,biomassvariables$Combined.Treatments)
DT = dunnTest(biomassvariables$Ctot....,biomassvariables$Combined.Treatments,
              method="bh")      # Adjusts p-values for multiple comparisons;
# See ?dunnTest for options

DT

shapiro.test(biomassvariables$N.tot....)
##For Ntot
###non parametric test
biomassvariables
bartlett.test(biomassvariables$N.tot....,biomassvariables$Combined.Treatments)
model5 <- kruskal.test(biomassvariables$N.tot....,biomassvariables$Combined.Treatments)
DT = dunnTest(biomassvariables$N.tot....,biomassvariables$Combined.Treatments,
              method="bh")      # Adjusts p-values for multiple comparisons;
# See ?dunnTest for options

DT
shapiro.test(biomassvariables$Humus....)
## For Humus
##For Humus
###non parametric test
biomassvariables
bartlett.test(biomassvariables$Humus....,biomassvariables$Combined.Treatments)
model6 <- kruskal.test(biomassvariables$Humus....,biomassvariables$Combined.Treatments)
DT = dunnTest(biomassvariables$Humus....,biomassvariables$Combined.Treatments,
              method="bh")      # Adjusts p-values for multiple comparisons;
# See ?dunnTest for options

DT
shapiro.test(biomassvariables$Clay.content....)
##For clay content
###non parametric test
biomassvariables
bartlett.test(biomassvariables$Clay.content....,biomassvariables$Combined.Treatments)
model7 <- kruskal.test(biomassvariables$Clay.content....,biomassvariables$Combined.Treatments)
DT = dunnTest(biomassvariables$Clay.content....,biomassvariables$Combined.Treatments,
              method="bh")      # Adjusts p-values for multiple comparisons;
# See ?dunnTest for options

DT

shapiro.test(biomassvariables$ pH..CaCl2.)#normal
#For pH
model8 <- aov(biomassvariables$pH..CaCl2. ~ biomassvariables$Combined.Treatments)
summary(model8)
TukeyHSD(model8)

