require 'childprocess'

module Thwomp

  class Command
    TIMEOUT = 900

    def self.exec(cmd, *args)
      process = ChildProcess.build(cmd, *args)
      process.start

      begin
        process.poll_for_exit TIMEOUT
      rescue ChildProcess::TimeoutError
        # tries increasingly harsher methods to kill the process.
        process.stop
      end
    end

  end

end
