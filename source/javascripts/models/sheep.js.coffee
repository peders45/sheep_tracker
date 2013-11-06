class SheepTracker.Models.Sheep extends Thorax.Model

  urlRoot: "#{SERVER_URL}/sheep/"

  parse: (response, options) ->
    response = if (options.collection) then response else response[0]
    response.birth_date = moment(response.birth_date).toDate();
    response.position = response.position.split(",")
    return response

  toJSON: ->
    return {
      name: @get("name")
      birthday: new Date(@get("birthday"))
      weight: @get("weight")
      breed: @get("breed")
      gender: @get("gender")
    }
