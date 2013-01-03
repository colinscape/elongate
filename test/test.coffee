expandol = require '../src/expandol'
assert = require 'assert'

short_url = 'https://bitly.com/UmDV9W'
expandol short_url, (err, final_url) ->
  target_url = 'http://tech.fortune.cnn.com/2013/01/03/google-larry-page/?section=money_technology&utm_source=feedburner&utm_medium=feed&utm_campaign=Feed%253A+rss%252Fmoney_technology+%2528Technology%2529'
  assert.equal target_url, final_url
