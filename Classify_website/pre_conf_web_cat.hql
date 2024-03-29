-- hive -hiveconf KEYPATH=/home/dk/keywords.csv -f pre_conf_web_cat.hql

CREATE TABLE WEB_DATA ( DATA STRING )
ROW FORMAT DELIMITED
LINES TERMINATED BY '\n';

CREATE TABLE KEYS (WORD STRING, CATEGORY STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'; 

CREATE TABLE WORD_COUNT ( WORD STRING, OCCUR INT);

LOAD DATA LOCAL INPATH'${hiveconf:KEYPATH}' INTO TABLE KEYS;