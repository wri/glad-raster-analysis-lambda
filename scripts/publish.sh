#!/bin/bash
set -e

echo "Running tests"
nosetests --nologcapture -v -s -w /home/geolambda/;

echo "Packaging dependencies..."
mkdir dist -p

# rm existing deploy file if it exists
# sometimes zip is too large if we don't do this
# apparently zip just adds to raster-ops-deploy if it already exists?
rm -f dist/raster-ops-deploy.zip

cd /var/task
zip -9qyr /home/geolambda/dist/raster-ops-deploy.zip lib/*.so* share

cd /var/lang/lib/python3.6/site-packages
zip -9qyr /home/geolambda/dist/raster-ops-deploy.zip . \
    -x \*-info\* \
    -x boto\*\* \
    -x pip\* \
    -x docutils\* \
    -x s3transfer\* \
    -x setuptools\* \
    -x jmespath\* \
    -x pkg_resources\* \


cd /home/geolambda
zip -9 -rq dist/raster-ops-deploy.zip geop/* data/* serializers/* utilities/* api.py wsgi.py

# Deploy the function
printf "Packaging complete! Run sls deploy -v to deploy.\n"

