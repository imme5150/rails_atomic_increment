Atomic increments allow you to avoid problems with a concurrent access to a counter:
http://www.alfreddd.com/2011/01/atomic-increment-in-rails.html

Install:

	gem install rails_atomic_increment


Usage:

	user = User.first
	user.account_balance # => 100
	user.atomic_increment!(:account_balance, 2)
	user.account_balance # => 102

	user.atomic_increment!('account_balance', 2, :reload) # reloads from DB
	user.account_balance # could be > 104 if it was updated by another process

	user.login_attempts # => 7
	user.page_views # => 1000
	user.increment_counters!([:login_attempts, :page_views]
	user.login_attempts # => 8
	user.page_views # => 1001

NOTE: This is designed for counters that are being updated a lot, so to decrease the DB load, the updated_at column is NOT updated when the counter get incremented.  If this is an option you'd like, drop me a line and I can quickly add it for you.

This is my first gem, so please give me feedback and let me know if you run into any bugs.  It's only been tested on Rails 2.3.8, but it should work on Rails 3.0 and 3.1

released under the [MIT license](http://www.opensource.org/licenses/mit-license.php) Josh Shupack
