CREATE OR REPLACE FUNCTION get_user_data(
  in_user_name VARCHAR2
) RETURN SYS_REFCURSOR IS
  result_cursor SYS_REFCURSOR;
BEGIN
  OPEN result_cursor FOR
    SELECT *
    FROM users
    WHERE user_name = in_user_name;

  RETURN result_cursor;
END;
