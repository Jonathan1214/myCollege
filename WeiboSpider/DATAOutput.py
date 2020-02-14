# encoding=utf-8
import csv
import json

class DATAOutput:
    ''' data '''
    def __init__(self):
        print('开启数据保存器')

    def save_to_csv(self, parser_result, csvpath):
        ''' 保存为 json 数据

            para: parser_result'''
        with open(csvpath, 'w', newline='', encoding='utf-8') as csvfile:
            # 以追加模式打开
            fieldnames = ['用户名', '微博内容', '收藏', '转发', '评论', '点赞']
            writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
            writer.writeheader()
            writer.writerows(parser_result)
        print("\t\t\t 当前页面数据保存完成，格式为 csv")

    def save_to_json(self, parser_result, jsonpath, page):
        ''' 保存为 csv 文件

            para: parser_result'''
        with open(jsonpath + 'result_{}.json'.format(page), 'w', encoding='utf-8') as jsonfile:
            # 以追加模式打开
            json.dump(parser_result, jsonfile, ensure_ascii=False, indent=4)
        print("\t\t\t\ 当前页面数据保存完成，格式为 json")
