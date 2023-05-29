FROM nginx:1.25.0

COPY app/config/etc/nginx/conf.d/default.conf /etc/nginx/conf.d
COPY app/src/ /usr/share/nginx/html