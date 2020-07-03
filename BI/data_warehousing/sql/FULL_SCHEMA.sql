CREATE TABLE DIM_Phone (
  Id int NOT NULL,
  reviewdate date NOT NULL,
  verified varchar2(100) NOT NULL,
  title varchar2(300) NOT NULL,
  helpfulvotes number NOT NULL,
  itemtitle varchar2(200) NOT NULL,
  url varchar2(200) NOT NULL,
  image varchar2(100) NOT NULL,
  overallrating number NOT NULL,
  reviewurl varchar2(200) NOT NULL,
  totalreviews number NOT NULL,
  price number,
  brand varchar2(50),
  brandID number,
  originalprice number ,
  PRIMARY KEY (Id)
);


CREATE TABLE DIM_Time (
  time_ID int NOT NULL,
  year int NOT NULL,
  month int NOT NULL,
  week int NOT NULL,
  day int NOT NULL,
  PRIMARY KEY (time_ID)
);

CREATE TABLE FACT_REVIEWS (
  fact_ReviewsID int NOT NULL,
  time_ID int  REFERENCES DIM_Time(time_ID),
  brand_ID int NOT NULL REFERENCES DIM_Phone(ID),
  Rating int NOT NULL,
  Review varchar2(4000),
  PRIMARY KEY (fact_ReviewsID)
);

ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/YYYY';
CREATE TABLE Reviews
( asin varchar2(100),
 name varchar2(100),
 rating int,
Review_date DATE,
verified varchar2(100),
title varchar2(300),
helpfulVotes Number,
brand varchar2(100),
item_title varchar2(200),
url varchar2(100),
image varchar2(100),
overall_rating Number,
reviewUrl varchar2(100),
totalReviews int,
price Number,
originalPrice Number,
Year int,Month int,Week int,Day int,
 ID number,
 brand_id number
);



