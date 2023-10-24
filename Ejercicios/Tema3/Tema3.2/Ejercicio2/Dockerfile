FROM ubuntu
RUN apt -qq update && apt -qq -y install -y python3
COPY index.html /index.html
CMD python3 -m http.server 1080