#loading required libraries
library(lubridate)
library(ggplot2)
library(plotly)
library(xts)
library(dygraphs)
library(scales)

#loading the covid dataset
data <- read.csv("https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/owid-covid-data.csv")

#cleaning the data
covid=data%>%select(-c("total_cases","total_deaths","total_vaccinations","new_cases_smoothed","new_deaths_smoothed","total_cases_per_million","new_cases_smoothed_per_million","total_deaths_per_million","new_deaths_smoothed_per_million","reproduction_rate","weekly_hosp_admissions","icu_patients_per_million","hosp_patients_per_million","weekly_icu_admissions_per_million","people_fully_vaccinated","weekly_hosp_admissions_per_million","total_tests","total_tests_per_thousand","new_tests_per_thousand","new_tests_smoothed","new_tests_smoothed_per_thousand","tests_per_case","tests_units","people_vaccinated","total_boosters","new_vaccinations","new_vaccinations_smoothed","total_vaccinations_per_hundred","people_vaccinated_per_hundred","people_fully_vaccinated_per_hundred","total_boosters_per_hundred","new_vaccinations_smoothed_per_million","new_people_vaccinated_smoothed","new_people_vaccinated_smoothed_per_hundred","stringency_index","population","population_density","median_age","aged_65_older","aged_70_older","gdp_per_capita","extreme_poverty","cardiovasc_death_rate","diabetes_prevalence","female_smokers","male_smokers","handwashing_facilities","hospital_beds_per_thousand","life_expectancy","human_development_index","excess_mortality_cumulative_absolute","excess_mortality_cumulative","excess_mortality_cumulative_per_million","weekly_icu_admissions"))
Canada=covid%>%filter(location %in% c("Canada"))      

Canada[is.na(Canada)] <- 0
#Canada <- na.omit(Canada)

#converting date to 'ymd' format
Canada$date<-as.Date(Canada$date,'%Y-%m-%d')
###########################################################


#declaring variables
dates <- Canada%>%select(date)
cases <- Canada%>%select(new_cases)
deaths <- Canada%>%select(new_deaths)
icu <- Canada%>%select(icu_patients)
hosp <- Canada%>%select(hosp_patients)
tests <- Canada%>%select(new_tests)
pos_rate <- Canada%>%select(positive_rate)
###########################################################


#plotting new_cases versus date using ggplot
ggplotly(ggplot(Canada,mapping=aes(date,new_cases)) +
  geom_area(fill="#69b3a2", alpha=0.5) +
  geom_line(color="#32a6a8") +
  ggtitle("Canada: Trend of Daily New Cases over Time")+
  xlab("Date")+
  ylab("Daily New Cases") +
  scale_x_date(breaks="8 weeks",date_labels="%b %y")+
  scale_y_continuous(labels=label_number(),breaks=seq(from=0,to=900000,by=10000))+
  stat_smooth(color="#281c63",size=0.5,method='loess',se=FALSE)+
  theme(plot.title=element_text(color="#281c63", size=14, face="bold")))
###########################################################


#plotting new_deaths versus date using ggplot
ggplotly(ggplot(Canada,mapping=aes(date,new_deaths)) +
  geom_area(fill="#b282e0", alpha=0.5) +
  geom_line(color="#965ecc") +
  ggtitle("Canada: Trend of Daily New Deaths over Time")+
  xlab("Date")+
  ylab("Daily New Deaths") +
  scale_x_date(breaks="8 weeks",date_labels="%b %y")+
  scale_y_continuous(labels=label_number(),breaks=seq(from=0,to=250,by=25))+
  stat_smooth(color="#281c63",size=0.5,method='loess',se=FALSE)+
  theme(plot.title=element_text(color="#281c63", size=14, face="bold")))
###########################################################


#plotting new_cases versus new_deaths
ggplot(Canada,mapping=aes(new_cases,new_deaths))+
  geom_point(color="#ad1602")+
  geom_line(color="#fc8021")+
  ggtitle("Canada: Daily New Cases plotted against Daily New Deaths")+
  xlab("Daily New Cases")+
  ylab("Daily New Deaths") + 
  scale_x_continuous(labels=label_number(),breaks=seq(from=0,to=90000,by=10000))+
  scale_y_continuous(labels=label_number(),breaks=seq(from=0,to=250,by=25))+
  theme(plot.title=element_text(color="#281c63", size=14, face="bold"))
###########################################################


#plotting date vs excess_mortality
ex <- Canada%>%select(date,excess_mortality)
ex_mortality <- ex %>% filter(excess_mortality>0)
ggplotly(ggplot(ex_mortality,mapping=aes(date,excess_mortality)) +
 geom_area(fill="#ffc4dd", alpha=0.5) +
 geom_line(color="#e30e67") +
 ggtitle("Canada: Trend of Excess Mortality over Time")+
 xlab("Date")+
 ylab("Excess Mortality") +
 scale_x_date(breaks="8 weeks",date_labels="%b %y")+
 #scale_y_continuous(labels=label_number(),breaks=seq(from=0,to=250,by=25))+
 stat_smooth(color="#281c63",size=0.5,method='loess',se=FALSE)+
 theme(plot.title=element_text(color="#281c63", size=14, face="bold")))
###########################################################


#using Time-series analysis
#creating a univariate time-series object
uts <- ts(cases, 
           start=decimal_date(ymd("2020-01-26")),
           frequency = 365.25)

#plotting the graph for uts
ggplotly(ggplot(Canada,mapping=aes(date,uts)) +
  geom_area(fill="#94cbff", alpha=0.5) +
  geom_line(color="#323e8f") +
  ggtitle("Canada: Univariate Time-Series")+
  xlab("Bi-monthly Data") +
  ylab("COVID-19 Pandemic") +
  scale_y_continuous(labels=label_number(),breaks=seq(from=0,to=900000,by=10000))+
  scale_x_date(breaks="8 weeks",date_labels="%b %y")+
  theme(plot.title=element_text(color="#281c63", size=14, face="bold")))
###########################################################


#creating an extensible time-series object
#plotting the graph for mts1
abc <- cbind(log(Canada$new_cases_per_million), Canada$new_deaths_per_million)
def <- xts(abc,order.by=Canada$date)
dygraph(def, 
        main="Canada: Multivariate Time-Series",
        xlab="Bi-monthly Data",
        ylab="Values") %>% 
  dyRangeSelector() %>% 
  dySeries("V1",color="#32a6a8",label="Log(New Daily Cases per Million People)") %>%
  dySeries("V2",color="#fc8021",label="New Daily Deaths per Million People") 



###########################################################
#forecasting model using ARIMA
library(forecast)
fit <- auto.arima(uts) #(only univariate allowed)
fit

#Forecasted values for next 6 months(181 days)
forecast(fit, 181)

#plotting the graph with next 181 forecasted values
plot(forecast(fit, 181), 
     xlab ="Yearly Data",
     ylab ="Total Positive Cases",
     main ="Canada: Predicted positive Cases of COVID-19 in the next 6 months", 
     col.main ="darkgreen",
     grid(nx=NULL, col="lightgray", lty="dotted", lwd=par("lwd"), equilogs=TRUE))


