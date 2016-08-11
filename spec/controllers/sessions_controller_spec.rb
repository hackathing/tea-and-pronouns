require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "POST create" do
    xit "creates a new session" do
      post :create, params: {
        session: {
        }
      }
      expect(response).to have_http_status(:success)
    end
  end

end

