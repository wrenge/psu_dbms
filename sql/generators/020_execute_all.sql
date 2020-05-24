USE uni_library
GO

EXEC GenerateFaculties
EXEC GenerateGroups 10
EXEC GenerateClasses
EXEC ImportNames
EXEC ImportSurNames
EXEC GenerateReaders 20000, '01/01/2010' -- 20 sec
EXEC GenerateAuthors 100 -- 20 s
EXEC GenerateCities
EXEC GenerateSubjects
EXEC GeneratePublishers
EXEC GenerateSciBooks 2
EXEC GenerateFiBooks 2
EXEC GenerateInstances 100
EXEC GenerateBooking 5000 -- 35 s
EXEC GenerateIssues 10000 -- 150 s
EXEC GenerateRequests '01/01/2010'