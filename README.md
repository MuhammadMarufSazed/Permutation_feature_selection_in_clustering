# Permutation_feature_selection_in_clustering
Implemented a new feature selection algorithm for clustering as part of my master's research. The project is written in R. 
Let Ac is a clustering algorithm with objective function L(). For a data set Xnp, where
n is the number of observations and p is the number of features, we dene (Xj ;X􀀀j), where
Xj is our target feature that we want to permute with j = 1; 2    p and X􀀀j represents
the rest of the features in the data set. Then we will implement the following algorithm.
1. We calculate the L(X) for any given Ac using all p number of features.
2. For each of the features Xj we will do the following,
• We permute Xj m number of times, where m = 1; 2;   M.
• We calculate Ljm = L(Xj ;X􀀀j) for a given Ac.
• We calculate Lj =
P
m Ljm
M
• We calculate the importance measure imj for feature Xj as per following,
imj =
jLj 􀀀 L(X)j
jL(X)j
6
3. We sort the imjs in descending order to get the feature ranking.
4. To select feature subset we do one of the following.
• We select a pre-determined number of top-ranked features.
• Exclude features that has low importance measure value.
• We plot the ranked features along with their importance measure value and
select the features that has higher values compared to the rest of the features.
