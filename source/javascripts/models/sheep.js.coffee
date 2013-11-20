# Defines a new model for sheep
class SheepTracker.Models.Sheep extends Thorax.Model

  # Set the urlRoot. This will be used when the 
  # only a single model is fetched without a
  # collection
  urlRoot: "#{SERVER_URL}/sheep/"

  # Parses the response from the server to
  # fit how the data should look
  parse: (response, options) ->
    if _.isArray(response)
      response = response[0]
    response.birth_date = moment(response.birth_date).toDate();
    response.position = response.position.split(",")
    return response

  # Specfifies how the request should be
  # converted to JSON before sending. The birth
  # date is formated to utc using Moment.js
  toJSON: ->
    return {
      name: @get("name")
      birth_date: moment(@get("birth_date")).format()
      weight: @get("weight")
      breed: @get("breed")
      gender: @get("gender")
      state: @get("state")
    }
