# Incremental Lattice Design of Weight Vector Set
[![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=tomtkg/ILD)
![](https://img.shields.io/github/languages/code-size/tomtkg/ILD)
![](https://img.shields.io/github/last-commit/tomtkg/ILD)

## Sample image of weight vector set
|![image](image/H1.svg)Three-objective problems, parameter H=1|![image](image/H2.svg)Three-objective problems, parameter H=2|![image](image/H3.svg)Three-objective  problems, parameter H=3
|:-:|:-:|:-:|
|![image](image/H4.svg)Three-objective problems, parameter H=4|![image](image/H5.svg)Three-objective problems, parameter H=5|![image](image/H6.svg)Three-objective problems, parameter H=6|

## How to use
You can easily use this weight vector set by reading the [data](data).  
If the data you want isn't there, you can use [ILD.m](ILD/ILD.m) to create the data.  

If you want to use this weight vector set in [PlatEMO](https://github.com/BIMK/PlatEMO), you can use ["PlatEMO/Algorithms/Utility functions/UniformPoint.m"](https://github.com/BIMK/PlatEMO/blob/master/PlatEMO/Algorithms/Utility%20functions/UniformPoint.m) like `[W,N] = UniformPoint(286,10,'ILD')`.

Also, you can easily use this in python. Like 'python ILD\ILD.py 3 3'

## Reference 
Tomoaki Takagi, Keiki Takadama, and Hiroyuki Sato, **Incremental Lattice Design of Weight Vector Set**, Proc. of the 2020 Genetic and Evolutionary Computation Conference (GECCO2020), pp. 1486-1494, 2020. [DOI](https://doi.org/10.1145/3377929.3398082).
