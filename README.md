# Time-Series-Prediction

# Predicting House Pricing of San Francisco with Time Series Model

### [Colab Link](https://drive.google.com/file/d/121CKqOmeUZZkk-1JX0jv0QO9tSQxyRbS/view?usp=sharing)
### Objective
In this report, we aim to analyze the house pricing data of San Francisco and predict the future development trend.
We used two methods: ARIMA model and Facebook developed model Prophet (based on Markov Chain), and compared the prediction performance on year 2018 with Mean Squared Errors. The ARIMA model out-performed Prophet model, and is used to forecast house pricing of year 2019.

**Regarding ARIMA model, [check here](https://github.com/elaine-chenma/Time-Series-Prediction/blob/master/ARIMA_weather_forecasting.md) for a statistical view of using the model to predict weather, where parameter selection and model comparison with information criteria is elaborated.**

### Exploratory Data Analysis
**Trend, Seasonal, and Noise**

By decomposing the mean house pricing, we can see clearly that this is typical time series data with a yearly seasonal part. There is always a peak in the mid of every single year.

![img](/images/Picture1.png)

### Modeling
1. ARIMA model

By iterating through all parameters, we select model with best AIC. The line plot is showing the observed values compared to the rolling forecast predictions. Overall, our forecasts align with the true values very well, showing an upward trend starts in the mid of the year and a slowing increase at the end of the year.

![img](/images/Picture2.png)


2. Prophet Model

Prophet Model is based on Markov Chai. We can see that it captures most of the trend in the data, but does not perform well when there is fluctuations.

![img](/images/Picture3.png)

3. Model Comparison

By computing the squared root of MSE(Mean Squared Error), we select ARIMA model as our final model as it out-performs Prophet model.

### Recommendation for house buyers and sellers
We used ARIMA model to predict the average housing price of San Francisco in year 2019, we can see that the price is still showing an upward trend.
Hence combined with the annually peak we observed from previous years’ data, we believe that for **house sellers**, the best time to sell a house would be in the mid of the year where the pricing reaches a peak.

While for **house buyers**, if it’s for owner-occupied purpose, then it would be reasonable to buy it sooner, as the pricing is predicted to go up. If it’s for investment purpose, then it would be wise to wait and see how the house pricing goes after mid of the year, as the confidence interval for the last few months of year 2019 is very wide, it’s very hard to tell whether house pricing would stay stable, go upwards, or drop in the long run.
