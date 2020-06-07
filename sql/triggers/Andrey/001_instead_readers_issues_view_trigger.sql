USE uni_library
GO
CREATE OR ALTER TRIGGER ReadersIssuesViewTrigger
    ON dbo.ReaderIssuesView
    INSTEAD OF DELETE
    AS
BEGIN
    DELETE
    FROM Issues
    WHERE Issue_id IN (SELECT D.Issue_id FROM deleted D)
end