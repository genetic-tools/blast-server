FROM divio/base:4.4-py3.6-slim-stretch-dev AS build

RUN apt-get update && apt-get install -y liblmdb-dev

RUN curl ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/2.7.1/ncbi-blast-2.7.1+-src.tar.gz | tar xvz

RUN cd ncbi-blast-2.7.1+-src/c++ && \
    ./configure && \
    cd ReleaseMT/build && \
    make -j6 all_r

RUN cp -r ncbi-blast-2.7.1+-src/c++/ReleaseMT/bin ./bin


# <DOCKER_FROM_DISABLED>
FROM divio/base:4.4-py3.6-slim-stretch
# </DOCKER_FROM_DISABLED>

COPY --from=build /app/bin /opt/blast/bin

# <PYTHON>
ENV PIP_INDEX_URL=${PIP_INDEX_URL:-https://wheels.aldryn.net/v1/aldryn-extras+pypi/${WHEELS_PLATFORM}/+simple/} \
    WHEELSPROXY_URL=${WHEELSPROXY_URL:-https://wheels.aldryn.net/v1/aldryn-extras+pypi/${WHEELS_PLATFORM}/}
COPY requirements.* /app/
COPY addons-dev /app/addons-dev/
RUN pip-reqs resolve && \
    pip install \
        --no-index --no-deps \
        --requirement requirements.urls
# </PYTHON>

# <SOURCE>
COPY . /app
# </SOURCE>

# <STATIC>
RUN DJANGO_MODE=build python manage.py collectstatic --noinput
# </STATIC>
