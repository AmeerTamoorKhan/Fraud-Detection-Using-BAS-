# Fraud Detection In Publicly Traded U.S Firms Using Beetle Antennae Search: A Machine Learning Approach

We presented a fraud detection framework for publicly traded firms using an optimization
approach integrated with a meta-heuristic algorithm known as Beetle Antennae Search (BAS). Existing
techniques include human resources, like financial experts and audit teams, to determine the ambiguities
or financial frauds in the companies based on financial and non-financial ratios. It is a laborious task, timeconsuming,
and prone to errors. We designed an optimization problem to minimize the loss function based
on a non-linear decision function combined with the maximization of recall (Sensitivity and Specificity).
We solved the optimization problem iteratively using the BAS. It is a nature-inspired algorithm and
mimics the beetle's food-searching nature. It includes a single searching particle to and an optimal
solution to the optimization problem in n-dimensional space. We used a benchmark dataset collected
from SEC's Accounting and Auditing Enforcement Releases (AAERs) for the simulation. It includes 28
raw financial variables and the data collected between 1991-2008: For the comparison, we evaluated the
performance of BAS with the recently proposed approach using RUSBoost. We also compared it with
some additional algorithms, i.e., Logit and SVM-FK. The results showed that BAS is comparable with
these algorithms and outperformed them in time consumption.

## Dataset
We used a benchmark dataset collected from SEC's Accounting and Auditing Enforcement Releases
(AAERs) by the University of California-Berkeley's Center for Financial Reporting and Management
(CFRM) (Li et al., 2020). The dataset contains 17 years data from 1979-2014 of public traded US firms.
The dataset consists of 28 raw accounting variables and 14 financial ratios.
[Dataset Link](https://github.com/JarFraud/FraudDetection)

## BAS Algorithm
We proposed an optimization-based meta-heuristic algorithm known as Beetle Antennae
Search (BAS) to detect fraud firms. BAS is a nature-inspired single-particle algorithm. It mimics the food
searching nature of the beetles for the fast convergence towards the optimal solution. BAS has recently
been employed in several real-world applications (Khan et al., 2021, Khan and Li, Khan et al.) including
the finance and stock market problems. (Khan et al., 2020b) employed Quantum Beetle Antennae
Search (QBAS) in the portfolio selection problem. (Khan et al., 2020a) used BAS for the management
and intelligent decision-making of complex and intricate systems. Likewise, (KHAN, 2020) solved the
portfolio selection problem under cardinality constraints. Its single-particle nature is computationally
robust and timely efficient, which allows it to make fraud perdition in real-time.

## References
1. [Jiang, X., and S. Li. "BAS: beetle antennae search algorithm for optimization problems (2017)." arXiv preprint arXiv:1710.10724.](https://arxiv.org/abs/1710.10724)
2. [Khan, A. T., Cao, X., Li, Z., & Li, S. (2021). Enhanced Beetle Antennae Search with Zeroing Neural Network for online solution of constrained optimization. Neurocomputing, 447, 294-306.](https://www.sciencedirect.com/science/article/abs/pii/S0925231221003957)
3. [Khan, A. T., Li, S., & Cao, X. (2021). Control framework for cooperative robots in smart home using bio-inspired neural network. Measurement, 167, 108253.](https://www.sciencedirect.com/science/article/pii/S0263224120307922?casa_token=NeHLkrfKm7EAAAAA:972ZRPiwj10KPGovRSwzQKYqkLz9j_LyzNaqW7WRGdh9MIApiea3PkaqkPqXkU2ZbppUQYAJvw)
4. [Khan, A. T., & Li, S. (2021). Human guided cooperative robotic agents in smart home using beetle antennae search. Science China Information Sciences.](https://www.sciengine.com/doi/10.1007/s11432-020-3073-5)

