load data 
infile 'G:\SQL_Loader_Files\csv\Reviews_File.csv' "str '\r\n'"
truncate
into table REVIEWS
fields terminated by ','
OPTIONALLY ENCLOSED BY '"' AND '"'
trailing nullcols
           ( asin CHAR(4000),
             name CHAR(4000),
             rating CHAR(4000),
             REVIEW_DATE  DATE "DD/MM/YYYY",
             verified CHAR(4000),
             title CHAR(4000),
            helpfulVotes CHAR(4000),
             brand CHAR(4000),
             item_title CHAR(4000),
             url CHAR(4000),
             image CHAR(4000),
             overall_rating CHAR(4000),
             reviewUrl CHAR(4000),
             totalReviews CHAR(4000), 
             price CHAR(4000),
             originalPrice CHAR(4000),
             id CHAR(4000),
             year CHAR(4000),
             month CHAR(4000),
            
             day CHAR(4000),
              week CHAR(4000)
             
             
             )
