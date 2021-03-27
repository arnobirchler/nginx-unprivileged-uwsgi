FROM nginxinc/nginx-unprivileged:stable-alpine

COPY ./default.conf.template /etc/nginx/templates/default.conf.template
COPY ./uwsgi_params /etc/nginx/uwsgi_params

USER root

RUN mkdir -p /vol/static
RUN mkdir -p 755 /vol/static

ENV NGINX_PORT 80
ENV APP_PORT 8000
ENV APP_HOST app
ENV HEALTH_PATH /

HEALTHCHECK --interval=1m --timeout=30s --retries=3 CMD curl --fail http://localhost:$NGINX_PORT$HEALTH_PATH || exit 1

USER nginx

