import concurrent.futures
import time


def div(divisor, limit):
    print(f'Started div: {divisor}')
    result = 0
    for i in range(1, limit):
        if i % divisor == 0:
            result += i
            # print(f' divisor = {divisor} x= {i}')
        time.sleep(0.2)
    print(f'ended div: {divisor}', end='\n')
    return result


if __name__ == '__main__':
    print('Started from main')

    # First way:
    futures = []
    with concurrent.futures.ThreadPoolExecutor(max_workers=2) as executor:
        futures.append(executor.submit(div, 3, 25))
        futures.append(executor.submit(div, 5, 25))

        while futures[0].running() and futures[1].running():
            print('.', end='')
            time.sleep(0.5)

        for f in futures:
            print(f'{f.result()}')

        print('Immediately printed after submit')

    print('Ended form main after with block')

    # Second way:
    # executor = concurrent.futures.ThreadPoolExecutor(max_workers=2)
    # executor.submit(div, 3, 25)
    # executor.submit(div, 5, 25)
    #
    # executor.shutdown(wait=False) # this param influence on the order of executing print('\nmain ended')
    # By default this threads has foreground type
    # print('\nmain ended')


