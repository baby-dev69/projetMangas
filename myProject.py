from os import name
import sqlite3
from flask import render_template
from flask import Flask
from flask import g



app = Flask(__name__)

@app.route("/")
def index():
    cursor = get_db().execute("select * from LIVRE L JOIN AUTEUR A ON L.IDAUTEUR=A.IDAUTEUR JOIN GENRE G ON G.IDGENRE=L.IDGENRE",[])
    books = cursor.fetchall()

    return render_template('listeMangas.html', books = books)



DATABASE = 'database.db'

def get_db():
    db = sqlite3.connect(DATABASE)
    db.row_factory = sqlite3.Row
    return db

def init_db():
    db = get_db()
    with open('bdm.sql') as f:
        db.cursor().executescript(f.read())
    db.commit() 

@app.cli.command('init-db')
def init_db_command():
    init_db()
    print('Initialized the database.')
