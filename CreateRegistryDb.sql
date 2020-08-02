CREATE DATABASE otusdb_registry;
GO

USE otusdb_registry;
GO

CREATE TABLE [dbo].[IdentityDocs]
(
	[Id] INT IDENTITY(1,1) NOT NULL,
	[DocType] INT NOT NULL,
	[Serie] NVARCHAR(10) NOT NULL,
	[Number] NVARCHAR(10) NOT NULL,
	[IssueDate] DATETIME NULL,
	[IssuedBy] NVARCHAR(150) NULL,
	
	CONSTRAINT [PK_IdentityDocs] 
		PRIMARY KEY CLUSTERED ([Id])
);
GO

CREATE TABLE [dbo].[PersonCards]
(
	[Id] INT IDENTITY(1,1) NOT NULL,
	[LastName] NVARCHAR(30) NOT NULL,
	[FirstName] NVARCHAR(30) NOT NULL,
	[MiddleName] NVARCHAR(30) NOT NULL,
	[BirthDate] DATETIME NOT NULL,
	[Gender] INT NOT NULL,
	[IdentityDocId] INT NOT NULL,
	[PhotoId] INT NULL,
	[RegAddress] NVARCHAR(200) NOT NULL,
	[FactAddress] NVARCHAR(200) NULL,
	[Phone] NVARCHAR(40) NULL,
	[IsDeleted] BIT NOT NULL,
	[CreateDate] DATETIME NOT NULL,
	[CreateUserId] INT NOT NULL,
	[LastModifiedDate] DATETIME NULL,
	[LastModifiedUserId] INT NULL,

	CONSTRAINT [PK_PersonCards] 
		PRIMARY KEY CLUSTERED ([Id]),

	CONSTRAINT [FK_PersonCards_IdentityDocs_Id] 
		FOREIGN KEY([IdentityDocId])
		REFERENCES [dbo].[IdentityDocs]([Id])
);
GO

CREATE TABLE [dbo].[IdempotencyKeys]
(
	[PersonCardId] INT NOT NULL,
	[Key] UNIQUEIDENTIFIER NOT NULL,
	[CreateDate] DATETIME NOT NULL,
	
	CONSTRAINT [PK_IdempotencyKeys] 
		PRIMARY KEY CLUSTERED ([PersonCardId]),
		
	CONSTRAINT [FK_IdempotencyKeys_PersonCards_Id] 
		FOREIGN KEY([PersonCardId])
		REFERENCES [dbo].[PersonCards]([Id])
);
GO

CREATE TABLE [dbo].[Directions]
(
	[Id] INT IDENTITY(1,1) NOT NULL,
	[DonorId] INT NOT NULL,
	[CurrentState] INT NOT NULL,
	[RegDate] DATETIME NOT NULL,
	[RegUserId] INT NOT NULL,
	[LastModifiedDate] DATETIME NULL,
	[LastModifiedUserId] INT NULL,

	CONSTRAINT [PK_Directions] 
		PRIMARY KEY CLUSTERED ([Id]),

	CONSTRAINT [FK_Directions_PersonCards_Id] 
		FOREIGN KEY([DonorId])
		REFERENCES [dbo].[PersonCards]([Id])
);
GO

CREATE TABLE [dbo].[DirectionEvents]
(
	[Id] INT IDENTITY(1,1) NOT NULL,
	[DirectionId] INT NOT NULL,
	[EventType] INT NOT NULL,
	[IsSent] BIT NOT NULL

	CONSTRAINT [PK_DirectionEvents] 
		PRIMARY KEY CLUSTERED ([Id]),
		
	CONSTRAINT [FK_DirectionEvents_Directions_Id] 
		FOREIGN KEY([DirectionId])
		REFERENCES [dbo].[Directions]([Id])
);
GO