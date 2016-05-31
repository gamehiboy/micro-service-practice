#!/usr/bin/env python
#-*- coding: utf-8 -*-
#-------------------------------------------------------------------------------
# Name:         templateInvoke.py
# Purpose:      自动扫描环境变量，实例化模板文件
#
# Author:       yangjun
#
# Created:      30/03/2016
# Copyright:    (c) yangjun 2016
# Licence:      <your licence>
#-------------------------------------------------------------------------------

import os
import sys
#import glob
import codecs
from mako.template import Template


def templateInvoke(srcFile, dstFile):
    template = Template(filename=srcFile, input_encoding='utf-8',output_encoding='utf-8')
    environ = os.environ
    dst_content = template.render(**environ)
    with codecs.open(dstFile, "w", "utf-8") as fp:
        fp.write(dst_content)


if __name__ == '__main__':
    if(len(sys.argv) < 2):
        print("""ARG ERROR, eg: python templateInvoke.py <srcFile> [dstFile]
        srcFile:    Required.
        dstFile:    Optional, DEFAULT=<srcFile>""")
        sys.exit(-1)
    srcFile = sys.argv[1]
    if(len(sys.argv) == 3):
        dstFile = sys.argv[2]
    else:
        dstFile = srcFile
    templateInvoke(srcFile, dstFile)

