# ConvertKit Homework Assignment
Welcome! ConvertKit's homework assignment is meant to be an approximation of
work at the company. The tasks are a bit contrived, but the concepts are things
you may deal with on a day-to-day basis. We respect your time, and know that
going through the hiring process at multiple companies can be time-consuming, so
we request that you don't spend much more than two to three hours completing the
assignment. If you finish faster, great! If you get part of the way through,
that's no problem either. You have the opportunity to explain any decisions you
made based on these constraints when you create your pull request.

## About the App
We've set up a fully working skeleton app for you to give you a solid starting
point. There are two working API endpoints in the app — `/validation` and
`/notification`. Both accept a `POST` request with the following parameters:

```
{
  notification {
    artist
    phoneNumber
  }
}
```

`/validation` is used to validate user input (does nothing else)
and  will return a `200` response with an empty JSON payload if the parameters
provided are valid. In case the parameters are invalid (i.e. either or both are
blank or phone number is invalid) you will get a `422` response with error
messages telling you what parameters did not pass validation:

```
{
  "errors": {
    "artist": [
      "can't be blank"
    ],
    "phone_number": [
      "can't be blank",
      "invalid format"
    ]
  }
}
```

`/notification` will attempt to enqueue a Sidekiq job to send an SMS message to the
provided phone number with the top track of the artist. If the provided parameters are
invalid you will get back a `422` response with the error messages telling you
what parameters are invalid (it will have the same structure as the JSON above). If
parameters are valid a job will be enqueued and a message will be sent. In that
case you will get a `200` response with an empty JSON payload.

If you start the app and navigate to `/` in your browser you should see a very
simple form:

<p align="center">
  <img src="mixtape.png?raw=true" alt="Mixtape App Form"/>
</p>

The form is working and it will take user input. Once the `Submit` button is
clicked it will post a request to `/notification`.

## Starting the App
The app runs using Ruby 3.1.1, NodeJS 16.14.2, Ruby on Rails 6.1.6 and Redis. You will
also need [yarn](https://yarnpkg.com) to manage JavaScript packages. We've
prepared a dockerized version of the app to get you started with a single command
(you will need both docker and docker-compose installed locally):

```
docker-compose up
```

Or depending on how you have your docker set up the command that you'd have to
run could be:

```
docker compose up
```

The application will be available at `http://0.0.0.0:3000/` and you are
ready to move on to the assignment.

Keep in mind that developing the app via docker can be quite slow though. If
you prefer, you can choose to run the app locally.

To run the app locally on your machine you need to install all dependencies. We
prefer to use [asdf](https://asdf-vm.com). You will also need to install Redis
separately. Once all dependencies are running you can finish setup by running:

```
> asdf plugin add nodejs
> asdf plugin add ruby
> asdf install
> bundle install && yarn
```

At this point you should be able to start the app by running `rails s`.

You don't need to follow any of those instructions though and if you prefer you
can run the app locally any way you like.

## Assignment
There are two tasks you can take on — backend or frontend adventure. Please
choose only one. You can choose either one unless you have been instructed
differently prior to receiving this homework assignment. Chose one that you
feel most comfortable with and the one that will help us learn most about
your skills and knowledge in software development.

### A Few Notes
Before you start we would like to ask you to keep few things in mind:
  - after you are done with your changes we should be able to run the
    application and it should work,
  - do not make any changes to the runtime configuration (i.e. change Ruby or
    NodeJS version, upgrade any gems or packages, introduce new ways to run
    application or manage dependencies, etc.),
  - do not refactor or restructure any code that was not directly related to your
    assignment (i.e. do not change API code if you chose Frontend Adventure or
    do not refactor models if you are working on a worker — we want to see how
    you can work within given constraints),
  - if you end up needing additional gems or libraries for development (i.e.
    byebug, pry, storybook, etc.) please remove them or any artifacts they leave
    behind before submitting your homework,
  - we discourage you from using any third party libraries or gems; but if you end
    up requiring one to finish your assignment please point all introduced
    dependencies out in the description of your PR telling us a compelling reason
    why you had to do so.

### Backend Adventure
`./app/sidekiq/notification_job.rb` holds a Sidekiq worker that takes in two
arguments: `artist` and a `phone_number`. It will then search for the artist using
Spotify API, grab their top track if one could be found and will send an SMS
message to the provided phone number with the name of the artist and their top
track.

Your task will be to refactor this worker.

You can assume that `artist` and `phone_number` arguments will always be
present and the `phone_number` will be pre-validated using a really simple regex.
An artist result may not exist or phone number may still be invalid.

If you are having trouble starting here are few example of what we will be
looking for in the PR:
  - solid abstractions of 3rd party API's,
  - usage of object oriented design and patterns,
  - coverage of the new code you write with unit tests,
  - following exceptional paths and handling unhappy scenarios,
  - how you handle logging,
  - etc.

Both Minitest and Rspec are set-up and ready to use. You can choose the one you
are most comfortable with, and we ask that all of the new code that you write is
covered by unit tests. Do not write tests for existing code.

If you are running a dockerized version of the app you can run your tests with one
of the following commands (depending on your docker setup and chosen test
framework):

```
docker-compose run app bundle exec rails test
docker-compose run app bundle exec rspec

docker compose run app bundle exec rails test
docker compose run app bundle exec rspec
```

### Frontend Adventure
`app/javascript/packs/notifications/new.jsx` implements a very simple form that allows
users to enter an artist and a phone number. Submitting a form makes a `POST` request
to `/notification`. If user input is valid, you will receive a `200` response
and an SMS message with the artist's top track will be sent to the provided phone
number. Otherwise, you will receive a `422` response with error messages and
no SMS will be sent.

Your task will be to write inline validations that will give immediate feedback
to the user as they are typing. For that use a `POST` request to the `/validation`
endpoint. It will return `200` response if user input is valid. Otherwise, you will
receive a `422` response with error messages.

We've added Tailwind CSS framework to help you with styles. Please use it and
do not add any CSS frameworks or any new stylesheets; use utility
classes that Tailwind provides to help you with styling your UI should you need
it.

If you are having trouble starting here are few example of what we will be
looking for in the PR:
  - handling state management in React,
  - good understanding of how to split and organize components into manageable
    chunks,
  - being mindful of a11y (you don't need to strive to achieve AA compliance but
    the new code you write should be accessible),
  - being mindful about user experience and building a solution that is not
    frustrating to use,
  - etc.

## Submitting your assignment
Once you've finished, create a Pull Request with your changes in this repo.
Indicate your chosen adventure. Write a description of your code changes,
including any decisions or trade-offs you made.

If you end up introducing new libraries or gems please point that out telling us
what those are and why you had to add them.

Since two to three hours is not a lot of time, include anything you would have
done or changed given more time.

We also welcome any comments or suggestions you may have to improve this
assignment: giving and receiving feedback are very important skills for us, and
we're always interested in iterating on our hiring process.

## Final Thoughts
Have any questions? Please ask!
