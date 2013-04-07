require "application"

describe Application do
  it "has an application root" do
    Application.root.should == File.expand_path("../../", __FILE__)
  end

  it "has a log folder" do
    Application.log_path.should == Application.root + "/log/application.log"
  end

  it "reads a yaml config file" do
    config = { "foo" => "bar" }
    YAML.should_receive(:load_file).with(Application.root + "/config/application.yml").and_return(config)
    Application.config.should == config
  end

  it "raises a helpful error if the config is missing" do
    YAML.stub(:load_file).and_raise(Errno::ENOENT)
    expect { Application.config }.to raise_error(Application::CONFIG_MISSING_MESSAGE)
  end
end

