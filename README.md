# decoupling-co2-gdp-1970-2023
“R analysis of global CO₂ emissions and GDP from 1970–2023, exploring correlations, linear regressions, and evidence of decoupling between economic growth and carbon emissions.”

#correlation of variables

#correlation of GDP and c02 emission 
cor(`GDP per Capita`,`Annual CO₂ emissions (per capita)`)
[1] 0.7811741

#correlation of GDP per capita and C02 per Capita
> cor(World_data$`GDP (IN $)`,World_data$`Annual CO₂ emissions`)
[1] 0.9857508

#Linear Regression of variables 

#Linear Regression model of GDP per capita and C02 emissions per capita
GDPC02Capitafit<-lm(`GDP per capita`~ c02_capita, data = World_data)
summary(GDPC02Capitafit)


Residual standard error: 1008 on 10 degrees of freedom
Multiple R-squared:  0.09534,	Adjusted R-squared:  0.004879 
F-statistic: 1.054 on 1 and 10 DF,  p-value: 0.3288

#Linear Regression model of GDP and C02 Emissions 
GDPC02fit<- lm(`GDP (IN $)` ~ `Annual CO₂ emissions (per capita)` , 
data = World_data)
summary(GDPC02fit)

Residual standard error: 1.908e+13 on 52 degrees of freedom
Multiple R-squared:  0.6254,	Adjusted R-squared:  0.6182 
F-statistic: 86.83 on 1 and 52 DF,  p-value: 1.123e-12

#Split data from 1970-1997 and 1998-2023 

#correlation between GDP per capita and annual c02 emissions per capita
# within 1970-1998
cor(data1970$`GDP per Capita`,data1970$`Annual CO₂ emissions (per capita)`)
-0.3007682

#correlation between GDP and annual c02 emissions within 1970-1998
cor(data1970$`Annual CO₂ emissions`,data1970$`GDP (IN $)`)
0.9663064

#correlation between GDP per capita and annual c02 emissions per capita within
#1998-2023
cor(data1998$`Annual CO₂ emissions (per capita)`,data1998$`GDP per Capita`)
0.838506

#correlation between GDP per capita and annual c02 emissions within 1998-2023
cor(data1998$`GDP (IN $)`,data1998$`Annual CO₂ emissions`)
0.9743734

#plots 

#plot the c02 emissions per capita based on year (full data no split)
plot(
  World_data$Year,
  World_data$`Annual CO₂ emissions (per capita)`,
  xlab = "Year",
  ylab = "CO₂ emissions per capita",
  main = "Global CO2 per capita (1970–2023)"
)  

#maximum and minimum point  of c02 emissions per capita on year 1970-2023
which.max(World_data$`Annual CO₂ emissions (per capita)`)
43
which.min(World_data$`Annual CO₂ emissions (per capita)`)
1

#plot the c02 emissions per capita on year 1970-1997
plot(
  data1970$Year,
  data1970$`Annual CO₂ emissions (per capita)`,
  xlab = "Year",
  ylab = "CO₂ emissions per capita",
  main = "Global CO2 per capita (1970–1997)"
)  

#maximum and minimum point  of c02 emissions per capita on year 1970-1997
which.max(data1970$`Annual CO₂ emissions (per capita)`)
10
which.min(data1970$`Annual CO₂ emissions (per capita)`)
1

#plot the c02 emissions per capita on year 1998-2023
plot(
  data1998$Year,
  data1998$`Annual CO₂ emissions (per capita)`,
  xlab = "Year",
  ylab = "CO₂ emissions per capita",
  main = "Global CO2 per capita (1998-2023)"
)

#maximum and minimum point of c02 emissions per capita on year 1998-2023
which.max(data1998$`Annual CO₂ emissions (per capita)`)
15
which.min(data1998$`Annual CO₂ emissions (per capita)`)
1

par(mfrow(3,1))
