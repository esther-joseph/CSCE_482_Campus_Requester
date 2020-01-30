/****** Object:  StoredProcedure [dbo].[createNewPost]    Script Date: 1/29/2020 5:58:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
CREATE PROCEDURE [dbo].[createNewPost]
(
   @details text
)
AS
BEGIN
	INSERT INTO [dbo].[Posts]
           ([details]
           ,[creationTime]
           ,[isOpen])
     VALUES
           (@details
           ,GETDATE()
           ,1)
END
GO
