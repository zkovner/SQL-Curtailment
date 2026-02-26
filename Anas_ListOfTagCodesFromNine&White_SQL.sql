DECLARE @StartDate date = '2025-01-01';
DECLARE @EndDate date = '2025-12-31';
SELECT
    HP.TagCode,
    MAX(HP.SourcePoint_ETAG) AS SourcePoint_ETAG,
    MAX(HP.SinkPoint_ETAG)   AS SinkPoint_ETAG,
    MAX(HP.LoadBA_ETAG)      AS LoadBA_ETAG,
    MIN(HP.OperatingDT_PPT)  AS FirstOperatingDT,
    SUM(HP.MW)               AS TotalMW
FROM Tagging_ETAG.dbo.TagHourProfileETAGView HP
WHERE HP.OperatingDT_PPT >= @StartDate
  AND HP.Composite_Status_Type_ETAG <> 'CANCELLED'
  AND HP.Request_Status_Type_ETAG = 'APPROVED'
  AND (
       UPPER(HP.SourcePoint_ETAG) LIKE '%HARVESTWIND%'
    OR UPPER(HP.SourcePoint_ETAG) LIKE '%WHtcrkwind%'
  )
GROUP BY HP.TagCode
ORDER BY FirstOperatingDT, HP.TagCode;