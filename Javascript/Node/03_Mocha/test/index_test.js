var assert = require("assert");
var Calculate =  require('../index.js')

describe('Calculate', () => {
  describe('.factorial', () => {
    it('ensures the output of 5! = 120', () => {
      const solution = 120;

      const submit = Calculate.factorial(5);

      assert.equal(submit, solution);
    });
    it('ensures the output of 3! = 6', () => {
      const solution = 6;

      const submit = Calculate.factorial(3);

      assert.equal(submit, solution);
    });
    it('ensures the output of 0! = 1', () => {
      const solution = 1;

      const submit = Calculate.factorial(0);

      assert.equal(submit, solution);
    });
  });
});