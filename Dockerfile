FROM nginx:latest
RUN sed -i 's/nginx/DevOps/g' /usr/share/nginx/html/index.html
EXPOSE 80