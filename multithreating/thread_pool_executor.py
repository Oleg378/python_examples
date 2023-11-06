import concurrent.futures
import time


def div(divisor, limit):
    print(f'Started div: {divisor}')

    for i in range(1, limit):
        if i % divisor == 0:
            print(f' divisor = {divisor} x= {i}')
        time.sleep(0.2)
    print(f'ended div: {divisor}', end='\n')


if __name__ == '__main__':
    print('Started from main')

    with concurrent.futures.ThreadPoolExecutor(max_workers=2) as executor:
        executor.submit(div, 3, 25)
        executor.submit(div, 5, 25)

        print('Immediately printed after submit')

    print('Ended form main after with block')
