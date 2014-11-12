observeTextEditorsObs = (workspace) ->
  rx.Observable.create (subj) ->
    return workspace.observeTextEditors (e) -> subj.onNext(e)

fromAtomEvent = (target, eventName) ->
  rx.Observable.create (subj) ->
    return target.on eventName, (args...) -> subj.onNext(args)

module.exports =
  activate: (state) ->
    unless atom.project.getRepo()
      @disp = rx.Disposable.empty

    @disp = observeTextEditorsObs(atom.workspace)
      .map (editor) -> fromAtomEvent(editor, 'onDidStopChanging').map(-> editor)
      .mergeAll()
      .where (editor) -> editor.isModified() and editor.getPath() is not ''
      .subscribe (editor) -> editor.save()

  deactivate: ->
    @disp.dispose()

  serialize: ->
