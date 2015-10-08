# Pelokit

[![Build Status](https://travis-ci.org/pelotontech/pelokit.svg?branch=master)](https://travis-ci.org/pelotontech/pelokit)

A gem for interacting with the Peloton API.

## Gem Usage
In your `Gemfile`, point at this repo. In time, this will be added to [RubyGems](https://rubygems.org).

```ruby
# Gemfile
gem 'pelokit', '~> 1.1.2', git: 'https://github.com/pelotontech/pelokit.git'
```

## Setup

Configure the `Pelokit` module. In a Rails app, this is best done with a `config/initializers` file:

```ruby
Pelokit.configure do |c|
  c.client_id    = 'your client id'
  c.account_name = 'your account name'
  c.password     = 'your password'
end
```

### Endpoints

By default `Pelokit` will target Peloton's test environment. URLs for different environments can be injected with the same Rails initializer approach:

```ruby
Pelokit.configure do |c|
  # ...
  c.wsdl = 'https://env-specific-wsdl... '
  c.rest = 'https://env-specific-rest... '
  # ...
end
```

## BankAccount
`BankAccount` is a class for sending bank account coordinates to Peloton, and receiving back an identifier.

### Default Credentials
Omit credentials, and `Pelokit` will use the underlying initializer credentials.

```ruby
api_properties = {
  :bank_account_id             => "my id",
  :bank_account_name           => "foobar",
  :bank_account_owner          => "owner",
  :bank_account_type_code      => "1",
  :financial_insitution_number => "001",
  :branch_transit_number       => "23232",
  :account_number              => "121212",
  :currency_code               => "CAD",
  :verify_account_by_deposit   => "1"
}

peloton        = Pelokit::BankAccount.new api_properties

# ....
response = peloton.add
```

### Deleting Accounts

```ruby
account = Pelokit::BankAccount.new bank_account_id: '65238812f8cc4dbca1604c9cad96e5fa'
result  = account.remove
puts result.message
```

### Validations
```ruby
account = Pelokit::BankAccount.new bank_account_name: 'foo'
account.valid?
# false
puts account.errors.full_messages
# ["Financial insitution number can't be blank", "Financial insitution number must be numeric", "Branch transit number can't be blank", "Branch transit number must be numeric", "Account number can't be blank", "Account number must be numeric", "Bank account type code is not included in the list"]
```
