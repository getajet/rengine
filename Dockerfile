# Dockerfile for the web and celery services

# Base image
FROM python:3.8-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set the working directory
WORKDIR /usr/src/app

# Install system dependencies (including pg_config)
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY ./web/requirements.txt /usr/src/app/
RUN pip install --no-cache-dir -r requirements.txt

# Copy the app code
COPY ./web /usr/src/app/

# Copy entrypoint script and make it executable
COPY ./web/entrypoint.sh /usr/src/app/entrypoint.sh
RUN chmod +x /usr/src/app/entrypoint.sh

# Copy celery entrypoint script for celery services
COPY ./web/celery-entrypoint.sh /usr/src/app/celery-entrypoint.sh
RUN chmod +x /usr/src/app/celery-entrypoint.sh

# Copy celery-beat entrypoint script for celery-beat
COPY ./web/beat-entrypoint.sh /usr/src/app/beat-entrypoint.sh
RUN chmod +x /usr/src/app/beat-entrypoint.sh

# Expose the port the app runs on
EXPOSE 8000

# Default entrypoint for the web service
ENTRYPOINT ["/usr/src/app/entrypoint.sh"]

# For the web service, default command to run Django server
CMD ["gunicorn", "--workers=3", "--bind=0.0.0.0:8000", "reNgine.wsgi:application"]
