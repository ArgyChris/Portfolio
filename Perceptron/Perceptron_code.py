#!/usr/bin/env python3
# The previous line is the shebang line to define to use python3
# (effort for PEP 8 style compliance, check with pycodestyle)

# load important modules
import numpy as np
import matplotlib as plt
import matplotlib.pyplot as plt

# load the modules that will be used for the regression vs. perceptron comparison
import sklearn as skl
from sklearn.linear_model import LinearRegression

# place a seed to replicate the results
np.random.seed(0)


def SeparateTrainingTestData(input_data, split_ratio):
    """  Performs data separation to training and
    testing sets according to a ratio
    Input:
        input_data: array for spliting
        split ratio: ratio, in percentage, to split the array
    Return:
        The seprated train (train_all_data) and test (test_all_data) data
    """
    # shuffle data along the first axis
    np.random.shuffle(input_data)
    # define the split size based on the parameters: data size, ratio
    test_sample_size = int(np.floor(input_data.shape[0]*split_ratio))
    training_sample_size = int(input_data.shape[0]-np.floor(test_sample_size))
    train_all_data = input_data[0:training_sample_size, :]
    test_all_data = input_data[training_sample_size:, :]

    return train_all_data, test_all_data


def RMSE_cost_function(weights, bias, X, Y):
    """ Computes the cost function: root mean square error (RMSE)
        Input:
            weights: weights values that are multiplied with the parameters
            bias: single number that controls the intercept
            X: input parameter values
            Y: house price
        Return:
            The error between the model (wx+b) and known house price
    """
    N = X.shape[0]
    RMSE_error = 0.0
    sum_error = 0.0
    for i in range(N):
        sum_error += (Y[i] - (np.dot(weights, X[i, :]) + bias))**2

    RMSE_error = np.sqrt(sum_error/N)
    return RMSE_error


def GradientDescentOpimizationFunction(weights, bias, X, Y, learning_rate):
    """ Performs the gradient descent optimization by computing the derivatives
    of the cost function (RMSE) w.r.t the parameters
    Input:
        weights: weights that are multiplied with the parameters
        bias: single number that controls the intercept
        X: input parameter values
        Y: known prediction, of the house price, given the parameters
        learning_rate: weight and bias adjustment for optimization
    Return:
        The updated weights and bias variables
    """
    N = X.shape[0]
    weight_derivative = np.zeros(X.shape[1])
    bias_derivative = 0
    for i in range(N):
        # compute the partial derivatives w.r.t to the weights and the bias
        # df/dw = -x(y-y')/sqrt((y-y')^2)
        # df/db = -(y-y')/sqrt((y-y')^2)

        numerator = Y[i] - (np.dot(weights, X[i, :]) + bias)
        denumerator = (Y[i] - (np.dot(weights, X[i, :]) + bias))**2
        weight_derivative += -((X[i, :] * numerator)/np.sqrt(denumerator))
        bias_derivative += -(numerator/np.sqrt(denumerator))

    # consider the magnitude factor
    magnitude_factor = np.sqrt(N)
    weights = weights-(weight_derivative/magnitude_factor)*learning_rate
    bias = bias-(bias_derivative/magnitude_factor)*learning_rate

    return weights, bias


def TrainingGradientDescent(weights, bias, learning_rate, epochs, X, Y):
    """ Performs the main training step, iterate along the dataset a number
    of epochs optimizing the weights and bias w.r.t to the cost function
    Input:
        weights: weights that are multiplied with the parameters
        bias: single number that controls the intercept
        learning_rate: weight and bias adjustment for the optimization
        epochs: number of times that the GD will "see" the full dataset
        X: input parameter values
        Y: known prediction, house price, given the parameters
    Return:
        The optimized weights and bias
    """
    for i in range(epochs):
        weights, bias = GradientDescentOpimizationFunction(weights, bias, X, Y, learning_rate)
        RMSE_error = RMSE_cost_function(weights, bias, X, Y)

    return weights, bias


def PerceptronPerdiction(X, weights, bias):
    """ Performs inference with the perceptron"""
    N = X.shape[0]
    Y_prediction = np.zeros(N)
    for i in range(N):
        Y_prediction[i] = np.dot(weights, X[i, :]) + bias

    return Y_prediction


def RMSE_error(predictions, targets):
    """ Computes the root mean square error"""
    differences_squared = (predictions - targets)**2
    mean_of_differences_squared = differences_squared.mean()
    RMSE = np.sqrt(mean_of_differences_squared)

    return RMSE


if __name__ == '__main__':
    """ Implement the perceptron and compare the performance against
    the regression in the boston housing market

    Example usage:
        ./Perceptron_code.py
    """
    # data reading and cleaning
    print('Read the .csv file')
    boston_housing_data = np.genfromtxt('mass_boston.csv', delimiter=',')
    print('Success')
    print('Cleaning the data....')
    # remove the header
    clean_boston_housing_data = boston_housing_data[1:, :]
    print('Success')

    split_ratio = 0.3
    train_data_all, test_data_all = SeparateTrainingTestData(clean_boston_housing_data, split_ratio)

    print('Main perceptron training...')
    # training parameters initialization
    weights_input_for_training = np.zeros([1, 13])
    bias_input_for_training = [0]
    learning_rate = 0.000003
    epochs = 5000
    X = train_data_all[:, 0:13]
    Y = train_data_all[:, 13]
    # main gradient descent function
    trained_weights, trained_bias = TrainingGradientDescent(weights_input_for_training, bias_input_for_training, learning_rate, epochs, X, Y)
    print('Successful training')

    print('--------------------------')
    print('Testing and evaluation step')
    # testing parameter initialization
    X_training = train_data_all[:, 0:13]
    Y_training = train_data_all[:, 13]
    # compute the perceptron RMSE error of the training and testing data
    training_RMSE_error = RMSE_cost_function(trained_weights, trained_bias, X_training, Y_training)
    X_inference = test_data_all[:, 0:13]
    Y_inference = test_data_all[:, 13]
    testing_RMSE_error = RMSE_cost_function(trained_weights, trained_bias, X_inference, Y_inference)
    print('RMSE error of the perceptron in the training set:'+str(training_RMSE_error))
    print('RMSE error of the perceptron in the test set:'+str(testing_RMSE_error))
    # perceptron inference in the test set
    Y_prediction = PerceptronPerdiction(X_inference, trained_weights, trained_bias)

    # comparison of the Y (given house prices) versus the predicted one
    # Y prime when using the two model: perceptron, sklearn linear regression
    print('-----Comparison against sklearn linear regression---------')
    # define the linear regression and apply it to the test data
    lm = LinearRegression()
    lm.fit(X_inference, Y_inference)
    Y_prediction_sklearn = lm.predict(X_inference)

    rmse_perceptron = RMSE_error(Y_prediction, Y_inference)
    rmse_sklearn_regression = RMSE_error(Y_prediction_sklearn, Y_inference)

    print('Plotting the two predictions')
    h1 = plt.scatter(Y_inference, Y_prediction_sklearn, s=70)
    h2 = plt.scatter(Y_inference, Y_prediction, marker='v', c='r', s=70)
    plt.ylabel("Predicted prices: $Y_{pred}$")
    plt.xlabel("Medv Prices: $Y_{medv}$")
    plt.legend((h1, h2), ('sklearn:'+str(rmse_sklearn_regression),
    'perceptron:'+str(rmse_perceptron)))
    plt.show()
    print("RMSE perceptron: "+str(rmse_perceptron))
    print("RMSE sklearn regression: "+str(rmse_sklearn_regression))
