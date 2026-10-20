DROP TABLE IF EXISTS borrowings;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS officers;
DROP TABLE IF EXISTS borrowers;
DROP TABLE IF EXISTS bookshelves;
DROP TABLE IF EXISTS categories;

CREATE TABLE categories (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE bookshelves (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE books (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  author VARCHAR(150) NOT NULL,
  publisher VARCHAR(150) NOT NULL,
  publication_year smallint NOT NULL,
  category_id INTEGER NOT NULL REFERENCES categories(id),
  bookshelf_id INTEGER NOT NULL REFERENCES bookshelves(id)
);

CREATE TABLE officers (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(150) NOT NULL
);

CREATE TABLE borrowers (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  phone_number VARCHAR(20) NOT NULL,
  address VARCHAR(255) NOT NULL
);

CREATE TABLE borrowings (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  book_borrowing_date date NOT NULL DEFAULT CURRENT_DATE,
  book_return_date date,
  borrower_id INTEGER NOT NULL REFERENCES borrowers(id),
  officer_id INTEGER NOT NULL REFERENCES officers(id),
  book_id INTEGER NOT NULL REFERENCES books(id)
);

INSERT INTO categories (name) VALUES
  ('Fiksi'),
  ('Teknologi'),
  ('Sejarah'),
  ('Pengembangan Diri');

INSERT INTO bookshelves (name) VALUES
  ('Rak A1'),
  ('Rak A2'),
  ('Rak B1'),
  ('Rak B2');

INSERT INTO books (name, author, publisher, publication_year, category_id, bookshelf_id) VALUES
  ('Laskar Pelangi', 'Andrea Hirata', 'Bentang Pustaka', 2005, 1, 1),
  ('Bumi Manusia', 'Pramoedya Ananta Toer', 'Hasta Mitra', 1980, 1, 1),
  ('Filosofi Teras', 'Henry Manampiring', 'Kompas', 2018, 4, 4),
  ('Atomic Habits', 'James Clear', 'Gramedia Pustaka Utama', 2019, 4, 4),
  ('Clean Code', 'Robert C. Martin', 'Prentice Hall', 2008, 2, 2),
  ('Sapiens', 'Yuval Noah Harari', 'Kepustakaan Populer Gramedia', 2017, 3, 3),
  ('Sejarah Indonesia Modern', 'M.C. Ricklefs', 'Serambi', 2008, 3, 3),
  ('Algoritma dan Pemrograman', 'Rinaldi Munir', 'Informatika', 2016, 2, 2);

INSERT INTO officers (name) VALUES
  ('Lionel Messi'),
  ('Luis Suarez'),
  ('Neymar Junior');

INSERT INTO borrowers (name, phone_number, address) VALUES
  ('Erling Haaland', '081234567801', 'Jl. Kenangan No. 12, Bekasi'),
  ('Ousmane Dembele', '081234567802', 'Jl. Buntu No. 7, Bekasi'),
  ('Lamine Yamal', '081234567803', 'Jl. Yang Salah No. 21, Jakarta Timur'),
  ('Kyllian Mbappe', '081234567804', 'Jl. Jalan No. 5, Bekasi'),
  ('Karim Adeyemi', '081234567805', 'Jl. Setapak No. 33, Depok');

INSERT INTO borrowings (book_borrowing_date, book_return_date, borrower_id, officer_id, book_id) VALUES
  ('2026-09-20', '2026-09-27', 4, 3, 7),
  ('2026-10-01', '2026-10-08', 1, 1, 1),
  ('2026-10-03', '2026-10-10', 2, 2, 3),
  ('2026-10-05', NULL, 1, 1, 5),
  ('2026-10-10', NULL, 3, 3, 2),
  ('2026-10-12', '2026-10-18', 4, 2, 4),
  ('2026-10-15', NULL, 5, 1, 8),
  ('2026-10-18', NULL, 2, 2, 6);
