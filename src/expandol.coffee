request = require 'request'
url = require 'url'

expandol = (short_url, cb) ->
  
  parsed_url = url.parse short_url

  options =
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
    console.log "Final url: #{destination_url}"
    console.log "Route: #{all_urls.join ' -> '}"
