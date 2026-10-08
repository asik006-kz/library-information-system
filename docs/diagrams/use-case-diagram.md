```mermaid
flowchart LR
    Reader["Оқырман"]
    Librarian["Кітапханашы"]
    Admin["Әкімші"]
    Head["Кітапхана басшысы"]

    Login["Жүйеге кіру"]
    Register["Тіркелу"]
    Search["Кітап іздеу"]
    Info["Кітап туралы ақпаратты көру"]
    Reserve["Кітапты онлайн брондау"]
    Issue["Кітап беру"]
    Return["Кітапты қайтару"]
    ManageBooks["Кітаптарды басқару"]
    ManageUsers["Жүйені басқару"]
    Reports["Есептерді қарау"]

    Reader --> Login
    Reader --> Register
    Reader --> Search
    Reader --> Info
    Reader --> Reserve

    Librarian --> Login
    Librarian --> Search
    Librarian --> Issue
    Librarian --> Return
    Librarian --> ManageBooks

    Admin --> ManageUsers

    Head --> Login
    Head --> Reports
