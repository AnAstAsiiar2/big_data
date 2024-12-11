(
    SELECT DISTINCT
        date,
        YEAR(date) AS year,
        MONTH(date) AS month,
        DAY(date) AS day
    FROM dbo.Operations
)