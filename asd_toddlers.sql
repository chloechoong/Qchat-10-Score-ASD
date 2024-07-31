-- CREATE DATABASE autism_data
-- GO

USE autism_data;
SELECT *
FROM asd_toddlers; 

SELECT ASD_Traits, COUNT(*) AS Count_ASD
FROM asd_toddlers
GROUP BY ASD_Traits; -- 728 with possible autistic traits, 326 without

/* -- Create a table for those who may be autistic
SELECT *
INTO asd_yes
FROM asd_toddlers
WHERE ASD_Traits = 'Yes'; */ 

SELECT *
FROM asd_yes;

-- Ethnicity in those who may be autistic
SELECT Ethnicity, COUNT(*) AS Ethnicity_Count
FROM asd_yes
GROUP BY Ethnicity
ORDER BY Ethnicity_Count DESC; -- Most from White Europeans and Asians

SELECT Age_Months, COUNT(*) AS Age_Count
FROM asd_yes
GROUP BY Age_Months
ORDER BY Age_Count DESC; -- Large number at 36 months (3 years)

SELECT Family_Mem_with_ASD, COUNT(*) AS Family_Mem_with_ASD_Count
FROM asd_yes
GROUP BY Family_Mem_with_ASD
ORDER BY Family_Mem_with_ASD_Count DESC; -- 613 = No, 115 = Yes

SELECT Sex, ASD_Traits, COUNT(*) AS Sex_Count
FROM asd_toddlers
GROUP BY Sex, ASD_Traits
ORDER BY Sex_Count DESC; -- Males are more likely to be autistic, with more than double of males being autistic to not, Females are roughly the same

SELECT Sex, Ethnicity, COUNT(*) AS Sex_Count
FROM asd_yes
WHERE Ethnicity IN ('White European', 'Asian')
GROUP BY Sex, Ethnicity
ORDER BY Sex_Count DESC; -- White European and Asian Males are at the highest risk

SELECT Jaundice, ASD_Traits, COUNT(*) AS Jaundice_Count
FROM asd_toddlers
GROUP BY Jaundice, ASD_Traits
ORDER BY Jaundice_Count DESC; -- Jaundice does not seem to have much of a connection to ASD traits

---------------------------------------------------------------------------------------------
-- Now look at the Qchat-10 Scores more closely!

-- First, let's look at score distribution:
SELECT Qchat_10_Score, COUNT(*) AS Qchat_10_Score_Count
FROM asd_yes
GROUP BY Qchat_10_Score;

SELECT Ethnicity, COUNT(*) AS Ethnicity_Count
FROM asd_yes
WHERE Qchat_10_Score >=7 -- and 8, 9, 10 
GROUP BY Ethnicity
ORDER BY Ethnicity_Count DESC -- White Europeans and Asians still at the top for all higher scores

SELECT Age_Months, COUNT(*) AS Age_Count
FROM asd_yes
WHERE Qchat_10_Score >= 7 -- and 8, 9, 10 
GROUP BY Age_Months
ORDER BY Age_Count DESC -- 36 months still has the highest diagnostic power

SELECT 
	1054 - SUM(A1) AS Sum_A1,
	1054 - SUM(A2) AS Sum_A2,
	1054 - SUM(A3) AS Sum_A3,
	1054 - SUM(A4) AS Sum_A4,
    1054 - SUM(A5) AS Sum_A5,
    1054 - SUM(A6) AS Sum_A6,
    1054 - SUM(A7) AS Sum_A7,
    1054 - SUM(A8) AS Sum_A8,
    1054 - SUM(A9) AS Sum_A9,
    SUM(A10) AS Sum_A10
FROM asd_yes; -- A3 seems to be the most telling for autistic traits

