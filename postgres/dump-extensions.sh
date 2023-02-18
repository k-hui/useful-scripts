DB_HOST=localhost
DB_PORT=5432
DB_NAME=postgres
DB_USER=postgres
DB_PASS=postgres
EXPORT_SQL=./dump-extensions.sql

export PGPASSWORD="$DB_PASS"

# CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

# SELECT pg_get_functiondef(f.oid)
# SELECT string_agg(pg_get_functiondef(f.oid)::text, ';')

psql -h "$DB_HOST" -p "$DB_PORT" -d "$DB_NAME" -U "$DB_USER" >"$EXPORT_SQL" <<"__END__"
SELECT string_agg(pg_get_functiondef(f.oid)::text, ';')
FROM pg_catalog.pg_proc f
INNER JOIN pg_catalog.pg_namespace n ON (f.pronamespace = n.oid)
WHERE n.nspname = 'public';
__END__

# replace non-sql syntax
sed -i '' "s/+//g" "$EXPORT_SQL"
sed -i '' "s/(1 row)//g" "$EXPORT_SQL"
sed -i '' "s/string_agg//g" "$EXPORT_SQL"
sed -i '' "s/\r//g" "$EXPORT_SQL"
sed -i '' "s/\t//g" "$EXPORT_SQL"
sed -i '' "s/\n//g" "$EXPORT_SQL"
sed -i '' "s/--//g" "$EXPORT_SQL"
# for testing new schema
sed -i '' "s/public./test./g" "$EXPORT_SQL"
