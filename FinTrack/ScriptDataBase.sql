CREATE DATABASE IF NOT EXISTS FinTrack;

USE FinTrack;

CREATE TABLE IF NOT EXISTS Users
(
    Id CHAR(36) NOT NULL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(255) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,

    CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt DATETIME NULL DEFAULT NULL
);

CREATE TABLE Accounts
(
    Id CHAR(36) NOT NULL PRIMARY KEY,
    UserId CHAR(36) NOT NULL,
    Name VARCHAR(100) NOT NULL,

    CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt DATETIME NULL DEFAULT NULL,

    CONSTRAINT FK_Accounts_Users
        FOREIGN KEY (UserId)
        REFERENCES Users(Id)
);

CREATE TABLE IF NOT EXISTS Categories
(
    Id CHAR(36) NOT NULL PRIMARY KEY,

    Name VARCHAR(100) NOT NULL,

    Type SMALLINT NOT NULL,

    CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt DATETIME NULL DEFAULT NULL
);

-- =========================================
-- TRANSACTIONS
-- =========================================
-- PaymentMethod:
-- 1 = Cash
-- 2 = DebitCard
-- 3 = CreditCard
-- 4 = Pix
-- 5 = BankTransfer

CREATE TABLE IF NOT EXISTS Transactions
(
    Id CHAR(36) NOT NULL PRIMARY KEY,

    AccountId CHAR(36) NOT NULL,
    CategoryId CHAR(36) NOT NULL,

    Amount DECIMAL(18,2) NOT NULL,

    PaymentMethod SMALLINT NOT NULL,

    Description VARCHAR(255) NULL,

    TransactionDate DATETIME NOT NULL,

    CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt DATETIME NULL DEFAULT NULL,

    CONSTRAINT FK_Transactions_Accounts
        FOREIGN KEY (AccountId)
        REFERENCES Accounts(Id),

    CONSTRAINT FK_Transactions_Categories
        FOREIGN KEY (CategoryId)
        REFERENCES Categories(Id)
);

CREATE TABLE Budgets
(
    Id CHAR(36) NOT NULL PRIMARY KEY,

    UserId CHAR(36) NOT NULL,

    CategoryId CHAR(36) NOT NULL,

    Amount DECIMAL(18,2) NOT NULL,

    Month INT NOT NULL,
    Year INT NOT NULL,

    CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt DATETIME NULL DEFAULT NULL,

    CONSTRAINT FK_Budgets_Users
        FOREIGN KEY (UserId)
        REFERENCES Users(Id),

    CONSTRAINT FK_Budgets_Categories
        FOREIGN KEY (CategoryId)
        REFERENCES Categories(Id)
);
