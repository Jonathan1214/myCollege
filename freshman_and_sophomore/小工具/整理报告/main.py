# coding:utf-8
import os
import zipfile
import shutil

#创建保存文件夹
i = 7
for index in range(1,i+1):
    try:
        os.mkdir('实验'+str(index))
    except:
        continue
print(os.getcwd())


file_list = os.listdir('.')


for file_name in file_list:

    if os.path.splitext(file_name)[1] == '.zip':
        print('开始处理zip文件', file_name)
        file_zip = zipfile.ZipFile(file_name, 'r') # 打开zip文件

        for file in file_zip.namelist():
            gbkfilename = file.encode('cp437').decode('gbk')
            print('当前正在处理: ', gbkfilename, end='\t')

            file_zip.extract(file) #解压
            os.rename(file, gbkfilename)
            # 移动文件
            try:
                true_name = gbkfilename.split('/')[1]
                destination = true_name[0:3] + '/' + true_name
                shutil.move(gbkfilename, destination)
            except:
                continue
            print('当前文件处理完成')
        #删除临时文件和目录
        print('当前zip文件', file_name, '处理完成')
        os.removedirs(file_zip.namelist()[0])
        os.removedirs(file_zip.namelist()[0].encode('cp437').decode('gbk'))
        file_zip.close()
