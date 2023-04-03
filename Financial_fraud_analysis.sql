use financialdb;
CREATE TABLE Transactions (
   TransactionID INT PRIMARY KEY,
   CardNumber VARCHAR(16),
   TransactionDate DATE,
   Amount DECIMAL(10, 2),
   Merchant VARCHAR(50)
);
INSERT INTO Transactions (TransactionID, CardNumber, TransactionDate, Amount, Merchant) VALUES
(1, '1234567890123456', '2023-03-01', 100.00, 'Amazon'),
(2, '1234567890123456', '2023-03-02', 50.00, 'Walmart'),
(3, '1234567890123456', '2023-03-03', 200.00, 'Target'),
(4, '2345678901234567', '2023-03-01', 500.00, 'Amazon'),
(5, '2345678901234567', '2023-03-04', 1000.00, 'Best Buy'),
(6, '3456789012345678', '2023-03-02', 75.00, 'Walmart'),
(7, '3456789012345678', '2023-03-03', 125.00, 'Target'),
(8, '3456789012345678', '2023-03-04', 150.00, 'Best Buy'),
(9, '4567890123456789', '2023-03-05', 300.00, 'Amazon'),
(10, '4567890123456789', '2023-03-06', 150.00, 'Walmart');
CREATE TABLE CreditCards (
   CardNumber VARCHAR(16) PRIMARY KEY,
   CardHolderName VARCHAR(50),
   ExpirationDate DATE,
   IssuingBank VARCHAR(50)
);
INSERT INTO CreditCards (CardNumber, CardHolderName, ExpirationDate, IssuingBank) VALUES
('1234567890123456', 'John Smith', '2025-12-01', 'Chase'),
('2345678901234567', 'Jane Doe', '2024-06-01', 'CitiBank'),
('3456789012345678', 'Bob Johnson', '2023-09-01', 'Wells Fargo'),
('4567890123456789', 'Mary Williams', '2026-03-01', 'Bank of America');
select * from CreditCards;

 1.total amount of money spent using each credit card
 SELECT CardNumber, SUM(Amount) AS TotalSpent
FROM Transactions
GROUP BY CardNumber;

1234567890123456	350.00
2345678901234567	1500.00
3456789012345678	350.00
4567890123456789	450.00

2. average transaction amount for each merchant
SELECT Merchant, AVG(Amount) AS AvgAmount
FROM Transactions
GROUP BY Merchant;

Amazon	300.000000
Best Buy	575.000000
Target	162.500000
Walmart	91.666667

3. average transaction amount for each cardholder
SELECT CardHolderName, AVG(Amount) AS AvgAmount
FROM Transactions
INNER JOIN CreditCards ON Transactions.CardNumber = CreditCards.CardNumber
GROUP BY CardHolderName;

Bob Johnson	116.666667
Jane Doe	750.000000
John Smith	116.666667
Mary Williams	225.000000

 4. Total transactions were made on each day of the week
  SELECT DAYOFWEEK(TransactionDate) AS DayOfWeek, COUNT(*) AS NumTransactions
FROM Transactions
GROUP BY DAYOFWEEK(TransactionDate);

Day of week:6
Numtransactions: 2

5.total amount of money spent on each day of the week
SELECT DAYOFWEEK(TransactionDate) AS DayOfWeek, SUM(Amount) AS TotalSpent
FROM Transactions
GROUP BY DAYOFWEEK(TransactionDate);

DayofWeek: 1
TotalSpent: 300


Which credit cards have been used to make transactions at more than one merchant?
SELECT CardNumber
FROM Transactions
GROUP BY CardNumber
HAVING COUNT(DISTINCT Merchant) > 1;

1234567890123456
2345678901234567
3456789012345678
4567890123456789

7.How many credit cards have been issued by each bank?
SELECT IssuingBank, COUNT(DISTINCT CardNumber) AS NumCards
FROM CreditCards
GROUP BY IssuingBank;

Bank of America	1
Chase	        1
CitiBank	    1
Wells Fargo	    1
