# # encoding: utf-8

# Inspec test for recipe mongo::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe service('mongod') do
  it {should be_running}
  it {should be_enabled}
end

describe package 'mongodb-org' do
  it { should be_installed }
  its('version') { should match /3\./ }
end

describe port(80), :skip do
  it { should_not be_listening }
end
