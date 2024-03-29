-- hive -hiveconf IPPATH=/home/dk/Website_data/etlhive.txt -f web_cat.hql > /home/dk/Website_data/etlhive_CATEGORY

LOAD DATA LOCAL INPATH'${hiveconf:IPPATH}' INTO TABLE WEB_DATA;

INSERT OVERWRITE TABLE WORD_COUNT SELECT WORD,COUNT(*)
FROM (SELECT EXPLODE(SPLIT(regexp_replace(UPPER(DATA),'[^A-Z0-9 ]',' '),' ')) AS WORD FROM WEB_DATA)W
GROUP BY WORD;

SELECT A.CATEGORY as CATEGORY,sum(A.OCCUR) as WEIGHTAGE FROM (SELECT * FROM WORD_COUNT JOIN KEYS ON (WORD_COUNT.WORD=KEYS.WORD)) A GROUP BY A.CATEGORY ORDER BY WEIGHTAGE DESC LIMIT 1;

TRUNCATE TABLE WORD_COUNT;