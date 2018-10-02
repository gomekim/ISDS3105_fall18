lesson 8: Querying a MySQL DB
================

`dplyr` makes easy to translate R code into SQL code for querying databases. To see how that works, first we connect to our online reviews MySQL DB:

``` r
#' this WON'T work off-campus unless you use a client server
#' you need to add USN/PW to con.R
#' DON'T push con.R to GitHub -- use .gitinore
source(here::here('lectures/lesson08_notes_datamodel/conn.R'))
```

    ## Loading required package: DBI

    ## [1] "If you get an error, try reinstalling `openssl``, restart R and rerun the script."

``` r
dbListTables(con) # these are the entities in the DB
```

    ## [1] "author"       "brand"        "employee"     "hotel"       
    ## [5] "interaction"  "lodgingchain" "response"     "review"

``` r
dbListFields(con, 'review') # these are the attributes in the entity review
```

    ##  [1] "reviewId"          "reviewDate"        "reviewStayMonth"  
    ##  [4] "reviewStayYear"    "reviewHelpfulness" "reviewMobile"     
    ##  [7] "reviewOverall"     "reviewCleanliness" "reviewLocation"   
    ## [10] "reviewRooms"       "reviewService"     "reviewValue"      
    ## [13] "reviewTitle"       "reviewText"        "hotelId"          
    ## [16] "authorId"

Each dplyr query, is trasnlated to a SQL query. For instance, to query a whole entity:

``` r
tbl(con, 'review')
```

    ## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 0 imported
    ## as numeric

    ## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 14
    ## imported as numeric

    ## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 15
    ## imported as numeric

    ## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 0 imported
    ## as numeric

    ## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 14
    ## imported as numeric

    ## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 15
    ## imported as numeric

    ## # Source:   table<review> [?? x 16]
    ## # Database: mysql 5.6.19-log
    ## #   [student@ba-isdsclass-dev2.lsu.edu:/hotelreviews]
    ##    reviewId reviewDate reviewStayMonth reviewStayYear reviewHelpfulne…
    ##       <dbl> <chr>      <chr>           <chr>                     <int>
    ##  1 91254323 2011-01-01 December        2010                          0
    ##  2 91254425 2011-01-01 December        2010                          0
    ##  3 91254804 2011-01-01 December        2010                          0
    ##  4 91254899 2011-01-01 December        2010                          0
    ##  5 91255301 2011-01-01 October         2010                          0
    ##  6 91255315 2011-01-01 June            2010                          0
    ##  7 91255523 2011-01-01 December        2010                          0
    ##  8 91255591 2011-01-01 July            2010                          0
    ##  9 91255749 2011-01-01 November        2010                          0
    ## 10 91256002 2011-01-01 November        2010                          0
    ## # ... with more rows, and 11 more variables: reviewMobile <chr>,
    ## #   reviewOverall <int>, reviewCleanliness <int>, reviewLocation <int>,
    ## #   reviewRooms <int>, reviewService <int>, reviewValue <int>,
    ## #   reviewTitle <chr>, reviewText <chr>, hotelId <dbl>, authorId <dbl>

``` r
show_query(tbl(con, 'review')) #this shows how tbl(con, 'review') translates to SQL
```

    ## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 0 imported
    ## as numeric

    ## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 14
    ## imported as numeric

    ## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 15
    ## imported as numeric

    ## <SQL>
    ## SELECT *
    ## FROM `review`

``` r
tbl(con, sql('SELECT * FROM review')) #this is how you can use actual SQL
```

    ## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 0 imported
    ## as numeric

    ## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 14
    ## imported as numeric

    ## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 15
    ## imported as numeric

    ## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 0 imported
    ## as numeric

    ## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 14
    ## imported as numeric

    ## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 15
    ## imported as numeric

    ## # Source:   SQL [?? x 16]
    ## # Database: mysql 5.6.19-log
    ## #   [student@ba-isdsclass-dev2.lsu.edu:/hotelreviews]
    ##    reviewId reviewDate reviewStayMonth reviewStayYear reviewHelpfulne…
    ##       <dbl> <chr>      <chr>           <chr>                     <int>
    ##  1 91254323 2011-01-01 December        2010                          0
    ##  2 91254425 2011-01-01 December        2010                          0
    ##  3 91254804 2011-01-01 December        2010                          0
    ##  4 91254899 2011-01-01 December        2010                          0
    ##  5 91255301 2011-01-01 October         2010                          0
    ##  6 91255315 2011-01-01 June            2010                          0
    ##  7 91255523 2011-01-01 December        2010                          0
    ##  8 91255591 2011-01-01 July            2010                          0
    ##  9 91255749 2011-01-01 November        2010                          0
    ## 10 91256002 2011-01-01 November        2010                          0
    ## # ... with more rows, and 11 more variables: reviewMobile <chr>,
    ## #   reviewOverall <int>, reviewCleanliness <int>, reviewLocation <int>,
    ## #   reviewRooms <int>, reviewService <int>, reviewValue <int>,
    ## #   reviewTitle <chr>, reviewText <chr>, hotelId <dbl>, authorId <dbl>

Note that even if you assign `tbl(con, 'review')` to an object, each time you call the object dplyr queries the DB again (you are not saving the table on your local machine). Also, note that you cannot use R function that are unavailable on your database. For instance:

``` r
tbl(con, 'review') %>% mutate(mean(reviewService, na.rm = T))
```

    ## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 0 imported
    ## as numeric

    ## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 14
    ## imported as numeric

    ## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 15
    ## imported as numeric

    ## Error: Window function `avg()` is not supported by this database

A viable solution is to `collect()` the output of your query before:

``` r
tbl(con, 'review') %>% collect %>%  summarise(avg = mean(reviewService, na.rm = T))
```

    ## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 0 imported
    ## as numeric

    ## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 14
    ## imported as numeric

    ## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 15
    ## imported as numeric

    ## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 0 imported
    ## as numeric

    ## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 14
    ## imported as numeric

    ## Warning in .local(conn, statement, ...): Unsigned INTEGER in col 15
    ## imported as numeric

    ## # A tibble: 1 x 1
    ##     avg
    ##   <dbl>
    ## 1  4.15

However, you want to `collect()` as late as possible to make sure you leverage the computational power of your server and you avoid downloading unnecessary data on your machine.

1.  Report the distinct types of hotels

``` r
options(warn =-1)
tbl(con, "hotel") %>%
  distinct(hotelType) -> q1
collect(q1)
```

    ## # A tibble: 2 x 1
    ##   hotelType        
    ##   <chr>            
    ## 1 Corporate Housing
    ## 2 hotel

1.  Report the top 3 hotels with the highest number of rooms (keep only hotelId, hotelName, hotelRooms)

``` r
tbl(con, sql('SELECT  hotelId, hotelName, hotelRooms FROM hotel ORDER BY hotelRooms DESC LIMIT 3' ))
```

    ## # Source:   SQL [?? x 3]
    ## # Database: mysql 5.6.19-log
    ## #   [student@ba-isdsclass-dev2.lsu.edu:/hotelreviews]
    ##   hotelId hotelName                         hotelRooms
    ##     <dbl> <chr>                                  <int>
    ## 1   93603 The Pierre, A Taj Hotel, New York        560
    ## 2  659532 Ritz-Carlton Dallas                      545
    ## 3  878358 The Ritz-Carlton, Denver                 531

1.  Count the independent business (those who do not belong to any brand)

``` r
tbl(con, sql('SELECT COUNT(hotelId) FROM hotel WHERE brandId IS NULL '))
```

    ## # Source:   SQL [?? x 1]
    ## # Database: mysql 5.6.19-log
    ## #   [student@ba-isdsclass-dev2.lsu.edu:/hotelreviews]
    ##   `COUNT(hotelId)`
    ##              <dbl>
    ## 1             1723

1.  Report the top 3 hotels with the best service (calculate the average using review.reviewService)

``` r
tbl(con, sql('SELECT h.hotelId, hotelName, AVG(reviewService) FROM hotel h , review r WHERE h.hotelId = r.hotelId GROUP BY hotelId ORDER BY AVG(r.reviewService) DESC LIMIT 3'))
```

    ## # Source:   SQL [?? x 3]
    ## # Database: mysql 5.6.19-log
    ## #   [student@ba-isdsclass-dev2.lsu.edu:/hotelreviews]
    ##   hotelId hotelName                                    `AVG(reviewService…
    ##     <dbl> <chr>                                                      <dbl>
    ## 1  119327 Extended Stay America - Phoenix - Deer Vall…                   5
    ## 2  239859 Studio 6 Houston Northwest                                     5
    ## 3   80067 Quality Inn I-15 Miramar                                       5

1.  Report all the authors and the hotels they reviewed. Report the author name, the hotel ID and hotel name. Order the output by author name

``` r
tbl(con, sql('SELECT h.hotelId , authorNickname, hotelName FROM hotel h , review r, author a WHERE h.hotelId = r.hotelId AND a.authorId = r.authorId ORDER BY authorNickname'))
```

    ## # Source:   SQL [?? x 3]
    ## # Database: mysql 5.6.19-log
    ## #   [student@ba-isdsclass-dev2.lsu.edu:/hotelreviews]
    ##    hotelId authorNickname     hotelName                                   
    ##      <dbl> <chr>              <chr>                                       
    ##  1   99307 **yuko*hawaii**    Wellington Hotel                            
    ##  2 1456560 *Mark*J*L*         Eventi - a Kimpton Hotel                    
    ##  3   80193 ------             Hyatt Regency Mission Bay                   
    ##  4  674288 ---------asali-ch… Residence Inn by Marriott Chicago Downtown …
    ##  5   80920 ---_nYx_anDre_---  Hotel Bijou                                 
    ##  6   84104 ---_nYx_anDre_---  State Plaza Hotel                           
    ##  7  119769 ---_nYx_anDre_---  Dolphin Motel                               
    ##  8  268977 ---_nYx_anDre_---  Hollywood Downtowner Inn                    
    ##  9   77274 -Chanelle-F        Hollywood Roosevelt Hotel - A Thompson Hotel
    ## 10   84561 -Chanelle-F        Orlando Hotel                               
    ## # ... with more rows

1.  Report the total number of reviews received by each hotel. Report a three columns table with `hotelId`, `hotelName` and total number of reviews. Make sure that you are including hotels with zero reviews as well. Note that some hotels have 0 reviews. If you decide to count the rows in each grouping level, make sure you you don't count as 1 those who have zero reviews.

``` r
tbl(con, sql('SELECT h.hotelId, hotelName, COUNT(reviewId) FROM hotel h JOIN review r WHERE h.hotelId = r.hotelId GROUP BY hotelId '))
```

    ## # Source:   SQL [?? x 3]
    ## # Database: mysql 5.6.19-log
    ## #   [student@ba-isdsclass-dev2.lsu.edu:/hotelreviews]
    ##    hotelId hotelName                               `COUNT(reviewId)`
    ##      <dbl> <chr>                                               <dbl>
    ##  1   72572 BEST WESTERN PLUS Pioneer Square Hotel                 77
    ##  2   72579 BEST WESTERN Loyal Inn                                 47
    ##  3   72586 BEST WESTERN PLUS Executive Inn                        67
    ##  4   72598 Comfort Inn & Suites Seattle                           17
    ##  5   73236 Days Inn San Antonio/Near Lackland AFB                  3
    ##  6   73242 BEST WESTERN Ingram Park Inn                            8
    ##  7   73445 BEST WESTERN PLUS Westchase Mini-Suites                41
    ##  8   73463 Downtowner Inn and Suites                               5
    ##  9   73470 Greenway Inn & Suites                                   4
    ## 10   73481 Holiday Inn Express - Houston                           1
    ## # ... with more rows

1.  Report how many chains established their headquarter in each country. Plot a barchart those frequencies by country and then add a title to your plot. Adjust your axes' labels as needed (remember that non-data ink points are modified within `theme()`).

2.  For each review of stays during 2011, calculate the composite average score as the mean of Location, Room, Service, Value and Cleanliness. Then plot a histogram (using `geom_hist()`) of the differences between the average of those 5 attributes and ratingOverall.

*warning*: If you query the DB and then pipe the remote table into a ggplot2 function, you might need to `collect()` the remote table before passing it to `ggplot()`, because `ggplot()` expects a class `data.frame` (and tibbles are also data.frame). However, if you pass a different object (such as a connection) "it will be converted to one by fortify()" (see the documentation `?ggplot()`). Apparently, for some of you `fortify()` does not convert the table to a local data.frame, and if that is the case you need to `collect()`.

1.  Report all data about brands that have minimum square footage requirement for rooms that exceeds the average minimum square footage of all brands by at least 50%.
