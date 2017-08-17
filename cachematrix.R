## Cache inverse of matrix to save computational expense when repeating
## inversion of same matrix

## usage:
## testMatrix <- matrix(...) # define standard matrix, e.g. diag(n)
## CacheMatrix <- makeCacheMatrix() # make special matrix
## CacheMatrix$set(testMatrix) # set data of special matrix
## CacheMatrix$get() # show matrix
## cacheSolve(CacheMatrix) # invert matrix if not cached; else show cache

## The function 'makeCacheMatrix()' creates a special "matrix" object
## that can cache its inverse.
## Actually, it is a list of closure functions:
## - set(): set values of matrix in makeCacheMatrix
## - get(): get values of matrix
## - setinv(): set the inverse of the matrix
## - getinv(): get the inverse of the matrix

makeCacheMatrix <- function(x = matrix()) {
        inv <- NULL
        set <- function(y) {
                x <<- y
                inv <<- NULL
        }
        get <- function() x
        setinv <- function(solve) inv <<- solve
        getinv <- function() inv
        list(set = set, get = get,
             setinv = setinv,
             getinv = getinv)
}


## The function 'cacheSolves' computes the inverse of the special "matrix"
## If the inverse has already been calculated (and the matrix has not changed;
## a change leads to 'inv <- NULL'),
## then cacheSolve should retrieve the inverse from the cache (and a message
## 'getting cached data' is printed).

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
        inv <- x$getinv()
        if(!is.null(inv)) {
                message("getting cached data")
                return(inv)
        }
        data <- x$get()
        inv <- solve(data, ...)
        x$setinv(inv)
        inv
}
