# encoding=utf-8
import requests
import lxml
from bs4 import BeautifulSoup

class HTMLParser:
    ''' Parser '''
    def __init__(self):
        print('启动解析器')

    def parse_a_page(self, download_html_text, data_num):
        '''返回每个数据组成的字典 保存工作交给 Output

            para: download_html_text为返回 text
                data_num 为当前共爬取的界面'''
        page_result = []
        soup = BeautifulSoup(download_html_text, 'lxml')
        user_tags = soup.find_all("div", class_="card-wrap", \
                        attrs={"action-type": "feed_list_item"})
        i = 1
        for user_tag in user_tags:
            # 添加到 page_result 的 list 中
            print('\t\t 当前解析第 {} 条数据'.format(data_num+i))
            i += 1
            page_result.append(self.parse_a_user(user_tag))
        return [len(user_tags), page_result]
        pass

    def parse_a_user(self, user_tag):
        ''' 解析当前页面的一个用户 '''
        rt_value = {}
        rt_value['用户名'] = self.get_user_name(user_tag)
        rt_value['微博内容'] = self.get_contents(user_tag)
        for key, values in self.get_social_contacts_info(user_tag).items():
            rt_value[key] = values
        return rt_value

    def get_social_contacts_info(self, user_tag):
        ''' 收藏 转发 评论 点赞 '''
        social_contact = ['收藏', '转发', '评论', '点赞']
        sc = {}
        card_act = user_tag.find("div", class_="card-act")
        lis = card_act.find_all("li")
        # 处理列表
        for index, li in enumerate(lis):
            if li.string:
                s = li.string.strip()
                tmp = s.split(' ')
                if len(tmp) > 1 and tmp[1].isalnum():
                    sc[social_contact[index]] = tmp[1]    # 去除空格
                elif len(tmp) == 1:
                    sc[social_contact[index]] = str(0)
                else:
                    sc[social_contact[index]] = s
            else:
                s = "".join(li.strings)
                if s.strip():
                    sc[social_contact[index]] = s.strip()
                else:
                    sc[social_contact[index]] = str(0)
        return sc

    def get_user_name(self, user_tag):
        ''' 获取用户名 '''
        txt = user_tag.find("p", class_="txt", attrs={"node-type": "feed_list_content"})
        return txt.attrs['nick-name']

    def get_contents(self, user_tag):
        ''' 获取主题内容 '''
        txt = user_tag.find("p", class_="txt", attrs={"node-type": "feed_list_content"})
        return ''.join(txt.stripped_strings)
