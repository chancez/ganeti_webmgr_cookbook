require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  c.before :all do
    c.path = '/sbin:/usr/sbin'
  end
end

describe "install and start the flashpolicy daemon" do
  describe service("flashpolicy") do
    it { should be_running }
  end
  it "is listening on port 843" do
    expect(port(843)).to be_listening
  end
end
