AWESOME_HASH =  {
    "id": "2874604608",
    "type": "WatchEvent",
    "actor": {
      "id": 11179090,
      "login": "tra38",
      "gravatar_id": "",
      "url": "https://api.github.com/users/tra38",
      "avatar_url": "https://avatars.githubusercontent.com/u/11179090?"
    },
    "repo": {
      "id": 2456210,
      "name": "peter-murach/github",
      "url": "https://api.github.com/repos/peter-murach/github"
    },
    "payload": {
      "action": "started"
    },
    "public": true,
    "created_at": "2015-06-08T23:46:27Z"
  }
p AWESOME_HASH

p AWESOME_HASH[:type]

puts "Today, I did a #{AWESOME_HASH[:type]} event. In this event, I #{AWESOME_HASH[:payload][:action]}."