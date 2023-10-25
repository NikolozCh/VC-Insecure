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