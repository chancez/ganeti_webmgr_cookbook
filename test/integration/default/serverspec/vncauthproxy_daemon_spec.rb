require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  c.before :all do
    c.path = '/sbin:/usr/sbin'
  end
end

describe "install and start the vncauthproxy daemon" do
  describe service("vncauthproxy") do
    it { should be_running }
  end
  # this will fail if you change the port
  # in the attributes
  it "is listening on port 8888" do
    expect(port(8888)).to be_listening
  end
end
