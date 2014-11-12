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

  describe "when true is true", ->
    it "expects true", ->
      expect(true).toBe(true)
