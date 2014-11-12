SaveallthetimeAtomView = require './saveallthetime-atom-view'

module.exports =
  saveallthetimeAtomView: null

  activate: (state) ->
    @saveallthetimeAtomView = new SaveallthetimeAtomView(state.saveallthetimeAtomViewState)

  deactivate: ->
    @saveallthetimeAtomView.destroy()

  serialize: ->
    saveallthetimeAtomViewState: @saveallthetimeAtomView.serialize()
