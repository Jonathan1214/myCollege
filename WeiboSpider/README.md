# 新浪微博爬虫

一个简单的新浪微博爬虫，主要功能为：

+ 爬取关键字 `星巴克致癌` 的综合搜索结果页面。
+ 解析页面，获得关键搜索结果中，每一条微博的某些数据。
+ 将数据保存为 `.json` 和 `.csv` 格式。

一个典型的网络爬虫结构：`URL管理器`，`网页下载器`，`数据解析器`，`解析数据管理器`和`爬虫调度器`。这里也使用了这种结构，分别对应 `URLmanager.py`，`HTMLDownloader.py`，`HTMLParser.py`，`DATAOutput.py` 和 `SinaSpider.py`。运行 `SinaSpider.py` 即可获得爬取结果。需要注意的是，因为只是爬取特定的界面，在这里 `URL管理器` 没有太大的作用，所以没有使用，`URLmanager.py` 也是个空文件，为了爬虫结构的完整，在这里还是列出 `URL管理器`。

## 爬虫调度器

爬虫调度器管理整个爬虫的运行，初始化网页下载器、网页解析器和解析数据管理器，在合适的时候调用它们，获得数据输出。在这里调度器还控制了所有待爬取的 `url`，包含了 `URL管理器` 的功能。

## 网页下载器

网页下载器负责下载网页，用到了 `requests` 库，使用 `requests.get(url)` 即可完成，如果直接这么使用容易导致爬虫被封，在这里使用了会话 `Session`，使用自己手动从浏览器复制到的 `cookies` 信息，更新会话，然后再去请求页面。通过会话请求时，没跑多久，出现了 `ssl_ban` 之类的错误，将 `verify` 设置为 `False` 即可。

```Python
s = requests.Session()
s.cookies.update(cookies)
s.get(url, headers=headers, verify=False)
```

## 网页解析器

网页解析器从网页下载器下载的页面中解析出需要的数据，用到了 `lxml` 和 `BeautifulSoup` 库，这是一种比较简单的方式，只需要对`BeautifulSoup`的特性和相关函数进行一点了解即可学会使用，示例代码如下：

```Python
import lxml
from bs4 import BeautifulSoup
# 包含在 bs4 库中
soup = BeautifulSoup(html, 'lxml')
# 指定 lxml 为解析器
result_tags = soup.find_all("div", class_="card-wrap",\
                            attrs={"action-type": "feed_list_item"})
```

当然也可以使用正则表达式，不过要稍复杂一些。实际解析页面时，需要自己去下载的页面的 `HTML` 代码中找到需要的信息，比如在这里，需要爬取相关话题下发微博的人的ID、微博内容、收藏量、点赞量、评论量和转发量，通过对页面的分析，发现，每一条微博都包含在一个 `class=card-wrap` 的 `<div>` 节点中，通过对节点内容的进一步分析可以获得我们想要的内容。

## 解析数据管理器

解析数据管理器负责将解析出来的大量数据保存为需要的格式，在这里我们需要保存 `.json` 和 `.csv` 格式，需要使用 `json` 和 `csv` 库。我们将解析出来的每一个微博的数据保存为字典，并把每个页面的微博保存到列表中，这样保存起来比较方便。

```Python
import json
import csv
# csv 格式 可以追加 多个页面的数据可以保存在一个文件中
with open(csvpath, 'w', newline='', encoding='utf-8') as csvfile:
    # 以追加模式打开
    fieldnames = ['用户名', '微博内容', '收藏', '转发', '评论', '点赞']
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
    writer.writeheader()
    writer.writerows(parser_result)
# json 格式 多个页面追加会导致错误 故每个界面分别保存在一个文件中
with open(jsonpath + 'result_{}.json'.format(page), 'w', encoding='utf-8') as jsonfile:
    # 以追加模式打开
    json.dump(parser_result, jsonfile, ensure_ascii=False, indent=4)
```
