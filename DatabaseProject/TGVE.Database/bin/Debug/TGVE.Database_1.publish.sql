﻿/*
Deployment script for TGVE.Database

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "TGVE.Database"
:setvar DefaultFilePrefix "TGVE.Database"
:setvar DefaultDataPath "C:\Users\102118963\AppData\Local\Microsoft\VisualStudio\SSDT"
:setvar DefaultLogPath "C:\Users\102118963\AppData\Local\Microsoft\VisualStudio\SSDT"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Creating $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Creating [dbo].[Clients]...';


GO
CREATE TABLE [dbo].[Clients] (
    [Id]          INT  IDENTITY (1, 1) NOT NULL,
    [FirstName]   TEXT NOT NULL,
    [LastName]    TEXT NOT NULL,
    [PhoneNumber] TEXT NOT NULL,
    [Address]     TEXT NOT NULL,
    [DateOfBirth] DATE NOT NULL,
    [Email]       TEXT NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[Tours]...';


GO
CREATE TABLE [dbo].[Tours] (
    [Id]            INT        IDENTITY (1, 1) NOT NULL,
    [TourStartTime] DATETIME   NOT NULL,
    [TourEndTime]   DATETIME   NOT NULL,
    [Name]          TEXT       NOT NULL,
    [Description]   TEXT       NOT NULL,
    [Area]          FLOAT (53) NOT NULL,
    [Location]      TEXT       NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
-- Refactoring step to update target server with deployed transaction logs

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
    EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
END
GO
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '1e18fac6-e883-4b5d-9b7d-1bcb98a510e5')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('1e18fac6-e883-4b5d-9b7d-1bcb98a510e5')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'c6a6c137-8840-4214-b4e1-d4ab8b145422')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('c6a6c137-8840-4214-b4e1-d4ab8b145422')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'cc4d1a78-7435-422f-a4ad-ef5e1d6c3e50')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('cc4d1a78-7435-422f-a4ad-ef5e1d6c3e50')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '3b0f196d-a13e-4697-a0d0-c231e927b4d9')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('3b0f196d-a13e-4697-a0d0-c231e927b4d9')

GO

GO
/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

/* INSERT STUDENTS */

delete from [Clients];
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Charline', 'Godbert', '+86 363 809 7872', '96783 Mccormick Alley', '12/20/2017', 'cgodbert0@woothemes.com');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Mateo', 'Surgen', '+62 287 568 5173', '2891 Thierer Alley', '12/7/2017', 'msurgen1@last.fm');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Sheila', 'Guillerman', '+351 279 855 2614', '363 Shelley Junction', '10/27/2018', 'sguillerman2@tripadvisor.com');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Elsinore', 'Cargenven', '+63 746 175 7237', '8 Westerfield Court', '2/2/2018', 'ecargenven3@statcounter.com');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Esteban', 'Turford', '+86 534 237 4852', '6398 Knutson Street', '4/1/2018', 'eturford4@latimes.com');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Xymenes', 'Prothero', '+20 838 146 2708', '219 Moland Street', '11/26/2017', 'xprothero5@ft.com');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Portia', 'Varsey', '+86 520 131 5083', '676 Ilene Parkway', '2/20/2018', 'pvarsey6@desdev.cn');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Westleigh', 'Ceschi', '+33 282 658 8928', '7 Union Way', '9/1/2018', 'wceschi7@wikipedia.org');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Ilse', 'Gilhoolie', '+7 657 351 7619', '34269 Gerald Drive', '7/21/2018', 'igilhoolie8@newsvine.com');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Clayson', 'Vogl', '+234 322 140 1371', '001 Straubel Hill', '9/28/2018', 'cvogl9@w3.org');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Gian', 'Luscott', '+86 284 768 5288', '4055 Forest Run Pass', '4/1/2018', 'gluscotta@smh.com.au');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Juli', 'McLoughlin', '+63 395 649 8889', '51 Del Mar Lane', '1/30/2018', 'jmcloughlinb@epa.gov');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Waverley', 'Curdell', '+234 891 478 5141', '7400 Barby Way', '5/7/2018', 'wcurdellc@google.co.uk');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Evelyn', 'Ohlsen', '+86 587 181 6596', '7872 Blackbird Road', '4/25/2018', 'eohlsend@alexa.com');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Cassandra', 'Gutridge', '+55 592 938 1387', '02982 Hanson Junction', '10/14/2018', 'cgutridgee@unblog.fr');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Porter', 'Raft', '+63 881 832 4151', '0 Nevada Circle', '8/20/2018', 'praftf@cornell.edu');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Gordan', 'Canete', '+33 915 988 3420', '527 Crowley Park', '10/31/2018', 'gcaneteg@ox.ac.uk');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Tate', 'Petracci', '+81 423 308 7091', '684 5th Plaza', '9/2/2018', 'tpetraccih@smh.com.au');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Thorvald', 'Ferres', '+36 608 675 1071', '361 Randy Circle', '10/17/2018', 'tferresi@google.de');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Kimble', 'Whimpenny', '+86 654 139 6390', '1 Fisk Lane', '11/5/2018', 'kwhimpennyj@last.fm');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Leann', 'Tristram', '+51 899 495 2744', '54 Thackeray Terrace', '10/31/2018', 'ltristramk@usa.gov');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Dolph', 'Goodbar', '+420 791 933 2994', '46 1st Park', '10/22/2018', 'dgoodbarl@stumbleupon.com');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Julina', 'Northin', '+54 693 359 8593', '2993 Vahlen Plaza', '3/14/2018', 'jnorthinm@yellowbook.com');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Junia', 'Juschke', '+351 991 690 6138', '1310 Morrow Court', '10/26/2018', 'jjuschken@intel.com');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Alex', 'Mila', '+62 788 968 7138', '97 Darwin Parkway', '4/17/2018', 'amilao@illinois.edu');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Paule', 'Joyes', '+86 306 505 7824', '88309 Bartillon Road', '2/19/2018', 'pjoyesp@elpais.com');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Ernst', 'Simonsson', '+7 235 982 9501', '1758 Raven Street', '7/18/2018', 'esimonssonq@usatoday.com');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Joanne', 'Belt', '+27 521 103 4141', '22024 Talisman Pass', '9/1/2018', 'jbeltr@senate.gov');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Genna', 'Critchard', '+86 365 134 1798', '7602 Colorado Trail', '4/2/2018', 'gcritchards@jiathis.com');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Dar', 'Steely', '+57 648 234 5850', '085 Rockefeller Park', '12/4/2017', 'dsteelyt@istockphoto.com');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Tamara', 'Renol', '+51 446 877 5043', '29586 Kinsman Way', '1/22/2018', 'trenolu@netlog.com');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Oates', 'Cobon', '+7 991 624 1645', '27278 Dahle Pass', '9/21/2018', 'ocobonv@about.com');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Dale', 'de Juares', '+55 712 445 0316', '14133 Emmet Way', '8/27/2018', 'ddejuaresw@vistaprint.com');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Gavra', 'Abbe', '+86 308 344 2685', '22543 Corscot Road', '12/23/2017', 'gabbex@columbia.edu');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Yankee', 'Ezzle', '+33 296 412 5686', '7 Maryland Point', '10/29/2018', 'yezzley@kickstarter.com');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Gill', 'Skayman', '+48 747 719 5245', '47 Green Ridge Road', '11/28/2017', 'gskaymanz@squarespace.com');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Eric', 'Lodewick', '+66 899 579 6727', '7773 Pankratz Alley', '4/5/2018', 'elodewick10@goo.gl');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Kassey', 'McParlin', '+55 162 749 6564', '24 Muir Plaza', '9/9/2018', 'kmcparlin11@eventbrite.com');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Locke', 'Ruske', '+52 327 847 7132', '1322 Barnett Terrace', '12/16/2017', 'lruske12@e-recht24.de');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Igor', 'Sirett', '+86 780 422 7279', '9 Village Pass', '10/18/2018', 'isirett13@last.fm');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Hermione', 'Lashley', '+7 812 199 4318', '382 Di Loreto Circle', '11/24/2017', 'hlashley14@mayoclinic.com');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Terese', 'Sommerlie', '+234 729 506 3561', '0263 Forest Run Plaza', '3/26/2018', 'tsommerlie15@ebay.com');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Ilyssa', 'Stockle', '+86 795 543 7721', '32 Ridgeview Avenue', '7/19/2018', 'istockle16@reverbnation.com');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Cristie', 'Langforth', '+86 734 378 3237', '83 Old Gate Court', '2/19/2018', 'clangforth17@fda.gov');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Odelinda', 'Whyteman', '+63 719 388 3611', '156 3rd Park', '10/3/2018', 'owhyteman18@prlog.org');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Thomasin', 'Alcorn', '+86 785 685 9543', '64 Talmadge Pass', '11/3/2018', 'talcorn19@stanford.edu');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Nap', 'Wiggin', '+86 574 519 7036', '00121 Merchant Drive', '8/19/2018', 'nwiggin1a@ted.com');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Becka', 'Padbury', '+86 850 968 6054', '77725 Main Drive', '3/19/2018', 'bpadbury1b@deviantart.com');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Adrianna', 'Siman', '+86 206 888 4305', '67 Acker Court', '4/26/2018', 'asiman1c@jiathis.com');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Christabel', 'Scranney', '+86 136 214 6280', '655 Delaware Park', '6/18/2018', 'cscranney1d@ed.gov');
insert into Clients (FirstName, LastName, PhoneNumber, [Address], DateOfBirth, Email) values ('Dianne', 'Antonsen', '+1 815 344 7878', '9236 Blue Bill Park Parkway', '11/12/2018', 'dantonsen1e@si.edu');

/* INSERT SESSIONS */
delete from [Tours];
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2018-01-16 08:29:28', '2017-11-09 05:43:29', 'Klein Inc', 'vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum sed magna at nunc commodo placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id', 727.75, '97 Vera Circle');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2018-05-19 20:01:17', '2018-03-04 04:49:19', 'Larkin-White', 'odio porttitor id consequat in consequat ut nulla sed accumsan', 761.63, '64 Express Terrace');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2018-05-08 17:23:06', '2018-09-14 11:05:54', 'Flatley LLC', 'primis in faucibus orci luctus et ultrices posuere cubilia curae nulla', 740.41, '5 Jackson Pass');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2017-11-17 14:56:11', '2018-06-13 01:36:01', 'MacGyver-Wintheiser', 'molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in', 170.05, '77246 Scott Trail');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2018-05-12 06:25:51', '2018-01-31 17:34:41', 'Rice, Gleason and Ebert', 'commodo placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget tempus vel pede morbi', 917.77, '69 Sachtjen Center');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2018-09-26 01:21:26', '2018-03-15 02:22:47', 'Blick, Swift and Gottlieb', 'sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida', 326.68, '4526 Manufacturers Park');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2018-01-29 15:04:40', '2017-12-07 11:04:18', 'Russel Group', 'porttitor lorem id ligula suspendisse ornare consequat lectus in est risus auctor sed tristique in tempus sit amet sem fusce consequat nulla nisl nunc nisl duis bibendum felis sed interdum venenatis turpis enim blandit mi in porttitor pede justo', 27.06, '42623 Arapahoe Lane');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2018-02-27 11:38:22', '2018-07-18 10:31:00', 'Will-Predovic', 'eu magna vulputate luctus cum sociis natoque', 325.68, '3328 Springs Terrace');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2018-01-11 20:03:45', '2018-09-07 15:41:40', 'Kunze, Bergnaum and Johnston', 'placerat ante nulla justo aliquam quis', 754.91, '34142 Dexter Trail');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2018-07-09 21:04:46', '2018-04-25 17:10:07', 'Gutkowski-Kling', 'cubilia curae nulla dapibus dolor vel est donec odio justo sollicitudin ut suscipit a feugiat et eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare', 17.33, '853 Dunning Lane');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2017-11-16 10:18:44', '2017-12-20 20:53:04', 'Bechtelar Group', 'justo morbi ut odio cras mi pede malesuada in imperdiet et commodo vulputate justo in blandit ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris', 447.77, '9 Warner Alley');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2018-06-13 03:55:58', '2018-06-06 23:46:24', 'Bosco-Botsford', 'fusce posuere felis sed lacus morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel sem sed sagittis nam congue risus semper', 966.81, '89996 Oak Trail');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2018-03-14 03:25:33', '2018-06-18 07:41:21', 'Flatley, Cassin and Hilll', 'gravida sem praesent id massa id nisl venenatis lacinia aenean sit amet justo morbi ut odio cras mi pede malesuada in imperdiet et commodo vulputate justo in blandit ultrices enim lorem ipsum dolor sit amet consectetuer', 956.14, '2 Muir Center');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2018-08-05 00:16:02', '2018-08-17 07:50:53', 'Powlowski-Schmitt', 'donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet nullam orci pede venenatis non sodales', 305.99, '67 Logan Pass');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2018-09-08 01:14:00', '2018-10-24 19:53:50', 'Mante, Gutkowski and Ratke', 'sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat volutpat in congue etiam justo', 351.8, '57081 Stoughton Junction');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2017-11-18 04:15:06', '2018-07-28 05:51:14', 'Quigley, Mertz and Kilback', 'diam vitae quam suspendisse potenti nullam porttitor lacus', 91.73, '6649 Sachs Place');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2018-06-22 06:29:41', '2017-12-05 08:42:59', 'Ernser-Quigley', 'lectus pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus vivamus', 923.49, '396 Atwood Avenue');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2018-08-23 12:24:58', '2018-10-29 21:32:44', 'Abbott and Sons', 'nulla mollis molestie lorem quisque ut erat curabitur gravida nisi at nibh in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer', 576.4, '92578 Transport Point');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2018-02-18 11:55:21', '2018-06-27 01:30:14', 'Kulas, Kemmer and Batz', 'donec odio justo sollicitudin ut suscipit a feugiat et eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id', 240.77, '90410 Cordelia Way');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2018-05-26 02:03:31', '2018-10-17 15:29:05', 'Gerhold Inc', 'ultricies eu nibh quisque id justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel est donec odio justo sollicitudin ut', 592.6, '5660 Holmberg Trail');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2018-06-05 01:21:03', '2018-01-26 04:43:43', 'Stroman-Kozey', 'lobortis convallis tortor risus dapibus augue vel accumsan', 838.45, '1 Mayfield Center');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2018-09-29 04:59:16', '2018-06-22 01:05:25', 'Champlin, Hyatt and Rippin', 'posuere felis sed lacus morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel sem sed sagittis nam congue risus semper porta volutpat', 907.64, '9949 4th Center');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2018-04-18 17:11:53', '2018-06-20 03:39:03', 'Kuhn, Hamill and Lemke', 'tortor duis mattis egestas metus aenean fermentum donec ut mauris eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh quisque id justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in', 11.19, '64477 Pleasure Crossing');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2018-10-15 11:26:00', '2018-10-26 00:21:44', 'Bradtke LLC', 'dui vel nisl duis ac nibh fusce lacus purus aliquet', 253.75, '7689 Hudson Trail');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2018-05-27 04:11:46', '2018-09-03 14:58:38', 'Berge and Sons', 'felis donec semper sapien a libero nam dui proin leo odio porttitor id consequat in consequat ut nulla sed accumsan felis ut at dolor quis odio consequat varius integer ac leo pellentesque ultrices mattis odio', 836.3, '76191 5th Terrace');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2018-04-11 15:47:38', '2017-11-09 00:15:26', 'Effertz Group', 'sapien placerat ante nulla justo aliquam quis turpis eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis mattis', 349.16, '86 Morningstar Alley');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2018-06-26 19:40:52', '2017-11-11 18:48:20', 'Langosh, Dickinson and Kertzmann', 'aliquet at feugiat non pretium quis lectus suspendisse potenti in eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis molestie lorem quisque ut erat curabitur', 139.21, '76925 Del Sol Center');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2017-12-31 13:49:40', '2018-07-29 14:08:30', 'Erdman, Ferry and Jerde', 'ornare consequat lectus in est risus auctor sed tristique in tempus sit amet sem fusce consequat nulla nisl nunc nisl duis bibendum felis sed interdum venenatis turpis enim blandit mi in porttitor pede justo eu massa', 455.26, '26 Johnson Hill');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2018-03-06 10:25:11', '2018-06-06 08:48:06', 'Collins, Russel and Gaylord', 'donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien non mi integer ac neque duis bibendum morbi non quam nec dui luctus rutrum nulla tellus in sagittis dui vel nisl duis', 591.9, '816 Redwing Terrace');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2018-01-25 12:02:40', '2017-11-15 07:54:21', 'Mitchell-Mohr', 'felis sed interdum venenatis turpis enim blandit mi in porttitor pede justo eu massa donec dapibus duis', 726.93, '4 Graceland Circle');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2018-07-09 13:46:16', '2018-04-01 20:28:31', 'Altenwerth-Borer', 'ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla', 410.03, '9 Quincy Circle');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2018-01-30 12:48:34', '2018-01-10 15:21:18', 'Batz, Hintz and Yost', 'sit amet eleifend pede libero quis orci nullam molestie nibh in lectus pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate luctus cum', 979.9, '77423 Maryland Pass');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2017-11-30 05:19:15', '2018-06-25 09:23:24', 'Gerlach-Bruen', 'mi nulla ac enim in tempor turpis nec euismod scelerisque quam turpis adipiscing', 985.0, '1649 Annamark Terrace');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2018-10-01 23:19:38', '2018-09-13 07:37:04', 'Hyatt-Kuhn', 'nullam orci pede venenatis non sodales sed tincidunt eu felis fusce posuere felis sed lacus morbi sem mauris laoreet', 25.75, '8423 Melvin Pass');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2018-05-26 04:00:05', '2018-05-03 07:07:45', 'Nolan, Lowe and Powlowski', 'id consequat in consequat ut nulla sed accumsan felis ut at dolor quis odio consequat varius integer ac leo pellentesque ultrices mattis odio donec vitae nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue', 399.53, '3 Waywood Hill');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2018-08-24 00:00:54', '2018-01-08 17:37:51', 'Koss, Langosh and Kris', 'nisl nunc nisl duis bibendum felis sed interdum venenatis turpis enim blandit mi in porttitor pede justo eu massa donec dapibus duis at velit eu est congue elementum in hac habitasse platea', 976.93, '17 Village Green Alley');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2018-03-06 21:54:19', '2018-02-04 22:08:35', 'McLaughlin Inc', 'vel lectus in quam fringilla rhoncus mauris', 33.58, '33 Rigney Road');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2018-01-05 05:21:45', '2018-01-19 05:08:21', 'Morissette Group', 'in hac habitasse platea dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis molestie lorem quisque ut erat curabitur gravida nisi at nibh in', 474.94, '7 Golden Leaf Terrace');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2018-02-10 02:32:12', '2017-12-22 06:44:51', 'Rice, Conroy and Reynolds', 'semper est quam pharetra magna ac consequat metus sapien ut nunc vestibulum ante ipsum primis', 711.59, '8 Havey Alley');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2017-12-27 11:54:10', '2018-09-08 22:57:18', 'Olson, Denesik and Schaden', 'dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis molestie lorem quisque ut erat curabitur gravida nisi at nibh in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget', 691.42, '332 Mallory Pass');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2018-02-13 11:14:22', '2018-03-27 13:34:15', 'Hoppe, Weber and Douglas', 'cursus urna ut tellus nulla ut erat id mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy', 578.13, '04575 Hovde Place');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2018-07-16 12:23:02', '2018-09-13 07:19:44', 'Ernser Group', 'orci luctus et ultrices posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi', 584.92, '2 Fulton Way');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2018-04-17 00:31:29', '2017-12-11 10:06:39', 'Yundt and Sons', 'ligula nec sem duis aliquam convallis nunc proin at turpis a pede posuere nonummy integer non velit donec diam neque vestibulum eget vulputate ut ultrices vel augue vestibulum ante ipsum', 758.64, '28335 Jenna Pass');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2018-08-19 04:45:29', '2017-12-22 16:10:11', 'Torphy LLC', 'magnis dis parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id massa id nisl venenatis lacinia aenean sit amet justo morbi ut odio cras mi pede malesuada in imperdiet et commodo', 317.26, '65009 Fairview Place');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2018-07-14 02:29:36', '2018-01-13 15:45:53', 'Ruecker Group', 'felis sed interdum venenatis turpis enim blandit mi in porttitor pede justo eu massa donec', 776.36, '4 Maple Street');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2018-05-23 18:35:22', '2017-12-23 09:55:01', 'Kilback-Dare', 'a nibh in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla', 895.81, '087 Sunbrook Pass');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2018-08-25 22:29:31', '2018-01-12 10:00:52', 'Metz Inc', 'at vulputate vitae nisl aenean lectus pellentesque eget nunc donec quis orci eget orci vehicula condimentum', 42.79, '7 Norway Maple Junction');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2018-02-26 21:41:25', '2018-02-21 22:38:04', 'Ritchie-Lind', 'non mi integer ac neque duis bibendum morbi', 897.89, '7 Sugar Lane');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2018-08-11 02:12:02', '2018-05-01 16:34:00', 'Pfannerstill-Hills', 'donec quis orci eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat nulla', 142.92, '2 Spohn Place');
insert into Tours (TourStartTime, TourEndTime, [Name], [Description], Area, [Location]) values ('2018-08-13 18:34:43', '2018-02-24 01:32:38', 'Leuschke and Sons', 'suspendisse ornare consequat lectus in', 476.58, '93 Dakota Lane');
GO

GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Update complete.';


GO
