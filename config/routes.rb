# frozen_string_literal: true

module SocialVibeTracker
  class Routes < Hanami::Routes
    root { "Hello from Hanami" }

    slice :user, at: "/user"
  end
end
