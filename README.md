## Description 
A simple system of mass distribution of notifications to users of the games.


## Run app
```
git clone https://github.com/maroki/mail_sender.git
// set db username and password in config/database.yml 
bundle install
rake db:create
rake db:migrate

rails s
```

## Run test
```
rake db:test:prepare

rspec
```