# Use a base image with a recent Linux distribution that can support all required tools
FROM ubuntu:22.04

# Set environment variables for non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Install Git, Java JRE, Maven, PostgreSQL client, .NET SDK, and Apache2
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    openjdk-17-jre \
    maven \
    postgresql-client \
    apache2 \
    curl \
    libc6-dev \
    libncurses5-dev \
    libsqlite3-dev \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
    build-essential \
    software-properties-common && \
    rm -rf /var/lib/apt/lists/*

# Install .NET SDK (e.g., .NET 8.0)
# Refer to Microsoft's official guide for the latest instructions:
# https://learn.microsoft.com/en-us/dotnet/core/install/linux-ubuntu
RUN wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    sudo dpkg -i packages-microsoft-prod.deb && \
    rm packages-microsoft-prod.deb && \
    apt-get update && \
    apt-get install -y dotnet-sdk-8.0

# Install VS Code (as a command-line tool or server if needed for remote development)
# This setup focuses on the CLI and build tools.

# Configure Apache to serve content
COPY apache-html/ /var/www/html/
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

# Expose port 80 for Apache
EXPOSE 80

# Command to run Apache when the container starts
CMD ["apache2ctl", "-D", "FOREGROUND"]