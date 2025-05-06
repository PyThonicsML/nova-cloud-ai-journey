# Use an official Python runtime as a base image
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /app

# Copy everything from your local folder into the container
COPY . .

# Run the app when the container starts
CMD ["python", "app.py"]
