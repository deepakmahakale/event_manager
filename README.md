# Event Manager

### Setup

```
bundle install
rake db:create
rake db:migrate
rails s
```

```
# Create a new user or change password of any existing user from console

user = User.last
user.password = 'password'
user.save
```

### Tasks
Add the CSV's in public folder of the application and execute the following tasks.

Note: Please import the users first

1. `rake import:users`
2. `rake import:events`

### Scope of improvement
- ActiveRecord Bulk upload can be used in CSV import to avoid multiple insert queries
- Calendar can be added
- users multiselect can be replaced with tags select where we won't load all users

### Questions/Assumptions
**CSV processing**
Model
  - Only owner of the event can edit the event and add/remove users
  - User can respond to event RSVP from my_events tab
Events CSV:
  - Task will not create users if they don't exist
  - only existing users will be associated with the event
  - Even if we import the users we don't have emails so there is no way to connect to users or send them email for password reset

-


