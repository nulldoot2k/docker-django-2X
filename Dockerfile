# The base image
FROM ubuntu:latest

# Install python and pip
RUN apt-get update && apt-get install -y \
 python3-pip \
 python3-dev \
 python3-venv \
 build-essential

 ENV FLASK_APP=app.py
 WORKDIR /usr/src/app

# Create a virtual environment
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Install Python modules needed by the Python app
COPY requirements.txt .
RUN pip install --no-cache-dir -r /usr/src/app/requirements.txt

# Copy files required for the app to run
COPY app.py .

# Declare the port number the container should expose
EXPOSE 5000

# Run the application
CMD ["flask", "run", "--host=0.0.0.0"]
