#coding:utf-8
def get_cars_or_roads_or_crosses(fname):
    '''
    para: 文件名 确定处理什么
    '''
    with open(fname, 'r') as f:
        f.readline() # 第一行排除
        sourses = [eval(sourse) for sourse in f.readlines()]
        f.close()

    return sourses

def put_answer(answer):
    '''
    para: answer tuple list
    rt: none output answer.txt
    '''
    with open('answer.txt', 'w+') as f:
        for item in answer:
            f.writelines(str(item))
            f.writelines('\n')
            f.close()