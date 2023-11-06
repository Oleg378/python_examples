import concurrent.futures
import threading
import time


class BankAccount:
    def __init__(self):
        self.balance = 100
        self.lock_obj = threading.Lock()

    def update(self, transaction, amount):
        print(f'Transaction {transaction} started')

        with self.lock_obj:
            tmp_amount = self.balance
            tmp_amount += amount
            time.sleep(1)
            self.balance = tmp_amount
        print(f'Transaction {transaction} ended')


if __name__ == '__main__':
    # In this case in order to avoid spoiling data we need to use .Lock():
    #  lock_obj = threading.Lock()
    #  print(lock_obj.locked()) # lock_obj created
    #
    # lock_obj.acquire()
    # print(lock_obj.locked()) # lock_obj locked
    #
    # lock_obj.release()
    # print(lock_obj.locked()) # lock_obj unlocked

    acc = BankAccount()
    print(f'Main started Acc balance: {acc.balance}')

    with concurrent.futures.ThreadPoolExecutor(max_workers=2) as ex:
        ex.map(acc.update, ('refill', 'withdraw'), (100, -200))

    print(f'End of main. Balance: {acc.balance}')


