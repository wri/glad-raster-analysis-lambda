FROM remotepixel/amazonlinux-gdal:2.4.0-light

COPY . /build
WORKDIR /build

RUN \
    pip install -r requirements.txt; \
    rm -rf /build/*
    
 
