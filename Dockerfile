# Pull official base image
FROM python:3.8-alpine
# MAINTAINER LuisQuinones

# Set work directory
WORKDIR /djangonginx

# set environment variables
# '''   PYTHONDONTWRITEBYTECODE: Prevents Python from writing pyc files to disc (equivalent to python -B option)
#       PYTHONUNBUFFERED: Prevents Python from buffering stdout and stderr (equivalent to python -u option)
# '''

ENV PYTHONDONTWRITEBYCOSE 1
ENV PYTHONUNBUFFERED 1

# Install dependencies

COPY requirements.txt /djangonginx/

# Install psycopg2 dependencies
RUN apk add --update --no-cache postgresql-client

RUN apk add --update --no-cache --virtual .tmp-build-deps \
      gcc libc-dev linux-headers postgresql-dev \
      musl-dev

RUN pip install --upgrade pip
RUN pip install -r /djangonginx/requirements.txt


RUN apk update --no-cache
RUN apk del .tmp-build-deps


# Copy project
COPY ./app /djangonginx/

# RUN apk add --update --no-cache postgresql-client 
#       This is necessary to install Pillow
#       \
#       jpeg-dev
# RUN apk add --update --no-cache --virtual .tmp-build-deps \
#       gcc libc-dev linux-headers postgresql-dev 
#       This is necessary to install Pillow
#       \
#       musl-dev zlib \
#       zlib-dev libjpeg
      
# RUN pip install -r /billdjpostg/requirements.txt

# RUN apk update --no-cache
# RUN apk del .tmp-build-deps

# RUN pip3 install -U pylint


# RUN fmkdir /billdjpostg

# COPY ./app /billdjpostg/

# RUN mkdir -p /vol/web/media
# RUN mkdir -p /vol/web/static
# RUN adduser -D userlq
# RUN chown -R userlq:userlq /vol/
# RUN chmod -R 755 /vol/web
# USER userlq