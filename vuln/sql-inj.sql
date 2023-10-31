CREATE TABLE users
(username VARCHAR2(10),
 password VARCHAR2(20)
);
INSERT INTO users
values ('JOHN_DOE', 'jfhgjdgdg');
commit;
CREATE OR REPLACE PROCEDURE do_login
(p_username IN VARCHAR2,
 p_password IN VARCHAR2
)
IS
   l_dummy  VARCHAR2(1);
   l_query_str CONSTANT VARCHAR2(1000) :=
   'SELECT NULL
      FROM users
     WHERE username = '''||p_username||
   ''' AND password = '''||p_password||'''';
BEGIN
   EXECUTE IMMEDIATE l_query_str
   INTO l_dummy;
   DBMS_OUTPUT.put_line('Login Succeeded');
EXCEPTION
   WHEN OTHERS
   THEN
      Raise_application_error (-20001, 'Login failed');
END;