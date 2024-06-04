# Use an official Python runtime as a parent image
FROM python:3.10-slim

# Install Git
RUN apt-get update && apt-get install -y git \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /app

# Clone LMCache repo
RUN git clone https://github.com/LMCache/LMCache

WORKDIR /app/LMCache

RUN pip install -r requirements.txt
RUN pip install -e .

WORKDIR /app

# Copy LMCache-server repo
COPY . /app/LMCache-server

WORKDIR /app/LMCache-server

RUN pip install -r requirements.txt
RUN pip install -e .


# Run app.py when the container launches
ENTRYPOINT ["python3", "-m", "lmcache_server.server"]
