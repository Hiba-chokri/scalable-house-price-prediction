FROM python:3.9-slim

# Install basic dependencies
RUN apt-get update && apt-get install -y git curl && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy your app
COPY data/ /app/data/
COPY ray_app/ /app
WORKDIR /app

# Start Ray head node by default
CMD ["ray", "start", "--head", "--dashboard-host=0.0.0.0", "--block"]
# Expose Ray dashboard port
EXPOSE 8265
# Expose Ray worker port