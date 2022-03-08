# Data Node Image
#
# Date: 2022.03.02
# Author: Hyunwoo Kang
#

from hadoop_base:latest

#
# run entrypoint.sh
#
COPY ./entrypoint.sh /tmp
WORKDIR /tmp
RUN chmod +x ./entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
