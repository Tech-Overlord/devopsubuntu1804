require 'spec_helper'

## Validate  groups.
describe group('vagrant') do
  it { should exist }
end

describe group('docker') do
  it { should exist }
end

describe group('jenkins') do
  it { should exist }
end

describe group('ansible') do
  it { should exist }
end


## Validate users.
describe user('vagrant') do
  it { should exist }
  it { should belong_to_group 'vagrant' }
  it { should have_home_directory '/home/vagrant' }
  it { should have_login_shell '/bin/bash' }
end

describe user('docker') do
  it { should exist }
  it { should belong_to_primary_group 'docker' }
  it { should belong_to_group 'docker' }
  it { should belong_to_group 'sudo' }
  it { should have_home_directory '/home/docker' }
  it { should have_login_shell '/bin/bash' }
end

describe user('ansible') do
  it { should exist }
  it { should belong_to_primary_group 'ansible' }
  it { should belong_to_group 'docker' }
  it { should belong_to_group 'sudo' }
  it { should have_home_directory '/home/ansible' }
  it { should have_login_shell '/bin/bash' }
end
