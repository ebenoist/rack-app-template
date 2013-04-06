module Application
  class << self
    def root
      File.expand_path("../../", __FILE__)
    end

    def log_path
      Application.root + "/logs/application.log"
    end
  end
end

