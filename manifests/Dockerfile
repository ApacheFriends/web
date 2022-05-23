FROM bitnami/nginx:1.17.10-debian-10-r14
LABEL maintainer "Bitnami Team <webdev@bitnami.com>"

# Copy the deployment
COPY build /usr/share/nginx/html
COPY config/nginx/default.conf /opt/bitnami/nginx/conf/server_blocks/default.conf

