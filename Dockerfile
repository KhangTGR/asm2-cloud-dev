# Dockerfile
FROM httpd:2.4

# Copy the HTML file to the default Apache root directory
COPY s3929994.html /usr/local/apache2/htdocs/index.html

# Expose port 80 for HTTP traffic
EXPOSE 80
