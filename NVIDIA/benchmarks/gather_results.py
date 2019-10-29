import re
import os
import subprocess
import datetime as dt
import numpy as np


SYSTEM='DGX1'
PATH_RESULTS = '/home/ubuntu/benchmarks/mlperf'

# tasks = ['gnmt', 'maskrcnn', 'minigo', 'resnet', 'single_stage_detector', 'transformer']
tasks = ['single_stage_detector', 'maskrcnn']
throughput_names = ['samples/sec', 'iterations/s']

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
        time_end = str(int(time_end[:2]) + 12) + time_end[2:]


    line_start = lines[1].split(' ')
    date_start = line_start[-3].split(',')[-1]
    time_start = line_start[-2]
    if lines[1][-3] == 'A':
        if time_start[:2] == '12':
            time_start = '00' + time_start[2:]
    else:
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

    return num_second


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
        time_end = str(int(time_end[:2]) + 12) + time_end[2:]


    line_start = lines[1].split(' ')
    date_start = line_start[-3].split(',')[-1]
    time_start = line_start[-2]

    if lines[1][-3] == 'A':
        if time_start[:2] == '12':
            time_start = '00' + time_start[2:]
    else:
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

    return num_second


def maskrcnn_TPS(filename):
    pattern = re.compile("^.*iterations / s.*$")
    count = 0.0
    total_throughput = 0.0
    for i, line in enumerate(open(filename)):
        for match in re.finditer(pattern, line):
            total_throughput += float(match.group().split(' ')[3].split('=')[1])
            count += 1

    return total_throughput / float(count)



for task, t_name in zip(tasks, throughput_names):  
    task_path = os.path.join(PATH_RESULTS, task + '_' + SYSTEM)

    list_t2solution = []
    list_tpsec = []
    for file in os.listdir(task_path):
        if file.endswith(".log"):
            filename = os.path.join(task_path, file)

            t2solution = locals()[task + "_T2S"](filename)
            tpsec = locals()[task + "_TPS"](filename)

            list_t2solution.append(t2solution)
            list_tpsec.append(tpsec)
        break

    array_t2solution = np.asarray(list_t2solution)
    array_tpsec = np.asarray(list_tpsec)

    
    print(task + ':')
    print('time 2 solution: ' + str(np.average(array_t2solution)/60) + ' minutes.')
    print(t_name + ': ' + str(np.average(array_tpsec)))
    print('------------------------------------------------')
