FROM python:3.10

# Set the working directory inside the container to /app
WORKDIR /app

#RUN pip install --upgrade pip
# Install the Python dependencies listed in requirements.txt using pip
RUN pip install flask flask_mysqldb

# Copy the rest of the FlaskApp files from the host to the /app directory in the container.
COPY . /app

EXPOSE 5000
# Set the command to be executed when the container starts.
CMD ["python3", "app.py"]


