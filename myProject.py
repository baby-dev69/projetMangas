from os import name
import sqlite3

from flask import render_template
from flask import request, flash , session
from flask import Flask
from flask import g



app = Flask(__name__)
app.secret_key = "SECRET45654343"

#Set default route
@app.route("/")
def index():

    #If not connected go to login condition 
    if 'userID' in session:
        #Select all Books for HTML
        cursor = get_db().execute("select * from LIVRE L JOIN AUTEUR A ON L.IDAUTEUR=A.IDAUTEUR JOIN GENRE G ON G.IDGENRE=L.IDGENRE",[])
        books = cursor.fetchall()

        #Select the user connected
        cursor = get_db().execute("select * from USER where IDUSER=?",[session["userID"]])
        users = cursor.fetchall()
        user = users[0]

        #Go to listeMangas.html
        return render_template('listeMangas.html', books = books, user = user)
    else :   
        #Go to login.html     
        return render_template('login.html')


#Set /auteur route with method POST
@app.route('/auteur' , methods=['POST'])
def auteur():

    #If not connected go to login condition
    if 'userID' in session:

        #Take Livre ID by button clicked
        idLivre = request.form.get('autBTN')

        #Select the book and the author with the Livre ID
        cursor = get_db().execute("select * from LIVRE L JOIN AUTEUR A ON L.IDAUTEUR=A.IDAUTEUR where IDLIVRE=?",[idLivre])
        books = cursor.fetchall()
        book = books[0]
        print(book['NOMAUTEUR'])

        #Select the user connected
        cursor = get_db().execute("select * from USER where IDUSER=?",[session["userID"]])
        users = cursor.fetchall()
        user = users[0]

        #Go to auteur.html
        return render_template('auteur.html', user = user , book = book)
    else : 
        #Go to login.html       
        return render_template('login.html')
   

#Set /couverture route with method POST
@app.route('/couverture', methods=['POST'])
def couverture():

    #If not connected go to login condition
    if 'userID' in session:

        #Take Livre ID by button clicked
        idLivre = request.form.get('couvBTN')

        #Select the book with the Livre ID
        cursor = get_db().execute("select * from LIVRE where IDLIVRE=?",[idLivre])
        books = cursor.fetchall()
        book = books[0]

        #Make the dir of the image for the book selected
        imgDir = "../static/images/" + book['COUVLIVRE']
        print(imgDir)

        #Select the user connected
        cursor = get_db().execute("select * from USER where IDUSER=?",[session["userID"]])
        users = cursor.fetchall()
        user = users[0]

        #Go to couverture.html
        return render_template('couverture.html', user = user , imgDir = imgDir, book = book)
    else :    
        #Go to login.html    
        return render_template('login.html')

#Set /login route
@app.route('/login')
def login():
    return render_template('login.html')

#Set /login route with method POST
@app.route('/login', methods=['POST'])
def login_post():

    #Get Html variables 
    email = request.form.get('email')
    password = request.form.get('password')
    

    #Select on user with the email of the form 
    cursor = get_db().execute("select * from USER where EMAIL=?",[email])
    users = cursor.fetchall()

    # check if the user actually exists
    if users : 

        userMail = users[0]['EMAIL']
        userPassword = users[0]['PASSWORD']
        userID = users[0]['IDUSER']
        print(userMail)

        #If user/password is incorrect
        if not userMail or not password == userPassword:
            
            #Go to login.html (try to connect again)
            return render_template('login.html')
        else : 

            #Stock connected user in the session storage 
            session['userID'] = userID
    else : 

        #Go to login.html (try to connect again)
        return render_template('login.html') 
    

    # if the above check passes, then we know the user has the right credentials
    #Go to the default route
    return index()


#Set /logout route
@app.route('/logout')
def logout():

   # remove the userID from the session if it is there
   session.pop('userID', None)

   #Go to login.html
   return render_template('login.html')


#
#Database config
#

DATABASE = 'database.db'

#Database connection
def get_db():
    db = sqlite3.connect(DATABASE)
    db.row_factory = sqlite3.Row
    return db

#Database creation
def init_db():
    db = get_db()
    with open('bdm.sql') as f:
        db.cursor().executescript(f.read())
    db.commit() 

#Command to create database with cmd
@app.cli.command('init-db')
def init_db_command():
    init_db()
    print('Initialized the database.')

