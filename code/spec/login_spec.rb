require_relative '../pages/login_page_object'
require_relative '../../code/spec/spec_helper'

describe 'Login', :shallow do

  before(:each) do
    @login = Login.new(@driver)
  end

  it 'succeeded' do
    @login.with('tomsmith', 'SuperSecretPassword!')

    expect(@login.success_message_present?).to eql true
  end

  it 'failed' do
    @login.with('tomsmith', 'notthis')

    expect(@login.failure_message_present?).to eql true
  end

end