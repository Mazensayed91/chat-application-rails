class CreateAppJob < ApplicationJob
  queue_as :default

  def perform(name, token)
    application = Application.create({name: name,token: token})
    application.save
  end
end
