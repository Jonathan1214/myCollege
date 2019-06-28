import logging
import sys

logging.basicConfig(level=logging.DEBUG,
                    filename='../logs/CodeCraft-2019.log',
                    format='[%(asctime)s] %(levelname)s [%(funcName)s: %(filename)s, %(lineno)d] %(message)s',
                    datefmt='%Y-%m-%d %H:%M:%S',
                    filemode='a')


def main():
    if len(sys.argv) != 5:
        logging.info('please input args: car_path, road_path, cross_path, answerPath')
        exit(1)

    car_path = sys.argv[1]
    road_path = sys.argv[2]
    cross_path = sys.argv[3]
    answer_path = sys.argv[4]

    logging.info("car_path is %s" % (car_path))
    logging.info("road_path is %s" % (road_path))
    logging.info("cross_path is %s" % (cross_path))
    logging.info("answer_path is %s" % (answer_path))
 
 
# to read input file 
    def get_data(fpath):
        '''
        para: filename file type
        return: sourses in tuple-list type
        '''
        with open(fpath, 'r') as f:
            f.readline()
            sourses = [eval(sourse) for sourse in f.readlines()]
            f.close()

        return sourses
    
    crosses = get_data(cross_path)
    print(crosses[0])
    
# process


# to write output file
    def put_answer(answer, path):
        '''
        para: answer tuple list
        rt: none output answer.txt
        '''
        with open(path, 'w+') as f:
            for item in answer:
                f.writelines(str(item))
                f.writelines('\n')
                f.close()


if __name__ == "__main__":
    main()