DELETE FROM uni_library.dbo.Request
DBCC CHECKIDENT ('Request', RESEED, 0)
DELETE FROM uni_library.dbo.Issues
DBCC CHECKIDENT ('Issues', RESEED, 0)
DELETE FROM uni_library.dbo.Booking
DBCC CHECKIDENT ('Booking', RESEED, 0)
DELETE FROM uni_library.dbo.Books
DBCC CHECKIDENT ('Books', RESEED, 0)
DELETE FROM uni_library.dbo.Publisher
DBCC CHECKIDENT ('Publisher', RESEED, 0)
DELETE FROM uni_library.dbo.Subject
DBCC CHECKIDENT ('Subject', RESEED, 0)
DELETE FROM uni_library.dbo.City
DBCC CHECKIDENT ('City', RESEED, 0)
DELETE FROM uni_library.dbo.Readers
DBCC CHECKIDENT ('Readers', RESEED, 0)
DELETE FROM uni_library.dbo.Classes
DBCC CHECKIDENT ('Classes', RESEED, 0)
DELETE FROM uni_library.dbo.Groups
DBCC CHECKIDENT ('Groups', RESEED, 0)