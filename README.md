# package2script
Auto generate a single script containing all the R source code for an R package. 
This is useful when working on systems where the user does not have permission to install packages. 
Currently only packages whose source code is available on your local machine can be converted into R scripts. 

If you're working directory contains the package `MyPackage` that you wish to convert into a single R script, this can 
be done with the following command:

```
library(package2script)
package2script("MyPackage", directory = ".")
```
and now the file `MyPackage.R`, located in your working directory, will contain all the R source code for `MyPackage`, 
including calls to imported external packages. This means that you can have the package functions available by calling

```
source("MyPackage.R")
```

