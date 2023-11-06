# import random # use this to generate file
#
# print(random.randint(3, 9))
#
# with open('numbers.txt', "a") as f:
#     f.writelines([str(random.randint(-500, 500)) + '\n' for i in range(1000)])
import threading


# lets write script to finding all triples wich in summ equal 0:

def read_ints(path):
    lst = []
    with open(path, "r") as f:
        while line := f.readline():
            lst.append(int(line))

    return lst


def count_three_summ(ints):
    print('started calculation')
    n = len(ints)
    counter_triples = 0
    for i in range(n):
        for j in range(i + 1, n):
            for k in range(j + 1, n):
                if ints[i] + ints[j] + ints[k] == 0:
                    print(f'Triple was found: {ints[i]} {ints[j]} {ints[k]}')
                    counter_triples += 1
    print(f'Calculation was finished. Amount of triples: {counter_triples}')


# There is the "main" loop:
if __name__ == '__main__':
    print('started form main')
    ints = read_ints('numbers.txt')

    # count_three_summ(ints) #instead of this we use threading:

    t1 = threading.Thread(target=count_three_summ, args=(ints,), daemon=True)
    t1.start()
    print('What are we waiting for?')

    # this syntax mean: script will wait until this daemon threat will non completed
    t1.join()
    print('We are waiting for t1.join')

    print("Ended main")
