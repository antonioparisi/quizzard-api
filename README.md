# Quizzard API

## Features

Quizzard API are used to expose some services for:

- Create an user (through the mobile, when an user do a login on Facebook it will send it data to the API)
- Permits to an user from the mobile app, to join a quiz
- When quiz start, send a notify through 'quiz' channel to advice all users connected to start answer to the questions that are showed

## Future Goals

- Add an endpoint on the quiz used when an user answer correctly to an answer and send a notify for increment his score on the desktop client
- Manage the scoreboard through redis store
- Get the 1st, 2nd, 3rd place when a quiz is finished

## Author

- Antonio Parisi <ant.parisi@gmail.com>
