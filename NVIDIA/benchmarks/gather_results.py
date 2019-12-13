import re
import os
import subprocess
import datetime as dt
import numpy as np


SYSTEM='LambdaCloud4xQuadro5000'
PATH_RESULTS = 'logs'
FORMAT = ".log"

tasks = ['single_stage_detector', 'maskrcnn', 'resnet', 'gnmt', 'translation', 'minigo']
throughput_names = ['samples/sec', 'iterations/s', 'samples/sec', 'Tok/s', 'batches/sec', 'epochs/min']

#tasks = ['single_stage_detector', 'maskrcnn', 'resnet', 'gnmt', 'translation']
#throughput_names = ['samples/sec', 'iterations/s', 'samples/sec', 'Tok/s', 'batches/sec']


def tail(filename, n):
    proc = subprocess.Popen(['tail', '-n', str(n), filename], stdout=subprocess.PIPE)
    lines = proc.stdout.readlines()
    return lines


def single_stage_detector_T2S(filename):
    lines = tail(filename, 2)

    line_end = lines[0].split(' ')
    date_end = line_end[-3]
    time_end = line_end[-2]
    if lines[0][-3] == 'A':
        if time_end[:2] == '12':
            time_end = '00' + time_end[2:]
    else:
        if not int(time_end[:2]) == 12:
            time_end = str(int(time_end[:2]) + 12) + time_end[2:]


    line_start = lines[1].split(' ')
    date_start = line_start[-3].split(',')[-1]
    time_start = line_start[-2]
    if lines[1][-3] == 'A':
        if time_start[:2] == '12':
            time_start = '00' + time_start[2:]
    else:
        if not int(time_start[:2]) == 12:
            time_start = str(int(time_start[:2]) + 12) + time_start[2:]

    date_start = date_start.split('-')
    time_start = time_start.split(':')

    date_end = date_end.split('-')
    time_end = time_end.split(':')

    start = dt.datetime(
        int(date_start[0]), int(date_start[1]), int(date_start[2]),
        int(time_start[0]), int(time_start[1]), int(time_start[2]))
    end = dt.datetime(
        int(date_end[0]), int(date_end[1]), int(date_end[2]),
        int(time_end[0]), int(time_end[1]), int(time_end[2]))
    num_second = (end-start).total_seconds()

    return num_second / 60.0


def single_stage_detector_TPS(filename):
    pattern = re.compile("^.*samples / sec:.*$")
    count = 0.0
    total_throughput = 0.0
    for i, line in enumerate(open(filename)):
        for match in re.finditer(pattern, line):
            total_throughput += float(match.group().split(' ')[-1])
            count += 1

    return total_throughput / float(count)


def maskrcnn_T2S(filename):
    lines = tail(filename, 2)

    line_end = lines[0].split(' ')

    date_end = line_end[-3]
    time_end = line_end[-2]

    if lines[0][-3] == 'A':
        if time_end[:2] == '12':
            time_end = '00' + time_end[2:]
    else:
        if not int(time_end[:2]) == 12:
            time_end = str(int(time_end[:2]) + 12) + time_end[2:]


    line_start = lines[1].split(' ')
    date_start = line_start[-3].split(',')[-1]
    time_start = line_start[-2]

    if lines[1][-3] == 'A':
        if time_start[:2] == '12':
            time_start = '00' + time_start[2:]
    else:
        if not int(time_start[:2]) == 12:
            time_start = str(int(time_start[:2]) + 12) + time_start[2:]

    date_start = date_start.split('-')
    time_start = time_start.split(':')

    date_end = date_end.split('-')
    time_end = time_end.split(':')

    start = dt.datetime(
        int(date_start[0]), int(date_start[1]), int(date_start[2]),
        int(time_start[0]), int(time_start[1]), int(time_start[2]))
    end = dt.datetime(
        int(date_end[0]), int(date_end[1]), int(date_end[2]),
        int(time_end[0]), int(time_end[1]), int(time_end[2]))

    num_second = (end-start).total_seconds()

    return num_second / 60.0


def maskrcnn_TPS(filename):
    pattern = re.compile("^.*iterations / s.*$")
    count = 0.0
    total_throughput = 0.0
    for i, line in enumerate(open(filename)):
        for match in re.finditer(pattern, line):
            total_throughput += float(match.group().split(' ')[3].split('=')[1])
            count += 1

    return total_throughput / float(count)


def resnet_T2S(filename):
    lines = tail(filename, 2)

    line_end = lines[0].split(' ')

    date_end = line_end[-3]
    time_end = line_end[-2]

    if lines[0][-3] == 'A':
        if time_end[:2] == '12':
            time_end = '00' + time_end[2:]
    else:
        if not int(time_end[:2]) == 12:
            time_end = str(int(time_end[:2]) + 12) + time_end[2:]


    line_start = lines[1].split(' ')
    date_start = line_start[-3].split(',')[-1]
    time_start = line_start[-2]

    if lines[1][-3] == 'A':
        if time_start[:2] == '12':
            time_start = '00' + time_start[2:]
    else:
        if not int(time_start[:2]) == 12:
            time_start = str(int(time_start[:2]) + 12) + time_start[2:]

    date_start = date_start.split('-')
    time_start = time_start.split(':')

    date_end = date_end.split('-')
    time_end = time_end.split(':')

    start = dt.datetime(
        int(date_start[0]), int(date_start[1]), int(date_start[2]),
        int(time_start[0]), int(time_start[1]), int(time_start[2]))
    end = dt.datetime(
        int(date_end[0]), int(date_end[1]), int(date_end[2]),
        int(time_end[0]), int(time_end[1]), int(time_end[2]))

    num_second = (end-start).total_seconds()

    return num_second / 60.0

def resnet_TPS(filename):
    pattern = re.compile("^.*samples/sec.*$")
    count = 0.0
    total_throughput = 0.0
    for i, line in enumerate(open(filename)):
        for match in re.finditer(pattern, line):
            total_throughput += float(match.group().split(' ')[-2])
            count += 1

    return total_throughput / float(count)


def gnmt_T2S(filename):
    lines = tail(filename, 2)

    line_end = lines[0].split(' ')

    date_end = line_end[-3]
    time_end = line_end[-2]

    if lines[0][-3] == 'A':
        if time_end[:2] == '12':
            time_end = '00' + time_end[2:]
    else:
        if not int(time_end[:2]) == 12:
            time_end = str(int(time_end[:2]) + 12) + time_end[2:]


    line_start = lines[1].split(' ')
    date_start = line_start[-3].split(',')[-1]
    time_start = line_start[-2]

    if lines[1][-3] == 'A':
        if time_start[:2] == '12':
            time_start = '00' + time_start[2:]
    else:
        if not int(time_start[:2]) == 12:
            time_start = str(int(time_start[:2]) + 12) + time_start[2:]

    date_start = date_start.split('-')
    time_start = time_start.split(':')

    date_end = date_end.split('-')
    time_end = time_end.split(':')

    start = dt.datetime(
        int(date_start[0]), int(date_start[1]), int(date_start[2]),
        int(time_start[0]), int(time_start[1]), int(time_start[2]))
    end = dt.datetime(
        int(date_end[0]), int(date_end[1]), int(date_end[2]),
        int(time_end[0]), int(time_end[1]), int(time_end[2]))

    num_second = (end-start).total_seconds()

    return num_second / 60.0


def gnmt_TPS(filename):    
    pattern = re.compile("^.*Training:.*$")
    count = 0.0
    total_throughput = 0.0
    for i, line in enumerate(open(filename)):
        for match in re.finditer(pattern, line):
            total_throughput += float(match.group().split(' ')[-2])
            count += 1

    return total_throughput / float(count)


def translation_T2S(filename):
    pattern = re.compile("^.*done training.*$")
    count = 0.0
    num_second = 0.0
    for i, line in enumerate(open(filename)):
        for match in re.finditer(pattern, line):
            num_second += float(match.group().split(' ')[-2])
            count += 1

    return num_second / (float(count) * 60)


def translation_TPS(filename):  
    pattern_time = re.compile("^.*epoch time.*$")
    pattern_batch = re.compile("^.*generated.*$")

    total_time = 0.0
    total_batch = 0.0

    for i, line in enumerate(open(filename)):
        for match in re.finditer(pattern_time, line):
            total_time += float(match.group().split(' ')[-1])

    for i, line in enumerate(open(filename)):
        for match in re.finditer(pattern_batch, line):
            batch = float(match.group().split(' ')[-4])
            if batch > 1000:
                total_batch += batch

    total_throughput = total_batch / total_time

    return total_throughput


def minigo_T2S(filename):
    pattern = re.compile("^.*beat target after.*$")
    num_second = 0.0
    for i, line in enumerate(open(filename)):
        for match in re.finditer(pattern, line):
            num_second = float(match.group().split(' ')[-1][:-2])

    return num_second / 60.0

def minigo_TPS(filename):
    pattern = re.compile("^.*Iteration time.*$")
    total_throughput = 0.0
    count = 0.0
    total_time = 0.0
    for i, line in enumerate(open(filename)):
        for match in re.finditer(pattern, line):
            total_throughput += 1 / float(match.group().split(' ')[-2])
            count += 1

    return total_throughput * 60.0 / float(count)


for task, t_name in zip(tasks, throughput_names):  
    task_path = os.path.join(PATH_RESULTS, task + '_' + SYSTEM)

    list_t2solution = []
    list_tpsec = []
    for file in os.listdir(task_path):
        if file.endswith(FORMAT):
            filename = os.path.join(task_path, file)
            try:
                t2solution = locals()[task + "_T2S"](filename)
                tpsec = locals()[task + "_TPS"](filename)

                list_t2solution.append(t2solution)
                list_tpsec.append(tpsec)
            except:
                list_t2solution.append(-1.0)
                list_tpsec.append(-1.0)
    #print(list_t2solution)
    #print(list_tpsec)
    array_t2solution = np.asarray(list_t2solution)
    array_tpsec = np.asarray(list_tpsec)

    print(task + ':')
    print('time 2 solution: ' + str(np.average(array_t2solution)) + ' minutes.')
    print(t_name + ': ' + str(np.average(array_tpsec)))
    print('------------------------------------------------')
