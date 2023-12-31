USE [master]
GO
/****** Object:  Database [ExamModule]    Script Date: 17-01-2021 15:31:45 ******/
CREATE DATABASE [ExamModule]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ExamModule', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\ExamModule.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ExamModule_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\ExamModule_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [ExamModule] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ExamModule].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ExamModule] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ExamModule] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ExamModule] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ExamModule] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ExamModule] SET ARITHABORT OFF 
GO
ALTER DATABASE [ExamModule] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ExamModule] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ExamModule] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ExamModule] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ExamModule] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ExamModule] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ExamModule] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ExamModule] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ExamModule] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ExamModule] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ExamModule] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ExamModule] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ExamModule] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ExamModule] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ExamModule] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ExamModule] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ExamModule] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ExamModule] SET RECOVERY FULL 
GO
ALTER DATABASE [ExamModule] SET  MULTI_USER 
GO
ALTER DATABASE [ExamModule] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ExamModule] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ExamModule] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ExamModule] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ExamModule] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ExamModule] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'ExamModule', N'ON'
GO
ALTER DATABASE [ExamModule] SET QUERY_STORE = OFF
GO
USE [ExamModule]
GO
/****** Object:  Table [dbo].[TBL_Admin]    Script Date: 17-01-2021 15:31:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_Admin](
	[Admin_ID] [int] IDENTITY(1,1) NOT NULL,
	[Admin_Key] [varchar](50) NOT NULL,
	[Admin_Password] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TBL_Admin] PRIMARY KEY CLUSTERED 
(
	[Admin_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TBL_Class]    Script Date: 17-01-2021 15:31:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_Class](
	[Class_ID] [int] IDENTITY(1,1) NOT NULL,
	[Class_Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TBL_Class] PRIMARY KEY CLUSTERED 
(
	[Class_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TBL_DESQAnswer]    Script Date: 17-01-2021 15:31:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_DESQAnswer](
	[Schedule_ID] [int] NOT NULL,
	[Stud_ID] [int] NOT NULL,
	[Question_ID] [int] NOT NULL,
	[Answer] [varchar](max) NOT NULL,
	[Remarks] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TBL_DESQNA]    Script Date: 17-01-2021 15:31:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_DESQNA](
	[Question_ID] [int] IDENTITY(1,1) NOT NULL,
	[Schedule_ID] [int] NOT NULL,
	[Question] [varchar](max) NOT NULL,
 CONSTRAINT [PK_TBL_DESQNA] PRIMARY KEY CLUSTERED 
(
	[Question_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TBL_Faculty]    Script Date: 17-01-2021 15:31:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_Faculty](
	[Faculty_ID] [int] IDENTITY(1,1) NOT NULL,
	[Faculty_Name] [text] NOT NULL,
	[Email_ID] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[Subject_ID] [int] NOT NULL,
 CONSTRAINT [PK_TBL_Faculty] PRIMARY KEY CLUSTERED 
(
	[Faculty_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TBL_MCQAnswer]    Script Date: 17-01-2021 15:31:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_MCQAnswer](
	[Schedule_ID] [int] NOT NULL,
	[Stud_ID] [int] NOT NULL,
	[Question_ID] [int] NOT NULL,
	[Answer] [varchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TBL_MCQNA]    Script Date: 17-01-2021 15:31:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_MCQNA](
	[Question_ID] [int] IDENTITY(1,1) NOT NULL,
	[Schedule_ID] [int] NOT NULL,
	[Question] [varchar](max) NOT NULL,
	[Option_A] [varchar](50) NOT NULL,
	[Option_B] [varchar](50) NOT NULL,
	[Option_C] [varchar](50) NOT NULL,
	[Option_D] [varchar](50) NOT NULL,
	[Correct_Option] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TBL_MCQNA] PRIMARY KEY CLUSTERED 
(
	[Question_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TBL_Result]    Script Date: 17-01-2021 15:31:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_Result](
	[Result_ID] [int] IDENTITY(1,1) NOT NULL,
	[Stud_ID] [int] NOT NULL,
	[Sch_ID] [int] NOT NULL,
	[Marks_Obtained] [decimal](5, 2) NOT NULL,
 CONSTRAINT [PK_TBL_Result] PRIMARY KEY CLUSTERED 
(
	[Result_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TBL_Schedule]    Script Date: 17-01-2021 15:31:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_Schedule](
	[Schedule_ID] [int] IDENTITY(1,1) NOT NULL,
	[Class_ID] [int] NOT NULL,
	[Subject_ID] [int] NOT NULL,
	[Date] [date] NOT NULL,
	[Start_Time] [time](0) NOT NULL,
	[End_Time] [time](0) NOT NULL,
	[Exam_Type] [text] NOT NULL,
	[Start_Limit] [int] NOT NULL,
 CONSTRAINT [PK_TBL_Schedule] PRIMARY KEY CLUSTERED 
(
	[Schedule_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TBL_Student]    Script Date: 17-01-2021 15:31:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_Student](
	[Stud_ID] [int] IDENTITY(1,1) NOT NULL,
	[Stud_Name] [text] NOT NULL,
	[Email_ID] [varchar](50) NOT NULL,
	[Passsword] [varchar](50) NOT NULL,
	[Class_ID] [int] NOT NULL,
	[Enrollment] [varchar](50) NOT NULL,
	[Seat_No] [int] NOT NULL,
 CONSTRAINT [PK_TBL_Student] PRIMARY KEY CLUSTERED 
(
	[Stud_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TBL_Subject]    Script Date: 17-01-2021 15:31:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_Subject](
	[Subject_ID] [int] IDENTITY(1,1) NOT NULL,
	[Subject_Name] [text] NOT NULL,
	[Class_ID] [int] NOT NULL,
 CONSTRAINT [PK_TBL_Subject] PRIMARY KEY CLUSTERED 
(
	[Subject_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[TBL_Class] ON 

INSERT [dbo].[TBL_Class] ([Class_ID], [Class_Name]) VALUES (1, N'FYCS Sem 1')
INSERT [dbo].[TBL_Class] ([Class_ID], [Class_Name]) VALUES (2, N'FYCS Sem 2')
INSERT [dbo].[TBL_Class] ([Class_ID], [Class_Name]) VALUES (3, N'SYCS Sem 3')
INSERT [dbo].[TBL_Class] ([Class_ID], [Class_Name]) VALUES (4, N'SYCS Sem 4')
INSERT [dbo].[TBL_Class] ([Class_ID], [Class_Name]) VALUES (5, N'TYCS Sem 5')
INSERT [dbo].[TBL_Class] ([Class_ID], [Class_Name]) VALUES (6, N'TYCS Sem 6')
SET IDENTITY_INSERT [dbo].[TBL_Class] OFF
GO
SET IDENTITY_INSERT [dbo].[TBL_DESQNA] ON 

INSERT [dbo].[TBL_DESQNA] ([Question_ID], [Schedule_ID], [Question]) VALUES (3, 4, N'What is the main difference between a computer program and computer software?')
INSERT [dbo].[TBL_DESQNA] ([Question_ID], [Schedule_ID], [Question]) VALUES (4, 4, N' What is software re-engineering?')
INSERT [dbo].[TBL_DESQNA] ([Question_ID], [Schedule_ID], [Question]) VALUES (5, 4, N'What is verification ?')
INSERT [dbo].[TBL_DESQNA] ([Question_ID], [Schedule_ID], [Question]) VALUES (7, 4, N'What is validation ?')
INSERT [dbo].[TBL_DESQNA] ([Question_ID], [Schedule_ID], [Question]) VALUES (8, 4, N'What language do you like to write programming algorithms?')
INSERT [dbo].[TBL_DESQNA] ([Question_ID], [Schedule_ID], [Question]) VALUES (9, 1005, N'What is CN?')
SET IDENTITY_INSERT [dbo].[TBL_DESQNA] OFF
GO
SET IDENTITY_INSERT [dbo].[TBL_MCQNA] ON 

INSERT [dbo].[TBL_MCQNA] ([Question_ID], [Schedule_ID], [Question], [Option_A], [Option_B], [Option_C], [Option_D], [Correct_Option]) VALUES (2, 2, N'What is SE ?', N'Soft Emissions', N'Software Electronics', N'Smart Engine', N'Software Engineering', N'Software Engineering')
INSERT [dbo].[TBL_MCQNA] ([Question_ID], [Schedule_ID], [Question], [Option_A], [Option_B], [Option_C], [Option_D], [Correct_Option]) VALUES (3, 2, N'Why use SE ?', N'Better Developement', N'Reliable Software', N'All Mentioned Options', N'Better Security', N'All Mentioned Options')
INSERT [dbo].[TBL_MCQNA] ([Question_ID], [Schedule_ID], [Question], [Option_A], [Option_B], [Option_C], [Option_D], [Correct_Option]) VALUES (4, 2, N'Efficiency in a software product does not include ____________________?', N'Responsiveness', N'Licensing', N'Memory Utilization', N'Processing Time', N'Licensing')
INSERT [dbo].[TBL_MCQNA] ([Question_ID], [Schedule_ID], [Question], [Option_A], [Option_B], [Option_C], [Option_D], [Correct_Option]) VALUES (5, 2, N'What are attributes of good software ?', N' Software Maintainability', N'Software Functionality', N'Software Development', N'Software Maintainability & Functionality', N'Software Maintainability & Functionality')
INSERT [dbo].[TBL_MCQNA] ([Question_ID], [Schedule_ID], [Question], [Option_A], [Option_B], [Option_C], [Option_D], [Correct_Option]) VALUES (6, 2, N'Which of these does not account for software failure ?', N'Increasing Demand', N'Low Expectation', N'Increasing Supply', N'Less Reliable And Expensive', N'Increasing Supply')
INSERT [dbo].[TBL_MCQNA] ([Question_ID], [Schedule_ID], [Question], [Option_A], [Option_B], [Option_C], [Option_D], [Correct_Option]) VALUES (7, 2, N'Which of these software engineering activities are not a part of software processes ?', N'Software Dependence', N'Software Development
', N'Software Validation', N'Software Specification', N'Software Dependence')
INSERT [dbo].[TBL_MCQNA] ([Question_ID], [Schedule_ID], [Question], [Option_A], [Option_B], [Option_C], [Option_D], [Correct_Option]) VALUES (8, 7, N' Which type of topology is best suited for large businesses which must carefully control and coordinate the operation of distributed branch outlets?', N'Ring', N'Local area', N'Hierarchical', N'Star', N'Star')
INSERT [dbo].[TBL_MCQNA] ([Question_ID], [Schedule_ID], [Question], [Option_A], [Option_B], [Option_C], [Option_D], [Correct_Option]) VALUES (9, 7, N'Which of the following transmission directions listed is not a legitimate channel?', N'Simplex', N'Half Duplex', N'Full Duplex', N'Double Duplex', N'Double Duplex')
INSERT [dbo].[TBL_MCQNA] ([Question_ID], [Schedule_ID], [Question], [Option_A], [Option_B], [Option_C], [Option_D], [Correct_Option]) VALUES (10, 7, N' "Parity bits" are used for which of the following purposes?', N'Encryption of data', N'To transmit faster', N'To detect errors', N'To identify the user', N'To detect errors')
INSERT [dbo].[TBL_MCQNA] ([Question_ID], [Schedule_ID], [Question], [Option_A], [Option_B], [Option_C], [Option_D], [Correct_Option]) VALUES (12, 7, N'What kind of transmission medium is most appropriate to carry data in a computer network that is exposed to electrical interferences?', N'Unshielded twisted pair', N'Optical fiber', N'Coaxial cable', N'Microwave', N'Optical fiber')
INSERT [dbo].[TBL_MCQNA] ([Question_ID], [Schedule_ID], [Question], [Option_A], [Option_B], [Option_C], [Option_D], [Correct_Option]) VALUES (13, 7, N'A collection of hyperlinked documents on the internet forms the ?', N'World Wide Web (WWW)', N'E-mail system', N'Mailing list', N'Hypertext markup language', N'World Wide Web (WWW)')
INSERT [dbo].[TBL_MCQNA] ([Question_ID], [Schedule_ID], [Question], [Option_A], [Option_B], [Option_C], [Option_D], [Correct_Option]) VALUES (14, 7, N'The term HTTP stands for?', N'Hyper terminal tracing program', N'Hypertext tracing protocol', N'Hypertext transfer protocol', N'Hypertext transfer program', N'Hypertext transfer protocol')
SET IDENTITY_INSERT [dbo].[TBL_MCQNA] OFF
GO
SET IDENTITY_INSERT [dbo].[TBL_Schedule] ON 

INSERT [dbo].[TBL_Schedule] ([Schedule_ID], [Class_ID], [Subject_ID], [Date], [Start_Time], [End_Time], [Exam_Type], [Start_Limit]) VALUES (2, 5, 1, CAST(N'2021-01-03' AS Date), CAST(N'13:00:00' AS Time), CAST(N'23:00:00' AS Time), N'MCQ', 1000)
INSERT [dbo].[TBL_Schedule] ([Schedule_ID], [Class_ID], [Subject_ID], [Date], [Start_Time], [End_Time], [Exam_Type], [Start_Limit]) VALUES (4, 5, 1, CAST(N'2021-01-04' AS Date), CAST(N'13:20:00' AS Time), CAST(N'21:33:00' AS Time), N'Descriptive', 1000)
INSERT [dbo].[TBL_Schedule] ([Schedule_ID], [Class_ID], [Subject_ID], [Date], [Start_Time], [End_Time], [Exam_Type], [Start_Limit]) VALUES (7, 5, 2, CAST(N'2021-01-05' AS Date), CAST(N'11:55:00' AS Time), CAST(N'13:07:00' AS Time), N'MCQ', 1000)
INSERT [dbo].[TBL_Schedule] ([Schedule_ID], [Class_ID], [Subject_ID], [Date], [Start_Time], [End_Time], [Exam_Type], [Start_Limit]) VALUES (1005, 5, 2, CAST(N'2021-01-05' AS Date), CAST(N'22:45:00' AS Time), CAST(N'22:55:00' AS Time), N'Descriptive', 1000)
SET IDENTITY_INSERT [dbo].[TBL_Schedule] OFF
GO
SET IDENTITY_INSERT [dbo].[TBL_Student] ON 

INSERT [dbo].[TBL_Student] ([Stud_ID], [Stud_Name], [Email_ID], [Passsword], [Class_ID], [Enrollment], [Seat_No]) VALUES (1, N'Gurudatta Safai', N'GurudattaSafai@gmail.com', N'Guru@123', 5, N'E1811192000310085', 20120)
INSERT [dbo].[TBL_Student] ([Stud_ID], [Stud_Name], [Email_ID], [Passsword], [Class_ID], [Enrollment], [Seat_No]) VALUES (2, N'Nilesh Patil', N'Nillpatil@gmail.com', N'Nill@123', 5, N'E1811192000310074', 20121)
INSERT [dbo].[TBL_Student] ([Stud_ID], [Stud_Name], [Email_ID], [Passsword], [Class_ID], [Enrollment], [Seat_No]) VALUES (1003, N'Mayur Patil', N'mpatil9@gmail.com', N'MP@DJ12', 5, N'E1811192000310073', 20122)
SET IDENTITY_INSERT [dbo].[TBL_Student] OFF
GO
SET IDENTITY_INSERT [dbo].[TBL_Subject] ON 

INSERT [dbo].[TBL_Subject] ([Subject_ID], [Subject_Name], [Class_ID]) VALUES (1, N'Software Engineering - I', 5)
INSERT [dbo].[TBL_Subject] ([Subject_ID], [Subject_Name], [Class_ID]) VALUES (2, N'Computer Networking', 5)
SET IDENTITY_INSERT [dbo].[TBL_Subject] OFF
GO
ALTER TABLE [dbo].[TBL_DESQAnswer]  WITH CHECK ADD  CONSTRAINT [FK_DESQAnswer_TBL_DESQNA] FOREIGN KEY([Question_ID])
REFERENCES [dbo].[TBL_DESQNA] ([Question_ID])
GO
ALTER TABLE [dbo].[TBL_DESQAnswer] CHECK CONSTRAINT [FK_DESQAnswer_TBL_DESQNA]
GO
ALTER TABLE [dbo].[TBL_DESQAnswer]  WITH CHECK ADD  CONSTRAINT [FK_DESQAnswer_TBL_Schedule] FOREIGN KEY([Schedule_ID])
REFERENCES [dbo].[TBL_Schedule] ([Schedule_ID])
GO
ALTER TABLE [dbo].[TBL_DESQAnswer] CHECK CONSTRAINT [FK_DESQAnswer_TBL_Schedule]
GO
ALTER TABLE [dbo].[TBL_DESQAnswer]  WITH CHECK ADD  CONSTRAINT [FK_DESQAnswer_TBL_Student] FOREIGN KEY([Stud_ID])
REFERENCES [dbo].[TBL_Student] ([Stud_ID])
GO
ALTER TABLE [dbo].[TBL_DESQAnswer] CHECK CONSTRAINT [FK_DESQAnswer_TBL_Student]
GO
ALTER TABLE [dbo].[TBL_DESQNA]  WITH CHECK ADD  CONSTRAINT [FK_DESQNA_Schedule] FOREIGN KEY([Schedule_ID])
REFERENCES [dbo].[TBL_Schedule] ([Schedule_ID])
GO
ALTER TABLE [dbo].[TBL_DESQNA] CHECK CONSTRAINT [FK_DESQNA_Schedule]
GO
ALTER TABLE [dbo].[TBL_Faculty]  WITH CHECK ADD  CONSTRAINT [FK_Faculty_Subject] FOREIGN KEY([Subject_ID])
REFERENCES [dbo].[TBL_Subject] ([Subject_ID])
GO
ALTER TABLE [dbo].[TBL_Faculty] CHECK CONSTRAINT [FK_Faculty_Subject]
GO
ALTER TABLE [dbo].[TBL_MCQAnswer]  WITH CHECK ADD  CONSTRAINT [FK_TBL_MCQAnswer_TBL_MCQNA] FOREIGN KEY([Question_ID])
REFERENCES [dbo].[TBL_MCQNA] ([Question_ID])
GO
ALTER TABLE [dbo].[TBL_MCQAnswer] CHECK CONSTRAINT [FK_TBL_MCQAnswer_TBL_MCQNA]
GO
ALTER TABLE [dbo].[TBL_MCQAnswer]  WITH CHECK ADD  CONSTRAINT [FK_TBL_MCQAnswer_TBL_Schedule] FOREIGN KEY([Schedule_ID])
REFERENCES [dbo].[TBL_Schedule] ([Schedule_ID])
GO
ALTER TABLE [dbo].[TBL_MCQAnswer] CHECK CONSTRAINT [FK_TBL_MCQAnswer_TBL_Schedule]
GO
ALTER TABLE [dbo].[TBL_MCQAnswer]  WITH CHECK ADD  CONSTRAINT [FK_TBL_MCQAnswer_TBL_Student] FOREIGN KEY([Stud_ID])
REFERENCES [dbo].[TBL_Student] ([Stud_ID])
GO
ALTER TABLE [dbo].[TBL_MCQAnswer] CHECK CONSTRAINT [FK_TBL_MCQAnswer_TBL_Student]
GO
ALTER TABLE [dbo].[TBL_MCQNA]  WITH CHECK ADD  CONSTRAINT [FK_MCQNA_Schedule] FOREIGN KEY([Schedule_ID])
REFERENCES [dbo].[TBL_Schedule] ([Schedule_ID])
GO
ALTER TABLE [dbo].[TBL_MCQNA] CHECK CONSTRAINT [FK_MCQNA_Schedule]
GO
ALTER TABLE [dbo].[TBL_Result]  WITH CHECK ADD  CONSTRAINT [FK_TBL_Result_TBL_Schedule] FOREIGN KEY([Sch_ID])
REFERENCES [dbo].[TBL_Schedule] ([Schedule_ID])
GO
ALTER TABLE [dbo].[TBL_Result] CHECK CONSTRAINT [FK_TBL_Result_TBL_Schedule]
GO
ALTER TABLE [dbo].[TBL_Result]  WITH CHECK ADD  CONSTRAINT [FK_TBL_Result_TBL_Student] FOREIGN KEY([Stud_ID])
REFERENCES [dbo].[TBL_Student] ([Stud_ID])
GO
ALTER TABLE [dbo].[TBL_Result] CHECK CONSTRAINT [FK_TBL_Result_TBL_Student]
GO
ALTER TABLE [dbo].[TBL_Schedule]  WITH CHECK ADD  CONSTRAINT [FK_TBL_Schedule_TBL_Class] FOREIGN KEY([Class_ID])
REFERENCES [dbo].[TBL_Class] ([Class_ID])
GO
ALTER TABLE [dbo].[TBL_Schedule] CHECK CONSTRAINT [FK_TBL_Schedule_TBL_Class]
GO
ALTER TABLE [dbo].[TBL_Schedule]  WITH CHECK ADD  CONSTRAINT [FK_TBL_Schedule_TBL_Subject] FOREIGN KEY([Subject_ID])
REFERENCES [dbo].[TBL_Subject] ([Subject_ID])
GO
ALTER TABLE [dbo].[TBL_Schedule] CHECK CONSTRAINT [FK_TBL_Schedule_TBL_Subject]
GO
ALTER TABLE [dbo].[TBL_Student]  WITH CHECK ADD  CONSTRAINT [FK_Student_Class] FOREIGN KEY([Class_ID])
REFERENCES [dbo].[TBL_Class] ([Class_ID])
GO
ALTER TABLE [dbo].[TBL_Student] CHECK CONSTRAINT [FK_Student_Class]
GO
ALTER TABLE [dbo].[TBL_Subject]  WITH CHECK ADD  CONSTRAINT [FK_Subject_Class] FOREIGN KEY([Class_ID])
REFERENCES [dbo].[TBL_Class] ([Class_ID])
GO
ALTER TABLE [dbo].[TBL_Subject] CHECK CONSTRAINT [FK_Subject_Class]
GO
USE [master]
GO
ALTER DATABASE [ExamModule] SET  READ_WRITE 
GO
