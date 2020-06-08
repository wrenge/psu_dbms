USE uni_library
GO
CREATE TYPE dbo.InstanceIDList
AS TABLE
(
    instance_id INT NOT NULL UNIQUE
);
GO
