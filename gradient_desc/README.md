# Gradient descent algorithm

* **Data set used** : Adult data set from UCI machine learning repository.

* **Objective** : Train a logistic regression model to predict if the wage is >50 K or =< 50K USD. The traning is performed via stochastic gradient descent.

* **Features selection and normaliation** : All except fnlwgt, and education-num. The continuous variables were normalized via z-score normalization to control the norm of the feature vectors, and the categorical variables were converted to one-hot binary vector via dummy encoding. The last column of each encoding was removed to avoid multi-collinearity.

* **Measure of accuracy** : Area under the curve (AUC)

* **Algorithms:

```
<a href="http://www.codecogs.com/eqnedit.php?latex=\LARGE&space;\Theta_{t&plus;1}&space;\leftarrow&space;\theta_t&space;-\eta&space;\bigtriangledown&space;\ell(\theta_t;x_t,y_t)." target="_blank"><img src="http://latex.codecogs.com/gif.latex?\LARGE&space;\Theta_{t&plus;1}&space;\leftarrow&space;\theta_t&space;-\eta&space;\bigtriangledown&space;\ell(\theta_t;x_t,y_t)." title="\LARGE \Theta_{t+1} \leftarrow \theta_t -\eta \bigtriangledown \ell(\theta_t;x_t,y_t)." /></a>
```


