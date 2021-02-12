FROM ubuntu:18.04
USER root

COPY . /usr/src/
WORKDIR /usr/src/

RUN apt-get update && \
    apt-get -y install locales python3 python3-pip libmysqlclient-dev

RUN pip3 install --upgrade pip
#RUN pip3 install flask gunicorn PyMySQL
RUN pip3 install flask gunicorn mysqlclient werkzeug==0.16.0 google-cloud-profiler

CMD ["python3", "/usr/src/app.py"]
