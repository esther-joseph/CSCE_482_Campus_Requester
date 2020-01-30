/****** Object:  StoredProcedure [dbo].[spAcceptPost]    Script Date: 1/29/2020 6:02:12 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
CREATE PROCEDURE [dbo].[spAcceptPost]
(
    @id int
)
AS
BEGIN
	UPDATE dbo.Posts
		SET isOpen = 0
		WHERE id = @id
END
GO


