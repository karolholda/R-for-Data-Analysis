rm(list=ls()) #removes all variables stored previously
install.packages("Hmisc")
library(Hmisc) 

data <- read.csv("~/ANALITYKA/R/R Project Covid-19/COVID19_line_list_data.csv")
describe(data) #Hmisc command

#check missing data
colSums(is.na(data))

#cleaned up deth column
data$death_dummy <- as.integer(data$death != 0)
unique(data$death_dummy)

#total infected people
sum(data$death_dummy)

#death rate = how many people died out of total infected people
sum(data$death_dummy) / nrow(data)

#% death rate
death_rate_percent <- (sum(data$death_dummy) / nrow(data)) * 100
death_rate_percent_label <- paste0(round(death_rate_percent, 2), "%")
# Wyświetlenie wyniku
death_rate_percent_label

#AGE
#claim: people who die are older than people who survive
dead = subset(data, death_dummy == 1)
alive = subset(data, death_dummy == 0)

# 63 people died and 1022 survived out of 1085

#mean age of both groups 
mean(dead$age)
mean(dead$age, na.rm = TRUE)
#mean age of dead is 68,5 

mean(alive$age)
mean(alive$age, na.rm = TRUE)
#mean age of dead is 48

#is this statistically significant?
t.test(alive$age, dead$age, alternative="two.sided", conf.level = 0.95)
#normally, if p-value < 0.05, we reject null hypothesis
#here, p-value ~ 0, so we reject the null hypothesis and conclude that this is statistically significant

#GENDER
#claim: gender has no effect
men = subset(data, gender == "male")
woman = subset(data, gender == "female")
mean(men$death_dummy, na.rm = TRUE) #8.4%
mean(women$death_dummy, na.rm = TRUE) #3.7%
#is this statistically significant?
t.test(men$death_dummy, women$death_dummy, alternative="two.sided", conf.level = 0.99)
#99% confidence: men have from 0.8% to 8.8% higher chance of dying
#p-value = 0.002 < 0.05, so this is significant

#Age distribution for all groups
hist(data$age, breaks = 20, main = "Age Distribution
", xlab = "Age")

#demographic analysis of deaths
deaths_by_country <- aggregate(death_dummy ~ country, data, sum)
deaths_by_country <- deaths_by_country[order(-deaths_by_country$death_dummy), ]
head(deaths_by_country, 10)
barplot(
  deaths_by_country$death_dummy[1:10],
  names.arg = deaths_by_country$country[1:10],
  las = 2,
  main = "Liczba zgonów wg kraju (Top 10)",
  ylab = "Liczba zgonów"
)

symptom_counts <- table(data$symptom_onset)
hosp_counts <- table(data$hosp_visit_date)

plot(
  as.Date(names(symptom_counts), format = "%m/%d/%y"), 
  as.numeric(symptom_counts), 
  type = "l", 
  col = "blue",
  main = "Symptomy w czasie",
  xlab = "Data",
  ylab = "Liczba przypadków"
)

lines(
  as.Date(names(hosp_counts), format = "%m/%d/%y"), 
  as.numeric(hosp_counts), 
  col = "red"
)
legend("topright", legend = c("Symptomy", "Hospitalizacje"), col = c("blue", "red"), lty = 1)

logistic_model <- glm(death_dummy ~ age + gender + visiting.Wuhan + from.Wuhan, data = data, family = "binomial")
summary(logistic_model)

model <- glm(death_dummy ~ age + gender + visiting.Wuhan + from.Wuhan + symptom_onset, 
             data = data, 
             family = binomial)
summary(model)


