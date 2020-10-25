CREATE OR REPLACE FUNCTION random_date_range(IN "from" TIMESTAMP, IN "to" TIMESTAMP, IN "seed" INT)
    RETURNS TIMESTAMP AS
$$
BEGIN
    RETURN "from" +
           (ABS(hash_numeric("seed")) %
                (SELECT EXTRACT(EPOCH FROM "to" - "from"))::INT) * INTERVAL '1 sec';
END;
$$ LANGUAGE plpgsql;