import sqlalchemy
from sqlalchemy import text, Column, Integer, String, Float
from sqlalchemy.orm import declarative_base, sessionmaker

engine = sqlalchemy.create_engine('postgresql+psycopg2://postgres:@localhost:5432/testdb')

connection = engine.connect()

result = connection.execute(text("SELECT * FROM book"))
[print('title:', row[1]) for row in result]

result.close()

with engine.begin() as trans:
    query = text("INSERT INTO book (title, isbn, weight) VALUES ('ROBIN BOBIN', 3554333, 23)")
    connection.execute(query)
result = connection.execute(text("SELECT * FROM book"))
[print('title:', row[1]) for row in result]

Base = declarative_base()


class Author(Base):
    __tablename__ = 'author'

    author_id = Column(Integer, primary_key=True)
    full_name = Column(String(25))
    rating = Column(Float)


Base.metadata.create_all(engine)

Session = sessionmaker(bind=engine)

session = Session()

author = Author(author_id=19, full_name='Denis Neprucha', rating=1.1)
session.add(author)

session.commit()

for item in session.query(Author).order_by(Author.rating):
    print(item.full_name, ' ', item.rating)

for item in session.query(Author).filter(Author.rating < 2):
    print(item.full_name, ' ', item.rating)
