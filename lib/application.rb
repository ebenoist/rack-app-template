module Application
  CONFIG_MISSING_MESSAGE = <<-MSG
    Looks like you're missing  the application config.
    Copy the example in the config directory to config/application.yml
  MSG

  class << self
    def root
      File.expand_path("../../", __FILE__)
    end

    def log_path
      Application.root + "/log/application.log"
    end

    def config
      begin
      YAML.load_file(root + "/config/application.yml")
      rescue Errno::ENOENT
        raise CONFIG_MISSING_MESSAGE
      end
    end
  end
end

