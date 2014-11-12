{WorkspaceView} = require 'atom'
SaveallthetimeAtom = require '../lib/saveallthetime-atom'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "SaveallthetimeAtom", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('saveallthetime-atom')

  describe "when the saveallthetime-atom:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.saveallthetime-atom')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.commands.dispatch atom.workspaceView.element, 'saveallthetime-atom:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.saveallthetime-atom')).toExist()
        atom.commands.dispatch atom.workspaceView.element, 'saveallthetime-atom:toggle'
        expect(atom.workspaceView.find('.saveallthetime-atom')).not.toExist()
