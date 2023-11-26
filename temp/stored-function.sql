!-- PENTING : Ini Belum ada di Laporan! Stored function untuk mengambil userid dari kurir secara acak.

DELIMITER &&
CREATE FUNCTION getRandomCourierUserId()
RETURNS CHAR(9)
DETERMINISTIC
BEGIN
    DECLARE courierId CHAR(9);

    SELECT user_id INTO courierId
    FROM users
    WHERE level_user = 'Courier'
    ORDER BY RAND()
    LIMIT 1;

    RETURN courierId;
END &&
DELIMITER ;
