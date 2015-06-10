rx = require 'rx'

observeTextEditorsObs = (workspace) ->
  rx.Observable.create (subj) ->
    workspace.observeTextEditors (e) -> subj.onNext(e)

fromAtomEvent = (target, eventName) ->
  rx.Observable.create (subj) ->
    target[eventName] (args...) -> subj.onNext(args)

module.exports =
  enableAutoSave: ->
    observeTextEditorsObs(atom.workspace)
      .map (editor) -> fromAtomEvent(editor, 'onDidStopChanging').map(-> editor)
      .mergeAll()
      .where (editor) -> editor.isModified() and editor.getPath()?
      .throttle 2000
      .subscribe (editor) -> editor.save()

  activate: (state) ->
    @disp ?= new rx.SerialDisposable()

    unless atom.project.getRepositories().length
      @disp.setDisposable rx.Disposable.empty
      return

    enabled = true
    atom.commands.add 'atom-workspace', 'saveallthetime:toggle-auto-save': =>
      newDisp = if enabled then rx.Disposable.empty else @enableAutoSave()
      @disp.setDisposable newDisp
      enabled = not enabled

    @disp.setDisposable @enableAutoSave()

  deactivate: ->
    @disp.dispose()
