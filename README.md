# Pelokit

A gem for interacting with the Peloton API.


## Setup

Configure the `Pelokit` module. In a Rails app, this is best done with a `config/initializers` file:

```ruby
Pelokit.configure do |c|
  c.client_id    = 'your client id'
  c.account_name = 'your account name'
  c.password     = 'your password'
end
```

## BankAccounts

```ruby
api_properties = {:bank_account_id=>"my id",
                  :bank_account_name=>"foobar",
                  :bank_account_owner=>"owner",
                  :bank_account_type_code=>"1",
                  :financial_insitution_number=>"001",
                  :branch_transit_number=>"23232",
                  :account_number=>"121212",
                  :currency_code=>"CAD",
                  :verify_account_by_deposit=>"1"}
peloton        = Pelokit::BankAccount.new api_properties
# ....
response = peloton.add
puts response.body
# ....
peloton.bank_account_owner = 'new_owner'
response = peloton.update
puts response.body
```
