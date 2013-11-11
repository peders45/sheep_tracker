class SheepTracker.Models.Sheep extends Thorax.Model

  urlRoot: "#{SERVER_URL}/sheep/"

  parse: (response, options) ->
    if _.isArray(response)
      response = response[0]
    response.birth_date = moment(response.birth_date).toDate();
    response.position = response.position.split(",")
    return response

  toJSON: ->
    return {
      name: @get("name")
      birth_date: new Date(@get("birth_date"))
      weight: @get("weight")
      breed: @get("breed")
      gender: @get("gender")
    }
