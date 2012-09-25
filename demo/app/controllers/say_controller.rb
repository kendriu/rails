class SayController < ApplicationController
  def hello
    @time = Time.now
  end
  
  def list
    @files = Dir.glob('*')
  end

  def goodbye
  end
end
