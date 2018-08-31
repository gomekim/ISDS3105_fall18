Assignment 2
================
Kimberly

The goal of this practice is to improve your understanding of vectors and how to manipulate them. The data we use are the prices of the [2017 Big Mac Index](http://www.economist.com/content/big-mac-index).

For each question, please create a new chunck with your reponse. Use narratives to comment the output whenever the question requires to do so.

1.  Edit the code below to assign country names to the vector `countries` and prices to the vector `prices`. Hide the code below when you knit (check the Rmarkdown cheatsheet to find the appropriate chunk option to hide code).

``` r
#countries
countries <- c("Argentina", "Australia", "Brazil", "Britain", "Canada", "Chile", "China", "Colombia", "Costa Rica", "Czech Republic", "Denmark", "Egypt", "Euro area", "Hong Kong", "Hungary", "India", "Indonesia", "Israel", "Japan", "Malaysia", "Mexico", "New Zealand", "Norway", "Pakistan", "Peru", "Philippines", "Poland", "Russia", "Saudi Arabia", "Singapore", "South Africa", "South Korea", "Sri Lanka", "Sweden", "Switzerland", "Taiwan", "Thailand", "Turkey", "UAE", "Ukraine", "United States", "Uruguay", "Venezuela", "Vietnam", "Austria", "Belgium", "Estonia", "Finland", "France", "Germany", "Greece", "Ireland", "Italy", "Netherlands", "Portugal", "Spain")

#prices in dollars
prices <- c(4.12553410932665, 4.527955, 5.10156757258139, 4.1114315, 4.6556967948218, 3.84409554461789, 2.9171270718232, 3.24360452925142, 4.00003493480292, 3.28139971386194, 4.60649054517816, 1.75398378529494, 4.4650245, 2.45791461307047, 3.20894752849616, 2.75723192502808, 2.40293204682299, 4.77333709927976, 3.36104723155846, 2.00302783277047, 2.75424026530641, 4.43226, 5.91416018925313, 3.56633380884451, 3.22927879440258, 2.64945182050953, 2.72339966564202, 2.27813538775693, 3.1998720051198, 4.06474559047688, 2.26073850791258, 3.84396977241952, 3.77297121483168, 5.81892070131244, 6.74168957112483, 2.26396522024444, 3.49624667636214, 3.00611009353896, 3.81159814865233, 1.69785838317577, 5.3, 4.52882773036056, 4.05555555555556, 2.63939293962389, 3.88263, 4.6248975, 3.5971425, 5.207292, 4.681995, 4.453605, 3.8255325, 4.6477365, 4.79619, 4.1224395, 3.7113375, 4.33941)
```

1.  Use `typeof()` to report the type of both vectors.

``` r
typeof(countries)
```

    ## [1] "character"

``` r
typeof(prices)
```

    ## [1] "double"

1.  Use `names()` to name the `prices` using `countries`. Show the first 5 values of your new vector

``` r
names(prices)<- countries
show(prices [1:5])
```

    ## Argentina Australia    Brazil   Britain    Canada 
    ##  4.125534  4.527955  5.101568  4.111432  4.655697

1.  Use `round()` to round the prices at the 3rd decimal. Overwrite `prices` with the rounded prices.

``` r
prices<- round(prices, digits = 3)
```

1.  Use indexing to report the prices for Canada, United States, Mexico

``` r
prices[c("Canada","United States", "Mexico")]
```

    ##        Canada United States        Mexico 
    ##         4.656         5.300         2.754

1.  Use inline code and the function `length()` to display the following sentence:

They are `length(prices)` observations in the Big-Mac Index

1.  Convert the prices from Dollar to Euro (1 Dollar = .83 Euro). In the narrative, comment about the property which allows you to combine a vector of length 1 (the exchange rate) with a vector of length 56 (the prices).

``` r
ePrices <- (1/.83)* prices
## multiplication of atomic vectors 
```

-   Could you use the vector `rep(.83, 28)` to do the same?

``` r
1/rep(.83,28) *prices
```

    ##      Argentina      Australia         Brazil        Britain         Canada 
    ##       4.971084       5.455422       6.146988       4.953012       5.609639 
    ##          Chile          China       Colombia     Costa Rica Czech Republic 
    ##       4.631325       3.514458       3.908434       4.819277       3.953012 
    ##        Denmark          Egypt      Euro area      Hong Kong        Hungary 
    ##       5.549398       2.113253       5.379518       2.961446       3.866265 
    ##          India      Indonesia         Israel          Japan       Malaysia 
    ##       3.321687       2.895181       5.750602       4.049398       2.413253 
    ##         Mexico    New Zealand         Norway       Pakistan           Peru 
    ##       3.318072       5.339759       7.125301       4.296386       3.890361 
    ##    Philippines         Poland         Russia   Saudi Arabia      Singapore 
    ##       3.191566       3.280723       2.744578       3.855422       4.897590 
    ##   South Africa    South Korea      Sri Lanka         Sweden    Switzerland 
    ##       2.724096       4.631325       4.545783       7.010843       8.122892 
    ##         Taiwan       Thailand         Turkey            UAE        Ukraine 
    ##       2.727711       4.212048       3.621687       4.592771       2.045783 
    ##  United States        Uruguay      Venezuela        Vietnam        Austria 
    ##       6.385542       5.456627       4.886747       3.179518       4.678313 
    ##        Belgium        Estonia        Finland         France        Germany 
    ##       5.572289       4.333735       6.273494       5.640964       5.366265 
    ##         Greece        Ireland          Italy    Netherlands       Portugal 
    ##       4.609639       5.600000       5.778313       4.966265       4.471084 
    ##          Spain 
    ##       5.227711

``` r
##yes
```

-   Could you use the vector `rep(.83, 112)` to do the same?

``` r
1/rep(.83,112) *prices
```

    ##   [1] 4.971084 5.455422 6.146988 4.953012 5.609639 4.631325 3.514458
    ##   [8] 3.908434 4.819277 3.953012 5.549398 2.113253 5.379518 2.961446
    ##  [15] 3.866265 3.321687 2.895181 5.750602 4.049398 2.413253 3.318072
    ##  [22] 5.339759 7.125301 4.296386 3.890361 3.191566 3.280723 2.744578
    ##  [29] 3.855422 4.897590 2.724096 4.631325 4.545783 7.010843 8.122892
    ##  [36] 2.727711 4.212048 3.621687 4.592771 2.045783 6.385542 5.456627
    ##  [43] 4.886747 3.179518 4.678313 5.572289 4.333735 6.273494 5.640964
    ##  [50] 5.366265 4.609639 5.600000 5.778313 4.966265 4.471084 5.227711
    ##  [57] 4.971084 5.455422 6.146988 4.953012 5.609639 4.631325 3.514458
    ##  [64] 3.908434 4.819277 3.953012 5.549398 2.113253 5.379518 2.961446
    ##  [71] 3.866265 3.321687 2.895181 5.750602 4.049398 2.413253 3.318072
    ##  [78] 5.339759 7.125301 4.296386 3.890361 3.191566 3.280723 2.744578
    ##  [85] 3.855422 4.897590 2.724096 4.631325 4.545783 7.010843 8.122892
    ##  [92] 2.727711 4.212048 3.621687 4.592771 2.045783 6.385542 5.456627
    ##  [99] 4.886747 3.179518 4.678313 5.572289 4.333735 6.273494 5.640964
    ## [106] 5.366265 4.609639 5.600000 5.778313 4.966265 4.471084 5.227711

``` r
##yes
```

-   Would `rep(.83, 45)` also work? Why?

``` r
1/rep(.83,45) *prices
```

    ## Warning in 1/rep(0.83, 45) * prices: longer object length is not a multiple
    ## of shorter object length

    ##      Argentina      Australia         Brazil        Britain         Canada 
    ##       4.971084       5.455422       6.146988       4.953012       5.609639 
    ##          Chile          China       Colombia     Costa Rica Czech Republic 
    ##       4.631325       3.514458       3.908434       4.819277       3.953012 
    ##        Denmark          Egypt      Euro area      Hong Kong        Hungary 
    ##       5.549398       2.113253       5.379518       2.961446       3.866265 
    ##          India      Indonesia         Israel          Japan       Malaysia 
    ##       3.321687       2.895181       5.750602       4.049398       2.413253 
    ##         Mexico    New Zealand         Norway       Pakistan           Peru 
    ##       3.318072       5.339759       7.125301       4.296386       3.890361 
    ##    Philippines         Poland         Russia   Saudi Arabia      Singapore 
    ##       3.191566       3.280723       2.744578       3.855422       4.897590 
    ##   South Africa    South Korea      Sri Lanka         Sweden    Switzerland 
    ##       2.724096       4.631325       4.545783       7.010843       8.122892 
    ##         Taiwan       Thailand         Turkey            UAE        Ukraine 
    ##       2.727711       4.212048       3.621687       4.592771       2.045783 
    ##  United States        Uruguay      Venezuela        Vietnam        Austria 
    ##       6.385542       5.456627       4.886747       3.179518       4.678313 
    ##        Belgium        Estonia        Finland         France        Germany 
    ##       5.572289       4.333735       6.273494       5.640964       5.366265 
    ##         Greece        Ireland          Italy    Netherlands       Portugal 
    ##       4.609639       5.600000       5.778313       4.966265       4.471084 
    ##          Spain 
    ##       5.227711

``` r
## No, because longer object length is not a multiple of shorter object length
```

1.  In your narrative, mention that we are going to drop the 46th element. Use dynamic code to report the country that will drop.

``` r
## dropping the 46th element which is country:
show(Old46<- countries[46])
```

    ## [1] "Belgium"

1.  Overwrite the vector of prices with a new vector without observation 46. Use `length()` to make sure you have one observation less.

``` r
prices[-46]
```

    ##      Argentina      Australia         Brazil        Britain         Canada 
    ##          4.126          4.528          5.102          4.111          4.656 
    ##          Chile          China       Colombia     Costa Rica Czech Republic 
    ##          3.844          2.917          3.244          4.000          3.281 
    ##        Denmark          Egypt      Euro area      Hong Kong        Hungary 
    ##          4.606          1.754          4.465          2.458          3.209 
    ##          India      Indonesia         Israel          Japan       Malaysia 
    ##          2.757          2.403          4.773          3.361          2.003 
    ##         Mexico    New Zealand         Norway       Pakistan           Peru 
    ##          2.754          4.432          5.914          3.566          3.229 
    ##    Philippines         Poland         Russia   Saudi Arabia      Singapore 
    ##          2.649          2.723          2.278          3.200          4.065 
    ##   South Africa    South Korea      Sri Lanka         Sweden    Switzerland 
    ##          2.261          3.844          3.773          5.819          6.742 
    ##         Taiwan       Thailand         Turkey            UAE        Ukraine 
    ##          2.264          3.496          3.006          3.812          1.698 
    ##  United States        Uruguay      Venezuela        Vietnam        Austria 
    ##          5.300          4.529          4.056          2.639          3.883 
    ##        Estonia        Finland         France        Germany         Greece 
    ##          3.597          5.207          4.682          4.454          3.826 
    ##        Ireland          Italy    Netherlands       Portugal          Spain 
    ##          4.648          4.796          4.122          3.711          4.339

``` r
length(prices[-46])
```

    ## [1] 55

1.  Knit, commit and push to your GitHub repo `assignment`. Then submit the link to the *assignment folder* on Moodle.
