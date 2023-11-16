-- 1. Создать таблицу exam с полями:
--
-- - идентификатора экзамена - автоинкрементируемый, уникальный, запрещает NULL;
-- - наименования экзамена
-- - даты экзамена
DROP TABLE IF EXISTS exam;

CREATE TABLE IF NOT EXISTS exam
(
    exam_id int GENERATED ALWAYS AS IDENTITY NOT NULL UNIQUE,
    exam_name VARCHAR(32),
    exam_date DATE
);

SELECT * FROM exam;

-- 2. Удалить ограничение уникальности с поля идентификатора

SELECT constraint_name
FROM information_schema.key_column_usage
WHERE table_name = 'exam'
    AND table_schema = 'public'
    AND column_name = 'exam_id';

ALTER TABLE exam
DROP CONSTRAINT exam_exam_id_key;

ALTER TABLE exam
ALTER COLUMN exam_id SET DATA TYPE int;

-- ALTER TABLE exam
-- ALTER COLUMN exam_id ADD GENERATED ALWAYS AS IDENTITY;


-- 3. Добавить ограничение первичного ключа на поле идентификатора

ALTER TABLE exam
ADD CONSTRAINT exam_exam_id_key PRIMARY KEY(exam_id);


-- 4. Создать таблицу person с полями
-- - идентификатора личности (простой int, первичный ключ)
-- - имя
-- - фамилия

CREATE TABLE IF NOT EXISTS person
(
    person_id int,
    first_name VARCHAR,
    last_name VARCHAR,
    CONSTRAINT pk_first_name PRIMARY KEY (person_id)
);

-- 5. Создать таблицу паспорта с полями:
--
-- - идентификатора паспорта (простой int, первичный ключ)
-- - серийный номер (простой int, запрещает NULL)
-- - регистрация
-- - ссылка на идентификатор личности (внешний ключ)

CREATE TABLE passport
(
    passport_id int PRIMARY KEY,
    serial_number int NOT NULL,
    registration varchar,
    person_id int,
    CONSTRAINT fk_person_id FOREIGN KEY (person_id) REFERENCES person(person_id)
);

SELECT *
FROM passport;

-- 6. Добавить колонку веса в таблицу book (создавали ранее) с ограничением,
-- проверяющим вес (больше 0 но меньше 100)

SELECT *
FROM book;

ALTER TABLE book
ADD COLUMN weight float,
ADD CONSTRAINT chk_weight CHECK ( weight >=0  AND weight < 100);




-- 7. Убедиться в том, что ограничение на вес работает (попробуйте вставить невалидное значение)


INSERT INTO book (title, isbn, weight)
VALUES
('dfgdg', '1234533', 70),
('jrerrr', '2345654', 50),
('dsfkdfkfgfg', '1234533', 90)
RETURNING *;

-- 8. Создать таблицу student с полями:
--
-- - идентификатора (автоинкремент)
-- - полное имя
-- - курс (по умолчанию 1)

CREATE TABLE student
(
    student_id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(128),
    course int default 1 CHECK (course >0  and course <= 4)
);


-- 9. Вставить запись в таблицу студентов и убедиться,
-- что ограничение на вставку значения по умолчанию работает

INSERT INTO student (full_name)
VALUES
('BIBur Bobof'),
('GIk Dermodemon')
RETURNING *;

INSERT INTO student (full_name, course)
VALUES
('777sdgdsdd', 7)
RETURNING *;

-- 10. Удалить ограничение "по умолчанию" из таблицы студентов

ALTER TABLE student
ALTER COLUMN course DROP DEFAULT;

-- 11. Подключиться к БД northwind и добавить ограничение на поле
-- unit_price таблицы products (цена должна быть больше 0)


ALTER TABLE products
ADD CONSTRAINT chk_unit_price CHECK ( unit_price >0 );

-- 12. "Навесить" автоинкрементируемый счётчик на поле product_id таблицы products (БД northwind).
-- Счётчик должен начинаться с числа следующего за максимальным значением по этому столбцу.

ALTER TABLE products
ALTER COLUMN product_id DROP IDENTITY;

ALTER TABLE products
ALTER COLUMN product_id ADD GENERATED ALWAYS AS IDENTITY (START WITH 78);

SELECT MAX(product_id)
FROM products;

SELECT *
FROM products
WHERE product_id = 77;

-- 13. Произвести вставку в products (не вставляя идентификатор явно)
-- убедиться, что автоинкремент работает. Вставку сделать так, чтобы в
-- результате команды вернулось значение, сгенерированное в качестве идентификатора.

INSERT INTO products (product_name, supplier_id, category_id, quantity_per_unit, unit_price, units_in_stock, units_on_order, reorder_level, discontinued)
VALUES
('Original Frankfurter grüne Soße', 12, 2, 12,13,32,2,15,0)
RETURNING *
