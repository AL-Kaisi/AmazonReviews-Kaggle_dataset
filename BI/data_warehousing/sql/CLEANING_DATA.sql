CREATE OR replace PACKAGE comp1434_cleaning AS 
    PROCEDURE run_me_only; 
    PROCEDURE update_brand_id; 
    PROCEDURE dw_insert; 
END comp1434_cleaning;

/

CREATE OR replace PACKAGE BODY comp1434_cleaning IS 

PROCEDURE Run_me_only AS 

BEGIN 
    Update_brand_id(); 
    Dw_insert(); 
END run_me_only; 

PROCEDURE Update_brand_id AS 

    v_id     reviews.id%TYPE; 
    v_brand     reviews.brand%TYPE; 


    CURSOR c_reviewsbrandid IS 
        SELECT brand, id FROM reviews;   
BEGIN 
 OPEN c_reviewsbrandid; 
    LOOP 
        FETCH c_reviewsbrandid INTO v_brand, v_id; 
        IF c_reviewsbrandid%FOUND THEN 
          
          IF v_brand= 'Motorola' THEN 
            UPDATE reviews SET brand_id = 1 WHERE id = v_id; 
          ELSIF v_brand = 'Samsung' THEN 
              UPDATE reviews SET brand_id = 2 WHERE id = v_id; 
          ELSIF v_brand = 'Nokia' THEN 
           UPDATE reviews SET brand_id = 3 WHERE id = v_id; 
          ELSIF v_brand = 'OnePlus' THEN 
            UPDATE reviews SET brand_id = 4 WHERE id = v_id; 
          ELSIF v_brand = 'HUAWEI' THEN 
             UPDATE reviews SET brand_id = 5 WHERE id = v_id; 
          ELSIF v_brand = 'Google' THEN 
          UPDATE reviews SET brand_id = 6 WHERE id = v_id; 
          ELSIF v_brand = 'Apple' THEN 
             UPDATE reviews SET brand_id = 7 WHERE id = v_id; 
               ELSIF v_brand = 'ASUS' THEN 
               UPDATE reviews SET brand_id = 8 WHERE id = v_id; 
                 ELSIF v_brand = 'Xiamoi' THEN 
           UPDATE reviews SET brand_id = 9 WHERE id = v_id; 
              ELSIF v_brand = 'Sony' THEN 
              UPDATE reviews SET brand_id = 10 WHERE id = v_id; 
          END IF; 
        END IF; 
        EXIT WHEN c_reviewsbrandid%NOTFOUND; 
    END LOOP; 
    CLOSE c_reviewsbrandid; 

END  update_brand_id; 

PROCEDURE Dw_insert AS 


v_id       reviews.id%TYPE; 
v_reviewdate reviews.review_date%TYPE; 
v_verified   reviews.verified%TYPE; 
v_title      reviews.title%TYPE; 
v_votes      reviews.helpfulvotes%TYPE; 
v_itemtitle  reviews.title%TYPE; 
v_url        reviews.url%TYPE; 
v_image      reviews.image%TYPE; 
v_overall    reviews.overall_rating%TYPE; 
v_reviewurl  reviews.reviewurl%TYPE; 
v_totalreview reviews.totalreviews%TYPE; 
v_price       reviews.price%TYPE; 
v_brandid     reviews.brand_id%TYPE; 
v_orginalprice reviews.originalprice%TYPE; 
v_brand        reviews.brand%TYPE; 
v_sid   reviews.id%TYPE; 
v_year  reviews.year%TYPE; 
v_month reviews.month%TYPE; 
v_week  reviews.week%TYPE; 
v_day   reviews.day%TYPE; 
v_timeid    dim_time.time_id%TYPE; 


CURSOR c_dim_phone IS 
SELECT id,review_date,verified,title,helpfulvotes,item_title,url,image,overall_rating,reviewurl,totalreviews,price,brand,
brand_id,originalprice FROM reviews; 

CURSOR c_dim_time IS 
SELECT id,year,month,week,day FROM  reviews; 

CURSOR c_timeid IS 
   SELECT time_id  FROM dim_time; 
    
v_idd      reviews.id%TYPE; 
v_brandidd  reviews.brand_id%TYPE; 
v_rating   reviews.rating%TYPE; 



CURSOR c_fact_review IS 
SELECT id,brand_id,rating  FROM reviews; 

BEGIN 


 OPEN c_dim_phone; 

    LOOP 
        FETCH c_dim_phone INTO  v_id,v_reviewdate,v_verified,v_title,v_votes,v_itemtitle,v_url,v_image,v_overall,v_reviewurl,v_totalreview,v_price,v_brand,v_brandid,v_orginalprice;

        IF c_dim_phone%FOUND THEN 
        INSERT INTO dim_phone(id,reviewdate,verified,title,helpfulvotes,itemtitle,url,image,overallrating,reviewurl,totalreviews,price,brand,brandid,originalprice)VALUES(v_id,v_reviewdate,v_verified,v_title,v_votes,v_itemtitle,v_url,v_image,v_overall,v_reviewurl,v_totalreview,v_price,v_brand,v_brandid,v_orginalprice);

        END IF; 

        EXIT WHEN c_dim_phone%NOTFOUND; 
    END LOOP; 

    CLOSE c_dim_phone; 


OPEN c_fact_review ; 

    LOOP 
        FETCH c_fact_review  INTO  v_id,v_brandid,v_rating; 

        IF c_fact_review%FOUND THEN 
        INSERT INTO fact_reviews (fact_reviewsid,brand_id,rating)VALUES(v_id,v_brandid,v_rating);

        END IF; 

        EXIT WHEN c_fact_review%NOTFOUND; 
    END LOOP; 

    CLOSE c_fact_review; 
  
 OPEN c_dim_time; 

    LOOP 
        FETCH c_dim_time  INTO v_sid,v_year,v_month,v_week,v_day; 

        IF c_dim_time%FOUND THEN 
          
        INSERT INTO dim_time (year,month,week,day)VALUES(v_year,v_month,v_week,v_day); 
      
        END IF; 
       OPEN c_timeid; 
       LOOP 
       FETCH c_timeid INTO v_timeid; 
       IF c_timeid%FOUND THEN 
        
       UPDATE fact_reviews SET time_id =v_timeid WHERE fact_reviewsid = v_sid; 
       END IF; 
          EXIT WHEN c_timeid%NOTFOUND; 
       END LOOP; 
       CLOSE c_timeid; 
        EXIT WHEN c_dim_time%NOTFOUND; 
    END LOOP; 

    CLOSE c_dim_time; 


END; 



END comp1434_cleaning;