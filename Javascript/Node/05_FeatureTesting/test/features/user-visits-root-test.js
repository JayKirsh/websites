const {assert} = require('chai');

describe('user visits root', () => {
  describe('posting a quote', () => {
    it('saves quote and metadata submitted by user', () => {
      const quote = 'The hardest mountains to climb are the ones we build for ourselves.';
      const attributed = 'Jordan Kirchner';
      const source = 'Mario Maker 2';

      browser.url('/');

      browser.setValue('textarea[id=quote]', quote);
      browser.setValue('textarea[id=attributed]', attributed);
      browser.setValue('textarea[id=source]', source);

      browser.click('input[type=submit]');

      assert.include(browser.getText('#quotes'), quote);
      assert.include(browser.getText('#quotes'), attributed);
      assert.include(browser.getText('#quotes'), source);      
    });
  });
});