#! /usr/bin/env coffee

request = require 'request'
url = require 'url'

expandol = (short_url, cb) ->
  
  parsed_url = url.parse short_url

  options =
    pool: false
    headers:
      'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.101 Safari/537.11'
    url: parsed_url

  request.get options, (err, resp, body) ->

    if err? then return cb err

    destination_url = resp.request.href
    redirects = resp.request.redirects
    nRedirects = resp.request.redirects.length

    # Create complete route, based on the redirects, the destination
    # and the original.
    all_urls = (redirect.redirectUri for redirect in redirects.slice 0, nRedirects-1)
    all_urls.push destination_url
    all_urls.unshift short_url

    cb null, destination_url, all_urls

module.exports = expandol

if not module.parent?
  short_url = process.argv[2]
  expandol short_url, (err, destination_url, all_urls) ->
    if err? then return console.log "ERROR: #{err}"
    console.log destination_url
