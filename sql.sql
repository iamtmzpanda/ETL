# SELECT





# FROM
-- LATERAL VIEW
SELECT survey_id, question_id_string
FROM dim_survey_definition LATERAL VIEW EXPLODE(question_ids_array) AS question_id_string

-- PIVOT 






# WHERE
-- DATE

-- HAVING
SELECT AccountId, MAX(Amount)
FROM invoice 
WHERE InvoiceDate > date('2022-03-01') and InvoiceDate < date('2022-06-01') 
GROUP BY AccountId
HAVING MAX(Amount) = 0
