# Exercise 2: The perceptron versus the regressor

The purpose of this project was to implement the gradient descent on a single neuron, the perceptron, using numpy only. In addition, to verify if the neuron worked, I performed training on the boston housing market dataset, and compare its inference with the standard regression from other sources.

## Getting Started

### Prerequisites

The code requires the script and the dataset (mass_boston) in a .csv form located in the same folder. Additionally, some important pre-installed modules are required in order for the code to run. 

### Installing

Go to the directory where the script is located. In order to be able to run the script, change the permission:

```
$sudo chmod +x Perceptron_code.py
```

Besides the permission change, install the following libraries:


```
$sudo pip install numpy
$sudo pip install matplotlib
$sudo pip install sklearn
```

## Code General Structure 

1. The first step is the data loading and cleaning. The data contain a header with the parameter/column name that I do not consider in the rest of my code. 
2. The next step is the data separation in the training and testing sets. Here, I call SeparateTrainingTestData() which splits randomly the data according to a predefined ratio: 70% for training and 30% for testing.
3. The main training module of the perceptron is launched. The chosen cost function is the root mean square error and the activation function the linear one. The partial derivatives of the cost function with respect to the parameters, weights and bias, are computed. I define GradientDescentOpimizationFunction() to perform the task, which in turn is used in TrainingGradientDescent() to iteratively optimizes the parameters as I go throught the training set. The gradient update is performed considering only one row (iteration) at a time, while the weights/bias are updated when I finish processing the whole training set (epoch).
4. The next step is the evaluation and testing of the perceptron in the dataset.
5. Finally, I compare the perceptron against the regression from the sklearn module in the testing set. Firstly, I fit the linear regressor on the training set, after that I make the prediction in the testing, and finally I plot the perceptron versus the sklearn prediction in the same plot. 

## Running the code

An example to run the code is given:

```
argy@laptop:~/Portfolio/Perceptron$ ./Perceptron_code.py
```
The previous outputs:
```
Read the .csv file
Success
Cleaning the data....
Success
Main perceptron training...
Successful training
--------------------------
Testing and evaluation step
RMSE error of the perceptron in the training set:[ 7.90689826]
RMSE error of the perceptron in the test set:[ 8.79350971]
-----Comparison against sklearn linear regression---------
Plotting the two predictions
RMSE perceptron: 8.79350971204
RMSE sklearn regression: 4.56535881959
```
Finally, it plots in a graph the predicted price versus the medv price in the case of the perceptron inference,
and the linear regression from the sklearn. It appears that the perceptron results are very close to the results from the perceptron.

## Authors

* **Argyrios Christodoulidis** - [email](mailto:argyrios.christodoulidis@gmail.com)
