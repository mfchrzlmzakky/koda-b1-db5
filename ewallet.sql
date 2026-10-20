-- CREATE DATABASE ewallet

DROP TABLE IF EXISTS histories;
DROP TABLE IF EXISTS transfers;
DROP TABLE IF EXISTS topups;
DROP TABLE IF EXISTS withdraws;
DROP TABLE IF EXISTS receivers;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS merchants;
DROP TABLE IF EXISTS banks;

CREATE TABLE banks (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE merchants (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE users (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  phone_number VARCHAR(20) NOT NULL UNIQUE,
  email VARCHAR(255) NOT NULL UNIQUE,
  photo_profile VARCHAR(255),
  balance BIGINT NOT NULL DEFAULT 0
);

CREATE TABLE receivers (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  phone_number VARCHAR(20) NOT NULL,
  account_number VARCHAR(30) NOT NULL
);

CREATE TABLE transfers (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  user_id INTEGER NOT NULL REFERENCES users(id),
  receiver_id INTEGER NOT NULL REFERENCES receivers(id),
  transaction_code VARCHAR(30) NOT NULL UNIQUE,
  transfer_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  amount BIGINT NOT NULL,
  description VARCHAR(255),
  merchant_id INTEGER NOT NULL REFERENCES merchants(id),
  bank_id INTEGER NOT NULL REFERENCES banks(id)
);

CREATE TABLE topups (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  user_id INTEGER NOT NULL REFERENCES users(id),
  transaction_code VARCHAR(30) NOT NULL UNIQUE,
  topup_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  amount BIGINT NOT NULL,
  merchant_id INTEGER NOT NULL REFERENCES merchants(id),
  bank_id INTEGER NOT NULL REFERENCES banks(id)
);

CREATE TABLE withdraws (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  user_id INTEGER NOT NULL REFERENCES users(id),
  transaction_code VARCHAR(30) NOT NULL UNIQUE,
  withdraw_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  amount BIGINT NOT NULL,
  merchant_id INTEGER NOT NULL REFERENCES merchants(id),
  bank_id INTEGER NOT NULL REFERENCES banks(id)
);

CREATE TABLE histories (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  transfer_id INTEGER REFERENCES transfers(id),
  topup_id INTEGER REFERENCES topups(id),
  withdraw_id INTEGER REFERENCES withdraws(id)
);

INSERT INTO banks (name) VALUES
  ('BCA'),
  ('Mandiri'),
  ('BNI'),
  ('BRI');

INSERT INTO merchants (name) VALUES
  ('Indomaret'),
  ('Alfamart'),
  ('Tokopedia'),
  ('Shopee');

INSERT INTO users (name, phone_number, email, photo_profile, balance) VALUES
  ('Peter Schmeicel', '081234567801', 'schmeicel@google.com', '/uploads/profile/schmeicel.jpg', 450000),
  ('Gianluigi Buffon', '081234567802', 'buffon@google.com', '/uploads/profile/buffon.jpg', 200000),
  ('Edwin Van der Sar', '081234567803', 'edwin@google.com', NULL, 450000),
  ('Oliver Kahn', '081234567804', 'kahn@google.com', '/uploads/profile/kahn.jpg', 625000);

INSERT INTO receivers (name, phone_number, account_number) VALUES
  ('Franco Baresi', '081298760001', '1234567890'),
  ('Paolo Maldini', '081298760002', '9876543210'),
  ('Alesandro Nesta', '081298760003', '5566778899');

INSERT INTO topups (user_id, transaction_code, topup_date, amount, merchant_id, bank_id) VALUES
  (1, 'TOP-20261001-0001', '2026-10-01 08:15:00', 500000, 1, 1),
  (2, 'TOP-20261002-0001', '2026-10-02 10:30:00', 300000, 2, 2),
  (3, 'TOP-20261003-0001', '2026-10-03 13:45:00', 1000000, 3, 3),
  (4, 'TOP-20261005-0001', '2026-10-05 09:00:00', 750000, 1, 4),
  (1, 'TOP-20261012-0001', '2026-10-12 16:20:00', 200000, 4, 1);

INSERT INTO withdraws (user_id, transaction_code, withdraw_date, amount, merchant_id, bank_id) VALUES
  (1, 'WDR-20261014-0001', '2026-10-14 11:10:00', 100000, 2, 2),
  (3, 'WDR-20261015-0001', '2026-10-15 14:00:00', 250000, 1, 3),
  (4, 'WDR-20261016-0001', '2026-10-16 17:30:00', 50000, 2, 4);

INSERT INTO transfers (user_id, receiver_id, transaction_code, transfer_date, amount, description, merchant_id, bank_id) VALUES
  (1, 1, 'TRF-20261006-0001', '2026-10-06 12:00:00', 150000, 'Bayar maksi siang', 3, 1),
  (2, 2, 'TRF-20261008-0001', '2026-10-08 19:25:00', 100000, 'Patungan beras', 4, 2),
  (3, 3, 'TRF-20261010-0001', '2026-10-10 08:40:00', 300000, 'Bayar air', 1, 3),
  (4, 1, 'TRF-20261017-0001', '2026-10-17 20:05:00', 75000, 'Ganti uang makan', 2, 4);

INSERT INTO histories (transfer_id, topup_id, withdraw_id) VALUES
  (NULL, 1, NULL),
  (NULL, 2, NULL),
  (NULL, 3, NULL),
  (NULL, 4, NULL),
  (1, NULL, NULL),
  (2, NULL, NULL),
  (3, NULL, NULL),
  (NULL, 5, NULL),
  (NULL, NULL, 1),   
  (NULL, NULL, 2),   
  (NULL, NULL, 3),   
  (4, NULL, NULL);
