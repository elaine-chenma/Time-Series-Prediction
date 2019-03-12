setwd("/Users/machen/Documents/000 MSBA/442 Advanced Stat/Class 7")
rm(list=ls(all=TRUE)) 	# clear data
library("forecast")
library("tseries") 		# reqired for adf.test of stationarity

data<-read.csv("data_week.csv", sep=",",dec=".",header=T) 	# weekly data
####################################################################################################
#PCA
weather <- cbind(data$avg_cloud_index,data$avg_temp,data$avg_hours_sun)
xcor = cor(weather)

## Eigen decomposition 
out = eigen(xcor)  # eigen decomposition of correlation matrix. Yields eiganvalues and eigenvectors
va = out$values		# eigenvalues
ve = out$vectors	# eigenvectors. Each column is an eigenvector and has a unit length. 	
## Scree Plot		# to decide how many variables to keep. Look for "elbow" in the scree plot
plot(va, type = "o", col = "blue")
w1 = ve[,1]	
weather_col = weather %*% w1
new_weather <- cbind(data$yearweek,data$id_week,data$netsales_online,weather_col)
colnames(new_weather) <- c("yearsweek","id_week","netsales_online","weather")

####################################################################################################
#step-by-step ARIMA (p,d,q) models for sales series
weather_col = new_weather[,4]	
#temp = data[,11]				# centigrade
yy = ts(weather_col, frequency = 52,start = c(2015,1))		# coverts sales data as time series object with start date and frequency (weekly here)
## check the stationary of the time series  
# Use Augmented Dickey-Fuller Test to test stationarity == > large p-value means nonstationary
plot.ts(yy)							
adf.test(yy)						
yd = diff(yy,differences = 1)			
plot.ts(yd)			# looks stationary visually
adf.test(yd)		# estimated p = 0.01 ==> small pvalue (< 0.10) ==> so yd is stationary ==> fix d = 1 in ARIMA models to be fitted
#####auto arima result
m = auto.arima(yy)		# fits ARIMA(p,d,q) x (P, D, Q) automatically
summary(m)

m.predict = forecast:::forecast.Arima(m, h = 52, level = c(68,80, 90, 95))
plot(m.predict)
##########################################################################################################
#####discover best model

## define aicc metric
AICc = function(model){
  n = model$nobs
  p = length(model$coef)
  AICc = model$aic + 2*(p+1)*(p+2)/(n-p-2)
  return(AICc)
}

evaluation = matrix(ncol=9)

for (p in 0:2){
  for (d in 0:2){
    for (q in 0:2){
      for (P in 0:1){
        for (D in 0:1){
          for (Q in 0:1){
      
      m1 <- arima(x=yy, order=c(p,d,q), seasonal = list(order=c(P,D,Q),period=52),method = 'ML') 
      evaluation = rbind(evaluation, matrix(c(p,d,q,P,D,Q,m1$aic, m1$bic, AICc(m1)), ncol=9))
      
    }}}}}}

colnames(evaluation) = c('p','d','q','P','D','Q','AIC','BIC','AICC')


evaluation[which.min(evaluation[,9]),]


### The best model is 
# "Model  2 P,D,Q  0 0 1 Seasonal  0,1,0 AIC  416.135077710408 BIC  420.848495363787 AICc  416.166327710408"
#It is not the same as the result returned by auto.arima, and it has the smallest AIC

#model 2 prediction
m2 = Arima(yy, order=c(0,0,1), seasonal = list(order = c(0,1,0), period = 52))
# fits ARIMA(p,d,q) x (P, D, Q) automatically
m2.predict = forecast:::forecast.Arima(m2, h = 52, level = c(68,80, 90, 95))
plot(m2.predict)

##########################################################################################################
####MA(t)
Acf(yd, lag.max = 10)				# # Acf suggests q = 1 

####AR(t)
Pacf(yd, lag.max = 10)					# Pacf suggests p = 1 


