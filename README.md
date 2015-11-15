# f2tracker

Rails version: 4.2.1

== Dependencies

Before running application, you need to install:

* The Ruby language (version 2.2)
* Rails (version 4.2)

Check that appropriate versions of Ruby and Rails are installed in you development environment:

$ ruby -v
$ rails -v

== Database

The application requires a database. The example application uses SQLite with Rails ActiveRecord. You can
easily substitute for example PostgreSQL.

Create databases and run:

$ rake db:create
$ rake db:schema:load

== Database Seed File

The db/seeds.rb file initializes the database with default values.

$ rake db:seeds

You can use it to log in to the application.

== What's here

This example application, F2tracker in online foosball tracker. The application manages access for users in two roles: admin and player.

Player may visit statistics page where he can track his opponents statistics and sort the list of players according to some conditions.
Player is able to sign up to the application and after logging in:

* has his own profile where he can check his avatar, achievements like number of matches won and lost, average number of points, a badge he gained etc.
  He is also able to edit his profile.
* may visit players page where is the list of players with their achievements. There is also a search option by surname, email and role of a player.
* may visit matches page where he can observe matches between players and a result each of them.

Admin has extra options. He is able to:
* add, edit and delete players
* add, edit and delete matches

Feel free to use the F2tracker.

