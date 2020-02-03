FROM remotepixel/amazonlinux-gdal:2.4.0-light

WORKDIR /var/task
ENV WORKDIR /var/task

RUN mkdir -p $WORKDIR
COPY requirements.txt /var/tasks
RUN CFLAGS="--std=c99" pip3 install rasterio[s3]==1.0.1 shapely==1.6b4 --no-binary numpy,rasterio,shapely

RUN python -m compileall .
RUN find -type f -name '*.pyc' | while read f; do n=$(echo $f | sed 's/__pycache__\///' | sed 's/.cpython-36//'); cp $f $n; done;
RUN find -type d -a -name '__pycache__' -print0 | xargs -0 rm -rf
RUN find -type f -a -name '*.py' -print0 | xargs -0 rm -f

RUN pip3 install pyproj==1.9.6 Flask==1.0.2 nose==1.3.7

