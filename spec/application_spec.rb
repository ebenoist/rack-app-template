require "application"

describe Application do
  it "has an application root" do
    Application.root.should == File.expand_path("../../", __FILE__)
  end

  it "has a log folder" do
    Application.log_path.should == Application.root + "/log/application.log"
  end
end

