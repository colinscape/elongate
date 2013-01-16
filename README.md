# Elongate -- Expand shortened urls

## Install globally

<pre>
  npm install -g elongate
</pre>

Or locally for use as a library:

<pre>
  npm install elongate
</pre>

Or from source:

<pre>
  git clone git://github.com/colinscape/elongate.git 
  cd elongate
  npm link
</pre>

## Super simple to use

If you installed it globally:

<pre>
  $ elongate http://bit.ly/TAA2AL
</pre>

If installed as a library:

<pre>
  elongate = require 'elongate'

  elongate 'http://bit.ly/TAA2AL', (err, destination_url) ->
    console.log "Destination log is #{destination_url}"
</pre>

or for the full redirect chain:

<pre>
  elongate = require 'elongate'

  elongate 'http://bit.ly/TAA2AL', (err, destination_url, all_urls) ->
    console.log intermediate_url for intermediate_url in all_urls
</pre>

Or, as JavaScript:

<pre>
  var elongate = require('elongate')

  elongate('http://bit.ly/TAA2AL', function(err, destination_url) {
    console.log('Destination url is ' + destination_url);
  });
</pre>

<pre>
  var elongate = require('elongate')

  elongate('http://bit.ly/TAA2AL', function(err, destination_url, all_urls) {
    for (var i=0; i &lt; all_urls.length; ++i) {
      console.log(all_urls[i]);  
    }
  });
</pre>
