require 'spec_helper'

describe 'openntpd::default' do

  describe port(123) do
    it { should be_listening.on('127.0.0.1').with('udp') } 
  end

  describe service('openntpd') do
    it { should be_enabled.with_level(3) }
    it { should be_running }
  end

  describe user('_ntp') do
    it { should belong_to_group '_ntp' }
    it { should have_home_directory '/var/empty/ntpd' }
    it { should have_login_shell '/sbin/nologin' }
  end

end
