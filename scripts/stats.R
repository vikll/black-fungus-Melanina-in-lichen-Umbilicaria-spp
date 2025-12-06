#Packages
install.packages("ggplot2")
install.packages("performance")

#Library
library(ggplot2)
library(performance)

#Data
stats.data <- read.csv("path/to/stats/EuropeGrad.csv", header = TRUE, sep = ';')
summary(stats.data)
#    Sample            Country             bracken            bwa       
# Length:149         Length:149         Min.   :0.0100   Min.   :1.070  
# Class :character   Class :character   1st Qu.:0.0900   1st Qu.:1.300  
# Mode  :character   Mode  :character   Median :0.2500   Median :1.410  
#                                       Mean   :0.4002   Mean   :1.584  
#                                       3rd Qu.:0.5100   3rd Qu.:1.750  
#                                       Max.   :2.4000   Max.   :3.780  
str(stats.data)
#'data.frame':	149 obs. of  4 variables:
# $ Sample : chr  "S11" "S12" "S13" "S14" ...
# $ Country: chr  "France" "France" "France" "France" ...
# $ bracken: num  0.49 0.62 0.74 0.24 0.22 0.7 0.17 0.18 0.29 0.37 ...
# $ bwa    : num  1.48 1.5 1.64 1.25 1.25 1.66 1.22 1.22 1.31 1.33 ...
 
bracken <- stats.data[[3]]
bwa <- stats.data[[4]]

#Normality test
shapiro.test(stats.data$bracken)
shapiro.test(stats.data$bwa)

hist(bracken)
hist(bwa)

#Correlation
cor.test(bracken, bwa, method = "spearman", data = stats.data)

#Scatterplot
tools_corr <- data.frame(bracken, bwa)
plot_tools_corr <- ggplot(tools_corr, aes(bracken, bwa)) +
  geom_point() +
  geom_smooth(method = "lm", col = "blue") + 
  labs(title = "Scattered plot",
       x = "bracken",
       y = "bwa") +
  scale_x_continuous(limits = c(0, 2.5), expand = c(0, 0)) +
  scale_y_continuous(limits = c(0, 4), expand = c(0, 0)) +
  theme_minimal()
print(plot_tools_corr)

#Linear model
model <- lm(bwa ~ bracken, data=stats.data)

coef(model)                                                           
summary(model)                                                        

#RMSE
y_pred <- predict(model)
rmse <- sqrt(mean((bwa - y_pred)^2))
rmse                                                                 

#Performance check
check_model(model)
model_performance(model)