# frozen_string_literal: true

module User
  module Actions
    module Users
      class Create < User::Action
        include Deps[
          contract: 'contracts.new_user_contract',
          repo: 'repositories.user'
        ]

        def handle(request, response)
          halt 422 unless contract.call(request.params[:user]).success?

          user = repo.create(request.params[:user])
          serializer = User::Serializers::User.new(user)

          response.format = :json
          response.body = serializer.as_hash.to_json
        rescue ROM::SQL::UniqueConstraintError => e
          puts "An error occured: #{e.message}"
          response.status = 500
          response.format = :json
          response.body = { error: 'Internal server error' }.to_json
        end
      end
    end
  end
end
