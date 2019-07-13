#coding:utf-8
# 正则表达式解析
import requests
import re
import os                  # 为了创建一个目录把照片存进去
from time import sleep     # 还是加一个延时函数
from random import randint # 简单一个随机数


def get_one_page(url):
    '''
    不用headers 这个网站绝了
    '''
    response = requests.get(url)
    if response.status_code == 200:
        return response.text
    return None

def main(offset, last_page_total=0):
    '''
    last_page_total 确定图片序号
    '''
    url = "https://www.fabiaoqing.com/search/search/keyword/%E7%8C%AB%E5%92%8C%E8%80%81%E9%BC%A0/type/bq/page/"+str(offset)+'.html'
    html = get_one_page(url)
    results = re.findall('<img.*?data-original="(.*?)".*?>', html, re.S)
    for index,result in enumerate(results,last_page_total+1):
        # 直接把index变成总的序号
        print(result)
        f_name = str(index)+result[-4:]
        print('开始下载第%d张表情包' % index)
        with open(f_name, 'wb') as f:
            f.write(requests.get(result).content)
        print('第%d张表情包下载完成' % index)
    return last_page_total+len(results)


if __name__ == "__main__":
    total = 0
    path = os.getcwd() + '\\emoticon_package'
    os.mkdir(path)
    os.chdir(path) 
    # 在当前目录下创建一个emoticon_package目录 并切换到该目录
    for i in range(12):
        total = main(i+1, last_page_total=total)
        slt = randint(1,10)
        print('第%d个页面下载%d张图片 延迟%fs' % (i+1, total, slt))
        sleep(slt)
    print('下载完成 共%d张表情包' % total)