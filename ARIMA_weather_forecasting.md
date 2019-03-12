### Introduction
In this report, we analyzed the [time series data of weather from January 2015 to May 2017](https://github.com/elaine-chenma/Time-Series-Prediction/blob/master/data_week.csv) by conducting Principal Component Analysis and Time Series Analysis(Check R code [here](https://github.com/elaine-chenma/Time-Series-Prediction/blob/master/ARIMA_R.R)). Autoregressive integrated moving average model is applied to fit the weather attribute with different combinations of number of time lags (p), the degree of differencing (d), order of the moving-average model (q) and seasonality. The best-fitted model is selected with criteria(AIC, BIC and AICc), compared with the result of auto.ARIMA result and used to predict future 26 weeks weather.


### Modeling

#### Principal Component Analysis
We first conducted Principal Component Analysis to reduce three variables: average cloud index data, average temperature data and average sum hours, into one variable to represent weather data. In our further analysis, we use the first Principle Component only.
#### Time Series ARIMA model
Time series data can be decomposed using the  Autoregressive integrated moving average model, which includes an explicit statistical model for the irregular component of a time series, that allows for non-zero autocorrelations in the irregular component. (1)
##### Check stationary of the model

![img](/images/Picture4.png)
![img](/images/Picture5.png)

*(Upper: Non-stationary; Lower: Stationary data by differencing one time period)*

ARIMA models require the stationary of time series. Since we started off with a non-stationary time series, our first step is to ‘difference’ the time series until obtaining a stationary time series. After differencing the original time series data by one period, we achieved stationary. The level of the differenced series stays roughly constant over time, and the variance of the series appears roughly constant over time. (1)

##### Conduct Auto.ARIMA analysis
Utilizing the auto arima function built in R, we got the best arima model as ARIMA(0,0,0)(0,1,0)[52]  with AICc 416.76.

#### Model Selection
We also compared ARIMA models with different combinations of number of time lags, the degree of differencing, order of the moving-average model and seasonality to benchmark the auto ARIMA model. **From the table below, we can see that model ARIMA(0,0,1)(0,1,0)[52] achieves the lowest AICc, which is 416.29.**

**Compared with the model selected by auto ARIMA, this model has a smaller AIC, so we will use it for weather forecasting.**

![img](/images/Picture6.png)

#### Model Interpretation
The best-fit model is ARIMA(0,0,1)(0,1,0)[52].

The MA part indicates that the regression error is moving average of one prior-period error terms whose values occurred contemporaneously and at various times in the past. (2) On the other hand the seasonal differencing captures the seasonal trend.

### Model Prediction
The weather of the future 26 weeks is predicted with the best-fit model. The time frame of the prediction is June 2017 to Dec 2017, and the forecasted weather index captures the seasonal weather trend very well.

![img](/images/Picture7.png)

### Conclusion
From above analysis, we can see that the auto arima method in R chose a well-fit model but failed to find the best-fit model. With a one order of moving average error and one order of seasonal differencing, we can well predict the future weather trend.



**Reference**
1.	https://a-little-book-of-r-for-time-series.readthedocs.io/en/latest/src/timeseries.html
2.	https://en.wikipedia.org/wiki/Autoregressive_integrated_moving_average
