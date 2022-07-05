#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#

FROM ttbb/compile:c

RUN echo "begin build" && \
    wget -q https://archive.apache.org/dist/pulsar/pulsar-2.10.1/RPMS/apache-pulsar-client-2.10.1-1.x86_64.rpm && \
    wget -q https://archive.apache.org/dist/pulsar/pulsar-2.10.1/RPMS/apache-pulsar-client-debuginfo-2.10.1-1.x86_64.rpm && \
    wget -q https://archive.apache.org/dist/pulsar/pulsar-2.10.1/RPMS/apache-pulsar-client-devel-2.10.1-1.x86_64.rpm && \
    rpm -ivh apache-pulsar-client-2.10.1-1.x86_64.rpm && \
    rpm -ivh apache-pulsar-client-debuginfo-2.10.1-1.x86_64.rpm && \
    rpm -ivh apache-pulsar-client-devel-2.10.1-1.x86_64.rpm && \
    rm -f apache-pulsar-client-2.10.1-1.x86_64.rpm && \
    rm -f apache-pulsar-client-debuginfo-2.10.1-1.x86_64.rpm && \
    rm -f apache-pulsar-client-devel-2.10.1-1.x86_64.rpm && \
    echo "end build"

COPY . /opt/sh
WORKDIR /opt/sh

RUN cmake . && \
    make

CMD ["/usr/bin/dumb-init", "/opt/sh/performance_producer_cpp"]
