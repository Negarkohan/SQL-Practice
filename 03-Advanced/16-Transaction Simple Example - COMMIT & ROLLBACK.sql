/*
===============================================
 Author:  Negar Kohansal
 Purpose: Demonstration of SQL Transaction with COMMIT and ROLLBACK logic.
===============================================
*/

BEGIN TRANSACTION;

-- Step 1: Withdraw 100000 from account with ID = 1
UPDATE accounts 
SET balance = balance - 100000 
WHERE account_id = 1;

-- Step 2: Check if account balance is valid (not negative)
IF (SELECT balance FROM accounts WHERE account_id = 1) < 0
BEGIN
   -- If balance is negative, cancel the whole transaction
   ROLLBACK;  
END
ELSE
BEGIN
   -- Step 3: Deposit 100000 into account with ID = 2
   UPDATE accounts 
   SET balance = balance + 100000 
   WHERE account_id = 2;

   -- Step 4: Save all changes permanently
   COMMIT;  
END
