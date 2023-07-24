User.collection.drop
BankAccount.collection.drop

user1 = User.create! first_name: 'John', last_name: 'Doe', email: 'john@doe.com', password: '111111', password_confirmation: '111111'
account1_1 = user1.bank_accounts.create! name: 'Main', account_number: 'DE02120300000000202051', account_type: 'Checking', bank_name: 'DEUTSCHE KREDITBANK BERLIN'
account1_1.transactions.create! amount: -123_50, description: 'Groceries', completed_at: Time.zone.now - 1.day
account1_1.transactions.create! amount: -53_44, description: 'Cafe', completed_at: Time.zone.now - 2.days
account1_1.transactions.create! amount: -80_00, description: 'Gasoline', completed_at: Time.zone.now - 2.days
account1_1.transactions.create! amount: -1000_00, description: 'Savings', completed_at: Time.zone.now - 2.days
account1_1.transactions.create! amount: 3000_00, description: 'Salary', completed_at: Time.zone.now - 4.days

account1_2 = user1.bank_accounts.create! name: 'Savings', account_number: 'DE02100100100006820101', account_type: 'Savings', bank_name: 'POSTBANK'
account1_2.transactions.create! amount: 1000_00, description: 'Savings', completed_at: Time.zone.now - 2.days

user2 = User.create! first_name: 'Jane', last_name: 'Doe', email: 'jane@doe.com', password: '111111', password_confirmation: '111111'
account2_1 = user2.bank_accounts.create! name: 'Main', account_number: 'DE02500105170137075030', account_type: 'Checking', bank_name: 'ING-DIBA'
account2_1.transactions.create! amount: -230_55, description: 'Groceries', completed_at: Time.zone.now - 1.day
account2_1.transactions.create! amount: -53_44, description: 'Cafe', completed_at: Time.zone.now - 2.days
account2_1.transactions.create! amount: -2000_00, description: 'Savings', completed_at: Time.zone.now - 4.days
account2_1.transactions.create! amount: 5000_00, description: 'Salary', completed_at: Time.zone.now - 5.days

account2_2 = user2.bank_accounts.create! name: 'Savings', account_number: 'DE88100900001234567892', account_type: 'Savings', bank_name: 'BERLINER VOLKSBANK'
account2_2.transactions.create! amount: 2000_00, description: 'Savings', completed_at: Time.zone.now - 4.days
