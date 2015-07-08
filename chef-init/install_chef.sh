#!/bin/sh

ret=0           # リターンコード
SRC_DIR="/root"
SRC_FIL=
COM_DIR=


YUM="wget zlib-devel"

for i in ${YUM}; do
        rpm -qa | grep ^${i} > /dev/null 2>&1
        RET=$?
        if [ ${RET} -ne 0 ]; then
                CMD="yum -y install ${i}"
                echo "exec ${CMD}"
                ${CMD}
        fi
done


# rubyファイル設定
if [ ! -f ${SRC_DIR}/ruby*gz ]; then
        echo "file not found"
        exit 8
else
        SRC_FIL=`ls -1 ${SRC_DIR}/ruby*gz`
        COM_DIR=`echo ${SRC_FIL} | sed -e "s/.\{7\}$//"`
fi

tar xf ${SRC_FIL}
cd ${COM_DIR}
./configure --disable-doc
make
make install

gem contents chef > /dev/null 2>&1
RET=$?
if [ ${RET} -eq 0 ]; then
        gem install chef
fi

exit 0

