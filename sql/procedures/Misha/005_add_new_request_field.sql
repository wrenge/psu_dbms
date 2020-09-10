USE uni_library
GO
alter table Request
	add Request_finish_date datetime default NULL
go

UPDATE Request
SET Request.Request_finish_date = GETDATE()