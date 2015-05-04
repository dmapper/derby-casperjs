# FIXME: This methods are here for future reference. Not used anymore.

# Click on something that has this text
casper.clickText = (text) ->
  @click sel.text text

# Click on a link with required text after removing the target='_blank' from it
casper.clickLink = (text) ->
  @evaluate (text) ->
    el = __utils__.getElementByXPath "//*[contains(text(), \'#{text}\')]"
    el.removeAttribute 'target'
  , text
  @clickText text

# Click on a button with required text inside of a form
casper.clickForm = (text) ->
  @click sel.text '*', text
