#Neural network stochastic differential equation models with applications to financial data forecasting 
This repo contains our code for paper: [Neural network stochastic differential equation models with applications to financial data forecasting](http://arxiv.org/abs/2111.13164).
It includes code for Cao's Method and the LDENet model we proposed. Cao's Method is used for calculating the best embedding dimension. LDENet model is used for forecasting time seires。

## Abstract

In this article, we employ a collection of stochastic differential equations with drift and diffusion coefficients approximated by neural networks to predict the trend of chaotic time series which has big jump properties. Our contributions are, first, we propose a model called Lévy induced stochastic differential equation network, which explores compounded stochastic differential equations with α-stable Lévy motion to model complex time series data and solve the problem through neural network approximation. Second, we theoretically prove that the numerical solution through our algorithm converges in probability to the solution of corresponding stochastic differential equation, without curse of dimensionality. Finally, we illustrate our method by applying it to real financial time series data and find the accuracy increases through the use of non-Gaussian Lévy processes. We also present detailed comparisons in terms of data patterns, various models, different shapes of Lévy motion and the prediction lengths.

If you find this implementation useful and want to cite/mention this paper, here is a bibtex citation:
@article{yang2021neural,
  title={NEURAL NETWORK STOCHASTIC DIFFERENTIAL EQUATION MODELS WITH APPLICATIONS TO FINANCIAL DATA FORECASTING},
  author={Yang, Luxuan and Gao, Ting and Lu, Yubin and Duan, Jinqiao and Liu, Tao},
  journal={arXiv preprint arXiv:2111.13164},
  year={2021}
}
