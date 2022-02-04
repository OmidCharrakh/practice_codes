# Read the csv file
df <- read.csv(file = '/Users/omid/Documents/GitHub/Causality/causal_drafts/Models/edges_df.csv')

#------------------------------------------------
?read.csv #See the Help
nrow(df)  #Number of rows 
ncol(df) #Number of columns 
head(df, n=10) #Show the head
tail(df) #show the tail
rm(df) # To remove df

df_cols=names(df)# df column names
str(df)#Structure--data types of each column 
summary(df)# Statistical description of df

# Subseting (indexing) the dataframe 
df[3,3] 
df[1:3,1:3] 
df[c(1,3),] 
df[3,'Scores'] 

df$'Scores' # choosing a column of df (Method 1) 
df[,'Scores'] #choosing a column of df (Method2)
levels(df$'Total_Edges') # Taking the levels of a categorical variable
is.data.frame(df[1,]) #Yes => no need for drop=F
is.data.frame(df[,1, drop=F]) #No => need for drop=F

df$'Scores' * df$'Scores' # Multiply columns 
df$'New_Score' = df$'Scores' * df$'Scores' # Add a new column
df$'New_Score' = NULL # Remove a column
#Filtering and Masking
filt=df$Scores <5 & df$OA__OB==0 
df[filt,]

#-----------------------------------------------Creating and Merging new Data Frames
# Define 3 vectors
Countries_2012_Dataset <- c("Aruba","Afghanistan","Angola","Albania","United Arab Emirates","Argentina","Armenia","Antigua and Barbuda","Australia","Austria","Azerbaijan","Burundi","Belgium","Benin","Burkina Faso","Bangladesh","Bulgaria","Bahrain","Bahamas, The","Bosnia and Herzegovina","Belarus","Belize","Bermuda","Bolivia","Brazil","Barbados","Brunei Darussalam","Bhutan","Botswana","Central African Republic","Canada","Switzerland","Chile","China","Cote d'Ivoire","Cameroon","Congo, Rep.","Colombia","Comoros","Cabo Verde","Costa Rica","Cuba","Cayman Islands","Cyprus","Czech Republic","Germany","Djibouti","Denmark","Dominican Republic","Algeria","Ecuador","Egypt, Arab Rep.","Eritrea","Spain","Estonia","Ethiopia","Finland","Fiji","France","Micronesia, Fed. Sts.","Gabon","United Kingdom","Georgia","Ghana","Guinea","Gambia, The","Guinea-Bissau","Equatorial Guinea","Greece","Grenada","Greenland","Guatemala","Guam","Guyana","Hong Kong SAR, China","Honduras","Croatia","Haiti","Hungary","Indonesia","India","Ireland","Iran, Islamic Rep.","Iraq","Iceland","Israel","Italy","Jamaica","Jordan","Japan","Kazakhstan","Kenya","Kyrgyz Republic","Cambodia","Kiribati","Korea, Rep.","Kuwait","Lao PDR","Lebanon","Liberia","Libya","St. Lucia","Liechtenstein","Sri Lanka","Lesotho","Lithuania","Luxembourg","Latvia","Macao SAR, China","Morocco","Moldova","Madagascar","Maldives","Mexico","Macedonia, FYR","Mali","Malta","Myanmar","Montenegro","Mongolia","Mozambique","Mauritania","Mauritius","Malawi","Malaysia","Namibia","New Caledonia","Niger","Nigeria","Nicaragua","Netherlands","Norway","Nepal","New Zealand","Oman","Pakistan","Panama","Peru","Philippines","Papua New Guinea","Poland","Puerto Rico","Portugal","Paraguay","French Polynesia","Qatar","Romania","Russian Federation","Rwanda","Saudi Arabia","Sudan","Senegal","Singapore","Solomon Islands","Sierra Leone","El Salvador","Somalia","Serbia","South Sudan","Sao Tome and Principe","Suriname","Slovak Republic","Slovenia","Sweden","Swaziland","Seychelles","Syrian Arab Republic","Chad","Togo","Thailand","Tajikistan","Turkmenistan","Timor-Leste","Tonga","Trinidad and Tobago","Tunisia","Turkey","Tanzania","Uganda","Ukraine","Uruguay","United States","Uzbekistan","St. Vincent and the Grenadines","Venezuela, RB","Virgin Islands (U.S.)","Vietnam","Vanuatu","West Bank and Gaza","Samoa","Yemen, Rep.","South Africa","Congo, Dem. Rep.","Zambia","Zimbabwe")
Codes_2012_Dataset <- c("ABW","AFG","AGO","ALB","ARE","ARG","ARM","ATG","AUS","AUT","AZE","BDI","BEL","BEN","BFA","BGD","BGR","BHR","BHS","BIH","BLR","BLZ","BMU","BOL","BRA","BRB","BRN","BTN","BWA","CAF","CAN","CHE","CHL","CHN","CIV","CMR","COG","COL","COM","CPV","CRI","CUB","CYM","CYP","CZE","DEU","DJI","DNK","DOM","DZA","ECU","EGY","ERI","ESP","EST","ETH","FIN","FJI","FRA","FSM","GAB","GBR","GEO","GHA","GIN","GMB","GNB","GNQ","GRC","GRD","GRL","GTM","GUM","GUY","HKG","HND","HRV","HTI","HUN","IDN","IND","IRL","IRN","IRQ","ISL","ISR","ITA","JAM","JOR","JPN","KAZ","KEN","KGZ","KHM","KIR","KOR","KWT","LAO","LBN","LBR","LBY","LCA","LIE","LKA","LSO","LTU","LUX","LVA","MAC","MAR","MDA","MDG","MDV","MEX","MKD","MLI","MLT","MMR","MNE","MNG","MOZ","MRT","MUS","MWI","MYS","NAM","NCL","NER","NGA","NIC","NLD","NOR","NPL","NZL","OMN","PAK","PAN","PER","PHL","PNG","POL","PRI","PRT","PRY","PYF","QAT","ROU","RUS","RWA","SAU","SDN","SEN","SGP","SLB","SLE","SLV","SOM","SRB","SSD","STP","SUR","SVK","SVN","SWE","SWZ","SYC","SYR","TCD","TGO","THA","TJK","TKM","TLS","TON","TTO","TUN","TUR","TZA","UGA","UKR","URY","USA","UZB","VCT","VEN","VIR","VNM","VUT","PSE","WSM","YEM","ZAF","COD","ZMB","ZWE")
Regions_2012_Dataset <- c("The Americas","Asia","Africa","Europe","Middle East","The Americas","Asia","The Americas","Oceania","Europe","Asia","Africa","Europe","Africa","Africa","Asia","Europe","Middle East","The Americas","Europe","Europe","The Americas","The Americas","The Americas","The Americas","The Americas","Asia","Asia","Africa","Africa","The Americas","Europe","The Americas","Asia","Africa","Africa","Africa","The Americas","Africa","Africa","The Americas","The Americas","The Americas","Europe","Europe","Europe","Africa","Europe","The Americas","Africa","The Americas","Africa","Africa","Europe","Europe","Africa","Europe","Oceania","Europe","Oceania","Africa","Europe","Asia","Africa","Africa","Africa","Africa","Africa","Europe","The Americas","The Americas","The Americas","Oceania","The Americas","Asia","The Americas","Europe","The Americas","Europe","Asia","Asia","Europe","Middle East","Middle East","Europe","Middle East","Europe","The Americas","Middle East","Asia","Asia","Africa","Asia","Asia","Oceania","Asia","Middle East","Asia","Middle East","Africa","Africa","The Americas","Europe","Asia","Africa","Europe","Europe","Europe","Asia","Africa","Europe","Africa","Asia","The Americas","Europe","Africa","Europe","Asia","Europe","Asia","Africa","Africa","Africa","Africa","Asia","Africa","Oceania","Africa","Africa","The Americas","Europe","Europe","Asia","Oceania","Middle East","Asia","The Americas","The Americas","Asia","Oceania","Europe","The Americas","Europe","The Americas","Oceania","Middle East","Europe","Europe","Africa","Middle East","Africa","Africa","Asia","Oceania","Africa","The Americas","Africa","Europe","Africa","Africa","The Americas","Europe","Europe","Europe","Africa","Africa","Middle East","Africa","Africa","Asia","Asia","Asia","Asia","Oceania","The Americas","Africa","Europe","Africa","Africa","Europe","The Americas","The Americas","Asia","The Americas","The Americas","The Americas","Asia","Oceania","Middle East","Oceania","Middle East","Africa","Africa","Africa","Africa")
# Create mydf from the 3 vectors
mydf=data.frame(Countries_2012_Dataset, Codes_2012_Dataset, Regions_2012_Dataset)
# Change column names
colnames(mydf)=data.frame('Country','Code','Region')
# Simpler way:
mydf=data.frame(Country= Countries_2012_Dataset, 
                Code= Codes_2012_Dataset, 
                Region= Regions_2012_Dataset)
# Merging Data Frames
merged_dfs=merge(stats, mydf, 
                 by.x='Country.Code', # left dataframe  
                 by.y= 'Code')        #right dataframe


#-----------------------------------------------Visualization with qplot()

stats=read.csv('/Users/omid/Downloads/P2-Demographic-Data.csv')

qplot(data=stats, x=Internet.users, y=Birth.rate,
      size= I(2), 
      color=I('blue'), 
      geom='boxplot') #Box plot

qplot(data=merged_dfs, x=Internet.users, y=Birth.rate, #use I() to assign a value 
      color=Region, #different colors are associated different levels 
      size=I(5),    #size of marker
      shape=I(19),  #shape 
      alpha=I(0.6), #transparency 
      main='Title') 
#-----------------------------------------------Working with Vectors


v1= c(1,4,7) # Vector of doubles
v2= c(1L,4L,7L) # Vector of integers
v3= c('1','4','7') # Vector of characters

is.numeric(v1) #True
is.integer(v1) #False
is.double(v2) #True
is.character(v3) #True

seq(1,15) # sequence from 1 to 15
seq(from=1,to=15,by=2) # 1:15 with step=2
seq(from=1,to=15,length.out = 100) # 100 numbers from to 

rep(3, 50) # replicate 3 for 50 times
rep(v1, 50) # replicate vectors

v1[1] #first element
v1[1:3] #all elements
v1[-1] #all elements except first
v1[c(1,3)] #first and third elements


#-----------------------------------------------R Principles

# Data Types in R: integer, double, characters, complex, logical
typeof(x) #check data type 

First='Omid'
Last='Charrakh'
Name= paste(First, Last) #combining strings to each other

#Logical Operations: ==, !=, <, >, <=, >=, ! not , | or, & and
isTRUE(x)

#----------------------------------------------- Loops

x=rnorm(n=5, sd=8 , mean=4) #5 random numbers

# R-specific loop
for(i in x){
   print(i)
}
# Conventional loop
for(j in 1:5){
   print(x[j])
}

counter=1 # While Loop
while(counter<12){
   print(counter)
   counter=counter+1
}


x=rnorm(1) #If statement
if(x>1){
   answer='Greater than 1'
} else if(x==1){
   answer='1'
}else{
   answer='Less than 1'
}


#-----------------------------------------------Factorizing
movies <- read.csv(file = '/Users/omid/Downloads/P2-Movie-Ratings.csv')
colnames(movies)=c('Film', 'Genre', 'CriticRating', 'AudienceRating', 'BudgetMillions', 'Year')
str(movies)
summary(movies)

# "Factor" is related to categorical variables having levels. 
# Binary columns are factor variables with 2 levels.

# Factorizing Categorical Variables of Data Frame:
movies$Year=factor(movies$Year)
movies$Film=factor(movies$Film)
movies$Genre=factor(movies$Genre)
#-----------------------------------------------GGPlot2
library(ggplot2)
# Remark: each of the "summed" terms are objects and can be use like p + geom_point() 

#Add aesthetics 
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating))

#Add geometry 
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating)) + 
   geom_point()

#Add color 
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, color=Genre)) + 
   geom_point()

#Add size 
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, color=Genre, size=BudgetMillions)) + 
   geom_point()

#--------------Overriding aesthetics (original q remains the same)
q= ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, color=Genre, size=BudgetMillions)) 
#example1
q + geom_point(aes(size=CriticRating))
#example2
q + geom_point(aes(x=BudgetMillions)) +
   xlab('Budget Milions $$$')+ # update the label
   geom_line(size=.5)+ # change sizes of line and point
   geom_point(size=.1)

#--------------Mapping vs Setting
r= ggplot(data=movies, aes(x=CriticRating, y=AudienceRating))

# Two methods for adding color/changing size,...:
# 1. Mapping (what was done previously)
r+geom_point(aes(color=Genre))
# 2. Setting
r+geom_point(color='DarkGreen')
r+geom_point(size=1)

#--------------Histograms and Density Charts 
s = ggplot(data=movies, aes(x=BudgetMillions))

# Histogram (with color and boarder)
s+geom_histogram(binwidth=10, aes(fill=Genre), color='Black')
# Density Chart (with color and position)
s+geom_density(aes(fill=Genre), position='stack')

#--------------Statistical Transformations

# geom_smooth() helps the eye in seeing patterns
u = ggplot(data=movies, aes(x=CriticRating, y= AudienceRating, color= Genre))
u+ geom_point() + geom_smooth(fill=NA)

# geom_jitter() distributes randomly the points (better visualization)
w = ggplot(data=movies, aes(x=Genre, y= AudienceRating, color= Genre))
w + geom_jitter() + geom_boxplot(size=1, alpha=0.5) 

#--------------Facets (multiple plots)

# Facets for histograms:
v = ggplot(data=movies, aes(x=BudgetMillions)) + geom_histogram(binwidth=10, aes(fill=Genre), color='Black')
v + facet_grid(Genre~., scale='free')

# Facets for scatterplots:
z= ggplot(data=movies, aes(x=CriticRating, y= AudienceRating, color= Genre))
z + geom_point(aes(size=BudgetMillions/100)) + 
   geom_smooth() + # regression lines on the plot
   facet_grid(Genre~Year)+ #facet
   coord_cartesian(ylim=c(0,100)) #zoom

#--------------Theme

h= ggplot(data=movies, aes(x=BudgetMillions))+ geom_histogram(binwidth=10, aes(fill=Genre), color='Black')

h + xlab('Money Axis') + ylab('Number of Movies') + # axes labels
   ggtitle('Budget Distribution') + # figure title
   theme(axis.title.x = element_text(color='DarkGreen', size=30),
         axis.title.y = element_text(color='Red', size=30), 
         axis.text.x = element_text(size=20),
         axis.text.y = element_text(size=20),
         
         legend.title = element_text(size=30),
         legend.text = element_text(size=20),
         legend.position = c(1,1),
         legend.justification = c(1,1),
         plot.title = element_text(size=40)
         )





