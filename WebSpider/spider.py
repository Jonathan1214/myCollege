#coding:utf-8
# 正则表达式解析
import requests
import re


def get_one_page(url):
    headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.110 Safari/537.36'}
    response = requests.get(url, headers=headers)
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
    for index,result in enumerate(results,1):
        print(result)
        f_name = str(index+last_page_total)+'.gif'
        print('开始下载第%d张表情' % f_name)
        with open(f_name, 'wb') as f:
            f.write(requests.get(result).content)
        print('第%d张表情下载完成' % f_name)
    return last_page_total+len(results)


if __name__ == "__main__":
    total = 0
    for i in range(10):
        total = main(i+1, last_page_total=total)