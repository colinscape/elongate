#! /usr/bin/env coffee

request = require 'request'
url = require 'url'

# The worker function that does the heavy lifting.
internal = (short_url, history, cb) ->

  history.push short_url
  parsed_url = url.parse short_url

  # Need a browser User-Agent for facebook.
  # However need a non-browser User-Agent for t.co urls.
  # Let's pretend to be a browser unless otherwise necessary.
  userAgent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.101 Safari/537.11'
  if parsed_url.host in ['t.co', 'mlad.co', 'clnk.me'] then userAgent = null

  # We don't pool so we can make more requests.
  # Don't use a cookie jar else it soon gets all full of rubbish.
  # Don't follow redirects as we do that ourselves so we can change the
  #   User-Agent if need be between requests.
  options =
    pool: false
    jar: false
    encoding: 'utf8'
    followRedirect: false
    headers:
      'User-Agent': userAgent
    url: parsed_url

  request.get options, (err, resp, body) ->

    if err? then return cb err

    # If we are to redirect, go recursive.
    if resp.statusCode >= 300 and resp.statusCode < 400
      location = resp.headers.location
      if location in history then return cb "Redirect loop"
      return internal location, history, cb

    # We get here, we are at the end of the redirections.
    destination_url = resp.request.href
    history.push destination_url

    cb null, destination_url, history

#============================================================================

# The function we expose.
elongate = (short_url, cb) ->
  return internal short_url, [], cb

#============================================================================

module.exports = elongate

if not module.parent?
  short_url = process.argv[2]
  elongate short_url, (err, destination_url, all_urls) ->
    if err? then return console.log "ERROR: #{err}"
    console.log destination_url
