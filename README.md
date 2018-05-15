# DISCONTINUED

Facebook does not allow pages with less than 4000 like to add tabs anymore, which makes this app obsolete for most of our customers. The current version keeps the service running for those who have installed it in the past already.

# Info

A application to show plans in facebook so that potential coworkers can see the services and prices the space offers on the facebook page.

## Development

It's a ruby padrino app, so run `bundle install` to get setup. It then can be run locally with `foreman start`. Make sure you setup your `.env` like below.

    FB_APP_ID=your facebook app id
    FB_APP_KEY=your facebook secret key
    COBOT_APP_ID=your cobot app id
    COBOT_APP_KEY=your cobot secret key
### Dependencies
For running the tests you will need __phatomjs__ (on OSX install with `brew install phantomjs`)