/****** Object:  StoredProcedure [dbo].[spGetPosts]    Script Date: 1/29/2020 6:51:33 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
CREATE PROCEDURE [dbo].[spGetPosts]
(
	@count INT
)
AS
BEGIN
	SELECT TOP (@count) * FROM dbo.Posts WHERE dbo.Posts.isOpen = 1 ORDER BY id DESC
END
GO


