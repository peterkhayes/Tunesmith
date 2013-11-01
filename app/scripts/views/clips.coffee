'use strict';

class Tunesmith.Views.ClipsView extends Backbone.View

  className: 'clips clearfix'

  initialize: ->
    console.log "initialized clip view"
    @collection.on('add change', @render, @)


  events: ->
    'click': 'processClick'

  render: ->
    console.log "rendering clip view"
    @$el.html ''

    # Put the add new button first.
    @$el.append(Templates['button_add_new']());

    # Then append any clips we've created.
    @collection.each( (clip) =>
      @$el.append (new Tunesmith.Views.ClipView({model: clip}).render())
    )

    @$el

  processClick: (e) ->
    clicked = $(e.target)

    # Clicking add new prompts the user to select a type of instrument to add.
    if clicked.hasClass "cancel"
      @render()
    else if clicked.hasClass "add"
      @renderSelector('type')
    else if clicked.hasClass "instrument"
      @renderRecorder('instrument')
    else if clicked.hasClass "drum"
      @renderRecorder('drum')
    else if clicked.hasClass "live"
      console.log "not yet you quicky!"
      @render()
    else if clicked.hasClass "stop"
      @endRecording()

  renderSelector: (template) ->
    @$el.html Templates['selector_' + template]()
    @$el

  renderRecorder: (type) ->
    @recorder = new Tunesmith.Models.RecorderModel({type: type})
    @$el.html Templates['selector_record']()
    
  endRecording: ->
    console.log "ending recording"
    @collection.add({type: @recorder.get('type')})



    
