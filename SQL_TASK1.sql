CREATE DATABASE LibraryManagementDB;
USE LibraryManagementDB;

CREATE TABLE LibraryMembers (
    MemberID INT PRIMARY KEY,  
    FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(20) NOT NULL,
    Email VARCHAR(50) UNIQUE NOT NULL,  
    PhoneNumber VARCHAR(15) UNIQUE,
    JoinDate DATE NOT NULL,
    AccountStatus ENUM('Active', 'Inactive') DEFAULT 'Active'
);

CREATE TABLE LibraryBooks (
    BookID INT PRIMARY KEY AUTO_INCREMENT,
    TitleOFBook VARCHAR(100) NOT NULL,
    AuthorName VARCHAR(255) NOT NULL,
    Publisher VARCHAR(150),
    YearPublished INT,
    ISBN VARCHAR(13) UNIQUE,
    Genre VARCHAR(50),
    CountAvailable INT DEFAULT 0 CHECK (CountAvailable >= 0)
);

CREATE TABLE TransactionsRecord (
    TransactionID INT PRIMARY KEY AUTO_INCREMENT,
    MemberID INT NOT NULL,
    BookID INT NOT NULL,
    CheckoutDate DATE NOT NULL,
    ReturnDate DATE GENERATED ALWAYS AS (DATE_ADD(CheckoutDate, INTERVAL 14 DAY)) STORED,
    ActualReturnDate DATE,
    Status ENUM('Borrowed', 'Returned') DEFAULT 'Borrowed',
    FOREIGN KEY (MemberID) REFERENCES LibraryMembers(MemberID) ON DELETE CASCADE,
    FOREIGN KEY (BookID) REFERENCES LibraryBooks(BookID) ON DELETE CASCADE
);

CREATE TABLE FineRecord (
    FineID INT PRIMARY KEY AUTO_INCREMENT,
    MemberID INT NOT NULL,
    TransactionID INT NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    PaymentStatus ENUM('Unpaid', 'Paid') DEFAULT 'Unpaid',
    FOREIGN KEY (MemberID) REFERENCES LibraryMembers(MemberID) ON DELETE CASCADE,
    FOREIGN KEY (TransactionID) REFERENCES TransactionsRecord(TransactionID) ON DELETE CASCADE
);

CREATE TABLE Staffdata (
    StaffID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    HireDate DATE NOT NULL
);

CREATE TABLE BookPurchaseRequests (
    RequestID INT PRIMARY KEY AUTO_INCREMENT,
    MemberID INT NOT NULL,
    Title VARCHAR(255) NOT NULL,
    Author VARCHAR(255),
    Status ENUM('Pending', 'Approved', 'Rejected') DEFAULT 'Pending',
    RequestDate DATE NOT NULL,
    FOREIGN KEY (MemberID) REFERENCES LibraryMembers(MemberID) ON DELETE CASCADE
);

CREATE TABLE CatLog (
    CatlogID INT PRIMARY KEY AUTO_INCREMENT,
    TableName VARCHAR(50),
    Action VARCHAR(50),
    ChangedData TEXT,
    Logintimes DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO LibraryMembers (MemberID, FirstName, LastName, Email, PhoneNumber, JoinDate, AccountStatus)
VALUES 
(1, 'Ram', 'Dharma', 'ramdharma@example.com', '1234567890', '2024-01-01', 'Active'),
(22, 'Shri', 'Patil', 'shripatil@example.com', '0987654321', '2022-01-02', 'Active'),
(44, 'Adi', 'Shake', 'adishake@example.com', '1231231231', '2023-02-05', 'Active'),
(12, 'Bobby', 'Raider', 'bobbyraider@example.com', '3213213210', '2023-03-05', 'Inactive'),
(15, 'Soham', 'Khan', 'sohamkhan@example.com', '1112223333', '2023-04-01', 'Active');

INSERT INTO LibraryBooks (TitleOFBook, AuthorName, Publisher, YearPublished, ISBN, Genre, CountAvailable)
VALUES 
('The Great Gatsby', 'F. Scott Fitzgerald', 'Scribner', 1925, '9780743273565', 'Fiction', 5),
('1984', 'George Orwell', 'Secker & Warburg', 1949, '9780451524935', 'Dystopian', 3),
('The Catcher in the Rye', 'J.D. Salinger', 'Little, Brown and Company', 1951, '9780316769488', 'Classic', 10),
('To Kill a Mockingbird', 'Harper Lee', 'J.B. Lippincott & Co.', 1960, '9780061120084', 'Fiction', 8),
('Brave New World', 'Aldous Huxley', 'Chatto & Windus', 1932, '9780060850524', 'Dystopian', 6);

INSERT INTO TransactionsRecord (MemberID, BookID, CheckoutDate, ActualReturnDate, Status)
VALUES 
(1, 32, '2023-01-03', '2024-01-10', 'Borrowed'),
(22, 22, '2023-01-03', '2023-01-10', 'Returned');

INSERT INTO FineRecord (MemberID, TransactionID, Amount, PaymentStatus)
VALUES 
(1, 1, 5.00, 'Paid'),
(22, 2, 10.00, 'Unpaid');

INSERT INTO Staffdata (FirstName, LastName, Email, HireDate)
VALUES 
('Satish', 'Prince', 'satishprince@example.com', '2023-02-01'),
('Jayesh', 'Kent', 'jayeshkent@example.com', '2023-03-01'),
('Anil', 'Mane', 'anilmane@example.com', '2023-04-01');

INSERT INTO BookPurchaseRequests (MemberID, Title, Author, Status, RequestDate)
VALUES 
(1, 'Pride and Prejudice', 'Jane Austen', 'Approved', '2023-03-01'),
(22, 'Moby-Dick', 'Herman Melville', 'Rejected', '2023-03-05'),
(44, 'War and Peace', 'Leo Tolstoy', 'Pending', '2023-03-10');

SELECT * FROM LibraryMembers;
SELECT * FROM LibraryBooks;
SELECT * FROM TransactionsRecord;
SELECT * FROM FineRecord;
SELECT * FROM Staffdata;
SELECT * FROM BookPurchaseRequests;
SELECT * FROM CatLog;
