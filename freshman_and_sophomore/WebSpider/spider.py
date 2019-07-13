#coding:utf-8
# 正则表达式解析
import requests
import re


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
    for i in range(12):
        total = main(i+1, last_page_total=total)
    print('下载完成 共%d张表情包' % total)