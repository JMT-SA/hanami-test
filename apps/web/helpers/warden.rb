module Web
  module Helpers
    module Warden

      def warden
        params.env['warden']
      end

      def logged_in_as
        return nil unless is_logged_in?
        "#{warden.user.first_name} #{warden.user.last_name}"
      end

      def is_logged_in?
        !params.env['warden'].user.nil?
      end
    end
  end
end

