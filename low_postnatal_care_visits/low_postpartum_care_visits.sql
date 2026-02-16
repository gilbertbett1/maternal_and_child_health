CREATE DATABASE IF NOT EXISTS `maternal_and_child_health`;
USE `maternal_and_child_health`;

-- ########################## KPIs ################################# --
-- i. Total number of mothers enrolled in PROMPTS --
SELECT 
	SUM(prompts_enrolled) AS total_number
FROM mothers_hmis;

-- ii. PROMPTS enrollment rate
SELECT 
	100 * SUM(prompts_enrolled) / 
    COUNT(DISTINCT mother_id) AS rate
FROM mothers_hmis;

-- iii. Average number of messages sent in the first 6 weeks postpartum
SELECT 
	AVG(msgs_sent_postpartum_6w) AS average_num
FROM prompts_engagement;

-- iv. Average number of messages to mothers who attended PNC 6-week visit vs those who did not
SELECT
    m.postnatal_visit_6w,
    AVG(p.msgs_sent_postpartum_6w) AS avg_msgs_postpartum_6w
FROM mothers_hmis AS m
INNER JOIN prompts_engagement AS p
    ON m.mother_id = p.mother_id
GROUP BY m.postnatal_visit_6w;

-- v. Overall PNC 6-week coverage
SELECT 
	100 * AVG(postnatal_visit_6w) AS postnatal_visit_rate
FROM mothers_hmis;

-- ######################### EDA ########################## --
-- i. PNC 6-week coverage by age group
SELECT 
	age_group, 
    100 * AVG(postnatal_visit_6w) AS postnatal_visit_coverage
FROM mothers_hmis
GROUP BY age_group
ORDER BY age_group ASC;

-- ii. PNC 6-week coverage by residence type
SELECT 
	residence_type, 
    100 * AVG(postnatal_visit_6w) AS postnatal_visit_coverage
FROM mothers_hmis
GROUP BY residence_type;
