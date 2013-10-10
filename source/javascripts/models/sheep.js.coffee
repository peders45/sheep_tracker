class SheepTracker.Models.Sheep extends Thorax.Model

  idAttribute: "_id"

  parse: (response) ->
    response._id = response._id.$oid
    response.birthday = moment(response.birthday.$date).toDate();
    return response

  toJSON: ->
    return {
      name: @get("name")
      birthday: @get("birthday")
      weight: @get("weight")
    }
