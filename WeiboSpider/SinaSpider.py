# encoding=utf-8
import time
import random
# 当前版本不许要 URL 管理器 通过一个显式的 pages 控制爬取的界面
import URLmanager
import HTMLDownloader
import HTMLParser
import DATAOutput

class SinaSpider:
    ''' SinaWeibo Spyder'''
    # 根目录 登录界面
    # root_url = "https://passport.weibo.cn/signin/login"
    # 根目录 直接跳转到搜索结果界面
    # 话题搜索结果
    # root_url = "https://s.weibo.com/weibo/%23%E6%98%9F%E5%B7%B4%E5%85%8B%E8%87%B4%E7%99%8C%23?topnav=1&wvr=6&topsug=1&page="
    # 直接搜索结果
    root_url = 'https://s.weibo.com/weibo?q=%E6%98%9F%E5%B7%B4%E5%85%8B%E8%87%B4%E7%99%8C&nodup=1&page='
    headers= {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36'
    }
    def __init__(self, cookies_path, csvpath, jsonpath):
        self.cookies_path = cookies_path
        self.csvpath = csvpath
        self.jsonpath = jsonpath
        # self.manager = URLmanager.URLmanager()
        self.downloader = HTMLDownloader.HTMLDownloader()
        self.parser = HTMLParser.HTMLParser()
        self.output = DATAOutput.DATAOutput()

    def crawl(self, pages):
        ''' 爬虫主程序

        para: pages ->指定爬取的页面数 '''
        print('爬取 ' + str(pages) + ' 个界面：')
        all_data_num = 0
        for index in range(1, pages+1):
            print('\t当前爬取第 {} 个界面，共 {} 个'.format(index, pages))

            # 随机延时一段时间 简单反反爬虫
            # try:
            time.sleep(random.random()+random.randrange(1,4))
            page_data_num = self.crawl_one_page(SinaSpider.root_url + str(index), all_data_num, page=index)
            all_data_num += page_data_num

            print('\t 当前界面爬取了 {} 条数据...'.format(page_data_num))
            print('\t 当前共爬取 {} 条数据'.format(all_data_num))
            # except:
            #     print('\t 当前第 {} 个页面爬取失败'.format(index))
        print('{} 个页面共爬取 {} 条数据'.format(pages, all_data_num))

    def crawl_one_page(self, url, data_num, page):
        ''' 爬取一个页面 '''
        r = self.downloader.get_a_page(url, self.cookies_path, SinaSpider.headers)
        print(r.status_code)
        num_of_data, parse_result = self.parser.parse_a_page(r.text, data_num)
        self.output.save_to_csv(parse_result, csvpath=self.csvpath)
        self.output.save_to_json(parse_result, jsonpath=self.jsonpath, page=page)
        return num_of_data

if __name__ == "__main__":
    spider = SinaSpider('./files/cookies.txt', './files/output/final_results.csv', './files/output/json/')
    spider.crawl(45)