PLS_INTEGER := DBMS_CRYPTO.ENCRYPT_DES
                           + DBMS_CRYPTO.CHAIN_CBC
                           + DBMS_CRYPTO.PAD_PKCS5;