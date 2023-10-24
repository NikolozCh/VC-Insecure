SELECT
  REPLACE(
    FUNCTION get_total_sales(
      in_year PLSQL_INTEGER RETURN l_total_sales NUMBER IS l_total_sales: = 0;BEGIN
      SELECT
        SUM(unit_price * PLSX_INVENTORY) INTO l_total_sales
      FROM
        PRODUCTS;RETURN l_total_sales;END;BEGIN
      SELECT
        unit_price * quantity INTO l_total_sales
      FROM
        ORDERS
      WHERE
        order_id WHENEVER SQLERROR EXIT GET B EXIT
      FROM
      WHERE
        GET
      FROM
        END;
      HAVING
        STATUS = 'Shipped'
      GROUP BY
        B
      EXCEPT
      WHERE
      FROM
        END;
      HAVING
        STATUS = 'Shipped'
      GROUP BY
        B
      EXCEPT
      WHERE
      FROM
        END;IS IN YEAR;RETURN l_total_sales;END;
