# Создать класс Pagination, который обрабатывает некое содержимое постранично. Пагинация используется для того, чтобы
# делить длинные списки как-бы на страницы.
# На рисунке пример такого подхода (интерфейс нам делать не надо)
#
# Конструктор принимает два параметра:
# items (по умолчанию: []): - список строкового содержимого, который мы будем пагинировать
# page_size (по умолчанию: 10): кол-во экземпляров строк, показываемых на одной странице

# Класс реализует функцию get_visible_items возвращающую элементы на текущей странице.
# Класс также должен предоставлять набор функций для перемещения по страницам:
# prev_page # переход на предыдущую страницу
# next_page # переход на следующую страницу
# first_page # переход на первую
# last_page # переход на последнюю страницу
# go_to_page # принимает номер страницы в качестве аргумента, осуществляет переход на конкретную страницу
#             # если передано число > числа страниц, то перейти на последнюю, если < 1 то перейти на первую
# Также, класс должен поддерживать следующие функции:
# get_current_page возвращающая текущий номер страницы
# get_page_size возвращающая размер страницы
# get_itemsвозвращающая список строк
# Например, мы можем создать наш класс следующим образом:
# alphabetList = list("abcdefghijklmnopqrstuvwxyz")
# p = Pagination(alphabetList, 4)
# А затем вызвать get_visible_items чтобы вывести содержимое текущей страницы (текущая страница - первая)
# p.get_visible_items() ➞ ["a", "b", "c", "d"]
# Если перейти на следующую страницу и снова вызвать get_visible_items, то получим ["e", "f", "g", "h"]
# p.next_page()
#
# p.get_visible_items() ➞ ["e", "f", "g", "h"]
# На последней странице должно быть всего два элемента, так что если вызвать last_page и get_visible_items, то получим ["y", "z"]
# p.last_page()
# p.get_visible_items() ➞ ["y", "z"]
# Notes
# Аргумент page_size и аргумент функции go_to_page передаются только типом int, не надо защищаться от float.
# Функции перемещения по страницам должны быть реализованы таким образом, чтобы их можно было вызывать цепочкой: p.next_page().next_page().prev_page()
# p.last_page().prev_page()
# p.first_page().next_page()
# p.go_to_page(10).next_page()

class Pagination:

    def __init__(self, items=[], page_size=10):
        self.items = items
        self.page_size = page_size
        self.current_page: int = 0

    def get_visible_items(self):
        return self.items[self.current_page * self.page_size:(self.current_page + 1) * self.page_size]

    def prev_page(self):  # переход на предыдущую страницу
        if self.current_page > 0:
            self.current_page -= 1
        return self

    def next_page(self):  # переход на следующую страницу
        if self.current_page + 1 < len(self.items) / self.page_size:
            self.current_page += 1
        return self

    def first_page(self):  # переход на первую
        self.current_page = 0
        return self

    def last_page(self):  # переход на последнюю страницу
        if len(self.items) % self.page_size != 0:
            self.current_page = len(self.items) // self.page_size
        else:
            self.current_page = len(self.items) // self.page_size - 1
        return self

    def go_to_page(self, page):
        if page < 1:
            self.current_page = 0
        elif page < len(self.items) / self.page_size:
            self.current_page = page - 1
        else:
            self.last_page()
        return self

    def get_current_page(self):
        return self.current_page + 1

    def get_page_size(self):
        return self.page_size

    def get_items(self):
        return self.items[0::]


alphabetList = list("abcdefghijklmnopqrstuvwxyz")

# p = Pagination(alphabetList, 5)

# print(p.get_visible_items())
# p.prev_page().prev_page().next_page().next_page().next_page().next_page().next_page().next_page()
# print(p.get_visible_items())
# print(len(alphabetList))
#
# print(p.get_current_page())
# print(p.get_page_size())
# print(p.get_items())

p = Pagination(alphabetList, 4)
print(p.get_visible_items())

p.last_page()

print(p.get_visible_items())

p.go_to_page(-1)
print(p.get_visible_items())

p.next_page().next_page().prev_page()
p.last_page().prev_page()
p.first_page().next_page()
p.go_to_page(10).next_page()

print(p.get_items())
