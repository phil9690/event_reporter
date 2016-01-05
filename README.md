# Event Reporter

## Setup

You will first need to install mysql
https://www.mysql.com/

Once installed create a user which is used to create and access the database

```
# LINUX
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';
GRANT ALL PRIVILEGES ON * . * TO 'admin'@'localhost';
```

* Clone the repo
* run ```bundle```
* run ```bundle exec rake db:setup```
* Boot the server ```rails s -b 0.0.0.0```
