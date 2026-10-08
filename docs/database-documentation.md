# Database Documentation

## Library Information System

### Database
LibraryInformationSystem

### Main Tables

1. admins — әкімшілер туралы ақпарат
2. readers — оқырмандар туралы ақпарат
3. librarians — кітапханашылар туралы ақпарат
4. catalogs — кітап каталогтары
5. books — кітаптар туралы ақпарат
6. reservations — кітап брондаулары
7. loans — кітап беру және қайтару операциялары

### Relationships

- admins → readers
- admins → librarians
- librarians → catalogs
- catalogs → books
- readers → reservations
- books → reservations
- readers → loans
- librarians → loans
- books → loans

### Main Operations

- Кітаптарды қосу
- Кітаптарды іздеу
- Кітаптарды басқару
- Кітапты брондау
- Кітап беру
- Кітапты қайтару
- Айыппұлды есепке алу
- Пайдаланушыларды басқару
