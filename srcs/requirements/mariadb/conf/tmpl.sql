CREATE USER IF NOT EXISTS '$MYSQL_USER_NAME'@'%' IDENTIFIED BY '$MYSQL_USER_PASS';
GRANT ALL PRIVILEGES ON $WP_DB_NAME.* TO '$MYSQL_USER_NAME'@'%' IDENTIFIED BY '$MYSQL_USER_PASS';

-- UPDATE mysql.user SET password=password('$MYSQL_USER_PASS') WHERE user='$MYSQL_USER_NAME';
UPDATE mysql.user SET password=password('$MYSQL_ROOT_PASS') WHERE user='root';

FLUSH PRIVILEGES;