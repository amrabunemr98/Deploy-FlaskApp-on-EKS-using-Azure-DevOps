FROM mysql:latest
EXPOSE 3306
# Copy all the files from the current directory (where the Dockerfile is located)
# to the /docker-entrypoint-initdb.d/ directory inside the container.
# The /docker-entrypoint-initdb.d/ directory is a special directory in the MySQL image
# that allows you to add SQL scripts that will be executed during container initialization.
# These scripts are used to initialize the database with custom data.
COPY . /docker-entrypoint-initdb.d

