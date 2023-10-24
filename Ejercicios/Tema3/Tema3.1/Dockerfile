FROM ubuntu
RUN apt -qq update && apt -qq -y install stress-ng
CMD stress-ng -c 1 -t 5s