# Gradient descent algorithm

* **Data set used** : Adult data set from UCI machine learning repository.

* **Objective** : Train a logistic regression model to predict if the wage is >50 K or =< 50K USD. The traning is performed via stochastic gradient descent.

* **Features selection and normaliation** : All except fnlwgt, and education-num. The continuous variables were normalized via z-score normalization to control the norm of the feature vectors, and the categorical variables were converted to one-hot binary vector via dummy encoding. The last column of each encoding was removed to avoid multi-collinearity.

* **Measure of accuracy** : Area under the curve (AUC)

* **Algorithms:

```
![equation](http://latex.codecogs.com/gif.latex?O_t%3D%5Ctext%20%7B%20Onset%20event%20at%20time%20bin%20%7D%20t)
![equation](http://latex.codecogs.com/gif.latex?s%3D%5Ctext%20%7B%20sensor%20reading%20%7D) 
![equation](http://latex.codecogs.com/gif.latex?P%28s%20%7C%20O_t%20%29%3D%5Ctext%20%7B%20Probability%20of%20a%20sensor%20reading%20value%20when%20sleep%20onset%20is%20observed%20at%20a%20time%20bin%20%7D%20t)

```


