require 'spec_helper'

describe 'dummy test which fails on purpose' do
  describe command('will fail') do
    its(:stdout) { should match(/will fail/) }
  end
end
