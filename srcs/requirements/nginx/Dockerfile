FROM debian:buster
EXPOSE 443

# Update and upgrade packages, then install packages
RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y \
    nginx \
    openssl

# Copy the nginx.conf config to /etc/nginx/sites-available/
COPY conf/nginx.conf /etc/nginx/sites-available/nginx.conf

# Remove all (default) sites-enabled and link sites-available to sites-enabled
RUN rm -rf /etc/nginx/sites-enabled/* && \
    ln -sf /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/nginx.conf

# Create the SSL certificate and key
# - sha256: Use the SHA-256 algorithm to sign the certificate
# - days: The number of days to certify the certificate for
# - nodes: If this option is specified then if a private key is created it will not be encrypted
# - out: The filename to write the newly created certificate to
# - keyout: The filename to write the newly created private key to
# - subj: Sets certificate subject
RUN openssl req -new \
    -newkey rsa:2048 \
    -x509 \
    -sha256 \
    -days 3560 \
    -nodes \
    -out /etc/ssl/certs/localhost.crt \
    -keyout /etc/ssl/private/localhost.key \
    -subj "/C=$COUNTRY_CODE/ST=$STATE/L=$LOCALITY_NAME/O=$ORGANIZATION/OU=$ORGANIZATION_UNIT/CN=$COMMON_NAME"

# Set the default command to start nginx server
CMD ["nginx", "-g", "daemon off;"]
