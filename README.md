# RHP: Ruby Hypertext Preprocessor

**This is a goofball project! Definitely not recommended for production.**

An amazing thing about PHP is you can just run a server, sit some files in a
directory, and boom, HTML templates.

This project imitates that workflow in Ruby! Run the server, drop some templates
in a directory, and use ERB to just make some HTML.

## Installation

Since this is just for messing around, install this gem from git source.

```
gem 'rhp', github: 'zachmargolis/rhp'
```

## Usage

The `RHP::Server` class is a Rack handler that serves files out of a directory:

```ruby
# config.ru
require 'rhp/server'

run RHP::Server.new('examples')
```

```
$ rackup config.ru
```

For a request to `/something`, we evaluate the `examples/something.html.erb`
template.

```erb
<% header("X-Is-Super-Awesome: yes") %>

Hello from RHP! The year is <%= Time.now.year %>.

```

Which gives us:

```
curl -v http://localhost:9292/something
< HTTP/1.1 200 OK 
< Content-Type: text/html
< X-Is-Super-Awesome: yes
< 
Hello from RHP! The year is 2014.
```

Inside templates, the `Rack::Request` object is exposed as `request` so a lot
of common PHP-isms translate easily. We also expose a few common functions for
setting headers, response codes, etc.

| PHP        | RHP           |                            |
|------------|---------------|----------------------------|
| `$_GET`    | `request.GET` | Access HTTP GET parameters |
| `$_POST`    | `request.POST` | Access HTTP POST parameters |
| `nl2br()`  | `nl2br`       | Convert newline characters into `<br />` tags |
| `header()` | `header`      | Set header values |
| `http_response_code()` | `http_response_code` | Get or set HTTP status code |
