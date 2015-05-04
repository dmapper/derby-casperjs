# derby-casperjs

> Helpers and tweaks for Casper.js to test Derby.js apps

## Usage

```coffee
# app/index.coffee

# app = require('derby').createApp 'foobar', __filename

window.app = app if window? # app must be accessible from the client
require('derby-casperjs/renderReady')(app)
```

```coffee
# test/index.coffee

constants =
  baseUrl: 'http://localhost:3003'

{model, history, sel} = require('derby-casperjs')(casper, constants)
```

## `casper.waitForUrl(url[, cb, onTimeout, timeout])`

Properly wait for derby to render page on client/server side.

casper.start constants.baseUrl, ->
  @waitForUrl '/', =>
    # On this stage derby fully loaded its client scripts and initialized everything
    @shot()

## `model`

### `model.set`, `model.get`

Evaluates `set`, `get` on the client. `set`'s callback waits until operation is executed on the server.

```coffee
casper.then ->
  userId = model.get '_session.userId'
  model.set "users.#{ userId }.casper", true, =>
    @shot()
```

### `model.wait()`

Waits for all model operations to execute on the server

### `model.waitFor(path)`

Waits for `path` to become truthy.

```coffee
casper.then ->
  model.waitFor '_page.flags.finish', =>
    @shot()
```

## `history`

### `history.push(path[, cb])`

Does `app.history.push` on the client. If `cb` is provided also waits until
the new page is loaded.

```coffee
casper.then ->
  history.push '/games', =>
    # Games page is loaded and fully initialized
    @shot()
```

### `history.refresh()`

Refresh the page using `app.history.refresh` on the client.

## `sel`

### `sel.text([Css3Selector, ]text)`

Returns an XPath selector to find a node which holds `text`.
Optionally you can specify a CSS3 selector to narrow the lookup.

```coffee
casper.then ->
  # Click on a `<button>` within `<form class='main'>` that has `Submit` text.
  @click sel.text('form.main button', 'Submit')
```

## additional debugging features

Adds client debugging if you run tests with env var DEBUG=true:

```bash
DEBUG=true casperjs test ./test/index.js
```

## `casper.shot([name])`

Make a screenshot and name it automatically with an incrementing number.
Saves screenshots to `test/screenshots/` - don't forget to add it to your `.gitignore`.

```coffee
casper.then ->
  @shot() # test/screenshots/1.png
  @shot() # test/screenshots/2.png
  @shot() # test/screenshots/3.png
  @shot 'foobar' # test/screenshots/foobar.png
```

## casper.

## sel

### sel.text('form button', 'Reset'), 'Reset button'