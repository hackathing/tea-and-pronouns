class TestsController < ApplicationController

  def show
    render json: {
      test: "test ok"
    }
  end
end
