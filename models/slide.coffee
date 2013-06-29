define ["backbone"], (Backbone) ->
  Slide = Backbone.Model.extend
    defaults:
      page: 0
      altitude: 0