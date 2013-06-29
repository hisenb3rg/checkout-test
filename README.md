[![Code Climate](https://codeclimate.com/github/jurglic/checkout-test.png)](https://codeclimate.com/github/jurglic/checkout-test)
[![Build Status](https://travis-ci.org/jurglic/checkout-test.png)](https://travis-ci.org/jurglic/checkout-test)

Checkout system test task for an e-commerce client
==================

Cart checkout domain is modelled by domain driven design approach. A set of small and decoupled classes is introduced that follow single responsibily principle.


Running acceptance specs is simple:
~~~ sh
$ rspec spec/checkout_acceptance_spec.rb
~~~

If you wish to expirement in irb, make sure you add lib to load path:
~~~ sh
$ irb -Ilib
> require 'checkout'
~~~


Requirements
------------
Dependencies:

* **Ruby 2.0.0** or newer

There are no other dependencies for runtime environment.

For development/test environment run bundler:
~~~ sh
$ bundle
# run all specs
$ rspec
~~~