# SELECT





# FROM
-- LATERAL VIEW
SELECT survey_id, question_id_string
FROM dim_survey_definition LATERAL VIEW EXPLODE(question_ids_array) AS question_id_string






# WHERE
-- DATE
