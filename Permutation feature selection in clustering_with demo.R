library(mclust)

# Function that will carry out the permutation based method
feature_importance <- function(data, no_shufle, cluster_fn){
  
  shuffle_fn <- function(data, permute_no){
    n = nrow(data)
    d = ncol(data)
    shuff_data = array(NA, dim = c(d, permute_no, n, d))
    for (i in 1:d){
      for (perm in 1:permute_no){
        s_data = cbind(data[ , -i], sample(data[,i]))
        shuff_data[ i, perm, , ] = s_data
      } 
    }
    return(shuff_data)
  }
  
  data = as.matrix(data)
  permuted_data  =  shuffle_fn(data = data, no_shufle)
  permute_fn = apply(permuted_data, 1, function(a){apply(a, 1, cluster_fn)})
  mean_perm = apply(permute_fn, 2, mean)
  
  return(mean_perm) 
}

# The clustering functions to be used for permutation based methods. 
# Here we used Mclust and k-means for demonstration. It could also be some other clustering algorithm.
# Different values of G can be used as well.
mclust_fn <- function(data, G = 3, verbose = FALSE){
  mod_clust = Mclust(data, G = G, verbose=  verbose)
  return(mod_clust$loglik)
}

kmeans_fn <- function(data, G = 3){
  mod = kmeans(data, centers = G)
  return(mod$tot.withinss)
}


# Implementing on Iris dataset
data = iris[ ,c(1:4)]

mclust_vals = feature_importance(data = as.matrix(data), no_shufle = 30, cluster_fn = mclust_fn) #permutation with Mclust on Iris dataset
kmeans_vals = feature_importance(data = as.matrix(data), no_shufle = 30, cluster_fn = kmeans_fn) #permutation with k-means on Iris dataset

mclust_original_data = Mclust(data, G = 3, verbose = FALSE)  
kmeans_original_data = kmeans(data, centers = 3) #importance measure calculation for k-means permutation

im_mclust = abs(mclust_vals - mclust_original_data$loglik)/abs(mclust_original_data$loglik) #importance measure calculation for mclust permutation 
im_kmeans = abs(kmeans_vals - kmeans_original_data$tot.withinss)/abs(kmeans_original_data$tot.withinss) #importance measure calculation for mclust permutation 

names(im_mclust) = colnames(data)
names(im_kmeans) = colnames(data)

par(mfrow = c(1,2))
barplot(sort(im_mclust), horiz = 2, las = 2, main = "Mclust permutation") # Plotting the measures
barplot(sort(im_kmeans), horiz = 2, las = 2, main = "k-means permutation") # Plotting the measures

