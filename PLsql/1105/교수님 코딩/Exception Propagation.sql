DECLARE
  exception_a EXCEPTION;
  exception_b EXCEPTION;
  
  exception_name   varchar2(10) := '&ex';
BEGIN
    DECLARE
      exception_c EXCEPTION;
    BEGIN
      IF exception_name = 'a' THEN
        RAISE exception_a;
      END IF;
      IF exception_name = 'b' THEN
        RAISE exception_b;
      END IF;
      IF exception_name = 'c' THEN
        RAISE exception_c;
      END IF;
    EXCEPTION
      WHEN exception_a THEN
        -- RAISE_APPLICATION_ERROR(-20001, 'EXCEPTION A raised');
        DBMS_OUTPUT.PUT_LINE('EXCEPTION A raised ...');
        RAISE exception_b;
    END;
EXCEPTION
  WHEN exception_b THEN
    DBMS_OUTPUT.PUT_LINE('EXCEPTION B raised ...');
  WHEN others THEN
    DBMS_OUTPUT.PUT_LINE('EXCEPTION C raised ...');
END;
