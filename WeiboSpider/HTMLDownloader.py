# encoding=utf-8
import requests

class HTMLDownloader:
    ''' downloader '''
    def __init__(self):
        print('启动下载器，开启 Session：')
        self.session = requests.Session()

    def deal_with_copied_cookies_from_chrome(self, cookies_file_path):
        '''将从浏览器复制的字符串型 cookies 处理成字典

            paras: 文件路径'''
        with open(cookies_file_path, 'r', encoding='utf-8') as f:
            cookies = f.read()
            cookie = cookies.split("; ")
            cookies = {}
            for c in cookie:
                tmp = c.split("=")
                cookies[tmp[0]]= tmp[1]
            return cookies

    def update_cookies(self, cookies):
        self.session.cookies.update(cookies)

    def get_a_page(self, url, cookies, headers):
        '''获取一个页面

            para：url[str] cookies[file_path]'''
        self.update_cookies(self.deal_with_copied_cookies_from_chrome(cookies))   # 更新 cookies
        # 设置 verify = False
        return self.session.get(url, headers=headers, verify=False)
