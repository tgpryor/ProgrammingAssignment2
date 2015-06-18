## Usage example:
##
## > source('cachematrix.R')
## > m <- makeCacheMatrix(matrix(c(1, 2, 3, 4), nrow=2, ncol=2))
## > m$getMatrix()
##      [,1] [,2]
## [1,]    1    3
## [2,]    2    4
## > cacheSolve(m)
##      [,1] [,2]
## [1,]   -2  1.5
## [2,]    1 -0.5
## > m$getCache()
##      [,1] [,2]
## [1,]   -2  1.5
## [2,]    1 -0.5
## > cacheSolve(m)
## getting cached data
##      [,1] [,2]
## [1,]   -2  1.5
## [2,]    1 -0.5

# MAKECACHEMATRIX() - store and retrieve a matrix, store and retrieve a cache of inversed matrix values
makeCacheMatrix <- function(x = matrix()) {
     
     # Initialize cache to NULL
     cache <- NULL
     
     # SETMATRIX()
     setMatrix <- function(newValue) {
          
          # Store numeric matrix
          x <<- newValue
          
          # Flush the cache
          cache <<- NULL
     }
     
     # GETMATRIX()
     getMatrix <- function() {
          # Return the stored matrix
          x
     }
     
     # SETCACHE() 
     setCache <- function(solve) {
          # Cache the matrix
          cache <<- solve
     }
     
     # GETCACHE()
     getCache <- function() {
          # Return the cached matrix
          cache
     }
     
     # Return a list: each named element is a function which can subsequently be called
     list(setMatrix=setMatrix, getMatrix=getMatrix, setCache=setCache, getCache=getCache)
}


# CACHESOLVE() - return the inverse of the matrix created by MAKECACHEMATRIX. Inverse values are 
# calculated once and cached.  Subsequent calls will simply return the cache.
cacheSolve <- function(x, ...) {
     
     # Get the cache
     inverse <- x$getCache()
     
     # If the cache value exists (is not NULL), return it
     if(!is.null(inverse)) {
          message("getting cached data")
          return(inverse)
     }
     
     # Since the cache is empty, calculate the inverse
     data <- x$getMatrix()
     inverse <- solve(data)   
     
     # Cache the matrix of inverse values
     x$setCache(inverse)
     
     # Return the inverse values
     inverse
}
