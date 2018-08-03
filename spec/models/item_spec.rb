require 'rails_helper'

RSpec.describe Item, type: :model do
#Assocation test, ensure the item record belongs t a single todo record 
  it {should belong_to(:todo)}
#Validation test - ensure column name is present before saving 
it {should validate_presence_of(:name)}
end
