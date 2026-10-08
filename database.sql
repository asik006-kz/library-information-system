USE LibraryInformationSystem;
GO

CREATE TABLE admins (
    id INT PRIMARY KEY IDENTITY(1,1),
    full_name NVARCHAR(100) NOT NULL,
    login NVARCHAR(50) NOT NULL UNIQUE,
    password NVARCHAR(255) NOT NULL,
    admin_code NVARCHAR(50) NOT NULL UNIQUE
);
GO

CREATE TABLE readers (
    id INT PRIMARY KEY IDENTITY(1,1),
    full_name NVARCHAR(100) NOT NULL,
    login NVARCHAR(50) NOT NULL UNIQUE,
    password NVARCHAR(255) NOT NULL,
    reader_card NVARCHAR(50) NOT NULL UNIQUE,
    admin_id INT NOT NULL,
    FOREIGN KEY (admin_id) REFERENCES admins(id)
);
GO

CREATE TABLE librarians (
    id INT PRIMARY KEY IDENTITY(1,1),
    full_name NVARCHAR(100) NOT NULL,
    login NVARCHAR(50) NOT NULL UNIQUE,
    password NVARCHAR(255) NOT NULL,
    employee_code NVARCHAR(50) NOT NULL UNIQUE,
    admin_id INT NOT NULL,
    FOREIGN KEY (admin_id) REFERENCES admins(id)
);
GO

CREATE TABLE catalogs (
    id INT PRIMARY KEY IDENTITY(1,1),
    book_count INT NOT NULL CHECK (book_count >= 0),
    librarian_id INT NOT NULL,
    FOREIGN KEY (librarian_id) REFERENCES librarians(id)
);
GO

CREATE TABLE books (
    id INT PRIMARY KEY IDENTITY(1,1),
    title NVARCHAR(200) NOT NULL,
    author NVARCHAR(100) NOT NULL,
    category NVARCHAR(100) NOT NULL,
    isbn NVARCHAR(20) NOT NULL UNIQUE,
    total_count INT NOT NULL CHECK (total_count >= 0),
    available_count INT NOT NULL CHECK (available_count >= 0),
    catalog_id INT NOT NULL,
    FOREIGN KEY (catalog_id) REFERENCES catalogs(id),
    CHECK (available_count <= total_count)
);
GO

CREATE TABLE reservations (
    id INT PRIMARY KEY IDENTITY(1,1),
    reservation_date DATE NOT NULL,
    expiry_date DATE NOT NULL,
    status NVARCHAR(30) NOT NULL,
    reader_id INT NOT NULL,
    book_id INT NOT NULL,
    FOREIGN KEY (reader_id) REFERENCES readers(id),
    FOREIGN KEY (book_id) REFERENCES books(id),
    CHECK (expiry_date >= reservation_date)
);
GO

CREATE TABLE loans (
    id INT PRIMARY KEY IDENTITY(1,1),
    issue_date DATE NOT NULL,
    return_due_date DATE NOT NULL,
    actual_return_date DATE NULL,
    fine DECIMAL(10,2) NOT NULL DEFAULT 0,
    reader_id INT NOT NULL,
    librarian_id INT NOT NULL,
    book_id INT NOT NULL,
    FOREIGN KEY (reader_id) REFERENCES readers(id),
    FOREIGN KEY (librarian_id) REFERENCES librarians(id),
    FOREIGN KEY (book_id) REFERENCES books(id),
    CHECK (fine >= 0),
    CHECK (return_due_date >= issue_date),
    CHECK (
        actual_return_date IS NULL
        OR actual_return_date >= issue_date
    )
);
GO

INSERT INTO admins
(full_name, login, password, admin_code)
VALUES
(N'Айбек Қасенов', 'admin1', '12345', 'ADM001');
GO

INSERT INTO readers
(full_name, login, password, reader_card, admin_id)
VALUES
(N'Арман Еркінов', 'reader1', '12345', 'CARD001', 1);
GO

INSERT INTO librarians
(full_name, login, password, employee_code, admin_id)
VALUES
(N'Ерлан Қасымов', 'librarian1', '12345', 'LIB001', 1);
GO

INSERT INTO catalogs
(book_count, librarian_id)
VALUES
(3, 1);
GO

INSERT INTO books
(title, author, category, isbn, total_count, available_count, catalog_id)
VALUES
(N'Абай жолы', N'Мұхтар Әуезов', N'Роман',
 '9786010000011', 5, 4, 1),
(N'Қан мен тер', N'Әбдіжәміл Нұрпейісов', N'Роман',
 '9786010000012', 3, 2, 1),
(N'Менің атым Қожа', N'Бердібек Соқпақбаев', N'Балалар әдебиеті',
 '9786010000013', 4, 4, 1);
GO

INSERT INTO reservations
(reservation_date, expiry_date, status, reader_id, book_id)
VALUES
('2026-10-08', '2026-10-15', N'Белсенді', 1, 1);
GO

INSERT INTO loans
(issue_date, return_due_date, actual_return_date,
 fine, reader_id, librarian_id, book_id)
VALUES
('2026-10-08', '2026-10-22', NULL,
 500.00, 1, 1, 2);
GO

UPDATE books
SET available_count = 3
WHERE id = 2;
GO

UPDATE reservations
SET status = N'Орындалды'
WHERE id = 1;
GO

UPDATE loans
SET fine = 500.00
WHERE id = 1;
GO

INSERT INTO reservations
(reservation_date, expiry_date, status, reader_id, book_id)
VALUES
('2026-10-08', '2026-10-10', N'Тестілеу', 1, 3);

DELETE FROM reservations
WHERE status = N'Тестілеу';

GO

SELECT * FROM admins;
SELECT * FROM readers;
SELECT * FROM librarians;
SELECT * FROM catalogs;
SELECT * FROM books;
SELECT * FROM reservations;
SELECT * FROM loans;
GO
