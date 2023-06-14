FROM nginx:1.25.0

ARG USERNAME
ENV USERNAME=$USERNAME

RUN apt update && apt install -y \
        htop \
        stress-ng

COPY app/src/ /usr/share/nginx/html