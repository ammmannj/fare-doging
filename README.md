# MATLAB HS12 – Research Plan

> * Group Name: netzwerk
> * Group participants names: Ammann Jens, Bischofberger Lukas
> * Project Title: Ticket inspection behaviour and its influence on fare evasion 

## General Introduction

Public transportation is of outstanding importance for your society since it ensures the mobility for a brought 
clientele, independent of social state and physical condition. In order to preserve public transportation and 
its financing, it is crucial to keep the fare evasion beyond a curtain limit. To realize this, fare evasion 
behaviour and its interference with the ticket inspection must be researched.

## The Model
The passenger and ticket inspector are represented by agents that show in a first step independent uniform 
behaviour. In a second step the behaviour of the agent is dependend on each other. The main idea of the passenger 
behaviour is that the probability of dodging fare increases with the time not being inspected and dodging fare 
successfully. This can then represent the situation, where ticket inspector plan their routes together and 
passenger share fare dodging experience. The public transportation network is implemented by a matrix, where 
the lines represent the different stations and the value of the row the connection to other stations. During the 
simulation the behaviour of the ticket inspectors is left constant whereas the fare dodging behaviour of the 
passenger changes due to their experience and his social environment. 


## Fundamental Questions

> * What behaviour for the passanger leads to realistic results (compared to surveys eg. San Francisco)?
> * What behaviour for the ticket inspectors lead to realistic results?
> * What is the influence of the ticket inspector behavoir to the behavoir of the passanger?
> * How can the ticket inspector behaviour be modified to minimize fare evasion?
> * How can the ticket inspector behaviour be modified to maximize profit?


## Expected Results
We expect that if the passenger are not sharing experience a regional focused inspection leads to higher 
fare evasion rate, as the inspection rate decreases regionally and thus the dodging fare probability increases. 
If on the other hand experience sharing among the passenger is implemented, the evasion rate probably decreases 
dramatically, because the passenger “warn” each other of a regional inspection focus.

## References 

Strategies of the Stakeholders Related with the Behavior of Fare Evasions Based on Game Theory.
Wu Dan; Qiu Canhua

Uncovering San Francisco, California, Muni's Proof-of-Payment Patterns to Help Reduce Fare Evasion.
Lee, J (Lee, Jason)

## Research Methods

Agent-Based Model (humans can change their behaviour and interact, controllers and environement is static and doesn't change throughout the simulation)
