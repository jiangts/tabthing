Array::last = ->
  if(@length > 0)
    return this[@length - 1]

class Storage
  constructor: ->

  setObject: (key, object) ->
    if object isnt null and typeof object is 'object'
      localStorage.setItem key, JSON.stringify object
  
  getObject: (key) ->
    JSON.parse localStorage.getItem key

  remove: (key) ->
    delete localStorage[key]

  removeAll: ->
    localStorage.clear()

window.storage = new Storage()
